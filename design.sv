module alu(
  input clk,
  input rst,
  input [7:0] A,B,  // ALU 8-bit Inputs                 
  input [1:0] ALU_Sel,// ALU Selection
  output reg [7:0] ALU_Out, // ALU 8-bit Output
  output bit CarryOut // Carry Out Flag
);

  reg [7:0] ALU_Result;
  wire [8:0] tmp;

  assign tmp = {1'b0,A} + {1'b0,B};

  
  always @(posedge clk or posedge rst) begin
    if(rst) begin
      ALU_Out  <= 8'd0;
      CarryOut <= 1'd0;
    end
    else begin
      ALU_Out <= ALU_Result;
      CarryOut <= tmp[8];
    end
  end


  always @(*) 
    begin
      case(ALU_Sel)
        2'b00: // Addition
          ALU_Result = A + B ; 
        2'b01: // Subtraction
          ALU_Result = A - B ;
        2'b10: // Multiplication
          ALU_Result = A * B;
        2'b11: // Division
          ALU_Result = A/B;
      endcase
    end

endmodule