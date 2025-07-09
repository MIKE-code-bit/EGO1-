
module xianshi(
input clk,
input rst_n,
//input [31:0] x,      //等待显示的BCD码
input wire [15:0] ax,
input wire [15:0] bx,
output reg [15:0] a_to_g, //段信号
output reg [7:0]  an  //位选信号
);

wire [7:0]aa_to_g;//=a_to_g[7:0];
wire [7:0]ba_to_g;//=a_to_g[15:8];
wire [3:0]aan;//=an[3:0];
wire [3:0]ban;//=an[7:4];
shumaguan_qudong youbian(
.clk(clk),
.rst_n(rst_n),
.x(ax),      //等待显示的BCD码
.enable_dp(1'b0),//不启用小数点
.a_to_g(aa_to_g), //段信号
.an(aan)  //位选信号
);
shumaguan_qudong zuobian(
.clk(clk),
.rst_n(rst_n),
.x(bx),      //等待显示的BCD码
.enable_dp(1'b1),//启用小数点
.a_to_g(ba_to_g), //段信号
.an(ban)  //位选信号
);
always @*
    begin
        a_to_g={aa_to_g,ba_to_g};
        an={aan,ban};
    end
endmodule