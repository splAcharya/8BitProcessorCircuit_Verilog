`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 09/30/2019 04:39:28 PM
// Design Name: 
// Module Name: Substractor_4bit
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


module Substractor_4bit(
//define inputs
input [7:0] _subInA, _subInB, 
input _subBin,

//define outputs
output [7:0] _differenceOut,
output _borrowOut
    );
    
wire [7:0] _bOut;

Substractor_1Bit M0(_subInA[0], _subInB[0], _subBin,  _differenceOut[0], _bOut[0]);
Substractor_1Bit M1(_subInA[1], _subInB[1], _bOut[0], _differenceOut[1], _bOut[1]);
Substractor_1Bit M2(_subInA[2], _subInB[2], _bOut[1], _differenceOut[2], _bOut[2]);
Substractor_1Bit M3(_subInA[3], _subInB[3], _bOut[2], _differenceOut[3], _bOut[3]);
Substractor_1Bit M4(_subInA[4], _subInB[4], _bOut[3], _differenceOut[4], _bOut[4]);
Substractor_1Bit M5(_subInA[5], _subInB[5], _bOut[4], _differenceOut[5], _bOut[5]);
Substractor_1Bit M6(_subInA[6], _subInB[6], _bOut[5], _differenceOut[6], _bOut[6]);
Substractor_1Bit M7(_subInA[7], _subInB[7], _bOut[6], _differenceOut[7], _bOut[7]);
    
assign _borrowOut = _bOut[7];
   
endmodule
