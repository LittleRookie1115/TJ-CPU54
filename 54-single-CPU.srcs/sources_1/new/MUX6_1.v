`timescale 1ns/1ps

/* 6ѡ1��·ѡ���� */
/* ��MUX1�� 001:NPC 010:JR JALR(Rs) 011:EPC(CPO_OUT) 100:BEQ(EXT18+NPC) 101:J JAR(CAT) 110:TEQ(4)
   ��MUX5�� 001:CP0_OUT 010:NPC 011:CLZ 100:D_OUT 101:ALU 110:HI_LO */

module MUX6_1(
    input [2:0] sel,    //ѡ���ź�
    input [31:0] in1,   //�����ź�1
    input [31:0] in2,   //�����ź�2
    input [31:0] in3,   //�����ź�3
    input [31:0] in4,   //�����ź�4
    input [31:0] in5,   //�����ź�5
    input [31:0] in6,   //�����ź�6
    output [31:0] out   //����ź�
    );
    reg [31:0] out_temp;
    always @(*) begin
        case(sel)
            3'b001: out_temp = in1;
            3'b010: out_temp = in2;
            3'b011: out_temp = in3;
            3'b100: out_temp = in4;
            3'b101: out_temp = in5;
            3'b110: out_temp = in6;
            default: out_temp = 32'b0;
        endcase
    end
    assign out = out_temp;
endmodule