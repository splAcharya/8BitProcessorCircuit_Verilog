`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2019 11:27:51 PM
// Design Name: 
// Module Name: ControlPath
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


module ControlPath(
//define inputs
input _clk, _reset, _start, _gt,
input [7:0] _count,

//define outputs
output _doneOut,_errorOut,
output _clearOut, _loadAOut, _loadBOut, _countUpOut, _holdAOut, _loadHoldAOut
    );
 
wire [2:0] _stateOut;    
parameter S0 = 3'b000,
         S1 = 3'b001,
         S2 = 3'b010,
         S3 = 3'b011,
         S4 = 3'b100,
         S5 = 3'b101,
         S6 = 3'b110,
         S7 = 3'b111;    


reg [2:0] _state, _nextState;
assign _stateOut = _state;


reg  _done, _error;
assign _doneOut = _done;
assign _errorOut = _error;


reg _clear, _loadA, _loadB, _countUp, _holdA, _loadHoldA;
assign _clearOut = _clear;
assign _loadAOut = _loadA;
assign _loadBOut = _loadB;
assign _countUpOut = _countUp;
assign _holdAOut = _holdA;
assign _loadHoldAOut = _loadHoldA;

//always block to update state
always@(posedge _clk, posedge _reset)
begin
    if(_reset)
    begin
        _state <= S0;
        //_nextState = S0;
    end
    else
    begin
        _state <= _nextState;
    end
end


//always block to compute nextstate
always@(_state,_gt,_start)
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
            if(_gt == 1'b1)
            begin
                _nextState = S4;
            end
            else
            begin
                _nextState = S0;
            end   
        end
        
        S4:
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
always@(_state,_gt,_count)
begin

    case(_state)
        S0:
        begin
        end
        
        
        S1:
        begin
            _clear = 1'b1;
            _done = 1'b0;
            _loadA= 1'b0;
            _loadB = 1'b0;
            _countUp = 1'b0;
            _holdA = 1'b0;
            _loadHoldA = 1'b0;
            _error = 1'b0;    
        end
        
        S2:
        begin
            _loadA = 1'b1;
            _loadB = 1'b1;
            _clear = 1'b0;
        end
        
        S3:
        begin
            _loadA = 1'b0;
            _loadB = 1'b0;
            
            if(_gt == 1'b1)
            begin
                _countUp = 1'b1;
                _holdA = 1'b1;               
            end
            else
            begin
                if(_count == 8'b00000000)
                begin
                    _error = 1'b1;
                end
                else
                begin
                   _done = 1'b1;
                end
            end
        end
        
        S4:
        begin
            _countUp = 1'b0;
            _holdA = 1'b0;
            _loadHoldA = 1'b1; 
        end
        
        default:
        begin
            _error = 1'b1;
            _done = 1'b0;           
        end
        
    endcase
end


endmodule
