`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:07 10/01/2019 
// Design Name: 
// Module Name:    dependence_check_block 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dependence_check_block(
    input [31:0] ins,
    input clk,
    input reset,
    output reg [15:0] imm,
    output reg [5:0] op_dec,
    output [4:0] RW_dm,
    output [1:0] mux_sel_A,
    output [1:0] mux_sel_B,
    output reg imm_sel,
    output reg mem_en_ex,
    output reg mem_rw_ex,	
    output reg mem_mux_sel_dm	 
    );
wire JMP,Cond_J,LD_fb,Imm,ld,ST;	 
wire LD_final, mee_tmp, mmsd_tmp1, signal;
wire [14:0] extended_signal;
wire [14:0] add;

reg ins26, ld_prv, ST_tmp,mmsd_tmp2,LD_fb_tmp;
reg [4:0] add_1014_tmp;
reg [4:0] C1;
reg [4:0] C2;
reg [4:0] C3;
reg [4:0] CA;
reg [4:0] CB;

assign JMP = (~ins[31]) & ins[30] & ins[29] & (~ins[28]) & (~ins[27]) & (~ins[26]);
assign Cond_J = (~ins[31]) & ins[30] & ins[29] & ins[28] ;
assign LD_fb = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ~ins[26] & ld_prv;
assign Imm = ~ins[31] & ~ins[30] & ins[29];
assign ld = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ~ins[26];
assign ST = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ins[26];

assign LD_final = ld & ~(ld_prv);
assign mee_tmp = ld_prv | ST_tmp;
assign mmsd_tmp1 = ~(ins26) & mee_tmp;

assign signal = ~(JMP | Cond_J | LD_fb_tmp);
assign extended_signal = {15{signal}};
assign add = extended_signal & ins[25:11];

assign mux_sel_A = (CA == C3) ? 2'b11:
						(CA == C2) ? 2'b10:
						(CA == C1)? 2'b01:2'b00;

assign mux_sel_B = (CB == C3) ? 2'b11:
						(CB == C2) ? 2'b10:
						(CB == C1)? 2'b01:2'b00;

assign RW_dm = C2;

always @(posedge clk)begin
	
	op_dec <= ins[31:26];
	imm_sel <= Imm;
	ins26 <= ins[26];
	mem_rw_ex <= ins26;
	ld_prv <= LD_final;
	ST_tmp <= ST;
	mmsd_tmp2 <= mmsd_tmp1;
	mem_mux_sel_dm <= mmsd_tmp2;
	mem_en_ex <= mee_tmp;
	imm <= ins[15:0];
	LD_fb_tmp <= LD_fb;
	add_1014_tmp <= add[14:10];
	C1 <= add_1014_tmp;
	C2 <= C1;
	C3 <= C2;
	CA <= add[9:5];
	CB <= add[4:0];
	
end		
				
endmodule
