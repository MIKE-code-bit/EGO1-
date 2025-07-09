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
    input clk,          // 时钟信号
    input rst_n,        // 异步复位（低有效）
    output reg seq_out  // 输出序列
);
    // 定义计数器位宽（15位用于32768计数，12位用于4096计数）
    reg [14:0] zero_counter; // 0的计数器（0~32767）
    reg [11:0] one_counter;  // 1的计数器（0~4095）

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            zero_counter <= 0;
            one_counter <= 0;
            seq_out <= 0; // 初始输出0
        end
        else begin
            // 当前输出0的阶段
            if (zero_counter < 15'd32767) begin
                zero_counter <= zero_counter + 1;
                seq_out <= 0;
            end
            // 切换到输出1的阶段
            else if (one_counter < 12'd4095) begin
                one_counter <= one_counter + 1;
                seq_out <= 1;
            end
            // 重置计数器，开始新周期
            else begin
                zero_counter <= 0;
                one_counter <= 0;
                seq_out <= 0;
            end
        end
    end
endmodule