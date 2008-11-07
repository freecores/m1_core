/*
 * Simply RISC M1 Arithmetic-Logic Unit
 *
 * Simple RTL-level ALU with Alternating Bit Protocol (ABP) interface.
 */

`include "m1_defs.vh"

// Combinational ALU with 32-bit operands
module m1_alu(
    input[31:0] a_i,             // Operands A
    input[31:0] b_i,             // Operands B
    input[4:0] func_i,           // Function to be performed
    input signed_i,              // Operation is signed
    output reg[31:0] result_o,   // Result
    output carry_o               // Carry bit
  );

  // Carry is currently unused
  assign carry_o = 0;

  // ALU Logic
  always @(a_i or b_i or func_i or signed_i) begin
    case(func_i)
      `ALU_OP_SLL: result_o = a_i << b_i[4:0];
      `ALU_OP_SRL: result_o = a_i >> b_i[4:0];
      `ALU_OP_SRA: result_o = {{32{a_i[31]}}, a_i } >> b_i[4:0];
      `ALU_OP_ADD: result_o = a_i + b_i;
      `ALU_OP_SUB: result_o = a_i - b_i;
      `ALU_OP_AND: result_o = a_i & b_i;
      `ALU_OP_OR:  result_o = a_i | b_i;
      `ALU_OP_XOR: result_o = a_i ^ b_i;
      `ALU_OP_NOR: result_o = ~(a_i | b_i);
      `ALU_OP_SEQ: result_o = (a_i == b_i) ? 32'b1 : 32'b0;
      `ALU_OP_SNE: result_o = (a_i != b_i) ? 32'b1 : 32'b0;
      `ALU_OP_SLT: if(signed_i) result_o = ({~a_i[31],a_i[30:0]} < {~b_i[31],b_i[30:0]}) ? 32'b1 : 32'b0;
                   else result_o = a_i < b_i;
      `ALU_OP_SLE: if ((a_i[31] == 1'b1) || (a_i == 32'b0)) result_o = 32'b1;   
                   else result_o = 32'b0;                        
      `ALU_OP_SGT: if ((a_i[31] == 1'b0) && (a_i != 32'b0)) result_o = 32'b1;   
                   else result_o = 32'b0;                        
      `ALU_OP_SGE: if(signed_i) result_o = ({~a_i[31],a_i[30:0]} >= {~b_i[31],b_i[30:0]}) ? 32'b1 : 32'b0;
                   else result_o = a_i >= b_i;
      default: result_o = 32'b0;
    endcase
  end

endmodule

