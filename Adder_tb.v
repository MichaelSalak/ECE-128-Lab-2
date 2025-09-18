`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/11/2025 01:26:12 PM
// Design Name: 
// Module Name: Adder_tb
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


module Adder_tb();
reg [3:0] A,B;
reg CI;
wire CO_RC, CO_CLA;
wire [3:0] SUM_RC, SUM_CLA;


RC4bit rc(.A(A), .B(B), .CI(CI), .SUM(SUM_RC), .CO(CO_RC));
CLA4bit cla(.A(A), .B(B), .CI(CI), .SUM(SUM_CLA), .CO(CO_CLA));

initial begin
    A = 4'b1101;
    B = 4'b0101;
    CI = 1'b1;
    #100;
    $finish;
end

endmodule
