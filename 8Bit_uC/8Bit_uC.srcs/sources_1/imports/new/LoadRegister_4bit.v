//`timescale 1ns / 1ps
`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 03:02:29 PM
// Design Name: 
// Module Name: LoadRegister_4bit
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


module LoadRegister_4bit(
//define inputs
input _clk, _reset, _load,
input [7:0] _dataIn,

//define outputs
output [7:0] _dataOut
    );
    
reg [7:0] _dataReg;

always@(posedge _clk, posedge _reset)
begin
    if(_reset)
    begin
        _dataReg <= 8'b00000000;
    end
    else
    begin
        if(_load)
        begin
            _dataReg <= _dataIn;
        end
        else
        begin
            _dataReg <= _dataReg;
        end
    end
end

assign _dataOut = _dataReg;
    
endmodule
