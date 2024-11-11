module pattern_detector_1010 (
input logic clk, rst, in,
output int count, 
output logic out);

typedef enum logic [2:0] {A , B, C , D, E} state_e;

state_e currentState, nextState;

always_ff @(posedge clk) begin
if (rst) 
currentState <= A;
else 
currentState <= nextState;
end

always_comb begin
case (currentState)
A:begin
out <= 0;
if (in) nextState = B;
else nextState = A;
end
B:begin
out <= 0;
if (!in) nextState = C;
else nextState = B;
end
C:begin
out <= 0;
if (in) nextState = D;
else nextState = A;
end
D:begin
out <= 0;
if (!in) nextState = E;
else nextState = B;
end
E:begin
out <= 1;
if (in) nextState = D;
else nextState = A;
end
default: nextState = A;
endcase
end
always_ff @(posedge clk) begin
if(out) begin 
count =count+ 1;
//$monitor("count = %0d", count);
end
end
endmodule

module top();
  logic clk, rst, in, out;
  int count, i, pattern;
  logic [3:0] a;

  pattern_detector_1010 DUT (clk, rst, in, count, out);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end 

  initial begin
    rst = 1;
    #10;
    rst = 0;
    pattern = 0;
    a = 4'b0000;

    repeat (50) begin
      in = $random; 
      #10; 
      a = {a[2:0], in}; 
      if (a == 4'b1010)
        pattern = pattern + 1;
      $display("time = %0t, out = %b, in = %b", $time, out, in);
    end

    $display("expected = %0d", pattern);
    $display("module = %0d", count);

    if (count == pattern)
      $display("Pattern counted successfully");
    else
      $display("Pattern count mismatch");
$stop;
  end
endmodule

