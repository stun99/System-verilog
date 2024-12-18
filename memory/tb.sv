`include "memory.sv"
module tb;
parameter DEPTH = 64;
parameter ADDR_WIDTH = $clog2(DEPTH);
parameter WIDTH = 16;

reg clk, rst;
reg [ADDR_WIDTH-1:0] addr;
reg wr_rd;
reg [WIDTH-1:0] wdata;
wire [WIDTH-1:0] rdata;
reg valid;
wire ready;
reg [WIDTH-1:0] mem [DEPTH-1:0];
int i;
memory #(.DEPTH(DEPTH))DUT (clk, rst, addr, wr_rd, wdata, rdata, valid, ready);

initial begin
clk =0;
forever #5 clk =~clk;
end

initial begin
reset_mem();
write_mem();
read_mem();
#100;
$stop;
end


task reset_mem ();
begin
rst =1;
addr=0;
wr_rd=0;
wdata=0;
valid =0;
@(posedge clk);
rst=0;
end
endtask

task write_mem ();
begin
for (i=0; i<DEPTH; i=i+1) begin
@(posedge clk)
addr = i;
wdata = $random;
wr_rd =1;
valid =1;
wait (ready ==1);
end
@(posedge clk)
valid =0;
end
endtask

task read_mem ();
begin
for (i=0; i<DEPTH; i=i+1) begin
@(posedge clk)
addr = i;
wr_rd =0;
valid =1;
wait (ready ==1);
end
@(posedge clk)
valid =0;
end
endtask

endmodule
