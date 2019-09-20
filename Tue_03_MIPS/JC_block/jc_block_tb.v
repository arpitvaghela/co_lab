`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:44:41 09/10/2019
// Design Name:   JC_block
// Module Name:   C:/Users/patel/Desktop/Arpit/co_lab/co_lab/lab_5/JC_block/jc_block_tb.v
// Project Name:  JC_block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: JC_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module jc_block_tb;

	// Inputs
	reg [15:0] jmp_address_pm;
	reg [15:0] current_address;
	reg [5:0] op;
	reg [1:0] flag_ex;
	reg interrupt;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] jmp_loc;
	wire pc_mux_sel;

	// Instantiate the Unit Under Test (UUT)
	JC_block uut (
		.jmp_address_pm(jmp_address_pm), 
		.current_address(current_address), 
		.op(op), 
		.flag_ex(flag_ex), 
		.interrupt(interrupt), 
		.clk(clk), 
		.reset(reset), 
		.jmp_loc(jmp_loc), 
		.pc_mux_sel(pc_mux_sel)
	);


	always begin
	clk = 0;
	forever #5 clk = ~clk;
	end
	
	initial begin
		// Initialize Inputs
		jmp_address_pm = 0;
		current_address = 'h0001;
		op = 'h00;
		flag_ex = 3;
		interrupt = 0;
		reset = 1;
<<<<<<< HEAD
		
		#16;//16
=======
        
        #1;
        reset = 0;
        #8;
        reset = 1;
		
		#7;//16
>>>>>>> 33d4a7707af5bb8cf2d1e73e4de8497d6baf2b41
		interrupt = 1;
		
		#10;//26
		interrupt = 0;
		reset = 1;
		jmp_address_pm = 'h0008;
	
		#10;//36
		op = 'h18;
		
		#20;//56
		op = 'h10;
		flag_ex = 0;
		
		#10;
		op = 'h1e;
		
	end
      
endmodule

