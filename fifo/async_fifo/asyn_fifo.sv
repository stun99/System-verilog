module asyn_fifo (
wr_clk,rd_clk,rst,
wr_en, w_data, full, overflow,
rd_en, r_data, empty, underflow);

parameter DEPTH = 16;
parameter PTR_WIDTH = $clog2(DEPTH);
parameter DATA_WIDTH = 8;

input wr_clk,rd_clk, rst, wr_en, rd_en;
input [DATA_WIDTH -1:0] w_data;
output reg full, overflow, empty, underflow;
output reg [DATA_WIDTH -1:0] r_data;
reg [PTR_WIDTH-1:0] rd_ptr_wr_clk, wr_ptr_rd_clk;
reg [DATA_WIDTH -1:0] mem [DEPTH -1:0];
integer i;
reg [PTR_WIDTH-1:0] wr_ptr, rd_ptr;
reg wr_toggle_f, rd_toggle_f,rd_toggle_f_wr_clk,wr_toggle_f_rd_clk;
always @(posedge wr_clk) begin
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
	overflow =0;
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
	end
end

always @(posedge rd_clk) begin
	if(rst==0) begin
	underflow =0;
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

always @(posedge rd_clk) begin
wr_ptr_rd_clk <= wr_ptr;
wr_toggle_f_rd_clk <= wr_toggle_f;
end

always @(posedge wr_clk) begin
rd_ptr_wr_clk <= rd_ptr;
rd_toggle_f_wr_clk <= rd_toggle_f;
end

always @(*) begin
full =0;
if(wr_ptr == rd_ptr_wr_clk && wr_toggle_f != rd_toggle_f_wr_clk) full =1;
end
always @(*) begin 
empty =0;
//$monitor("time=%t,wr_ptr_rd_clk=%d,rd_en =%d,rd_ptr=%d,wr_toggle_f_rd_clk=%d, rd_toggle_f=%d,empty=%d",$time,wr_ptr_rd_clk,rd_en,rd_ptr,wr_toggle_f_rd_clk,rd_toggle_f,empty);
if(wr_ptr_rd_clk == rd_ptr && wr_toggle_f_rd_clk == rd_toggle_f) empty =1;
end
endmodule
