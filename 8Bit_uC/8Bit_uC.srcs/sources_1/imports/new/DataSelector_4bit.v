`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 04:58:58 PM
// Design Name: 
// Module Name: DataSelector_4bit
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


module DataSelector_4bit(
//define inputs
input [7:0] _dataInA, 
input [7:0] _dataInB,
input _select,

//define outputs
output [7:0] _dataOut
    );
    
    
assign _dataOut = (_select == 1'b1)? _dataInB:_dataInA;
    
endmodule
