`include "asyn_fifo.sv"
module tb;
parameter DEPTH = 16;
parameter PTR_WIDTH = $clog2(DEPTH);
parameter DATA_WIDTH = 8;

reg wr_clk,rd_clk, rst, wr_en, rd_en;
reg [DATA_WIDTH -1:0] w_data;
reg [DATA_WIDTH -1:0] r_data;
wire full, overflow, empty, underflow;
reg [8*25:1] testname;
integer seed, j, k, read_dly, write_dly;
integer i;
asyn_fifo #(.DEPTH(DEPTH), .PTR_WIDTH(PTR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) dut (wr_clk, rd_clk, rst,
wr_en, w_data, full, overflow,
rd_en, r_data, empty, underflow); 

initial begin
wr_clk =0;
forever #5 wr_clk = ~wr_clk;
end

initial begin
rd_clk =0;
forever #7 rd_clk = ~rd_clk;
end

initial begin
$value$plusargs("testname=%s",testname);
$monitor("time:%t,data_in = %b, data_out =%b",$time,w_data, r_data);
seed = 183932;
reset_fifo();
case (testname)
"test_full" : begin
write_fifo(DEPTH);
end
"test_empty" : begin
write_fifo(DEPTH);
read_fifo(DEPTH);
end
"test_overflow" : begin
write_fifo(DEPTH+1);
end
"test_underflow" : begin
write_fifo(DEPTH);
read_fifo(DEPTH+1);
end
"test_concurrent_wr_rd" : begin
fork
	begin
		for (j=0; j<10;j=j+1) begin
		write_fifo(1);
		write_dly = $urandom_range(1,10);
		repeat(write_dly) @(posedge wr_clk);
		end
	end
	begin
		for (k=0; k<10;k=k+1) begin
		read_fifo(1);
		read_dly = $urandom_range(1,10);
		repeat(read_dly) @(posedge rd_clk);
		end
	end
join
end
endcase
#30
$stop;
end

task reset_fifo();
begin
rst =1;
wr_en =0;
rd_en =0;
w_data =0;
@(posedge wr_clk);
rst =0;
end
endtask

task write_fifo(input integer num_writes);
begin
for (i=0;i< num_writes;i=i+1) begin
@(posedge wr_clk);
wr_en =1;
w_data = $random;
end
@(posedge wr_clk);
wr_en =0;
w_data = 0;
end
endtask

task read_fifo(input integer num_reads);
begin
for (i=0;i< num_reads;i=i+1) begin
@(posedge rd_clk);
rd_en =1;
end
@(posedge rd_clk);
rd_en =0;
end
endtask
endmodule


