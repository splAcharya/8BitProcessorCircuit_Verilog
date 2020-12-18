`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/01/2019 12:35:59 AM
// Design Name: 
// Module Name: Divider_4Bit
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


module Divider_8Bit(
//define inputs
input _clk, _reset, _start,
input [7:0] _dataInA, _dataInB,

//define outputs
output _doneOut, _errorOut,
output [7:0] _quotientOut, _remainderOut
);
  
  
wire [7:0] _count;
wire _clearOut, _loadAOut, _loadBOut, _countUpOut, _holdAOut, _loadHoldAOut;
wire _gt;
  
ControlPath CPM0(
//define inputs
._clk(_clk),
._reset(_reset), 
._start(_start),
._gt(_gt),
._count(_quotientOut),

//define outputs
._doneOut(_doneOut),
._errorOut(_errorOut),
._clearOut(_clearOut),
._loadAOut(_loadAOut),
._loadBOut(_loadBOut),
._countUpOut(_countUpOut),
._holdAOut(_holdAOut),
._loadHoldAOut(_loadHoldAOut)
    ); 
    
 


DataPath DPM0(
//define inputs
._clk(_clk), 
._reset(_clearOut),
._loadA(_loadAOut),
._loadB(_loadBOut),
._loadHoldA(_loadHoldAOut), 
._countUp(_countUpOut),
._holdA(_holdAOut),
._dataAIn(_dataInA),
._dataBIn(_dataInB),

//output
._gtOut(_gt),
._quotientOut(_quotientOut),
._remainderOut(_remainderOut)
    );   
  
endmodule
