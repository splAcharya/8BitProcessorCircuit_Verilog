`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Swapnil Acharya
// 
// Create Date: 10/09/2019 02:15:07 PM
// Design Name: 
// Module Name: uC_8Bit
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


module uC_8Bit(
//define inputs
input _clk, _reset,
//define outputs
output reg [5:0] _cycle,
output reg [7:0] _romAddress,
output reg [7:0] _instructionReg, _programCounter,
output reg [7:0] _R0, _R1, _R2, _R3,
output reg [7:0] _Rhi, _Rlo, _Rquotient, _Rremainder,
output reg _ramWrite,
output reg [7:0] _ramAddress,
output [7:0] _romOut, _ramOut
    );
    


//^^^^^^^^^^^^^^^^^^^^^^^^CONNECT MULTIPLIER^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^////

//internal connections
wire _done_multouc;
wire [15:0] _product_multouc;

reg _mul_start_uc; 
reg [7:0] _mul_dataA_uC, _mul_dataB_uC; 


//output connections

Multiplier_8Bit MUL80(
//define inputs
._clk(_clk),
._reset(_reset),
._start(_mul_start_uc),
._dataInA(_mul_dataA_uC),
._dataInB(_mul_dataB_uC),
    
//define outputs
._product(_product_multouc),    
._done(_done_multouc)
    );

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^////




//^^^^^^^^^^^^^^^^^^^^^^^^CONNECT DIVIDER^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^////


//internal connections
wire _done_divtouc, _error_divtouc;
wire [7:0] _quotient_divtouc, _remainder_divtouc;

reg _div_start_uc; 
reg [7:0] _div_dataA_uC, _div_dataB_uC; 


//ouput connections
Divider_8Bit DIV80(
//define inputs
._clk(_clk),
._reset(_reset),
._start(_div_start_uc),
._dataInA(_div_dataA_uC),
._dataInB(_div_dataB_uC),

//define outputs
._doneOut(_done_divtouc),
._errorOut(_error_divtouc),
._quotientOut(_quotient_divtouc),
._remainderOut(_remainder_divtouc)
);

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^////




///^^^^^^^^^^^^^^^^^^^^^^^^^^^Connect Memory Unit^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^///

//CREATE ROM
reg [7:0] ROM [255:0];
initial $readmemh("D:/BitBucketLocalRepository/verilog-projects/8_Bit_Processor/8Bit_uC/8Bit_uC.srcs/sources_1/imports/8Bit_uC/ROM_INSTRUCTIONS.txt",ROM,0,255); 
assign _romOut = ROM[_romAddress];


//CREATE RAM
reg [7:0] RAM [256:0];
reg [7:0] _ramDataIn;   
integer i;        
always@(posedge _clk, posedge _reset)  
begin
    if(_reset == 1'b1)
    begin
        for(i = 0; i < 256; i = i + 1)
        begin
            RAM[i] <= 8'd0;
        end
    end
    else
    begin
        if(_ramWrite == 1'b1)
        begin
            RAM[_ramAddress] <= _ramDataIn;
        end
        else
        begin
            RAM[_ramAddress] <= RAM[_ramAddress];
        end
    end
end    
    
assign _ramOut = RAM[_ramAddress];
///^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//




//^^^^^^^^^^^^^^^^^^^^^^^^^^^define parameters^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//
parameter IDLE  = 6'd0,
          FETCH = 6'd1,
          DECODE = 6'd2,
          
          EXECUTE_NOP = 6'd3,
          EXECUTE_ADD = 6'd4,
          EXECUTE_SUB = 6'd5,
          EXECUTE_NOT = 6'd6,
          EXECUTE_AND = 6'd7,
          EXECUTE_OR = 6'd8,
          
          EXECUTE_MOV_RD_RS = 6'd9,
         
          EXECUTE_MUL_START = 6'd10,
          EXECUTE_MUL_WAIT = 6'd11,
          EXECUTE_MUL_DONE = 6'd12,
          
          EXECUTE_DIV_START = 6'd13,
          EXECUTE_DIV_WAIT = 6'd14,
          EXECUTE_DIV_DONE = 6'd15,
          
          EXECUTE_MOV_MEM_RS_START = 6'd16,  //store register to mem
          EXECUTE_MOV_MEM_RS_DONE = 6'd17,
          
          EXECUTE_MOV_RD_OP_START = 6'd18, //Load Reg Immidiate
          EXECUTE_MOV_RD_OP_DONE = 6'd19,
          
          EXECUTE_MOV_RD_MEM_START = 6'd20, //Load Reg From Memory
          EXECUTE_MOV_RD_MEM_DONE = 6'd21,
          
          EXECUTE_JMP_START = 6'd22, //Unconditional Jump
          EXECUTE_JMP_DONE = 6'd23, //Unconditional Jump
          
          EXECUTE_JNZ_START = 6'd24, //jump if zero
          EXECUTE_JNZ_DONE  = 6'd25, //jump if zero
          
          EXECUTE_MOV_MEM_RHI_RLO_START = 6'd26,
          EXECUTE_MOV_MEM_RHI_RLO_WAIT = 6'd27,
          EXECUTE_MOV_MEM_RHI_RLO_DONE = 6'd28; //store rhi rlo to memory
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^//          
          


 
always@(posedge _clk, posedge _reset)
begin
    if(_reset == 1'b1)
    begin
        _cycle <= IDLE;
    end
    
    else
    begin
    
        case(_cycle)
            
            IDLE:
            begin
                _cycle <= FETCH;
                _instructionReg <= 8'd0;
                _programCounter <= 8'd0;
                _R0 <= 8'd0;
                _R1 <= 8'd0;
                _R2 <= 8'd0;
                _R3 <= 8'd0;
                _Rhi <= 8'd0;
                _Rlo <= 8'd0;
                _Rquotient <= 8'd0;
                _Rremainder <= 8'd0;
                _ramWrite<= 1'b0;
                _romAddress<= 8'd0;
                _ramAddress<= 8'd0;
                _ramDataIn<= 8'd0;                
            end
            
            FETCH:
            begin
                 //currect cycle instrcutions
                _instructionReg <= _romOut;
                _programCounter <= _programCounter + 1;
                
                //next cycle computation
                _cycle <= DECODE;
            end
           
            DECODE:
            begin
                //currect cycle instructions
                _romAddress <= _programCounter;
                
                //decode instruction
                case(_instructionReg[7:4])
                    4'b0000: 
                    begin
                        _cycle <= EXECUTE_NOP; 
                    end
                    
                    4'b0001: 
                    begin
                        _cycle <= EXECUTE_ADD;
                    end
                    
                    4'b0010:
                    begin
                        _cycle <= EXECUTE_SUB;
                    end
                    
                    4'b0011: 
                    begin
                        _cycle <= EXECUTE_NOT;
                    end
                    
                    4'b0100:
                    begin
                        _cycle <= EXECUTE_AND;
                    end
                    
                    4'b0101: 
                    begin
                        _cycle <= EXECUTE_OR;
                    end
                    
                    4'b0110: 
                    begin
                        _cycle <= EXECUTE_MOV_RD_RS;
                    end
                    
                    4'b1100: 
                    begin
                        _cycle <= EXECUTE_MUL_START;
                    end
                    
                    4'b1101:
                    begin
                         _cycle <= EXECUTE_DIV_START;
                    end
                    
                    4'b0111:
                    begin
                        _programCounter <= _programCounter + 1'b1;
                        _cycle <= EXECUTE_MOV_MEM_RS_START;
                    end 
                    
                    4'b1000:
                    begin
                        _programCounter <= _programCounter + 1'b1;
                        _cycle <= EXECUTE_MOV_RD_OP_START;
                    end
                    
                    
                    4'b1001:
                    begin
                        _programCounter <= _programCounter + 1'b1;
                        _cycle <= EXECUTE_MOV_RD_MEM_START;
                    end
                    
                    4'b1010:
                    begin
                        _programCounter <= _programCounter + 1'b1;
                        _cycle <= EXECUTE_JMP_START;                    
                    end
                    
                    4'b1011:
                    begin
                        _programCounter <= _programCounter + 1'b1;
                        _cycle <= EXECUTE_JNZ_START;                       
                    end
                    
                    4'b1110:
                    begin
                        _programCounter <= _programCounter + 1'b1;
                        _cycle <= EXECUTE_MOV_MEM_RHI_RLO_START;   
                    end
                    
                    default: _cycle <= EXECUTE_NOP;
                endcase
                
            end
       
            
            EXECUTE_NOP:
            begin
            
                //curret cycle instructions
                
                //next cycle instructions
                _cycle <= FETCH;
            end
            
            EXECUTE_ADD:
            begin
                
                //current cycle instructions
                case(_instructionReg[3:0])
                    4'b0000: _R0 <= _R0 + _R0;
                    4'b0001: _R0 <= _R0 + _R1;
                    4'b0010: _R0 <= _R0 + _R2;
                    4'b0011: _R0 <= _R0 + _R3;
                    
                    4'b0100: _R1 <= _R1 + _R0;
                    4'b0101: _R1 <= _R1 + _R1;
                    4'b0110: _R1 <= _R1 + _R2;
                    4'b0111: _R1 <= _R1 + _R3;

                    4'b1000: _R2 <= _R2 + _R0;
                    4'b1001: _R2 <= _R2 + _R1;
                    4'b1010: _R2 <= _R2 + _R2;
                    4'b1011: _R2 <= _R2 + _R3;
                    
                    4'b1100: _R3 <= _R3 + _R0;
                    4'b1101: _R3 <= _R3 + _R1;
                    4'b1110: _R3 <= _R3 + _R2;
                    4'b1111: _R3 <= _R3 + _R3; 
                    
                    default: _R0 <= _R0 + _R0;                                                           
                endcase
                
                //next cycle instructions
                _cycle <= FETCH;
            end


            EXECUTE_SUB:
            begin
                
                //current cycle instructions
                case(_instructionReg[3:0])
                
                    4'b0000: _R0 <= _R0 - _R0;
                    4'b0001: _R0 <= _R0 - _R1;
                    4'b0010: _R0 <= _R0 - _R2;
                    4'b0011: _R0 <= _R0 - _R3;
                    
                    4'b0100: _R1 <= _R1 - _R0;
                    4'b0101: _R1 <= _R1 - _R1;
                    4'b0110: _R1 <= _R1 - _R2;
                    4'b0111: _R1 <= _R1 - _R3;

                    4'b1000: _R2 <= _R2 - _R0;
                    4'b1001: _R2 <= _R2 - _R1;
                    4'b1010: _R2 <= _R2 - _R2;
                    4'b1011: _R2 <= _R2 - _R3;
                    
                    4'b1100: _R3 <= _R3 - _R0;
                    4'b1101: _R3 <= _R3 - _R1;
                    4'b1110: _R3 <= _R3 - _R2;
                    4'b1111: _R3 <= _R3 - _R3; 
                    
                    default: _R0 <= _R0 - _R0;                                                           
                endcase
                
                //next cycle instructions
                _cycle <= FETCH;
            end
            
            
            
            EXECUTE_NOT:
            begin
                
                //current cycle instructions
                case(_instructionReg[3:0])
                    4'b0000: _R0 <= ~_R0;
                    4'b0001: _R0 <= ~_R1;
                    4'b0010: _R0 <= ~_R2;
                    4'b0011: _R0 <= ~_R3;
                    
                    4'b0100: _R1 <= ~_R0;
                    4'b0101: _R1 <= ~_R1;
                    4'b0110: _R1 <= ~_R2;
                    4'b0111: _R1 <= ~_R3;

                    4'b1000: _R2 <= ~_R0;
                    4'b1001: _R2 <= ~_R1;
                    4'b1010: _R2 <= ~_R2;
                    4'b1011: _R2 <= ~_R3;
                    
                    4'b1100: _R3 <= ~_R0;
                    4'b1101: _R3 <= ~_R1;
                    4'b1110: _R3 <= ~_R2;
                    4'b1111: _R3 <= ~_R3; 
                    
                    default: _R0 <= ~_R0;                                                           
                endcase
                
                //next cycle instructions
                _cycle <= FETCH;
            end            
                         
                         
            EXECUTE_AND:
            begin
                
                //current cycle instructions
                case(_instructionReg[3:0])
                    4'b0000: _R0 <= _R0 & _R0;
                    4'b0001: _R0 <= _R0 & _R1;
                    4'b0010: _R0 <= _R0 & _R2;
                    4'b0011: _R0 <= _R0 & _R3;
                    
                    4'b0100: _R1 <= _R1 & _R0;
                    4'b0101: _R1 <= _R1 & _R1;
                    4'b0110: _R1 <= _R1 & _R2;
                    4'b0111: _R1 <= _R1 & _R3;

                    4'b1000: _R2 <= _R2 & _R0;
                    4'b1001: _R2 <= _R2 & _R1;
                    4'b1010: _R2 <= _R2 & _R2;
                    4'b1011: _R2 <= _R2 & _R3;
                    
                    4'b1100: _R3 <= _R3 & _R0;
                    4'b1101: _R3 <= _R3 & _R1;
                    4'b1110: _R3 <= _R3 & _R2;
                    4'b1111: _R3 <= _R3 & _R3; 
                    
                    default: _R0 <= _R0 & _R0;                                                           
                endcase
                
                //next cycle instructions
                _cycle <= FETCH;
            end
            
            
            
            EXECUTE_OR:
            begin
                
                //current cycle instructions
                case(_instructionReg[3:0])
                    4'b0000: _R0 <= _R0 | _R0;
                    4'b0001: _R0 <= _R0 | _R1;
                    4'b0010: _R0 <= _R0 | _R2;
                    4'b0011: _R0 <= _R0 | _R3;
                    
                    4'b0100: _R1 <= _R1 | _R0;
                    4'b0101: _R1 <= _R1 | _R1;
                    4'b0110: _R1 <= _R1 | _R2;
                    4'b0111: _R1 <= _R1 | _R3;

                    4'b1000: _R2 <= _R2 | _R0;
                    4'b1001: _R2 <= _R2 | _R1;
                    4'b1010: _R2 <= _R2 | _R2;
                    4'b1011: _R2 <= _R2 | _R3;
                    
                    4'b1100: _R3 <= _R3 | _R0;
                    4'b1101: _R3 <= _R3 | _R1;
                    4'b1110: _R3 <= _R3 | _R2;
                    4'b1111: _R3 <= _R3 | _R3; 
                    
                    default: _R0 <= _R0 | _R0;                                                           
                endcase
                
                //next cycle instructions
                _cycle <= FETCH;
            end            
            
            EXECUTE_MOV_RD_RS:
            begin
                
                //current cycle instructions
                case(_instructionReg[3:0])
                    4'b0000: _R0 <= _R0;
                    4'b0001: _R0 <= _R1;
                    4'b0010: _R0 <= _R2;
                    4'b0011: _R0 <= _R3;
                    
                    4'b0100: _R1 <= _R0;
                    4'b0101: _R1 <= _R1;
                    4'b0110: _R1 <= _R2;
                    4'b0111: _R1 <= _R3;

                    4'b1000: _R2 <= _R0;
                    4'b1001: _R2 <= _R1;
                    4'b1010: _R2 <= _R2;
                    4'b1011: _R2 <= _R3;
                    
                    4'b1100: _R3 <= _R0;
                    4'b1101: _R3 <= _R1;
                    4'b1110: _R3 <= _R2;
                    4'b1111: _R3 <= _R3; 
                    
                    default: _R0 <= _R0;                                                           
                endcase
                
                //next cycle instructions
                _cycle <= FETCH;
            end
            
            EXECUTE_MUL_START:
            begin
            
                //current cycle instructions
                
                case(_instructionReg[3:0]) //assgin data to mul inputs
                    4'b0000: {_mul_dataA_uC,_mul_dataB_uC} <= {_R0,_R0};
                    4'b0001: {_mul_dataA_uC,_mul_dataB_uC} <= {_R0,_R1};
                    4'b0010: {_mul_dataA_uC,_mul_dataB_uC} <= {_R0,_R2};
                    4'b0011: {_mul_dataA_uC,_mul_dataB_uC} <= {_R0,_R3};
                    
                    4'b0100: {_mul_dataA_uC,_mul_dataB_uC} <= {_R1,_R0};
                    4'b0101: {_mul_dataA_uC,_mul_dataB_uC} <= {_R1,_R1};
                    4'b0110: {_mul_dataA_uC,_mul_dataB_uC} <= {_R1,_R2};
                    4'b0111: {_mul_dataA_uC,_mul_dataB_uC} <= {_R1,_R3};

                    4'b1000: {_mul_dataA_uC,_mul_dataB_uC} <= {_R2,_R0};
                    4'b1001: {_mul_dataA_uC,_mul_dataB_uC} <= {_R2,_R1};
                    4'b1010: {_mul_dataA_uC,_mul_dataB_uC} <= {_R2,_R2};
                    4'b1011: {_mul_dataA_uC,_mul_dataB_uC} <= {_R2,_R3};
                    
                    4'b1100: {_mul_dataA_uC,_mul_dataB_uC} <= {_R3,_R0};
                    4'b1101: {_mul_dataA_uC,_mul_dataB_uC} <= {_R3,_R1};
                    4'b1110: {_mul_dataA_uC,_mul_dataB_uC} <= {_R3,_R2};
                    4'b1111: {_mul_dataA_uC,_mul_dataB_uC} <= {_R3,_R3}; 
                    
                    default: _R0 <= _R0;                                                           
                endcase
                
                _mul_start_uc <= 1'b1; //start multiplier
                
                //next cycle instructions
                _cycle <= EXECUTE_MUL_WAIT;
            end
             
             
           EXECUTE_MUL_WAIT:
           begin
                
                //current cycle instructions
                _mul_start_uc <= 1'b0; //turn off start mul signal
                
                //next cycle instructions
                if(_done_multouc == 1'b1)
                begin
                    _cycle <= EXECUTE_MUL_DONE;
                end
                else
                begin
                    _cycle <= EXECUTE_MUL_WAIT;
                end
           end
           
           EXECUTE_MUL_DONE:
           begin
                //current cycle instructions
                {_Rhi,_Rlo} <= _product_multouc;
                
                //next cycle instructions
                _cycle <= FETCH;
           end
           
           
           EXECUTE_DIV_START:
           begin
            //current cycle instructions
                
                case(_instructionReg[3:0]) //assgin data to mul inputs
                    4'b0000: {_div_dataA_uC,_div_dataB_uC} <= {_R0,_R0};
                    4'b0001: {_div_dataA_uC,_div_dataB_uC} <= {_R0,_R1};
                    4'b0010: {_div_dataA_uC,_div_dataB_uC} <= {_R0,_R2};
                    4'b0011: {_div_dataA_uC,_div_dataB_uC} <= {_R0,_R3};
                    
                    4'b0100: {_div_dataA_uC,_div_dataB_uC} <= {_R1,_R0};
                    4'b0101: {_div_dataA_uC,_div_dataB_uC} <= {_R1,_R1};
                    4'b0110: {_div_dataA_uC,_div_dataB_uC} <= {_R1,_R2};
                    4'b0111: {_div_dataA_uC,_div_dataB_uC} <= {_R1,_R3};

                    4'b1000: {_div_dataA_uC,_div_dataB_uC} <= {_R2,_R0};
                    4'b1001: {_div_dataA_uC,_div_dataB_uC} <= {_R2,_R1};
                    4'b1010: {_div_dataA_uC,_div_dataB_uC} <= {_R2,_R2};
                    4'b1011: {_div_dataA_uC,_div_dataB_uC} <= {_R2,_R3};
                    
                    4'b1100: {_div_dataA_uC,_div_dataB_uC} <= {_R3,_R0};
                    4'b1101: {_div_dataA_uC,_div_dataB_uC} <= {_R3,_R1};
                    4'b1110: {_div_dataA_uC,_div_dataB_uC} <= {_R3,_R2};
                    4'b1111: {_div_dataA_uC,_div_dataB_uC} <= {_R3,_R3}; 
                    
                    default: _R0 <= _R0;                                                           
                endcase
                
                _div_start_uc <= 1'b1; //start divider
                
                //next cycle instructions
                _cycle <= EXECUTE_DIV_WAIT;
            end
             
             
           EXECUTE_DIV_WAIT:
           begin
                
                //current cycle instructions
                _div_start_uc <= 1'b0; //turn off start div signal
                
                //next cycle instructions
                if(_done_divtouc == 1'b1)
                begin
                    _cycle <= EXECUTE_DIV_DONE;
                end
                else
                begin
                    _cycle <= EXECUTE_DIV_WAIT;
                end
           end
           
           EXECUTE_DIV_DONE:
           begin
                //current cycle instructions
                _Rquotient <= _quotient_divtouc;
                _Rremainder <= _remainder_divtouc;
                
                //next cycle instructions
                _cycle <= FETCH;
           end
           
           
          EXECUTE_MOV_MEM_RS_START:
          begin
            //current cycle instructions
            _ramWrite <= 1'b1;
            _ramAddress <= _romOut;
                        
            case(_instructionReg[1:0])
                2'b00: _ramDataIn <= _R0;
                2'b01: _ramDataIn <= _R1;
                2'b10: _ramDataIn <= _R2;
                2'b11: _ramDataIn <= _R3;
                default: _ramDataIn<= _R0;
            endcase
            //next cycle instructions
            _cycle <= EXECUTE_MOV_MEM_RS_DONE;
          end
          
          
          EXECUTE_MOV_MEM_RS_DONE:
          begin
            //current cycle instructions
            _ramWrite <= 1'b0;
                        
            //next cycle instructions
            _cycle <= FETCH;          
          end
          
           
          EXECUTE_MOV_RD_OP_START:
          begin
            //current cycle instructions
            case(_instructionReg[1:0])
                2'b00: _R0 <= _romOut;
                2'b01: _R1 <= _romOut;
                2'b10: _R2 <= _romOut;
                2'b11: _R3 <= _romOut;
                default: _R0 <= _romOut;
            endcase
            //next cycle instructions
            _cycle <= EXECUTE_MOV_RD_OP_DONE;       
          end
          
          EXECUTE_MOV_RD_OP_DONE:
          begin
            //current cycle instructions
            _romAddress <= _programCounter;    
                    
            //next cycle instructions
            _cycle <= FETCH;          
          end
         
          
          EXECUTE_MOV_RD_MEM_START:
          begin
            //current cycle instructions
            _ramAddress <= _romOut;            
            
            //next cycle instructions   
            _cycle <= EXECUTE_MOV_RD_MEM_DONE;        
          end
          
          
          EXECUTE_MOV_RD_MEM_DONE:
          begin           
            //current cycle instructions
            _romAddress <= _programCounter;
            
            case(_instructionReg[1:0])
                2'b00: _R0 <= _ramOut;
                2'b01: _R1 <= _ramOut;
                2'b10: _R2 <= _ramOut;
                2'b11: _R3 <= _ramOut;
                default: _R0 <= _ramOut;
            endcase
            
            //next cycle instructions
            _cycle <= FETCH;
          end
          
          EXECUTE_JMP_START:
          begin
            //current cycle instructions
            _programCounter <= _romOut;
                        
            //next cycle instructions
            _cycle <= EXECUTE_JMP_DONE;         
          end
          
          
          EXECUTE_JMP_DONE:
          begin
            //current cycle instructions
            _romAddress <= _programCounter;
            
            //next cycle instructions
            _cycle <= FETCH;          
          end
          
          EXECUTE_JNZ_START:
          begin
            //current cycle instructions
            if(_R0 == 8'd0)
            begin
                _programCounter <= _romOut;
            end
            else
            begin
                _programCounter <= _programCounter;
            end
            
            
            //next cycle instructions
            _cycle <= EXECUTE_JNZ_DONE;          
          end
          
          
          EXECUTE_JNZ_DONE:
          begin
            //current cycle instructions
            _romAddress <= _programCounter;
                        
            //next cycle instructions
            _cycle <= FETCH;          
          end
          
          
          EXECUTE_MOV_MEM_RHI_RLO_START:
          begin
            //current cycle instructions
            _ramWrite <= 1'b1;
            _ramAddress <= _romOut;
            _ramDataIn <= _Rhi;
            
            //next cycle instructions
            _cycle <= EXECUTE_MOV_MEM_RHI_RLO_WAIT;      
          end
          
          
          EXECUTE_MOV_MEM_RHI_RLO_WAIT:
          begin
            //current cycle instructions
            _ramAddress <= _romOut + 1'b1;
            _ramDataIn <= _Rlo;
            
            //next cycle instructions
            _cycle <= EXECUTE_MOV_MEM_RHI_RLO_DONE;      
          end
          
          
          EXECUTE_MOV_MEM_RHI_RLO_DONE:
          begin
            //current cycle instructions
            _ramWrite <= 1'b0;
            _romAddress <= _programCounter;
                        
            //next cycle instructions
            _cycle <= FETCH;          
          end
          
          default:
          begin
            _cycle <= IDLE;
          end
          
        endcase
        
    end
    
end 
 
              
endmodule
