`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:16:18 09/03/2019
// Design Name:   write_back_block
// Module Name:   C:/Users/student/Desktop/Tue_03_MIPS/Write_Back_Block/write_back_block_tb.v
// Project Name:  Write_Back_Block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: write_back_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module write_back_block_tb;

	// Inputs
	reg [15:0] ans_dm;
	reg clk;
	reg reset;
	wire [15:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	write_back_block uut (
		.ans_dm(ans_dm), 
		.clk(clk), 
		.reset(reset), 
		.ans_wb(ans_wb)
	);

      
endmodule

