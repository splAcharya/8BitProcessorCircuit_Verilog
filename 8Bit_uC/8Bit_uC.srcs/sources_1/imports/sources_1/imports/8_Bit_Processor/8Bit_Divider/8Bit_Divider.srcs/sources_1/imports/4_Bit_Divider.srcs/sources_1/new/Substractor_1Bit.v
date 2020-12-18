`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 09/30/2019 03:33:33 PM
// Design Name: 
// Module Name: Substractor_1Bit
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


module Substractor_1Bit(
//define inputs
input _subInA, _subInB, _subBin,
//define ouputs
output _differenceOut, _borrowOut
    );
    
    
reg _diffReg, _borrowReg;

assign _differenceOut = ({_subInA,_subInB} == 2'b00) ? _subBin:
                        ({_subInA,_subInB} == 2'b01) ? (~_subBin):
                        ({_subInA,_subInB} == 2'b10) ? (~_subBin): 
                        ({_subInA,_subInB} == 2'b11) ?  _subBin: 2'b00;



assign _borrowOut = ({_subInA,_subInB} == 2'b00) ? _subBin:
                    ({_subInA,_subInB} == 2'b01) ? 1'b1:
                    ({_subInA,_subInB} == 2'b10) ? 1'b0:
                    ({_subInA,_subInB} == 2'b11) ? _subBin: 2'b00;    
                    
endmodule
