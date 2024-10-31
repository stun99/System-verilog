module demux (input [1:0]s,y,output reg [3:0]e);
always @(*) begin
e = 4'b0000;
e[s]=y;
end
endmodule

module top;
logic [1:0]s;
logic [3:0]e;
logic y;
demux DUT (s,y,e);
initial begin
repeat (10) begin
//#5;
s = $random;
y = $random;
$monitor("s=%0d,e=%0d,y=%0d",s,e,y);
#5;
end
end
endmodule

