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
input [15:0] x,      //�ȴ���ʾ��BCD��
input enable_dp,//����С���� 
output reg [7:0] a_to_g, //���ź�
output reg [3:0] an  //λѡ�ź�
);
//8611 3819/ 1000_0110_0001_0001// 0011_1000_0001_1001
//wire [15:0]x=16'b0011_1000_0001_1001;
//x={H,L};
//ʱ�ӷ�Ƶ ������
reg [20:0] clkdiv;
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		clkdiv<=21'd0;
	else
		clkdiv<=clkdiv+1;
end
/*���ü������Զ����ʱ�䣬������clkdiv��0~11111111111111111111ѭ��������
��clk[20:19]����00~11֮����5.24msΪʱ�����仯  2^19=524288
������19λȫ0��ȫ1�ļ���ʱ�䣩
*/

//bitcnt: λɨ���ź� 0~1ѭ���仯 ɨ������ 5.24ms    ������ɨ��ʱ�䲻����10ms�������������ʾʱ��ԼΪ5ms
wire  [1:0]bitcnt;
assign bitcnt=clkdiv[20:19];

//an:λѡ�źŲ���������Ч
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


//digit ��ǰ����ʾ������
 
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

//a_to_g: �����źţ�����������ܣ��������Ч�� 7�������
always @(posedge clk or negedge rst_n)
begin
if(!rst_n)
	a_to_g=8'b11111111;
else begin
    case(digit)
	   0:a_to_g=8'b11111100;//����λ���ɸߵ���Ϊa-g
	   1:a_to_g=8'b01100000;
	   2:a_to_g=8'b11011010;
	   3:a_to_g=8'b11110010;
	   4:a_to_g=8'b01100110;
	   5:a_to_g=8'b10110110;
	   6:a_to_g=8'b10111110;
	   7:a_to_g=8'b11100000;
	   8:a_to_g=8'b11111110;
	   9:a_to_g=8'b11110110;
	   10:a_to_g=8'b10011100;//c,c��10��ʾ
	   11:a_to_g=8'b11101100;//n,n��11��ʾ
	   default:a_to_g=8'b11111100;
	endcase
	if (an == 4'b0010 && enable_dp)
	   a_to_g[0] <= 1'b1;//����״̬������
	else
	   a_to_g[0] <= 1'b0;//С���㲻��
	end
end 
endmodule