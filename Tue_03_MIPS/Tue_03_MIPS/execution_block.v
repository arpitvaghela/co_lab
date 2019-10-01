`timescale 1ns / 1ps
/*
 * execution_block
 *
 * __author__ = {
 *     'AU1841003': 'Dhruvil Dave',
 *     'AU1841034': 'Arpitsinh Vaghela',
 *     'AU1841097': 'Razin Mansuri',
 *     'AU1841142': 'Nisarg Thoriya'
 * }
 *
 * __datetime__ = 'Fri 30 Aug 2019 02:42:39 PM IST'
 */


module execution_block(input [15:0] A,
                       input [15:0] B,
                       input [15:0] data_in,
                       input [5:0] op_dec,
                       input clk,
                       input reset,
                       output reg [15:0] ans_ex,
                       output reg [15:0] DM_data,
                       output reg [15:0] data_out,
                       output [1:0] flag_ex);

    wire [15:0] ans_tmp;
    wire [15:0] data_out_buff;
    reg [1:0] flag_prv;

    assign {flag_ex[0], ans_tmp} = (op_dec == 6'b000000) ? A + B :  // ADD
                                   (op_dec == 6'b000001) ? A + (~B) + 1 :  // SUB
                                   (op_dec == 6'b000010) ? {1'b0, B} :  // MOV
                                   (op_dec == 6'b000100) ? {1'b0, A & B} :  // AND
                                   (op_dec == 6'b000101) ? {1'b0, A | B} :  // OR
                                   (op_dec == 6'b000110) ? {1'b0, A ^ B} :  // XOR
                                   (op_dec == 6'b000111) ? {1'b0, ~B} :  // NOT
                                   (op_dec == 6'b001000) ? A + data_in :  // ADI
                                   (op_dec == 6'b001001) ? A + (~data_in) + 1 :  // SBI
                                   (op_dec == 6'b001010) ? {1'b0, data_in} :  // MVI
                                   (op_dec == 6'b001100) ? {1'b0, A & data_in} :  // ANI
                                   (op_dec == 6'b001101) ? {1'b0, A | data_in} :  // ORI
                                   (op_dec == 6'b001110) ? {1'b0, A ^ data_in} :  // XRI
                                   (op_dec == 6'b001111) ? {1'b0, ~data_in} :  // NTI
                                   (op_dec == 6'b010000) ? {1'b0, ans_ex} :  // RET
                                   (op_dec == 6'b010001) ? {1'b0, ans_ex} :  // HLT
                                   (op_dec == 6'b010100) ? {1'b0, A} :  // LD
                                   (op_dec == 6'b010101) ? {1'b0, A} :  // ST
                                   (op_dec == 6'b010110) ? {1'b0, data_in} :  // IN
                                   (op_dec == 6'b010111) ? {1'b0, ans_ex} :  // OUT
                                   (op_dec == 6'b011000) ? {1'b0, ans_ex} :  // JMP
                                   (op_dec == 6'b011001) ? {1'b0, A << B} :  // LS
                                   (op_dec == 6'b011010) ? {1'b0, A >> B} :  // RS
                                   (op_dec == 6'b011011) ? {1'b0, $signed(A) >>> B} :  // RSA
                                   (op_dec == 6'b011100) ? {flag_prv[0], ans_ex} :  // JV
                                   (op_dec == 6'b011101) ? {flag_prv[0], ans_ex} :  // JNV
                                   (op_dec == 6'b011110) ? {flag_prv[0], ans_ex} :  // JZ
                                   (op_dec == 6'b011111) ? {flag_prv[0], ans_ex} :  // JNZ
                                   {1'b0, 16'b0};  // default


    assign data_out_buff = (op_dec == 6'b010111) ? A : 0;  // OUT

    assign flag_ex[1] = (ans_ex == 0) ? 1 : 0;  // Checking the zero flag

    // Resetting zero flag
    assign flag_ex[1] = (op_dec == 6'b010000) ? 0 :  // RET
                        (op_dec == 6'b010001) ? 0 :  // HLT
                        (op_dec == 6'b010010) ? 0 :  // LD
                        (op_dec == 6'b010100) ? 0 :  // ST
                        (op_dec == 6'b010111) ? 0 :  // OUT
                        (op_dec == 6'b011000) ? 0 :  // JMP
                        flag_prv[1];  // default

    always @(posedge clk) begin
        if (reset) begin
            ans_ex = 0;
            data_out = 0;
            DM_data = 0;
        end
        else begin
            ans_ex <= ans_tmp;
            data_out <= data_out_buff;
            DM_data <= B;
            flag_prv <= flag_ex;
        end
    end

endmodule // execution_block
