`timescale 1ns / 1ps

module top_module (
    input clk,            // 100MHz 系统时钟
    input rst_n,          // 低电平复位
    input kaiguan_1,        // 控制是否测距
    input kaiguan_2,        // 控制是否报警
    input echo,           // 超声波回波信号

    output trig,          // 超声波触发信号
    output [15:0] a_to_g,  // 数码管段选
    output [7:0] an ,      // 数码管位选
    output bee
);

    // ============ 测距模块 ============ 
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
.a_to_g(a_to_g), //段信号
.an(an)  //位选信号
);

fengmingqi fengmingqi(
.clk(clk),
.rst_n(rst_n),
.juli(juli),
.bee(bee),
.kaiguan(kaiguan_2)
);
endmodule


