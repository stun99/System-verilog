module OR();
logic a,y;
wire b;
reg c;
int d;
bit e= 1'b1;
byte f;
real g;
logic h[3:0];
assign h[0] = d;
assign h[1] = e;
assign h[2] = a;
assign h[3] = b;
initial begin
$display("default values a=%0d, b= %0b, c=%0b, d= %0d, e=%0b, f= %0b, g=%0d", a,b,c,d,e,f,g);
for (int i=0; i<4; i++) begin
for (int j=i; j<4; j++) begin
 y = (h[i] | h[j]);
$display(" or_gate output in_0 = %0b, in_1 = %0b, op = %0b",h[i],h[j],y);
end
end
end
endmodule
