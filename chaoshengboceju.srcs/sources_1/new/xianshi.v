
module xianshi(
input clk,
input rst_n,
//input [31:0] x,      //�ȴ���ʾ��BCD��
input wire [15:0] ax,
input wire [15:0] bx,
output reg [15:0] a_to_g, //���ź�
output reg [7:0]  an  //λѡ�ź�
);

wire [7:0]aa_to_g;//=a_to_g[7:0];
wire [7:0]ba_to_g;//=a_to_g[15:8];
wire [3:0]aan;//=an[3:0];
wire [3:0]ban;//=an[7:4];
shumaguan_qudong youbian(
.clk(clk),
.rst_n(rst_n),
.x(ax),      //�ȴ���ʾ��BCD��
.enable_dp(1'b0),//������С����
.a_to_g(aa_to_g), //���ź�
.an(aan)  //λѡ�ź�
);
shumaguan_qudong zuobian(
.clk(clk),
.rst_n(rst_n),
.x(bx),      //�ȴ���ʾ��BCD��
.enable_dp(1'b1),//����С����
.a_to_g(ba_to_g), //���ź�
.an(ban)  //λѡ�ź�
);
always @*
    begin
        a_to_g={aa_to_g,ba_to_g};
        an={aan,ban};
    end
endmodule