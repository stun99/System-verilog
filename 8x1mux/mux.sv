module mux (input [1:0]s,[3:0]e, output y);

assign y =e[s];
//$display ("%0d",y);

endmodule

module top_4x1;
logic [1:0]s;
logic [3:0]e;
logic y;
mux DUT (s,e,y);
initial begin
repeat (10) begin
#5;
s = $random;
e = $random;
$monitor("s=%0d,e=%0d,y=%0d",s,e,y);
end
end
endmodule
