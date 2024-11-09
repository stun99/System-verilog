import ece571_cpu_pkg::*;
module ece571_alu #(parameter N = 32) (
  input opcode_t opcode,
  input logic [N-1:0] a,
  input logic [N-1:0] b,
    output logic [N-1:0] result
);
  always_comb begin
    case (opcode)
      OP_ADD: result = a + b;
      OP_SUB: result = a - b;
      OP_AND: result = a & b;
      OP_OR:  result = a | b;
      OP_XOR: result = a ^ b;
      default: result = 1'b0;
    endcase
end
endmodule
