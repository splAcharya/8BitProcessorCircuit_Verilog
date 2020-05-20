`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 10:08:08 PM
// Design Name: 
// Module Name: Multiplier_8Bit
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


module Multiplier_8Bit(
//define inputs
input _clk, _reset, _start,
input [7:0] _dataInA, _dataInB,
    
//define outputs
output [15:0] _product,    
output _done
    );


wire _clear;
wire _loadA;
wire _loadB;
wire _countDown;
wire _loadHoldA;
wire _loadProduct;

wire _countZero;



ControlPath_Multiplier CPMUL0(
//define inputs
._clk(_clk),
._reset(_reset),
._start(_start),
._countZero(_countZero),

//define outputs
._clear(_clear),
._loadA(_loadA),
._loadB(_loadB),
._countDown(_countDown),
._loadHoldA(_loadHoldA),
._loadProduct(_loadProduct),
._done(_done)
    );




Datapath_Multiplier DPMUL0(
//define inputs
._clk(_clk), 
._clear(_clear),
._loadA(_loadA),
._loadB(_loadB),
._countDown(_countDown),
._loadHoldA(_loadHoldA),
._loadProduct(_loadProduct),
._dataInA(_dataInA),
._dataInB(_dataInB),
 
//define outputs
._countZero(_countZero),
._product(_product)
    );
   


    
    
endmodule
