`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:15:48 09/03/2019
// Design Name:   Data_Memory_Block
// Module Name:   C:/Users/student/Desktop/Tue_03_MIPS/data_memory_block/Data_Memory_Block_tb.v
// Project Name:  data_memory_block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Data_Memory_Block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Data_Memory_Block_tb;

	// Inputs
	reg [15:0] ans_ex;
	reg [15:0] DM_data;
	reg mem_rw_ex;
	reg mem_en_ex;
	reg mem_mux_sel_dm;
	reg reset;
	reg clk;

	// Outputs
	wire [15:0] ans_dm;

	// Instantiate the Unit Under Test (UUT)
	Data_Memory_Block uut (
		.ans_ex(ans_ex), 
		.DM_data(DM_data), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_en_ex(mem_en_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm), 
		.reset(reset), 
		.clk(clk), 
		.ans_dm(ans_dm)
	);

	  always begin
        clk = 0;
        forever #5 clk = ~clk;
        end
		  
	initial begin
		// Initialize Inputs
		ans_ex = 'h0003;
		DM_data = 'hffff;
		mem_rw_ex = 0;
		mem_en_ex = 0;
		mem_mux_sel_dm = 0;
		reset = 1;
		#2;
		reset = 0;
		#6;
		reset =1;
		#2;
		mem_en_ex = 1;
		mem_mux_sel_dm = 1;
		#10;
		mem_rw_ex = 1;
		#10;
		mem_rw_ex = 0;


	end
      
endmodule

