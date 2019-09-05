`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:33:18 09/03/2019
// Design Name:   stall_control_block
// Module Name:   C:/Users/student/Desktop/Tue_03_MIPS/Stall_Control_Block/stall_control_block_tb.v
// Project Name:  Stall_Control_Block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: stall_control_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module stall_control_block_tb;

	// Inputs
	reg [5:0] op;
	reg clk;
	reg reset;

	// Outputs
	wire stall;
	wire stall_pm;

	// Instantiate the Unit Under Test (UUT)
	stall_control_block uut (
		.op(op), 
		.clk(clk), 
		.reset(reset), 
		.stall(stall), 
		.stall_pm(stall_pm)
	);
    
   always begin
clk=0;
forever #5 clk = ~clk;
end
	initial begin
		
		op = 0;
		clk = 0;
		reset = 1; 
		#2
		reset=0;
		
		#6
		reset=1;
		
		#8
		op=6'b010100;
		
		#20
		op=6'b000000;
		#10
		op=6'b011110;
		#30
		op=6'b000000;
		#10
		op=6'b010001;
		
		end
		
	endmodule
	