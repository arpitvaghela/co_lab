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

wire [31:0] ins_tmp;
wire [15:0] A_tmp;
wire [15:0] B_tmp;
wire [15:0] Current_Address_tmp;
wire [15:0] ans_ex_tmp;
wire [15:0] ans_dm_tmp;
wire [15:0] ans_wb_tmp;
wire [1:0] mux_sel_A_tmp;
wire [1:0] mux_sel_B_tmp;
wire imm_sel_tmp;   

wire stall_tmp,stall_pm_tmp,pc_mux_sel_tmp;
wire [15:0] jmp_loc_tmp;
wire [1:0] flag_ex_tmp;
wire [15:0] DM_data_tmp;
wire [15:0] imm_tmp;
wire [5:0] op_dec_tmp;
wire [4:0] RW_dm_tmp;
wire mem_en_ex_tmp,mem_rw_ex_tmp,mem_mux_sel_dm_tmp;

assign ins_tmp = ins;
assign A_tmp = A;
assign B_tmp = B;
assign Current_Address_tmp = Current_Address;
assign ans_ex_tmp = ans_ex;
assign ans_dm_tmp = ans_dm;
assign ans_wb_tmp = ans_wb;
assign mux_sel_A_tmp = mux_sel_A;
assign mux_sel_B_tmp = mux_sel_B;
assign imm_sel_tmp = imm_sel; 

assign stall_tmp  = stall;
assign stall_pm_tmp  = stall_pm;
assign pc_mux_sel_tmp = pc_mux_sel;
assign jmp_loc_tmp = jmp_loc;
assign flag_ex_tmp = flag_ex;
assign DM_data_tmp = DM_data;
assign imm_tmp = imm;
assign op_dec_tmp = op_dec;
assign RW_dm_tmp = RW_dm;
assign mem_en_ex_tmp = mem_en_ex;
assign mem_rw_ex_tmp = mem_rw_ex;
assign mem_mux_sel_dm_tmp = mem_mux_sel_dm;

JC_block jc(ins_tmp[15:0], Current_Address_tmp,ins_tmp[31:26],flag_ex_tmp,interrupt,clk,reset,jmp_loc,pc_mux_sel);
//JC_block(input [15:0] jmp_address_pm,input [15:0] current_address,input [5:0] op,input [1:0] flag_ex,input interrupt,input clk,input reset,output [15:0] jmp_loc,output pc_mux_sel);

stall_control_block sc(ins_tmp[31:26], clk, reset,stall,stall_pm);
//stall_control_block(input [5:0] op,input clk,input reset,output stall,output reg stall_pm);

program_memory_block pm(ins,Current_Address, jmp_loc_tmp,pc_mux_sel_tmp,stall_tmp,stall_pm_tmp,reset,clk);
//program_memory_block(output [31:0] ins,output [15:0] current_address,input [15:0] jmp_loc,input pc_mux_sel,input stall,input stall_pm,input reset,input clk);

Register_Bank_Block reg_bank(ans_ex_tmp,ans_dm_tmp,ans_wb_tmp,imm_tmp,ins_tmp[20:16],ins_tmp[15:11],RW_dm_tmp,mux_sel_A_tmp,mux_sel_B_tmp,imm_sel_tmp,clk,A,B);
//Register_Bank_Block(input [15:0] ans_ex,input [15:0] ans_dm,input [15:0] ans_wb,input [15:0] imm,input [4:0] RA,input [4:0] RB,input [4:0] RW_dm,input [1:0] mux_sel_A,input [1:0] mux_sel_B,
//input imm_sel,input clk,output [15:0] A,output [15:0] B);

execution_block ex(A_tmp, B_tmp, data_in,op_dec_tmp,clk,reset, ans_ex,DM_data,data_out,flag_ex);
//execution_block(input [15:0] A,input [15:0] B,input [15:0] data_in,input [5:0] op_dec,input clk,input reset,outputreg[15:0]ans_ex,output reg[15:0]DM_data,output reg[15:0]data_out,output[1:0]flag_ex);

Data_Memory_Block dm(ans_ex_tmp, DM_data_tmp, mem_rw_ex_tmp, mem_en_ex_tmp, mem_mux_sel_dm_tmp,reset,clk,ans_dm);
//Data_Memory_Block(input [15:0] ans_ex,input [15:0] DM_data,input mem_rw_ex,input mem_en_ex,input mem_mux_sel_dm,input reset,input clk,output [15:0] ans_dm);

dc_block dc(ins_tmp, clk, reset, imm, op_dec, RW_dm, mux_sel_A, mux_sel_B, imm_sel, mem_en_ex, mem_rw_ex, mem_mux_sel_dm);
//dc_block(input [31:0]ins,input clk,input reset,output reg [15:0] imm,output reg[5:0]op_dec,output [4:0] RW_dm,output [1:0] mux_sel_A,output [1:0] mux_sel_B,output reg imm_sel,
//output reg mem_en_ex,output reg mem_rw_ex,output reg mem_mux_sel_dm);

write_back_block wb(ans_dm_tmp, clk, reset, ans_wb);
//write_back_block(input [15:0] ans_dm,input clk,input reset,output reg [15:0] ans_wb  );
endmodule
