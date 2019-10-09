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
wire LD_final;
reg LD_tmp,ST_tmp,mmsd_tmp,ins_0_tmp,LD_fb_final;
wire extended_signal [14:0];
wire signal;

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
assign extended_signal = signal ? 15'b1: 15'b0;

always @(posedge clk)
begin
    ins_0_tmp = ins[0];
    mem_rw_ex <= ins_0_tmp;
    LD_tmp <= LD_final;
    ST_tmp <= ST;
    mmsd_tmp <= mmsd;
    mem_mux_sel_dm <= mmsd_tmp;
    mem_en_ex <= mem_en_ex_tmp;
    
    imm_sel <= Imm;
    
    op_dec <= ins[31:26];
    
    LD_fb_final <= LD_fb;
    
    imm <= ins[15:0];
    
end
endmodule
