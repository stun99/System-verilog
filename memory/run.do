vlog +define+DEBUG memory.sv backdoor_tb.sv


vsim -L work tb_bd -voptargs="+acc" +testname=test_bd_write_fd_read
add wave sim:tb_bd/*

run -all
