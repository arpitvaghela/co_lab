`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:26:14 09/03/2019 
// Design Name: 
// Module Name:    stall_control_block 
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
module stall_control_block(
    input [5:0] op,
    input clk,
    input reset,
    output stall,
    output reg stall_pm
    );
    
    wire HLT;
    wire ld;
    wire JUMP;
    
    reg ldD0;
    reg jumpD0;
    reg jumpD1;
    
    wire ldD0_tmp;
    wire jumpD0_tmp;
    wire jumpD1_tmp;
    wire stall_pm_tmp;
    
    assign HLT = op[0] & (~op[1]) & (~op[2]) & (~op[3]) & op[4] & (~op[5]);
    
    assign ld  = (~op[0]) & (~op[1]) & op[2] & (~op[3]) & op[4] & (~op[5]) & (~ldD0_tmp);
    
    assign JUMP = op[2] & op[3] & op[4] & (~op[5]) &( ~jumpD1_tmp);
    
    assign stall = HLT | ld | JUMP;
    
    assign ldD0_tmp = reset ? ld : 0 ;
    assign jumpD0_tmp = reset ? JUMP : 0;
    assign jumpD1_tmp = reset ? jumpD0 : 0;
    assign stall_pm_tmp = reset ? stall : 0;
    
    
    always @(posedge clk)
    begin
    
            ldD0 <= ldD0_tmp;
            jumpD0 <= jumpD0_tmp;
            jumpD1 <= jumpD1_tmp;
            stall_pm <= stall_pm_tmp;
            
     end
    
    
endmodule
