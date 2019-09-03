`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:21 09/03/2019 
// Design Name: 
// Module Name:    write_back_block 
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
module write_back_block(
    input [15:0] ans_dm,
    input clk,
    input reset,
    output reg [15:0] ans_wb
    );
    always @(posedge clk)
    begin
       if(reset)
       begin
            ans_wb  <= ans_dm;
       end
       
       else begin
            ans_wb <= 0;
       end
    end

endmodule
