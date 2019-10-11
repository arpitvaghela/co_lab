`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:26:15 09/06/2019
// Design Name:   write_back_block
// Module Name:   C:/Users/patel/Desktop/Arpit/co_lab/co_lab/Tue_03_MIPS/Write_Back_Block/WriteBack_tb.v
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

module WriteBack_tb;

	// Inputs
	reg [15:0] ans_dm;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] ans_wb;

	// Instantiate the Unit Under Test (UUT)
	write_back_block uut (
		.ans_dm(ans_dm), 
		.clk(clk), 
		.reset(reset), 
		.ans_wb(ans_wb)
	);
always begin
        clk = 0;
        forever #5 clk = ~clk;
    end
	
	initial begin
            
        ans_dm = 'h0034;
		reset  = 1;
        #2;
        reset = 0;
        #6;
        reset = 1;
        ans_dm = 'h1111;
        #5;
        ans_dm = 'h3331;
		
	end
    
      
endmodule

