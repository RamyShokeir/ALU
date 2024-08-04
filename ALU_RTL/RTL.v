//Declaration of Input and Output Signals with their Data Types
module ALU #(parameter IN_DATA_WIDTH=16, parameter OUT_DATA_WIDTH=32)(
input wire [IN_DATA_WIDTH-1:0] A,B,
input wire [3:0] ALU_FUN,
input wire CLK,
output reg [OUT_DATA_WIDTH-1:0] ALU_OUT,
output wire Arith_Flag,Logic_Flag,CMP_Flag,Shift_Flag
);
reg[OUT_DATA_WIDTH-1:0] ALU_Comb;
//Combinational Always Block
always @ (*)
 begin
    //Case statements for Arithmetic,Logic ,Compare and Shift Operations
  case(ALU_FUN)
  4'b0000:ALU_Comb=A+B;
  4'b0001:
  begin
  if(A>=B)
  ALU_Comb=A-B;
  else
  ALU_Comb=B-A;
  end
  4'b0010:ALU_Comb=A*B;
  4'b0011:ALU_Comb=A/B;
  4'b0100:ALU_Comb=A&B;
  4'b0101:ALU_Comb=A|B;
  4'b0110:ALU_Comb=~(A&B);
  4'b0111:ALU_Comb=~(A|B);
  4'b1000:ALU_Comb=A^B;
  4'b1001:ALU_Comb=A~^B;
  4'b1010:
  begin
    if(A==B)
     ALU_Comb='b1;
     else
     ALU_Comb='b0;
  end
  4'b1011:
  begin
    if(A>B)
     ALU_Comb='b10;
     else
     ALU_Comb='b0;
  end
  4'b1100:
  begin
   if(A<B)
     ALU_Comb='b11;
    else
    ALU_Comb='b0;
  end
  //Shift Right
  4'b1101:ALU_Comb=A>>1;
  //Shift Left
  4'b1110:ALU_Comb=A<<1;
  default:
  ALU_Comb='b0;
  endcase
 end
 //Sequential Always Block
 always @(posedge CLK)
 begin
    ALU_OUT<=ALU_Comb;
 end
 //Rising Arith_Flag if ALU_FUN is one of ALU cases
 assign Arith_Flag=((ALU_FUN==4'b0000) || (ALU_FUN==4'b0001) || (ALU_FUN==4'b0010) || (ALU_FUN==4'b0011))?1:0;
 //Rising Logic_Flag if ALU_FUN is one of ALU cases
 assign Logic_Flag=((ALU_FUN==4'b0100) || (ALU_FUN==4'b0101) || (ALU_FUN==4'b0110) || (ALU_FUN==4'b0111) || (ALU_FUN==4'b1000) || (ALU_FUN==4'b1001))?1:0;
 //Rising CMP_Flag if ALU_FUN is one of ALU cases
 assign CMP_Flag=((ALU_FUN==4'b1010) || (ALU_FUN==4'b1011) || (ALU_FUN==4'b1100))?1:0;
 //Rising Shift_Flag if ALU_FUN is one of ALU cases
 assign Shift_Flag=((ALU_FUN==4'b1101) || (ALU_FUN==4'b1110))?1:0;
endmodule
