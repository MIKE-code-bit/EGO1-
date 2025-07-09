`timescale 1ns / 1ps

module top_module (
    input clk,            // 100MHz ϵͳʱ��
    input rst_n,          // �͵�ƽ��λ
    input kaiguan_1,        // �����Ƿ���
    input kaiguan_2,        // �����Ƿ񱨾�
    input echo,           // �������ز��ź�

    output trig,          // �����������ź�
    output [15:0] a_to_g,  // ����ܶ�ѡ
    output [7:0] an ,      // �����λѡ
    output bee
);

    // ============ ���ģ�� ============ 
wire [15:0] ax;
wire [15:0] bx;
wire [16:0] juli;

ceju u_ceju (
    .clk(clk),
    .kaiguan(kaiguan_1),
    .rst_n(rst_n),
    .echo(echo),
    .trig(trig),
    .ax(ax),
    .bx(bx),   
    .juli(juli)
);

xianshi xianshi(
.clk(clk),
.rst_n(rst_n),
.ax(ax),
.bx(bx),
.a_to_g(a_to_g), //���ź�
.an(an)  //λѡ�ź�
);

fengmingqi fengmingqi(
.clk(clk),
.rst_n(rst_n),
.juli(juli),
.bee(bee),
.kaiguan(kaiguan_2)
);
endmodule


