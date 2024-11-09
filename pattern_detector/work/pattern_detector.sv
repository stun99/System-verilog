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
$monitor("count = %0d", count);
end
end
endmodule

module top();
logic clk, rst, in, count, out;
pattern_detector_1010 DUT (clk, rst, in, count, out);
initial begin
clk =0;
forever #5 clk =~clk;
end 
initial begin

repeat (50) begin
$display("time = %t, out = %d, in = %d", $time, out, in);

in = $random; 
#10;
end
end
endmodule

