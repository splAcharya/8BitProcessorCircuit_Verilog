`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 08:24:32 PM
// Design Name: 
// Module Name: LoadAndCountDownRegister_nBit
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


module LoadAndCountDownRegister_nBit(
//define inputs    
input _clk, _reset, _load, _countDown,
input [7:0] _dataIn,

//define outputs
output [7:0] _dataOut
    );
    

//define data registes
reg [7:0] _dataHoldReg;

always@(posedge _clk, posedge _reset)
begin
    if(_reset)
    begin
        _dataHoldReg <= 8'd0;
    end
    else
    begin
        if(_load)
        begin
            _dataHoldReg <= _dataIn;
        end
        else if(_countDown)
        begin
            _dataHoldReg <= _dataHoldReg - 1'b1;
        end
        else
        begin
            _dataHoldReg <= _dataHoldReg;
        end
    end
end


assign _dataOut = _dataHoldReg;
    
endmodule
