`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 07:59:34 PM
// Design Name: 
// Module Name: Adder_8Bit
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


module Adder_8Bit(
//define inputs
input [15:0] _A, _B,
input _carryIn,

//define outputs
output [15:0] _sum,
output _carryOut
    );

//define wires
wire [15:0] _cIn;

Adder_1Bit  A0(_A[0],_B[0],_carryIn,_sum[0],_cIn[0]);
Adder_1Bit  A1(_A[1],_B[1],_cIn[0],_sum[1],_cIn[1]);
Adder_1Bit  A2(_A[2],_B[2],_cIn[1],_sum[2],_cIn[2]);
Adder_1Bit  A3(_A[3],_B[3],_cIn[2],_sum[3],_cIn[3]);
Adder_1Bit  A4(_A[4],_B[4],_cIn[3],_sum[4],_cIn[4]);
Adder_1Bit  A5(_A[5],_B[5],_cIn[4],_sum[5],_cIn[5]);
Adder_1Bit  A6(_A[6],_B[6],_cIn[5],_sum[6],_cIn[6]);
Adder_1Bit  A7(_A[7],_B[7],_cIn[6],_sum[7],_cIn[7]);
Adder_1Bit  A8(_A[8],_B[8],_cIn[7],_sum[8],_cIn[8]);
Adder_1Bit  A9(_A[9],_B[9],_cIn[8],_sum[9],_cIn[9]);

Adder_1Bit  A10(_A[10],_B[10], _cIn[9],_sum[10],_cIn[10]);
Adder_1Bit  A11(_A[11],_B[11],_cIn[10],_sum[11],_cIn[11]);
Adder_1Bit  A12(_A[12],_B[12],_cIn[11],_sum[12],_cIn[12]);
Adder_1Bit  A13(_A[13],_B[13],_cIn[12],_sum[13],_cIn[13]);
Adder_1Bit  A14(_A[14],_B[14],_cIn[13],_sum[14],_cIn[14]);
Adder_1Bit  A15(_A[15],_B[15],_cIn[14],_sum[15],_cIn[15]);
    
assign _carryOut = _cIn[15];
    
endmodule
