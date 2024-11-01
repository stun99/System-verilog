//'include "../../mux/mux.sv"

module mux8x1 (input [2:0]s,[7:0]e, output y);
logic y0, y1;
mux a0(.s(s[1:0]), .e(e[3:0]), .y(y0));
mux a1(.s(s[1:0]), .e(e[7:4]), .y(y1));
assign y = (s[2] == 0) ? y0 : y1;
endmodule

module top;
logic [2:0]s;
logic [7:0]e;
logic y;
mux8x1 DUT (s,e,y);
initial begin
repeat (10) begin
#5;
s = $random;
e = $random;
$monitor("s=%0d,e=%0d,y=%0d",s,e,y);
end
end
endmodule



