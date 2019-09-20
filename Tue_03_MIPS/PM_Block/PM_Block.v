`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Create Date:    Tue Aug 20 2019 13:21:00 IST
// Module Name:    execution block (ALU)
// Group Members : Arpitsinh Vaghela AU1841034
//                 Dhruvil Dave AU1841003
//                 Nisarg Thoria AU1841142
//                 Razin Mansuri AU1841097
//////////////////////////////////////////////////////////////////////////////////

module program_memory_block(
    output [31:0] ins,
    output [15:0] current_address,
    input [15:0] jmp_loc,
    input pc_mux_sel,
    input stall,
    input stall_pm,
    input reset,
    input clk
    );
    
    wire [31:0] PM_out;
    wire [15:0] hold_address_tmp;
    wire [15:0] next_address_tmp;
    wire [31:0] ins_prv_tmp;
	wire [31:0] ins_pm;
	 
    prog_mem ROM (
       .clka(clk), // input clka
       .addra(current_address), // input [15 : 0] addra
       .douta(PM_out) // output [31 : 0] douta
    );

    reg [15:0] hold_address;
    reg [15:0] next_address;
    wire [15:0] CAJ;
    wire [15:0] CAR; 
    reg [31:0] ins_prv;
    
    assign CAJ = (stall == 1'b0) ? next_address : hold_address;
    assign CAR = (pc_mux_sel == 1'b0) ? CAJ : jmp_loc;
    assign current_address  = (reset == 1'b0) ? 16'b0 : CAR;

    // instruction assignmnet
    assign ins_pm = (stall_pm == 1'b0) ? PM_out : ins_prv_tmp;
    assign ins = (reset == 1'b0) ? 32'b0 : ins_pm;
    
    // reg assignmnets
    // assign hold_address
    assign hold_address_tmp = (reset == 1'b0) ? 16'b0 : current_address;
    assign next_address_tmp = (reset == 1'b0) ? 16'b0 : current_address + 16'b0000000000000001;
    assign ins_prv_tmp = (reset == 1'b0) ? 32'b0 : ins;

    always @ (posedge clk) begin
        hold_address <= hold_address_tmp;
        next_address <= next_address_tmp;
        ins_prv <= ins_prv_tmp;
    end
    
endmodule
