`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 08:39:06 PM
// Design Name: 
// Module Name: NorGate_nBit
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


module NorGate_nBit(
//define  inputs  
input [7:0] _dataIn,

//define outputs
output _dataOut
    );
   


wire [7:0] orGateOut; 
wire norGateOut;

assign orGateOut = (_dataIn[0] | _dataIn[1] | _dataIn[2] | _dataIn[3] | _dataIn[4] | _dataIn[5] | _dataIn[6] | _dataIn[7]);

assign norGateOut = ~orGateOut;
assign _dataOut = norGateOut;

endmodule
