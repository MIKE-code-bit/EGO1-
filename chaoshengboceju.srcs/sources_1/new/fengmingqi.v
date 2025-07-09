module fengmingqi (
    input clk,               // 100MHz 时钟
    input rst_n,             // 异步复位
    input [16:0] juli,       // 距离（单位 0.01cm）
    input kaiguan,           // 控制蜂鸣器开关，1 = 使能，0 = 关闭
    output reg bee           // 有源蜂鸣器输出
);

reg [31:0] cnt;
reg [31:0] period;
reg [31:0] beep_time;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 0;
        bee <= 0;
    end else if (kaiguan && juli < 17'd3000) begin
        // 特殊处理：≤3cm 始终响
        if (juli <= 17'd300) begin
            bee <= 1;
            cnt <= 0;
        end else begin
            if (cnt < period)
                cnt <= cnt + 1;
            else
                cnt <= 0;

            if (cnt < beep_time)
                bee <= 1;
            else
                bee <= 0;
        end
    end else begin
        cnt <= 0;
        bee <= 0;
    end
end

// === 多段节奏周期映射 ===
always @(*) begin
    if (juli >= 17'd2500)
        period = 32'd150_000_000;
    else if (juli >= 17'd2000)
        period = 32'd120_000_000;
    else if (juli >= 17'd1500)
        period = 32'd90_000_000;
    else if (juli >= 17'd1000)
        period = 32'd60_000_000;
    else if (juli >= 17'd500)
        period = 32'd40_000_000;
    else if (juli > 17'd300)
        period = 32'd25_000_000;
    else
        period = 32'd0;

    beep_time = period >> 2;
end

endmodule




