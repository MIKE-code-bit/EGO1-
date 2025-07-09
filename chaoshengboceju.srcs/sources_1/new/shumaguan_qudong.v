`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/05/21 22:04:31
// Design Name: 
// Module Name: shumaguan_qudong
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


module shumaguan_qudong(
input clk,
input rst_n,
input [15:0] x,      //等待显示的BCD码
input enable_dp,//启动小数点 
output reg [7:0] a_to_g, //段信号
output reg [3:0] an  //位选信号
);
//8611 3819/ 1000_0110_0001_0001// 0011_1000_0001_1001
//wire [15:0]x=16'b0011_1000_0001_1001;
//x={H,L};
//时钟分频 计数器
reg [20:0] clkdiv;
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		clkdiv<=21'd0;
	else
		clkdiv<=clkdiv+1;
end
/*利用计数器自动溢出时间，即就是clkdiv从0~11111111111111111111循环计数，
则clk[20:19]会在00~11之间以5.24ms为时间间隔变化  2^19=524288
（即后19位全0到全1的计数时间）
*/

//bitcnt: 位扫描信号 0~1循环变化 扫描周期 5.24ms    控制总扫描时间不超过10ms，单个数码管显示时间约为5ms
wire  [1:0]bitcnt;
assign bitcnt=clkdiv[20:19];

//an:位选信号产生，高有效
always @(posedge clk or negedge rst_n)
begin 
if(!rst_n)
	an=4'd0;
else
	case(bitcnt)
	2'd0:an=4'b0001;
	2'd1:an=4'b0010;
	2'd2:an=4'b0100;
	2'd3:an=4'b1000;
    endcase
end


//digit 当前带显示的数字
 
 reg [3:0]digit;
always @(posedge clk or negedge rst_n)
begin
if (!rst_n)
	digit=4'd0;
else
	case(bitcnt)
	2'd0:digit=x[3:0];
	2'd1:digit=x[7:4];
	2'd2:digit=x[11:8];
	2'd3:digit=x[15:12];
	default:digit=4'd0;
	endcase
end

//a_to_g: 段码信号，共阴极数码管，段码高有效。 7段译码表
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
	a_to_g=8'b11111111;
else begin
    case(digit)
	   0:a_to_g=8'b11111100;//段码位序由高到低为a-g
	   1:a_to_g=8'b01100000;
	   2:a_to_g=8'b11011010;
	   3:a_to_g=8'b11110010;
	   4:a_to_g=8'b01100110;
	   5:a_to_g=8'b10110110;
	   6:a_to_g=8'b10111110;
	   7:a_to_g=8'b11100000;
	   8:a_to_g=8'b11111110;
	   9:a_to_g=8'b11110110;
	   10:a_to_g=8'b10011100;//c,c用10表示
	   11:a_to_g=8'b11101100;//n,n用11表示
	   default:a_to_g=8'b11111100;
	endcase
	if (an == 4'b0010 && enable_dp)
	   a_to_g[0] <= 1'b1;//允许状态被点亮
	else
	   a_to_g[0] <= 1'b0;//小数点不亮
	end
end 
endmodule