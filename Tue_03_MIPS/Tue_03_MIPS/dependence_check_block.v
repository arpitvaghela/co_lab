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
    output [15:0] imm,
    output [5:0] op_dec,
    output [4:0] RW_dm,
    output [1:0] mux_sel_A,
    output [1:0] mux_sel_B,
    output imm_sel,
    output mem_en_ex,
    output mem_rw_ex,
    output mem_mux_sel_dm
    );
/*
wire JMP,Cond_J,LD_fb,Imm,ld,ST;
wire LD_tmp,LD_final;

assign JMP = ~ins[5] & ins[4] & ins[3] & ~ins[2] & ~ins[1] & ~ins[0];
assign Cond_J = ~ins[5] & ins[4] & ins[3] & ins[2];
assign LD_fb = ~ins[5] & ins[4] & ~ins[3] & ins[2] & ~ins[1] & ~ins[0];
assign Imm = ~ins[5] & ~ins[4] & ins[3];
assign ld = ~ins[5] & ins[4] & ~ins[3] & ins[2] & ~ins[1] & ~ins[0];
assign ST = ~ins[5] & ins[4] & ~ins[3] & ins[2] & ~ins[1] & ins[0];

assign LD_final = ld & LD_tmp;

always @(posedge clk)
begin
    op_dec <= ins[31:26];
    LD_tmp <= LD_final;
end*/
endmodule
