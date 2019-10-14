`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:56:18 10/14/2019 
// Design Name: 
// Module Name:    dc_block 
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
module dc_block(
input [31:0]ins,
input clk,
input reset,
output reg [15:0] imm,
output reg[5:0]op_dec,
output [4:0] RW_dm,
output [1:0] mux_sel_A,
output [1:0] mux_sel_B,
output reg imm_sel,
output reg mem_en_ex,
output reg mem_rw_ex,
output reg mem_mux_sel_dm
    );

wire JMP,Cond_J,LD_fb,Imm,ld,ST;

assign JMP = (~ins[31] && ins[30] && ins[29] && ~ins[28] && ~ins[27] && ~ins[26]);

assign Cond_J = (~ins[31] && ins[30] && ins[29] && ins[28]);

assign LD_fb = (~ins[31] && ins[30] && ~ins[29] && ins[28] && ~ins[27] && ~ins[26] && ~ld_dff);

assign Imm = (~ins[31] && ~ins[30] && ins[29]);

assign ld = (~ins[31] && ins[30] && ~ins[29] && ins[28] && ~ins[27] && ~ins[26]);

assign ST = (~ins[31] && ins[30] && ~ins[29] && ins[28] && ~ins[27] && ins[26]);

//op_dec
wire [5:0]op_dec_tmp;
wire [14:0]extendand;
wire [14:0]extend;
assign op_dec_tmp = (reset==0?5'b0:ins[31:26]);

//intial
wire JCnor,ld_fb_dff_tmp;
reg ld_fb_dff;

assign JCnor = ~(JMP || Cond_J || ld_dff);
assign ld_fb_dff_tmp  = (reset==0?0:ld_fb_dff);

//extend
assign extend = (JCnor==0?15'b0:15'b111111111111111);
assign extendand[0] = (extend[0] && ins[11]);   //check for extend error
assign extendand[1] = (extend[1] && ins[12]); 
assign extendand[2] = (extend[2] && ins[13]); 
assign extendand[3] = (extend[3] && ins[14]); 
assign extendand[4] = (extend[4] && ins[15]); 
assign extendand[5] = (extend[5] && ins[16]); 
assign extendand[6] = (extend[6] && ins[17]); 
assign extendand[7] = (extend[7] && ins[18]); 
assign extendand[8] = (extend[8] && ins[19]); 
assign extendand[9] = (extend[9] && ins[20]); 
assign extendand[10] = (extend[10] && ins[21]); 
assign extendand[11] = (extend[11] && ins[22]); 
assign extendand[12] = (extend[12] && ins[23]); 
assign extendand[13] = (extend[13] && ins[24]); 
assign extendand[14] = (extend[14] && ins[25]); 

//and a(extendand,extend,ins[26:11]);   //check for extend error

//intial lower
wire ldand,ld_dff_tmp,st_dff_tmp,lower_dff_tmp;
reg ld_dff,st_dff,lower_dff;

assign ldand = (ld && ~ld_dff);
assign ld_dff_tmp = (reset==0?0:ldand);
assign st_dff_tmp = (reset==0?0:ST);
assign lower_dff_tmp = (reset==0?0:ins[26]);

//endlowerend
wire loweror,lowerand,ldff1_tmp,ldff2_tmp,ldff3_tmp,ldff4_tmp;
reg ldff_2;
assign loweror = (ld_dff || st_dff);
assign lowerand = (loweror && ~lower_dff);

assign ldff1_tmp = (reset==0?0:lower_dff);
assign ldff2_tmp = (reset==0?0:lowerand);
assign ldff3_tmp = (reset==0?0:loweror);
assign ldff4_tmp = (reset==0?0:ldff_2);

//imm 
wire immdff_tmp;
assign immdff_tmp = (reset==0?0:Imm);


wire [15:0]immreg_tmp;
assign immreg_tmp = (reset==0?0:ins[15:0]);

//upperend
reg [4:0]r1,r2,r3,r4,r5,r6;
wire [4:0]r1_tmp,r2_tmp,r3_tmp,r4_tmp,r5_tmp,r6_tmp;

assign r1_tmp = (reset==0?0:extendand[9:5]);
assign r2_tmp = (reset==0?0:extendand[14:10]);
assign r3_tmp = (reset==0?0:r2);
assign r4_tmp = (reset==0?0:r3);
assign r5_tmp = (reset==0?0:r4);
assign r6_tmp = (reset==0?0:extendand[4:0]);

//finale
assign RW_dm = r4;

//comparators
wire comp1,comp2,comp3,comp4,comp5,comp6;
wire a1,a2,a3,a4;

assign comp1 = (r1==r3?1:0);
assign comp2 = (r1==r4?1:0);
assign comp3 = (r5==r1?1:0);
assign comp4 = (r3==r6?1:0);
assign comp5 = (r6==r4?1:0);
assign comp6 = (r5==r6?1:0);

assign a1 = (~comp1 && comp2);
assign a2 = (~comp1 && ~comp2 && comp3);
assign a3 = (~comp4 && comp5);
assign a4 = (~comp4 && ~comp5 && comp6);

//priority encoder
wire [1:0]enc1,enc2;

assign enc1 = ((1 && (comp1==0) && (a1==0) && (a2==0))==1?2'b00:
                ((1 && (comp1==1) && (a1==0) && (a2==0))==1?2'b01:
					 ( (1 && (comp1==0 || comp1==1) && (a1==1) && (a2==0))==1?2'b10:2'b11)));
					 
assign enc2 = ((1 && (comp4==0) && (a3==0) && (a4==0))==1?2'b00:
                ((1 && (comp4==1) && (a3==0) && (a4==0))==1?2'b01:
					 ( (1 && (comp4==0 || comp4==1) && (a3==1) && (a4==0))==1?2'b10:2'b11)));

assign mux_sel_A = enc1;
assign mux_sel_B = enc2;

always @(posedge clk)
begin
op_dec <= op_dec_tmp;
ld_fb_dff <= ld_fb_dff_tmp;
ld_dff <= ld_dff_tmp;
st_dff <= st_dff_tmp;
lower_dff <= lower_dff_tmp;

mem_rw_ex <= ldff1_tmp;
ldff_2 <= ldff2_tmp;
mem_mux_sel_dm <= ldff4_tmp;
mem_en_ex <= ldff3_tmp;

imm_sel <= immdff_tmp;
imm <= immreg_tmp;

r1 <= r1_tmp;
r2 <= r2_tmp;
r3 <= r3_tmp;
r4 <= r4_tmp;
r5 <= r5_tmp;
r6 <= r6_tmp;


end

endmodule
