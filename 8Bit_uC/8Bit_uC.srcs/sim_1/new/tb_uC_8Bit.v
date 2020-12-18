`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/10/2019 08:09:00 PM
// Design Name: 
// Module Name: tb_uC_8Bit
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


module tb_uC_8Bit();
    

//define inputs
reg _clk, _reset;
//define outputs
wire [5:0] _cycle;
wire [7:0] _romAddress;
wire [7:0] _instructionReg, _programCounter;
wire [7:0] _R0, _R1, _R2, _R3;
wire [7:0] _Rhi, _Rlo, _Rquotient, _Rremainder;
wire  _ramWrite;
wire [7:0] _ramAddress;
wire [7:0] _romOut, _ramOut;
    

uC_8Bit DUT(
//define inputs
._clk(_clk),
._reset(_reset),

//define outputs
._cycle(_cycle),
._romAddress(_romAddress),
._instructionReg(_instructionReg),
._programCounter(_programCounter),
._R0(_R0),
._R1(_R1),
._R2(_R2),
._R3(_R3),
._Rhi(_Rhi),
._Rlo(_Rlo),
._Rquotient(_Rquotient),
._Rremainder(_Rremainder),
._ramWrite(_ramWrite),
._ramAddress(_ramAddress),
._romOut(_romOut),
._ramOut(_ramOut)
    );
    
 
 
initial
begin
_clk = 1'b0;
_reset = 1'b1;
end

always #5 _clk = ~ _clk;

initial
begin
_reset = #5 1'b0;
end

       
endmodule
