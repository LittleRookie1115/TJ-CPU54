`timescale 1ns/1ps

/* 6选1多路选择器 */
/* 在MUX1中 001:NPC 010:JR JALR(Rs) 011:EPC(CPO_OUT) 100:BEQ(EXT18+NPC) 101:J JAR(CAT) 110:TEQ(4)
   在MUX5中 001:CP0_OUT 010:NPC 011:CLZ 100:D_OUT 101:ALU 110:HI_LO */

module MUX6_1(
    input [2:0] sel,    //选择信号
    input [31:0] in1,   //输入信号1
    input [31:0] in2,   //输入信号2
    input [31:0] in3,   //输入信号3
    input [31:0] in4,   //输入信号4
    input [31:0] in5,   //输入信号5
    input [31:0] in6,   //输入信号6
    output [31:0] out   //输出信号
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