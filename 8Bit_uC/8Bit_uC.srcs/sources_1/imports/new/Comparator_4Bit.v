`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 03:22:31 PM
// Design Name: 
// Module Name: Comparator_4Bit
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


module Comparator_4Bit(
//define inputs
input [7:0] _compInA, _compInB,
//input _compare,

//define
output _gt
//output lt,
//output eq
    );
    


assign _gt = ((_compInA > _compInB) || (_compInA == _compInB)) ? 1'b1:1'b0;
    
endmodule
