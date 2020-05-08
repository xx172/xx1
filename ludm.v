`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2020 05:46:26
// Design Name: 
// Module Name: ludm
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

module ludm(A,clk,reset,wr,L,U,finish,wr_addr);
parameter STATE1 =3'd1;
parameter STATE2=3'd1;
parameter STATE3=3'd1;
parameter STATE4=3'd1;
parameter STATE5=3'd1;
parameter STATE6=3'd1;

input [31:0]A;
input clk,reset,wr;
output [31:0]L;
output [31:0]U;
output reg finish;
integer i=32'b0;
integer j=32'b0;
integer k=32'b0;
reg[31:0]L;
reg[31:0]U;
input [31:0]wr_addr;
reg[31:0]L1[0:99][0:99];
reg[31:0]U1[0:99][0:99];
reg[31:0]A1[0:99][0:99];
reg[31:0]mem[0:999];
reg[2:0]state;
wire[31:0]A;
wire clk,reset,wr;
integer sum=32'b0;
integer sum1=32'b0;
integer sum2=32'b0;
integer sum3=32'b0;



always@(posedge clk or negedge reset)
begin
if(wr)
begin
mem[wr_addr]<=A;
end
else
begin
L<=mem[wr_addr];
U<=mem[wr_addr];
end
end

always@(posedge clk or negedge reset)
begin

if(reset)
begin
state<=STATE1;
end
else
begin
case(state)
STATE1:
begin
i<=0;
j<=0;
k<=0;
sum<=0;
sum1<=0;
sum2<=0;
sum3<=0;
finish<=1'b0;
state<=STATE2;
end
STATE2:
begin
if (i!=100)
begin
if (k!=i)
begin
if(j!=100)
begin
sum1=L1[i][j]*U1[i][j];
i=i+1;
j=j+1;
k=k+1;
state<=STATE3;
end
end
end
else 
state<=STATE6;
end
STATE3:
begin
U1[i][k]=A1[i][k]-sum;
state<=STATE4;
end
STATE4:
begin
if(i==k)
begin
L1[i][i]=1;
end
else
begin
sum2=L1[k][j]*U1[j][i];
sum3=sum2+sum3;
state<=STATE5;
end
end
STATE5:
begin
L1[k][i]=A1[k][i]-sum3/U1[i][i];
state<=STATE6;
end
STATE6:
finish<=1'b1;
endcase
end
end

endmodule
