module bin_to_bcd_17bit (
    input wire [16:0] binary_in,
    output [15:0] ax,
    output [15:0] bx
);

    integer i;
    reg [36:0] shift_reg;
    reg [15:0] ax_reg, bx_reg;

    assign ax = ax_reg;
    assign bx = bx_reg;

    always @(*) begin
        shift_reg = 0;
        shift_reg[16:0] = binary_in;  // 放在最低位

        for (i = 0; i < 17; i = i + 1) begin
            // 检查各位 BCD（每4位）是否 >= 5，加3
            if (shift_reg[20:17] >= 5) shift_reg[20:17] = shift_reg[20:17] + 3;
            if (shift_reg[24:21] >= 5) shift_reg[24:21] = shift_reg[24:21] + 3;
            if (shift_reg[28:25] >= 5) shift_reg[28:25] = shift_reg[28:25] + 3;
            if (shift_reg[32:29] >= 5) shift_reg[32:29] = shift_reg[32:29] + 3;
            if (shift_reg[36:33] >= 5) shift_reg[36:33] = shift_reg[36:33] + 3;

            shift_reg = shift_reg << 1;
        end

        // 输出 BCD（5位）
        bx_reg[15:12] = shift_reg[36:33]; // 万位
        bx_reg[11:8]  = shift_reg[32:29]; // 千位
        bx_reg[7:4]   = shift_reg[28:25]; // 百位
        bx_reg[3:0]   = shift_reg[24:21]; // 十位

        ax_reg[15:12] = shift_reg[20:17]; // 个位
        ax_reg[11:0]  = 12'b101010111011; // 固定段码
    end

endmodule

