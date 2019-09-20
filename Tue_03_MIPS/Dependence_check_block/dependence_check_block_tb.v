`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:03:10 09/20/2019
// Design Name:   dependency_check_block
// Module Name:   C:/Users/patel/Desktop/CLG/Arpit/co_lab/co_lab/Tue_03_MIPS/Dependence_check_block/dependence_check_block_tb.v
// Project Name:  Dependence_check_block
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dependency_check_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dependence_check_block_tb;

	// Inputs
	reg [31:0] ins;
	reg clk;
	reg reset;

	// Outputs
	wire [5:0] op_dec;
	wire [4:0] RW_dm;
	wire [15:0] imm;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel;
	wire mem_rw_ex;
	wire mem_en_ex;
	wire mem_mux_sel_dm;

	// Instantiate the Unit Under Test (UUT)
	dependency_check_block uut (
		.ins(ins), 
		.clk(clk), 
		.reset(reset), 
		.op_dec(op_dec), 
		.RW_dm(RW_dm), 
		.imm(imm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_en_ex(mem_en_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm)
	);

     
		always begin
      clk = 1;
      forever #5 clk = ~clk;
      end
		
	initial begin
		#10;
		ins = 'b000000_00001_00010_00011_00000000000;
		#10;
		ins = 'b010100_00100_00001_00000_00000000000;
		#20;
		ins = 'b000100_00101_00001_00100_00000000000;
		#10;
		ins = 'b001101_00110_00001_00000_00000000101;
		
		

	end
      
endmodule

