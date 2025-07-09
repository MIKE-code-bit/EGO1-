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


`timescale 1ns/1ns  // ʱ�䵥λ1ns������1ns

module ceju_tb;
    // �����ź�
    reg clk;
    reg rst_n;
    reg echo;
    reg  kaiguan;
    // ����ź�
    wire trig;
    wire [21:0] date;
    
    // ʵ��������ģ��
    ceju uut (
        .clk(clk),
        .rst_n(rst_n),
        .echo(echo),
        .trig(trig),
        .date(date),
        .kaiguan(kaiguan)
    );
    
    // ����100MHzʱ�� (����10ns)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // ÿ5ns��תһ�Σ��õ�100MHzʱ��
    end
    
    // ����echo�ź� (ÿ100us��תһ��)
    initial begin
        echo = 0;
        forever #50000 echo = ~echo;  // 100us = 100,000ns��������50,000ns
    end
    
    // ���Լ���
    initial begin
        // ��ʼ��
        rst_n = 0;
        #100;  // ���ָ�λ100ns
        
        // �ͷŸ�λ
        rst_n = 1;
        kaiguan=1;
        
        // �����㹻��ʱ��۲���Ϊ
        #100000000;  // ����1ms
        
        $finish;  // ��������
    end
    
    // ���μ�¼
    initial begin
        $dumpfile("ceju_tb.vcd");
        $dumpvars(0, ceju_tb);
    end
    
endmodule