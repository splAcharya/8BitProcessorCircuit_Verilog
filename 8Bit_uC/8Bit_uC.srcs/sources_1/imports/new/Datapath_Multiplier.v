`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 08:50:37 PM
// Design Name: 
// Module Name: Datapath_Multiplier
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


module Datapath_Multiplier(
//define inputs
input _clk, _clear, _loadA, _loadB, _countDown, _loadHoldA, _loadProduct,
input [7:0] _dataInA, _dataInB,
 
//define outputs
output _countZero,
output [15:0] _product
    );


//define wires
wire [15:0] _loadRegisterAOut, _productHoldOut, _dataSelectorOut, _adderOut;
wire [7:0] _loadAndCountRegisterBOut;
wire _carryOut;


assign _product = _productHoldOut;


LoadAndCountDownRegister_nBit LACDRB(
//define inputs    
._clk(_clk),
._reset(_clear),
._load(_loadB),
._countDown(_countDown),
._dataIn(_dataInB),

//define outputs
._dataOut(_loadAndCountRegisterBOut)
    );
    
    
NorGate_nBit NGM0(
//define  inputs  
._dataIn(_loadAndCountRegisterBOut),

//define outputs
._dataOut(_countZero)
    );
   

LoadRegister_16Bit_Mul LRA(
//define inputs
._clk(_clk),
._reset(_clear),
._load(_loadB),
._dataIn({8'd0,_dataInA}),

//define outputs
._dataOut(_loadRegisterAOut)
    );


DataSelector_nBit DSMUL0(
//define inputs
._dataInA(16'd0),
._dataInB(_productHoldOut),
._selectLine(_loadHoldA),

//define outputs
._dataOut(_dataSelectorOut)
    );


Adder_8Bit ADMUL0(
//define inputs
._A(_dataSelectorOut),
._B(_loadRegisterAOut),
._carryIn(1'b0),

//define outputs
._sum(_adderOut),
._carryOut(_carryOut)
    );
    
    
LoadRegister_16Bit_Mul LRP(
//define inputs
._clk(_clk),
._reset(_clear),
._load(_loadProduct),
._dataIn(_adderOut),

//define outputs
._dataOut(_productHoldOut)
    );
            
endmodule
