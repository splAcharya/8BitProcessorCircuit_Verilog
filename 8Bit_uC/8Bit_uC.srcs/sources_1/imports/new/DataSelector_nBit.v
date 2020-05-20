`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 08:34:13 PM
// Design Name: 
// Module Name: DataSelector_nBit
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


module DataSelector_nBit(
//define inputs
input [15:0] _dataInA, _dataInB,
input _selectLine,

//define outputs
output [15:0] _dataOut
    );

assign _dataOut = (_selectLine == 1'b0) ? _dataInA:_dataInB;
   
endmodule
