module ceju(
    input clk,
    input kaiguan,
    input rst_n,
    input echo,
    output reg trig,
    output wire [15:0] ax,
    output wire [15:0] bx,
    output wire [16:0] juli   // ��Ӷ�������ľ����źţ���λ 0.01cm��
);

// ---------- �����ź����� ----------
reg [22:0] trig_cnt0;  // ���Ƶ͵�ƽʱ�䣬8388607*10ns �� 83.8ms
reg [11:0] trig_cnt1;  // ���Ƹߵ�ƽʱ�䣬4095*10ns �� 40us

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        trig_cnt0 <= 0;
        trig_cnt1 <= 0;
        trig <= 0;
    end
    else if (kaiguan) begin
        if (trig_cnt0 < 23'd8388607) begin
            trig_cnt0 <= trig_cnt0 + 1;
            trig <= 0;
        end
        else if (trig_cnt1 < 12'd4095) begin
            trig_cnt1 <= trig_cnt1 + 1;
            trig <= 1;
        end
        else begin
            trig_cnt0 <= 0;
            trig_cnt1 <= 0;
            trig <= 0;
        end
    end
end

// ---------- echo ���ؼ�� ----------
reg echo_d;
wire echo_negedge;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        echo_d <= 0;
    else
        echo_d <= echo;
end

assign echo_negedge = (echo_d == 1 && echo == 0);

// ---------- echo �ߵ�ƽ���� ----------
reg [21:0] date;
reg [21:0] date_cnt;
reg [21:0] date_1, date_2, date_3, date_4;
reg [23:0] sum;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        date_cnt <= 0;
        date_1 <= 0;
        date_2 <= 0;
        date_3 <= 0;
        date_4 <= 0;
    end
    else if (kaiguan) begin
        if (echo)
            date_cnt <= date_cnt + 1;
        else if (echo_negedge) begin
            sum = date_1 + date_2 + date_3 + date_4;
            date_4 = date_3;
            date_3 = date_2;
            date_2 = date_1;
            date_1 = date_cnt;
            date_cnt = 0;
        end
    end
end

// ---------- ƽ���˲���ֵ ----------
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        date <= 0;
    else if (!echo)
        date <= sum[23:2];  // ����2λ�ȼ۳���4����ƽ��
end

// ---------- ���ݻ���Ϊ 0.01cm ----------
wire [38:0] huancun = date * 18141;
assign juli = huancun[36:20];  // ��λ��0.01cm�����ⲿ��ʾʹ��

// ---------- ������תBCD ----------
bin_to_bcd_17bit bcd_zhuanhua (
    .binary_in(juli),
    .ax(ax),
    .bx(bx)
);

endmodule


  
