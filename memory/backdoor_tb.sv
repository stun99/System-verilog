`include "memory.sv"
module tb_bd;
parameter DEPTH = 64;
parameter ADDR_WIDTH = $clog2(DEPTH);
parameter WIDTH = 16;
reg [8*25:1] testname;
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
$value$plusargs("testname=%s",testname);
reset_mem();
case(testname)
"test_fd_write_fd_read" :begin
write_mem_fd(0,DEPTH);
read_mem_fd(0,DEPTH);
end
"test_fd_write_bd_read" :begin
write_mem_fd(0,DEPTH);
read_mem_bd(0,DEPTH);
end
"test_bd_write_fd_read" :begin
write_mem_bd(0,DEPTH);
read_mem_fd(0,DEPTH);
end
"test_bd_write_bd_read" :begin
write_mem_bd(0,DEPTH);
read_mem_bd(0,DEPTH);
end
endcase
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

task write_mem_fd(input [ADDR_WIDTH-1:0] start_loc, input [ADDR_WIDTH:0] num_locations);
begin
for (i=start_loc; i<start_loc+num_locations; i=i+1) begin
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

task read_mem_fd (input [ADDR_WIDTH-1:0] start_loc, input [ADDR_WIDTH:0] num_locations);
begin
for (i=start_loc; i<start_loc+num_locations; i=i+1) begin
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
task write_mem_bd (input [ADDR_WIDTH-1:0] start_loc, input [ADDR_WIDTH:0] num_locations);
begin
$readmemh("image.hex",DUT.mem, start_loc, start_loc+num_locations-1);
end
endtask

task read_mem_bd (input [ADDR_WIDTH-1:0] start_loc, input [ADDR_WIDTH:0] num_locations);
begin
$writememb("image_out.bin",DUT.mem, start_loc, start_loc+num_locations-1);
end
endtask

endmodule
