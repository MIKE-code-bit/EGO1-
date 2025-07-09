`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/18 21:40:50
// Design Name: 
// Module Name: a
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


module periodic_sequence (
    input clk,          // ʱ���ź�
    input rst_n,        // �첽��λ������Ч��
    output reg seq_out  // �������
);
    // ���������λ��15λ����32768������12λ����4096������
    reg [14:0] zero_counter; // 0�ļ�������0~32767��
    reg [11:0] one_counter;  // 1�ļ�������0~4095��

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            zero_counter <= 0;
            one_counter <= 0;
            seq_out <= 0; // ��ʼ���0
        end
        else begin
            // ��ǰ���0�Ľ׶�
            if (zero_counter < 15'd32767) begin
                zero_counter <= zero_counter + 1;
                seq_out <= 0;
            end
            // �л������1�Ľ׶�
            else if (one_counter < 12'd4095) begin
                one_counter <= one_counter + 1;
                seq_out <= 1;
            end
            // ���ü���������ʼ������
            else begin
                zero_counter <= 0;
                one_counter <= 0;
                seq_out <= 0;
            end
        end
    end
endmodule