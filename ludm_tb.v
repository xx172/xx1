`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2020 05:58:58
// Design Name: 
// Module Name: ludm_tb
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


module ludm_tb;
reg[31:0]A;
reg clk,reset,wr;
reg[31:0]wr_addr;
wire[31:0]L,U;
wire finish;
ludm uut(.clk(clk),.reset(reset),.wr(wr),.L(L),.U(U),.finish(finish),.wr_addr(wr_addr));
initial
begin
clk=1;reset=1;wr=0;A=0;wr_addr=0;
#10reset=0;
#10 wr=1;
#10 wr_addr=1;
#10 A=32'd13;
#10 wr=0;
#10 wr_addr=1;
#10 wr=1;
#10 wr_addr=1;
#10 A=32'd23;
#10 wr=0;
#10 wr_addr=1;
#10 $display("%d",L);
#10 $display("%d",U);
wait(finish==1);
$finish;
end
always 
begin
#5clk=~clk;
end

endmodule
