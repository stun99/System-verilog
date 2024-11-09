module syn_fifo ( 
input logic data_in, reset, clk, write_en, read_en,
output logic data_out, empty, full);
parameter DATA_WIDTH =8;
parameter LENGTH = $clog2(DATA_WIDTH);
logic [LENGTH:0] write_ptr, read_ptr;
logic mem [DATA_WIDTH-1:0];

assign empty = (write_ptr == read_ptr) && !write_en;
assign full = ((write_ptr + 1) == read_ptr);

always @(posedge clk) begin
if( reset ==1) begin
data_out =0;
write_ptr <=0;
read_ptr <=0;
end
else begin 
if (read_en==1 && empty ==0) begin
data_out <= mem[read_ptr];
$monitor("data_out =%b", data_out);
read_ptr = read_ptr +1;
end
else if( write_en ==1 && full ==0) begin
mem[write_ptr] <= data_in;
write_ptr = write_ptr +1;
end
end
end
endmodule

module top;
logic clk, reset, data_in, write_en, read_en, data_out;

syn_fifo DUT (data_in, reset, clk, write_en, read_en, data_out, empty, full);
initial begin
clk = 0;
forever #5 clk = ~clk; 
end

initial begin
$monitor("time:%t,data_in = %b, data_out =%b",$time,data_in, data_out);
reset =1;
#10;
reset =0;
write_en =1;
data_in =1;
#9;
data_in =0;
#9;
data_in =1;
#9;
data_in =0;
#9;
write_en =0;
#20;
data_in =1;
#10;
read_en =1;
#100;
end

endmodule
