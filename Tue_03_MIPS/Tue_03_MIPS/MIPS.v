`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:35:59 10/15/2019 
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
    input [15:0] data_in,
    input clk,
    input interrupt,
    input reset,
    output [15:0] data_out,
    output [31:0] ins,
    output [15:0] A,
    output [15:0] B,
    output [15:0] Current_Address,
    output [15:0] ans_ex,
    output [15:0] ans_dm,
    output [15:0] ans_wb,
    output [1:0] mux_sel_A,
    output [1:0] mux_sel_B,
    output imm_sel
    );

wire stall,stall_pm,pc_mux_sel;
wire [15:0] jmp_loc;
wire [1:0] flag_ex;
wire [15:0] DM_data;
wire [15:0] imm;
wire [5:0] op_dec;
wire [4:0] RW_dm;
wire mem_en_ex,mem_rw_ex,mem_mux_sel_dm;
    
//JC_block jc(ins[25:10], Current_Address,ins[31:26],flag_ex,interrupt,clk,reset,jmp_loc,pc_mux_sel);
JC_block jc(
    .jmp_address_pm(ins[14:0]),
    .current_address(Current_Address),
    .op(ins[31:26]),
    .flag_ex(flag_ex),
    .interrupt(interrupt),
    .clk(clk),
    .reset(reset),
    .jmp_loc(jmp_loc),
    .pc_mux_sel(pc_mux_sel)
    );
//stall_control_block sc(ins[31:26], clk, reset,stall,stall_pm);
stall_control_block sc(
    .op(ins[31:26]),
    .clk(clk),
    .reset(reset),
    .stall(stall),
    .stall_pm(stall_pm)
    );
//program_memory_block pm(ins,Current_Address, jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);
program_memory_block pm(
    .ins(ins),
    .current_address(Current_Address),
    .jmp_loc(jmp_loc),
    .pc_mux_sel(pc_mux_sel),
    .stall(stall),
    .stall_pm(stall_pm),
    .reset(reset),
    .clk(clk)
    );
//Register_Bank_Block reg_bank(ans_ex,ans_dm,ans_wb,imm,ins[20:16],ins[15:11],RW_dm,mux_sel_A,mux_sel_B,imm_sel,clk,A,B);
Register_Bank_Block reg_bank(
    .ans_ex(ans_ex),
    .ans_dm(ans_dm),
    .ans_wb(ans_wb),
    .imm(imm),
    .RA(ins[20:16]),
    .RB(ins[15:11]),
    .RW_dm(RW_dm),
    .mux_sel_A(mux_sel_A),
    .mux_sel_B(mux_sel_B),
    .imm_sel(imm_sel),
    .clk(clk),
    .A(A),
    .B(B)
    );
//execution_block ex(A, B, data_in,op_dec,clk,reset, ans_ex,DM_data,data_out,flag_ex);
execution_block ex(
		.A(A),
		.B(B),
      .data_in(data_in),
      .op_dec(op_dec),
      .clk(clk),
      .reset(reset),
      .ans_ex(ans_ex),
      .DM_data(DM_data),
      .data_out(data_out),
      .flag_ex(flag_ex)
		);

//Data_Memory_Block dm( ans_ex, DM_data, mem_rw_ex, mem_en_ex, mem_mux_sel_dm,reset,clk,ans_dm);
Data_Memory_Block dm(
	 .ans_ex(ans_ex),
    .DM_data(DM_data),
    .mem_rw_ex(mem_rw_ex),
    .mem_en_ex(mem_en_ex),
    .mem_mux_sel_dm(mem_mux_sel_dm),
    .reset(reset),
    .clk(clk),
    .ans_dm(ans_dm)
    );
//dc_block dc(ins, clk, reset, imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm);
dc_block dc(
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

//write_back_block wb(ans_dm, clk, reset, ans_wb);
write_back_block wb(
    .ans_dm(ans_dm),
    .clk(clk),
    .reset(reset),
    .ans_wb(ans_wb)
    );
	 
endmodule
