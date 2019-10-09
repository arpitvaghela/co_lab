`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date : Tue Aug 27 2019 15:54 IST
// Module Name : Data_Memory_Block
// Group Members : Arpitsinh Vaghela AU1841034
//	 	   Dhruvil Dave AU1841003
//		   Nisarg Thoria AU1841142
//		   Razin Mansuri AU1841097
//////////////////////////////////////////////////////////////////////////////////
module Data_Memory_Block(
    input [15:0] ans_ex,
    input [15:0] DM_data,
    input mem_rw_ex,
    input mem_en_ex,
    input mem_mux_sel_dm,
    input reset,
    input clk,
    output [15:0] ans_dm
    );
reg [15:0] Ex_out;
wire [15:0] DM_out;

data_mem d_m(
  .clka(clk), // input clka
  .ena(mem_en_ex), // input ena
  .wea(mem_rw_ex), // input [0 : 0] wea
  .addra(ans_ex), // input [15 : 0] addra
  .dina(DM_data), // input [15 : 0] dina
  .douta(DM_out) // output [15 : 0] douta
);

always @(posedge clk)
begin
    if(reset)
       begin
            Ex_out = ans_ex;
       end
       
       else begin
            Ex_out = 0;
       end
       
		 
	
end

assign ans_dm = (mem_mux_sel_dm == 1'b0)? Ex_out : DM_out;

endmodule
