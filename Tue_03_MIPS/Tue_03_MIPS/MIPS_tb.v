`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:04:45 10/14/2019
// Design Name:   MIPS
// Module Name:   C:/Users/patel/Desktop/CLG/Arpit/co_lab/co_lab/Tue_03_MIPS/Tue_03_MIPS/MIPS_tb.v
// Project Name:  Tue_03_MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MIPS
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module MIPS_tb;

	// Inputs
	reg [15:0] data_in;
	reg clk;
	reg interrupt;
	reg reset;

	// Outputs
	wire [15:0] data_out;
	wire [31:0] ins;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] Current_Address;
	wire [15:0] ans_ex;
	wire [15:0] ans_dm;
	wire [15:0] ans_wb;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel;

	// Instantiate the Unit Under Test (UUT)
	MIPS uut (
		.data_in(data_in), 
		.clk(clk), 
		.interrupt(interrupt), 
		.reset(reset), 
		.data_out(data_out), 
		.ins(ins), 
		.A(A), 
		.B(B), 
		.Current_Address(Current_Address), 
		.ans_ex(ans_ex), 
		.ans_dm(ans_dm), 
		.ans_wb(ans_wb), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel)
	);

	always begin
        clk = 0;
        forever #500 clk = ~clk;
    end
	initial begin
		data_in = 0;
		interrupt = 0;
		clk = 0;
		reset = 1;
		#200; reset = 0;
		#500; reset = 1;
	end
      
endmodule

