`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date : Tue Aug 27 2019 14:01 IST
// Module Name : Register_Bank_Block
// Group Members : Arpitsinh Vaghela AU1841034
//	 	   Dhruvil Dave AU1841003
//		   Nisarg Thoria AU1841142
//		   Razin Mansuri AU1841097
//////////////////////////////////////////////////////////////////////////////////
module Register_Bank_Block(

     input [15:0] ans_ex,
    input [15:0] ans_dm,
    input [15:0] ans_wb,
    input [15:0] imm,
    input [4:0] RA,
    input [4:0] RB,
    input [4:0] RW_dm,
    input [1:0] mux_sel_A,
    input [1:0] mux_sel_B,
    input imm_sel,
    input clk,
    output [15:0] A,
    output [15:0] B
    );

reg [15:0] RegBank [31:0];
reg [15:0] AR;
reg [15:0] BR;
wire [15:0] BI;

//32 array element of size [15:0]
always @(posedge clk)
begin  
        AR = RegBank[RA];
        BR = RegBank[RB];
        RegBank[RW_dm] = ans_dm;
end


//assign A based on mux_sel_A values
assign A = (mux_sel_A == 2'b00) ? AR :
    (mux_sel_A == 2'b01) ? ans_ex :
    (mux_sel_A == 2'b10) ? ans_dm :
    (mux_sel_A == 2'b11) ? ans_wb : 0 ;

//assign BI based on mux_sel_B values
assign BI = (mux_sel_B == 2'b00) ? BR :
    (mux_sel_B == 2'b01) ? ans_ex :
    (mux_sel_B == 2'b10) ? ans_dm :
    (mux_sel_B == 2'b11) ? ans_wb : 0 ;

//assign B based on imm_sel values
assign B = (imm_sel == 1'b0) ? BI : imm ;




endmodule
