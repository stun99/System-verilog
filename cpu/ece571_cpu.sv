`include "ece571_cpu_pkg.sv"
module ece571_cpu (
  input logic clk,
  input logic reset,
  input logic [3:0] read_addr1,
  input logic [3:0] read_addr2,
  input logic [3:0] write_addr,
  input logic [31:0] write_data,
  input logic we,
  output logic [31:0] alu_result
);
  logic [31:0] reg_data1;
  logic [31:0] reg_data2;
  ece571_cpu_pkg::alu_instruction pipe_stage;
  ece571_cpu_pkg::opcode_t opcode;

  ece571_regfile regfile_inst (
    .clk(clk),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),
    .write_data(write_data),
    .we(we),
    .read_data1(reg_data1),
    .read_data2(reg_data2)
  );
  ece571_alu #(.N(32)) alu_inst (
    .a(reg_data1),
    .b(reg_data2),
    .opcode(opcode),
    .result(alu_result)
  );
  always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
      pipe_stage <= '0; 
    end else begin
      pipe_stage.rs1 <= read_addr1;
      pipe_stage.rs2 <= read_addr2;
      pipe_stage.rd <= write_addr;
      pipe_stage.data <= write_data;
      pipe_stage.opcode <= opcode;
      pipe_stage.we <= we;
    end
  end
  always_comb begin
    opcode = pipe_stage.opcode;
  end

endmodule
