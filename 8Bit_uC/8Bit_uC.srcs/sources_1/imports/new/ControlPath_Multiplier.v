`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/02/2019 09:43:43 PM
// Design Name: 
// Module Name: ControlPath_Multiplier
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


module ControlPath_Multiplier(
//define inputs
input _clk, _reset, _start,
input _countZero,

//define outputs
output  reg _clear, _loadA, _loadB, _countDown, _loadHoldA, _loadProduct, _done
    );
    
    
//define parameters
parameter S0 = 3'b000,
          S1 = 3'b001,
          S2 = 3'b010,
          S3 = 3'b011,
          S4 = 3'b100,
          S5 = 3'b101,
          S6 = 3'b110,
          S7 = 3'b111;
    
//define state paramters
reg [2:0] _state, _nextState;    



//alawys block to update state
always@(posedge _clk, posedge _reset)
begin
    if(_reset)
    begin
        _state <= S0;
        //_nextState <= S0;
    end
    else
    begin
        _state <= _nextState;
    end
end



//always block to compute next state
always@(_state, _start, _countZero)
begin

    case(_state)
    
    S0:
    begin
        if(_start == 1'b1)
        begin
            _nextState = S1;
        end
        else
        begin
            _nextState = S0;
        end
    end
    
    S1:
    begin
        if(_start == 1'b0)
        begin
            _nextState = S2;
        end
        else
        begin
            _nextState = S1;
        end
    end
    
    S2:
    begin
        _nextState = S3;
    end
    
    S3:
    begin
        if(_countZero == 1'b1)
        begin
            _nextState = S0;
        end
        else
        begin
            _nextState = S4;
        end
    end
    
    S4:
    begin
        _nextState = S5;
    end
    
    S5:
    begin
        _nextState = S3;
    end
    
    default:
    begin
        _nextState = S0;
    end
    endcase
end

    
//alwasy block to compute output
always@(_state, _start, _countZero)
begin
    case(_state)
        
        S0:
        begin
        end
        
        
        S1:
        begin
            _clear = 1'b1;
            _done = 1'b0;
            _loadA = 1'b0;
            _loadB = 1'b0;
            _countDown = 1'b0;
            _loadHoldA = 1'b0;
            _loadProduct = 1'b0;
        end
        
        S2:
        begin
            _clear = 1'b0;
            _loadA = 1'b1;
            _loadB = 1'b1;
        end
        
        S3:
        begin
            _loadA = 1'b0;
            _loadB = 1'b0;
            
            if(_countZero == 1'b1)
            begin
                _done = 1'b1;
            end
            else
            begin
                _done = 1'b0;
            end
        end
        
        S4:
        begin
            _loadProduct = 1'b1;
            _countDown = 1'b1;            
        end
        
        S5:
        begin
            _loadProduct = 1'b0;
            _countDown = 1'b0;
            _loadHoldA = 1'b1;
        end
        
        default:
        begin
            _done = 1'b0;
        end
        
    endcase
end

    
endmodule
