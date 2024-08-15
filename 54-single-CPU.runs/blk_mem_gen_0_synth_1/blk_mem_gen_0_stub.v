// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
// Date        : Mon Jul 08 21:34:17 2024
// Host        : LAPTOP-POBHROGD running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {E:/Computer
//               Organization/CPU54/54-single-CPU/54-single-CPU.runs/blk_mem_gen_0_synth_1/blk_mem_gen_0_stub.v}
// Design      : blk_mem_gen_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_3_3,Vivado 2016.2" *)
module blk_mem_gen_0(clka, ena, addra, douta)
/* synthesis syn_black_box black_box_pad_pin="clka,ena,addra[10:0],douta[31:0]" */;
  input clka;
  input ena;
  input [10:0]addra;
  output [31:0]douta;
endmodule
