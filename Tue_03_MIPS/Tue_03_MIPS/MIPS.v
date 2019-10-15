`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:45:20 10/09/2019 
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

    
JC_block jc(ins[25:10], Current_Address,ins[31:26],flag_ex,interrupt,clk,reset,jmp_loc,pc_mux_sel);
//JC_block(input [15:0] jmp_address_pm,input [15:0] current_address,input [5:0] op,input [1:0] flag_ex,input interrupt,input clk,input reset,output [15:0] jmp_loc,output pc_mux_sel);

stall_control_block sc(ins[31:26], clk, reset,stall,stall_pm);
//stall_control_block(input [5:0] op,input clk,input reset,output stall,output reg stall_pm);

program_memory_block pm(ins,Current_Address, jmp_loc,pc_mux_sel,stall,stall_pm,reset,clk);
//program_memory_block(output [31:0] ins,output [15:0] current_address,input [15:0] jmp_loc,input pc_mux_sel,input stall,input stall_pm,input reset,input clk);

Register_Bank_Block reg_bank(ans_ex,ans_dm,ans_wb,imm,ins[20:16],ins[15:11],RW_dm,mux_sel_A,mux_sel_B,imm_sel,clk,A,B);
//Register_Bank_Block(input [15:0] ans_ex,input [15:0] ans_dm,input [15:0] ans_wb,input [15:0] imm,input [4:0] RA,input [4:0] RB,input [4:0] RW_dm,input [1:0] mux_sel_A,input [1:0] mux_sel_B,
//input imm_sel,input clk,output [15:0] A,output [15:0] B);

execution_block ex(A, B, data_in,op_dec,clk,reset, ans_ex,DM_data,data_out,flag_ex);
//execution_block(input [15:0] A,input [15:0] B,input [15:0] data_in,input [5:0] op_dec,input clk,input reset,outputreg[15:0]ans_ex,output reg[15:0]DM_data,output reg[15:0]data_out,output[1:0]flag_ex);

Data_Memory_Block dm( ans_ex, DM_data, mem_rw_ex, mem_en_ex, mem_mux_sel_dm,reset,clk,ans_dm);
//Data_Memory_Block(input [15:0] ans_ex,input [15:0] DM_data,input mem_rw_ex,input mem_en_ex,input mem_mux_sel_dm,input reset,input clk,output [15:0] ans_dm);

dc_block dc(ins, clk, reset, imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm);
//dc_block(input [31:0]ins,input clk,input reset,output reg [15:0] imm,output reg[5:0]op_dec,output [4:0] RW_dm,output [1:0] mux_sel_A,output [1:0] mux_sel_B,output reg imm_sel,
//output reg mem_en_ex,output reg mem_rw_ex,output reg mem_mux_sel_dm);

write_back_block wb(ans_dm, clk, reset, ans_wb);
//write_back_block(input [15:0] ans_dm,input clk,input reset,output reg [15:0] ans_wb  );
endmodule
