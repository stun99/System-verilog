module memory(clk, rst, addr, wr_rd, wdata, rdata, valid, ready);
parameter DEPTH = 1024;
parameter ADDR_WIDTH = $clog2(DEPTH);
parameter WIDTH = 16;

input clk, rst;
input [ADDR_WIDTH-1:0] addr;
input wr_rd;
input [WIDTH -1:0] wdata;
output reg [WIDTH -1:0] rdata;
input valid;
output ready;
reg ready;
int i;
reg [WIDTH-1:0] mem [DEPTH-1:0];
 always @(posedge clk) begin
if (rst ==1) begin
rdata =0;
ready =0;
for (i=0; i<DEPTH; i=i+1)
mem[i]=0;
end
else begin
if (valid ==1) begin
ready =1;
if(wr_rd ==1) begin
mem[addr] <= wdata;
end
else begin
rdata <= mem[addr];
end
end
end 
end
endmodule

