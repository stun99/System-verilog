module async (input logic d,clk,rst,output logic q);
always @(posedge clk or posedge rst) begin
if(rst==1) q <=0;
else q <=d;
end
endmodule

module top ();
logic d,clk,rst,q;
async DUT(d,clk,rst,q);

initial begin
clk =0;
forever #5 clk =~clk;
end

initial begin 
rst =0;
d=1;
#10;
rst =1;
d=1;
#15;
rst =0;
d=1;
#10;
d=0;
#10;
d=1;
$stop;
end 

endmodule


