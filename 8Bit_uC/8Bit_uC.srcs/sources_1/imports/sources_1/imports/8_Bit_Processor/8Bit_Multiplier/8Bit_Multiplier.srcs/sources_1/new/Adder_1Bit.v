`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 07:54:06 PM
// Design Name: 
// Module Name: Adder_1Bit
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


module Adder_1Bit(
//define inputs
input _A, _B, _carryIn,
//define outputs
output _sum, _carryOut
    );
    
    
assign _sum = ({_A,_B} == 2'b00) ? _carryIn:
              ({_A,_B} == 2'b01) ? ~_carryIn:
              ({_A,_B} == 2'b10) ? ~_carryIn: _carryIn;
              
              
assign _carryOut = ({_A,_B} == 2'b00) ? 1'b0:
                   ({_A,_B} == 2'b01) ? _carryIn:
                   ({_A,_B} == 2'b10) ? _carryIn: 1'b1;              
              
endmodule
