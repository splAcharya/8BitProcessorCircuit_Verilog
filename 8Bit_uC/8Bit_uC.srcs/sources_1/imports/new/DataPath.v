`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 04:46:18 PM
// Design Name: 
// Module Name: DataPath
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


module DataPath(
//define inputs
input _clk, _reset,
input _loadA, _loadB, _loadHoldA,
input _countUp, _holdA,
input [7:0] _dataAIn, _dataBIn,

//output
output _gtOut,
output [7:0] _quotientOut, _remainderOut
    );
   
wire [7:0] _ALoadOut;
wire [7:0] _HoldAOut;
wire [7:0] _AOut;
wire [7:0] _BOut;
wire [7:0] _subOut;

assign _remainderOut = _HoldAOut;   

LoadRegister_4bit LRA(
//define inputs
._clk(_clk),
._reset(_reset), 
._load(_loadA),
._dataIn(_dataAIn),

//define outputs
._dataOut(_ALoadOut)
);


DataSelector_4bit DSM0(
//define inputs
._dataInA(_ALoadOut), 
._dataInB(_HoldAOut),
._select(_loadHoldA),

//define outputs
._dataOut(_AOut)
);



LoadRegister_4bit LRB(
//define inputs
._clk(_clk),
._reset(_reset),
._load(_loadB),
._dataIn(_dataBIn),

//define outputs
._dataOut(_BOut)
);
    


Comparator_4Bit CM0(
//define inputs
._compInA(_AOut), 
._compInB(_BOut),
//._compare(_compare),

//define
._gt(_gtOut)
//output lt,
//output eq
);



UpCounter_4Bit UCM0(
//define inputs
._clk(_clk),
._reset(_reset),
._countUp(_countUp),

//define outputs
._counterOut(_quotientOut)
);



Substractor_4bit SM0(
//define inputs
._subInA(_AOut), 
._subInB(_BOut), 
._subBin(1'b0),

//define outputs
._differenceOut(_subOut)
);
 

 
LoadRegister_4bit HOLDAM0(
//define inputs
._clk(_clk),
._reset(_reset), 
._load(_holdA),
._dataIn(_subOut),

//define outputs
._dataOut(_HoldAOut)
 );

 
      
endmodule
