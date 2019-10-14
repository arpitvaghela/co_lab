`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:23:30 10/01/2019
// Design Name:   dependence_check_block
// Module Name:   C:/Users/student/Desktop/co_lab/co_lab/Tue_03_MIPS/dependency/dependency_check_tb.v
// Project Name:  dependency
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dependence_check_block
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module dependency_check_tb;

	// Inputs
	reg [31:0] ins;
	reg clk;
	reg reset;

	// Outputs
	wire [15:0] imm;
	wire [5:0] op_dec;
	wire [4:0] RW_dm;
	wire [1:0] mux_sel_A;
	wire [1:0] mux_sel_B;
	wire imm_sel;
	wire mem_en_ex;
	wire mem_rw_ex;
	wire mem_mux_sel_dm;

	// Instantiate the Unit Under Test (UUT)
	dc_block uut (
		.ins(ins), 
		.clk(clk), 
		.reset(reset), 
		.imm(imm), 
		.op_dec(op_dec), 
		.RW_dm(RW_dm), 
		.mux_sel_A(mux_sel_A), 
		.mux_sel_B(mux_sel_B), 
		.imm_sel(imm_sel), 
		.mem_en_ex(mem_en_ex), 
		.mem_rw_ex(mem_rw_ex), 
		.mem_mux_sel_dm(mem_mux_sel_dm)
	);

	always begin
      clk = 1;
      forever #5 clk = ~clk;
      end
		
	initial begin
        #2
        reset = 0;
        #2
        reset = 1;
		#16;
		ins = 'b000000_00001_00010_00011_00000000000;
		#10;
		ins = 'b010100_00100_00001_00000_00000000000;
		#20;
		ins = 'b000100_00101_00001_00100_00000000000;
		#10;
		ins = 'b001101_00110_00001_00000_00000000101;
	
	end
endmodule

