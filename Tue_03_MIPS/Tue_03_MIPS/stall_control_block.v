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
    
    
    assign HLT = op[0] & (~op[1]) & (~op[2]) & (~op[3]) & op[4] & (~op[5]);
    
    assign ld  = (~op[0]) & (~op[1]) & op[2] & (~op[3]) & op[4] & (~op[5]) & (~ldD0);
    
    assign JUMP = op[2] & op[3] & op[4] & (~op[5]) &( ~jumpD1);
    
    assign stall = HLT | ld | JUMP;
    
    
    always @(posedge clk)
    begin
			if(reset)begin
					ldD0 <= ld;
					jumpD0 <= JUMP;
					jumpD1 <= jumpD0;
					stall_pm <= stall;
            end
			else begin
					ldD0 <= 0;
					jumpD0 <= 0;
					jumpD1 <= 0;
					stall_pm <= 0;
			
			end
     end
    
    
endmodule
