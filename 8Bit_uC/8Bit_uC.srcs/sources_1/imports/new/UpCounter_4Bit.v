`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 03:28:14 PM
// Design Name: 
// Module Name: UpCounter_4Bit
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


module UpCounter_4Bit(
//define inputs
input _clk, _reset, _countUp,

//define outputs
output [7:0] _counterOut
    );

reg [7:0] _upCounter;
    
always@(posedge _clk, posedge _reset)    
begin
    if(_reset)
    begin
        _upCounter <= 8'b00000000;
    end
    else
    begin
        if(_countUp)
        begin
            _upCounter <= _upCounter + 1'b1;
        end
        else
        begin
            _upCounter <= _upCounter;
        end
    end
end

assign _counterOut = _upCounter;
    
endmodule
