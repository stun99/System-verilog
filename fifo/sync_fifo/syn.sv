module syn_fifo (
clk, rst,
wr_en, w_data, full, overflow,
rd_en, r_data, empty, underflow);

parameter DEPTH = 16;
parameter PTR_WIDTH = $clog2(DEPTH);
parameter DATA_WIDTH = 8;

input clk, rst, wr_en, rd_en;
input [DATA_WIDTH -1:0] w_data;
output reg full, overflow, empty, underflow;
output reg [DATA_WIDTH -1:0] r_data;

reg [DATA_WIDTH -1:0] mem [DEPTH -1:0];
integer i;
reg [PTR_WIDTH-1:0] wr_ptr, rd_ptr;
reg wr_toggle_f, rd_toggle_f;
always @(posedge clk) begin
	if(rst==1) begin
	full =0;
	empty =1;
	overflow =0;
	underflow =0;
	r_data =0;
	wr_toggle_f=0;
	rd_toggle_f=0;
	rd_ptr=0;
	wr_ptr=0;
	for (i=0;i<DEPTH;i=i+1)
	mem[i] =0;
	end
	else begin
	overflow=0;
	underflow=0;
	if(wr_en ==1) begin
		if (full==1) begin
			overflow=1;
		end
		else begin
			mem[wr_ptr] = w_data;
			if (wr_ptr == DEPTH -1) wr_toggle_f = ~ wr_toggle_f;
			wr_ptr = wr_ptr +1;
		end
	end
	if(rd_en ==1) begin
		if (empty==1) begin
			underflow=1;
		end
		else begin
			r_data = mem[rd_ptr];
			if (rd_ptr == DEPTH -1) rd_toggle_f = ~ rd_toggle_f;
			rd_ptr = rd_ptr +1;
		end
	end
	end
end
always @(*) begin 
empty =0;
full=0;
if(wr_ptr == rd_ptr && wr_toggle_f == rd_toggle_f) empty =1;
if(wr_ptr == rd_ptr && wr_toggle_f != rd_toggle_f) full =1;
end
endmodule

