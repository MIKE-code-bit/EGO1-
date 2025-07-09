//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/19 22:57:52
// Design Name: 
// Module Name: cejufangzhen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ns  // 时间单位1ns，精度1ns

module ceju_tb;
    // 输入信号
    reg clk;
    reg rst_n;
    reg echo;
    reg  kaiguan;
    // 输出信号
    wire trig;
    wire [21:0] date;
    
    // 实例化被测模块
    ceju uut (
        .clk(clk),
        .rst_n(rst_n),
        .echo(echo),
        .trig(trig),
        .date(date),
        .kaiguan(kaiguan)
    );
    
    // 生成100MHz时钟 (周期10ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // 每5ns翻转一次，得到100MHz时钟
    end
    
    // 生成echo信号 (每100us翻转一次)
    initial begin
        echo = 0;
        forever #50000 echo = ~echo;  // 100us = 100,000ns，半周期50,000ns
    end
    
    // 测试激励
    initial begin
        // 初始化
        rst_n = 0;
        #100;  // 保持复位100ns
        
        // 释放复位
        rst_n = 1;
        kaiguan=1;
        
        // 运行足够长时间观察行为
        #100000000;  // 仿真1ms
        
        $finish;  // 结束仿真
    end
    
    // 波形记录
    initial begin
        $dumpfile("ceju_tb.vcd");
        $dumpvars(0, ceju_tb);
    end
    
endmodule