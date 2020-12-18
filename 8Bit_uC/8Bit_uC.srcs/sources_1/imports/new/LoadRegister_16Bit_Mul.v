`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/03/2019 12:04:46 AM
// Design Name: 
// Module Name: LoadRegister_16Bit_Mul
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


module LoadRegister_16Bit_Mul(
//define inputs
input _clk, _reset, _load,
input [15:0] _dataIn,

//define outputs
output [15:0] _dataOut
    );
    
reg [15:0] _dataHoldRegister;


always@(posedge _clk, posedge _reset)
begin
    if(_reset == 1'b1)
    begin
        _dataHoldRegister <= 16'd0;
    end
    else
    begin
        if(_load == 1'b1)
        begin
            _dataHoldRegister <= _dataIn;
        end
        else
        begin
            _dataHoldRegister <= _dataHoldRegister;
        end
    end
end

assign _dataOut = _dataHoldRegister;

endmodule
