`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:54:16 10/01/2019 
// Design Name: 
// Module Name:    MIPS 
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
module MIPS(
    input [7:0] data_in,
    input clk,
    input interrupt,
    input reset,
    input [7:0]  data_out,
    input [23:0] ins,
    input [7:0] A,
    input [7:0] B,
    input [7:0] Current_Address,
    input [7:0] ans_ex,
    input [7:0] ans_dm,
    input [7:0] ans_wb,
    input [1:0] mux_sel_A,
    input [1:0] mux_sel_B,
    input imm_sel
    );


endmodule
