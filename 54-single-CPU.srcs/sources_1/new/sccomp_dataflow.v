`timescale 1ns / 1ps

module sccomp_dataflow(
    input clk_in,       //ʱ���ź�
    input reset,        //��λ�ź�
    output [31:0] inst, //���ָ��
    output [31:0] pc    //ִ�е�ַ
    );

/* CPU��� */
wire [31:0] pc_out;
wire [31:0] dm_addr_temp;

/* IMEM�� */
wire [10:0] im_addr_in;     //11λָ�����ַ����IMEM�ж�ָ��
wire [31:0] im_instr_out;   //32λָ����

assign im_addr_in = (pc_out - 32'h00040000) / 4;    

/* DMEM�� */
wire dm_ena;                //�Ƿ���Ҫ����DMEM
wire dm_r, dm_w;            //��дָ��
wire [31:0] dm_addr;        //��Ҫ�õ���DMEM��ַ
wire [31:0] dm_data_out;    //DMEM��ȡʱ��ȡ��������
wire [31:0] dm_data_w;      //Ҫд��DMEM������ 
wire sb_flag;               //��ǰд��ָ���Ƿ���SB����
wire sh_flag;               //��ǰд��ָ���Ƿ���SH����
wire sw_flag;               //��ǰд��ָ���Ƿ���SW����
wire lb_flag;               //��ǰ��ȡָ���Ƿ���LB����
wire lh_flag;               //��ǰ��ȡָ���Ƿ���LH����
wire lbu_flag;              //��ǰ��ȡָ���Ƿ���LBU����
wire lhu_flag;              //��ǰ��ȡָ���Ƿ���LHU����
wire lw_flag;               //��ǰ��ȡָ���Ƿ���LW����

assign dm_addr = dm_addr_temp - 32'h10010000;

/* ��� */
assign pc = pc_out;
assign inst = im_instr_out;

/* ʵ����IMEM */
IMEM imem(
    .addr(im_addr_in),
    .str(im_instr_out)
    );

/* ʵ����DMEM */
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


/* ʵ����CPU */
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