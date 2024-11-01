module down_count(input logic clk,rst, output logic [3:0] count);

always @(posedge clk) begin
if(rst==1) begin
count=15;
end
else if (count ==0) begin
count =15;
end
else count --; 
end
endmodule

module top ();
logic clk,rst;
logic [3:0]count;
down_count DUT(clk,rst,count);

initial begin
clk =0;
forever #5 clk =~clk;
end 

initial begin
$monitor("count = %0b",count);
#5;
rst=1;
#20;
rst =0;
#40;
rst=1;
#20;
rst=0;
#400;
$stop;
end

endmodule