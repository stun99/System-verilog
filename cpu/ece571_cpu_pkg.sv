package ece571_cpu_pkg;
  parameter int N = 32;

  typedef enum logic [2:0] {
    OP_ADD = 3'b000,
    OP_SUB = 3'b001,
    OP_AND = 3'b010,
    OP_OR  = 3'b011,
    OP_XOR = 3'b100
  } opcode_t;

  typedef struct packed {
    logic [7:0] instruction;
    logic [3:0] rs1;
    logic [3:0] rs2;
    logic [3:0] rd;
    opcode_t opcode;
    logic [31:0] data;
    logic we;
  } alu_instruction;
endpackage
