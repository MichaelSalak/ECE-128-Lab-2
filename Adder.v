`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2025 09:34:52 AM
// Design Name: 
// Module Name: Adder
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


//Full Adder (1 bit)
module Adder(A,B,CI,SUM,CO);
input A,B,CI;
output SUM,CO;

wire ab = A ^ B;
assign SUM = ab ^ CI;
assign CO = (A & B) | (CI & ab);

endmodule


//Ripple Carry Adder (4 bit)
module RC4bit(A,B,CI,SUM,CO);
input [3:0] A,B;
input CI;
output [3:0] SUM;
output CO;

wire [2:0] c;
Adder a0(.A(A[0]),.B(B[0]),.CI(CI),.SUM(SUM[0]),.CO(c[0]));
Adder a1(.A(A[1]),.B(B[1]),.CI(c[0]),.SUM(SUM[1]),.CO(c[1]));
Adder a2(.A(A[2]),.B(B[2]),.CI(c[1]),.SUM(SUM[2]),.CO(c[2]));
Adder a3(.A(A[3]),.B(B[3]),.CI(c[2]),.SUM(SUM[3]),.CO(CO));

endmodule


//Carry Look Ahead Adder (4 bit)
module CLA4bit(A,B,CI,SUM,CO);
input [3:0] A,B;
input CI;
output [3:0] SUM;
output CO;

wire [3:0] P,G;
wire [3:1] C;   //omit C0 (carry in)
assign P = A ^ B; //P[i] = A[i] ^ B[i] 
assign G = A & B; //G[i] = A[i] & B[i] 

//Ci+1 = Gi + PiCi
assign C[1] = G[0] | (P[0]&CI); //G0+P0CI
assign C[2] = G[1] | (G[0]&P[1]) | (P[1]&P[0]&CI); 
//C2 = G1+P1(G0+P0CI) = G1+G0P1+P1P0CI
assign C[3] = G[2] | (G[1]&P[2]) | (G[0]&P[2]&P[1]) | (P[2]&P[1]&P[0]&CI); 
//C3 = G2+P2(G1+G0P1+P1P0CI) = G2+G1P2+G0P2P1+P2P1P0CI
assign CO = G[3] | (G[2]&P[3]) | (G[1]&P[3]&P[2]) | (G[0]&P[3]&P[2]&P[1]) | 
(P[3]&P[2]&P[1]&P[0]&CI);
//CO = G3+P3(G2+G1P2+G0P2P1+P2P1P0CI) = G3+G2P3+G1P3P2+G0P3P2P1+P3P2P1P0CI

//omit carryouts (carries computed above)
Adder a0(.A(A[0]),.B(B[0]),.CI(CI),.SUM(SUM[0]),.CO());
Adder a1(.A(A[1]),.B(B[1]),.CI(C[1]),.SUM(SUM[1]),.CO());
Adder a2(.A(A[2]),.B(B[2]),.CI(C[2]),.SUM(SUM[2]),.CO());
Adder a3(.A(A[3]),.B(B[3]),.CI(C[3]),.SUM(SUM[3]),.CO());

endmodule