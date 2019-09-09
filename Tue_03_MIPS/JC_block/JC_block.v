`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:43:34 09/10/2019 
// Design Name: 
// Module Name:    JC_block 
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
module JC_block(
    input [15:0] jmp_address_pm,
    input [15:0] current_address,
    input [5:0] op,
    input [1:0] flag_ex,
    input interrupt,
    input clk,
    input reset,
    output [15:0] jmp_loc,
    output pc_mux_sel
);
wire JV;
wire JNV;
wire JZ;
wire JNZ;
wire JMP;
wire RET;

wire [1:0] flag_mux_1;
wire [1:0] flag_mux_2;
reg [1:0] flag_reg;

wire [15:0] nxt_address;
wire [15:0] current_address_mux;
reg [15:0] current_address_reg;

wire [15:0] jmp_address_mux;

reg F1;
reg F2;

assign JV =  ~op[5] & op[4] & op[3] & op[2] & ~op[1] & ~op[0] ;
assign JNV = ~op[5] & op[4] & op[3] & op[2] & ~op[1] & op[0] ;
assign JZ =  ~op[5] & op[4] & op[3] & op[2] & op[1] & ~op[0] ;
assign JNZ = ~op[5] & op[4] & op[3] & op[2] & op[1] & op[0] ;
assign JMP = ~op[5] & op[4] & op[3] & ~op[2] & ~op[1] & ~op[0] ;

assign RET = ~op[5] & op[4] & ~op[3] & ~op[2] & ~op[1] & ~op[0] ;


assign flag_mux_1 = (F2) ? flag_ex : flag_reg ;
assign flag_mux_2 = (RET) ? flag_reg : flag_ex ;

assign nxt_address = current_address + 1;
assign current_address_mux = (interrupt)? nxt_address : current_address_reg ;

assign jmp_address_mux = (F1) ? 'hf000 :jmp_address_pm;

assign jmp_loc = (RET) ? current_address_reg : jmp_address_mux ;

assign pc_mux_sel = ( JV & flag_mux_2[0] ) | ( ~flag_mux_2[0] & JNV ) | ( JZ & flag_mux_2[1] ) | ( ~flag_mux_2[1] & JNZ ) | JMP | RET | F1 ;

always @(posedge clk ) begin
    flag_reg = flag_mux_1 ;
    current_address_reg = current_address_mux ;
    F1 = interrupt;
    F2 = F1;
end

endmodule //


