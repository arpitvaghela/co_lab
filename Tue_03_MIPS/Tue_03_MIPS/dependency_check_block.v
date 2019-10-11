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
    output reg [4:0] RW_dm,
    output [1:0] mux_sel_A,
    output [1:0] mux_sel_B,
    output reg imm_sel,
    output reg mem_en_ex,
    output reg mem_rw_ex,	
    output reg mem_mux_sel_dm
	);
reg [4:0] C1;
reg [4:0] C2;
reg [4:0] C3;
reg [4:0] CA;
reg [4:0] CB;
reg [4:0] add1410tmp;
    
wire JMP,Cond_J,LD_fb,Imm,ld,ST;
wire LD_final;
reg LD_tmp,ST_tmp,mmsd_tmp,ins_0_tmp,LD_fb_final;
wire [14:0] extended_signal;
wire signal;

wire [14:0] add;
wire [4:0] C1_tmp;
wire [4:0] C2_tmp;
wire [4:0] add1410tmp_1;

assign JMP = ~ins[5] & ins[4] & ins[3] & ~ins[2] & ~ins[1] & ~ins[0];
assign Cond_J = ~ins[5] & ins[4] & ins[3] & ins[2];
assign LD_fb = ~ins[5] & ins[4] & ~ins[3] & ins[2] & ~ins[1] & ~ins[0];
assign Imm = ~ins[5] & ~ins[4] & ins[3];
assign ld = ~ins[5] & ins[4] & ~ins[3] & ins[2] & ~ins[1] & ~ins[0];
assign ST = ~ins[5] & ins[4] & ~ins[3] & ins[2] & ~ins[1] & ins[0];

assign LD_final = ld & LD_tmp;
assign mem_en_ex_tmp = LD_tmp | ST_tmp;
assign mmsd = ~ins_0_tmp & mem_en_ex_tmp;

//extend address signal
assign signal = ~(JMP | Cond_J | LD_fb_final);
assign extended_signal = {15{signal}};
assign add = extended_signal & ins[25:11];
//comparator outputs
assign mux_sel_A = (C3 == CA) ? 2'b11:
				(C2 == CA) ? 2'b10:
				(C1 == CA) ? 2'b01:2'b00;

assign mux_sel_B = (C3 == CB) ? 2'b11:
				(C2 == CB) ? 2'b10:
				(C1 == CB) ? 2'b01:2'b00;
				
assign C1_tmp = C1;
assign C2_tmp = C2;
assign add1410tmp_1 = add1410tmp;

always @(posedge clk)
begin

    if(reset)
       begin
        ins_0_tmp = ins[0];
        mem_rw_ex = ins_0_tmp;
        LD_tmp = LD_final;
        ST_tmp = ST;
        mmsd_tmp = mmsd;
        mem_mux_sel_dm = mmsd_tmp;
        mem_en_ex = mem_en_ex_tmp;
    
        imm_sel = Imm;
    
        op_dec = ins[31:26];
    
        LD_fb_final = LD_fb;
    
        imm = ins[15:0];
    
        add1410tmp = add[14:10];
        C1 = add1410tmp_1;
        C2 = C1_tmp;
        C3 = C2_tmp;
        CA = add[9:5];
        CB = add[4:0];
        RW_dm = C1;
       end
       
       else begin
            ins_0_tmp =0;
        mem_rw_ex = 0;
        LD_tmp = 0;
        ST_tmp = 0;
        mmsd_tmp = 0;
        mem_mux_sel_dm =0;
        mem_en_ex =0;
    
        imm_sel = 0;
    
        op_dec = 0;
    
        LD_fb_final =0;
    
        imm = 0;
    
        add1410tmp = 0;
        C1 = 0;
        C2 = 0;
        C3 = 0;
        CA = 0;
        CB = 0;
        RW_dm = 0;
       end
   
end
endmodule
