module demux (input [1:0]s,input y,output reg [3:0]e);
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
for (int i = 0; i < 8; i = i + 1) begin
            {y,s} = i; 
$monitor("%0t: y=%0b,s=%d,e=%b",$time,y,s,e);
#5;
end
end
endmodule

