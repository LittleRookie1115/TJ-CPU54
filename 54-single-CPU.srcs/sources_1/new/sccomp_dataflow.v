`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk_in,       //时钟信号
    input reset,        //复位信号
    output [31:0] inst, //输出指令
    output [31:0] pc    //执行地址
    );

/* CPU相关 */
wire [31:0] pc_out;
wire [31:0] dm_addr_temp;

/* IMEM用 */
wire [10:0] im_addr_in;     //11位指令码地址，从IMEM中读指令
wire [31:0] im_instr_out;   //32位指令码

assign im_addr_in = (pc_out - 32'h00040000) / 4;    

/* DMEM用 */
wire dm_ena;                //是否需要启用DMEM
wire dm_r, dm_w;            //读写指令
wire [31:0] dm_addr;        //需要用到的DMEM地址
wire [31:0] dm_data_out;    //DMEM读取时读取到的数据
wire [31:0] dm_data_w;      //要写入DMEM的内容 
wire sb_flag;               //当前写入指令是否是SB发出
wire sh_flag;               //当前写入指令是否是SH发出
wire sw_flag;               //当前写入指令是否是SW发出
wire lb_flag;               //当前读取指令是否是LB发出
wire lh_flag;               //当前读取指令是否是LH发出
wire lbu_flag;              //当前读取指令是否是LBU发出
wire lhu_flag;              //当前读取指令是否是LHU发出
wire lw_flag;               //当前读取指令是否是LW发出

assign dm_addr = dm_addr_temp - 32'h10010000;

/* 输出 */
assign pc = pc_out;
assign inst = im_instr_out;

/* 实例化IMEM */
IMEM imem(
    .addr(im_addr_in),
    .str(im_instr_out)
    );

/* 实例化DMEM */
DMEM dmem(
    .dm_clk(clk_in),
    .dm_ena(dm_ena),
    .dm_r(dm_r),
    .dm_w(dm_w),
    .sb_flag(sb_flag),
    .sh_flag(sh_flag),
    .sw_flag(sw_flag),
    .lb_flag(lb_flag),
    .lh_flag(lh_flag),
    .lbu_flag(lbu_flag),
    .lhu_flag(lhu_flag),
    .lw_flag(1),
    .dm_addr(dm_addr),
    .dm_data_in(dm_data_w),
    .dm_data_out(dm_data_out)
    );


/* 实例化CPU */
cpu sccpu(
    .clk(clk_in),
    .ena(1'b1),
    .rst(reset),
    .IM_instr(im_instr_out),
    .dm_data(dm_data_out),
    .dm_ena(dm_ena),
    .dm_w(dm_w),
    .dm_r(dm_r),
    .pc_out(pc_out),
    .ALU_RES(dm_addr_temp),
    .dm_data_w(dm_data_w),
    .sb_flag(sb_flag),
    .sh_flag(sh_flag),
    .sw_flag(sw_flag),
    .lb_flag(lb_flag),
    .lh_flag(lh_flag),
    .lbu_flag(lbu_flag),
    .lhu_flag(lhu_flag),
    .lw_flag(lw_flag)
    );



endmodule