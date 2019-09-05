`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:00:52 09/03/2019
// Design Name:   program_memory_block
// Module Name:   C:/Users/student/Desktop/Tue_03_MIPS/PM_Block/program_memory_block_tb.v
// Project Name:  PM_Block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: program_memory_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module program_memory_block_tb;

	// Inputs
	reg [15:0] jmp_loc;
	reg pc_mux_sel;
	reg stall;
	reg stall_pm;
	reg reset;
	reg clk;

	// Outputs
	wire [31:0] ins;
	wire [15:0] current_address;

	// Instantiate the Unit Under Test (UUT)
	program_memory_block uut (
		.ins(ins), 
		.current_address(current_address), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel), 
		.stall(stall), 
		.stall_pm(stall_pm), 
		.reset(reset), 
		.clk(clk)
	);

	 always begin
        clk = 0;
        forever #5 clk = ~clk;
	end
	
	initial begin
		reset = 1;
		jmp_loc = 'h0008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		
		#2
		reset = 0;
		jmp_loc = 'h0008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		
		#6
		reset = 1;
		jmp_loc = 'h0008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		
		#2
		reset = 1;
		jmp_loc = 'h0008;
		pc_mux_sel = 0;
		stall = 0;
		stall_pm = 0;
		
		#30
		reset = 1;
		jmp_loc = 'h0008;
		pc_mux_sel = 0;
		stall = 1;
		stall_pm = 0;
		
		#10
		reset = 1;
		jmp_loc = 'h0008;
		pc_mux_sel = 0;
		stall = 0;
		stall_pm = 1;
		
		#10
		reset = 1;
		jmp_loc = 'h0008;
		pc_mux_sel = 1;
		stall = 0;
		stall_pm = 0;
		
		
	end
      
endmodule

