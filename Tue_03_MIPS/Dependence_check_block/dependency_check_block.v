`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:22:56 09/17/2019 
// Design Name: 
// Module Name:    dependency_check_block 
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
module dependency_check_block(
    input [31:0] ins,
    input clk,
    input reset,
    output reg [5:0] op_dec,
    output [4:0] RW_dm,
    output reg [15:0] imm,
    output [1:0] mux_sel_A,
    output [1:0] mux_sel_B,
    output reg imm_sel,
    output reg mem_rw_ex,
    output reg mem_en_ex,
    output reg mem_mux_sel_dm
    );
wire JMP, Cond_J, LD_fb, Imm, ld, ST ;
reg LD_fb_q0;
reg op_dec_reg[5:0];
reg mem_q00, mem_q01, mem_q02, mem_q10;
reg [4:0]add_5_9;
reg [4:0]add_0_4;
reg [4:0]add_10_14_1;
reg [4:0]add_10_14_2;
reg [4:0]add_10_14_3;
reg [4:0]add_10_14_4;

wire ld_mem_gate, q01_or_q02, q_and_q00;
wire [14:0] extended_signal;
wire [14:0] addresses;

wire comp_00;
wire comp_01;
wire comp_02;
wire comp_10;
wire comp_11;
wire comp_12;

wire pri_in_01 , pri_in_02 , pri_in_03 , pri_in_11 , pri_in_12 , pri_in_13;

assign JMP = ~ins[31] & ins[30] & ins[29] & ~ins[28] & ~ins[27] & ~ins[26];
assign Cond_J = ~ins[31] & ins[30] & ins[29] & ins[28];
assign LD_fb = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ~ins[26] & ~LD_fb_q0; //from flipflop

assign extended_signal = {15{~(JMP | Cond_J | LD_fb_q0)}};
assign addresses = extended_signal & ins[25:11];

assign comp_00 = (add_10_14_2 == add_5_9) ? 1 : 0;
assign comp_01 = (add_10_14_3 == add_5_9) ? 1 : 0; 
assign comp_02 = (add_10_14_4 == add_5_9) ? 1 : 0;

assign comp_10 = (add_10_14_2 == add_0_4) ? 1 : 0;
assign comp_11 = (add_10_14_3 == add_0_4) ? 1 : 0;
assign comp_12 = (add_10_14_4 == add_0_4) ? 1 : 0;

assign pri_in_01 = comp_00;
assign pri_in_02 = (~comp_00 & comp_01);
assign pri_in_03 = (~comp_00 & ~comp_01 & comp_02);

assign pri_in_11 = comp_10;
assign pri_in_12 = (~comp_10 & comp_11);
assign pri_in_13 = (~comp_10 & ~comp_11 & comp_12);

assign mux_sel_A = (pri_in_03)? 2'b11:(pri_in_02)? 2'b10:(pri_in_01)? 01:00;
assign mux_sel_B = (pri_in_13)? 2'b11:(pri_in_12)? 2'b10:(pri_in_11)? 01:00;


assign Imm = ~ins[31] & ~ins[30] & ins[29];

assign ld = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ~ins[26];
assign ST = ~ins[31] & ins[30] & ~ins[29] & ins[28] & ~ins[27] & ins[26];

assign ld_mem_gate = ld & ~mem_q01;
assign q01_or_q02 = mem_q02 | mem_q01;
assign q_and_q00  = q01_or_q02 & ~(mem_q00);



always @(posedge clk)begin

    op_dec  = ins[31:26];
    imm = ins[15:0];
    imm_sel = Imm;
    mem_q01 = ld_mem_gate;
    mem_q00 = ins[26];
    mem_rw_ex = mem_q00;
    mem_q02 = ST;
    mem_en_ex = q01_or_q02;
    mem_q10 = q_and_q00;
    mem_mux_sel_dm = mem_q10;
    add_10_14_1 = addresses[14:10];
    add_10_14_2 = add_10_14_1;
    add_10_14_3 = add_10_14_2;
    add_10_14_4 = add_10_14_3;
    add_5_9 = addresses[9:5];
    add_0_4 = addresses[4:0];
    
end

endmodule
