vlog +define+DEBUG asyn_fifo.sv tb.sv


vsim -L work tb -voptargs="+acc" +testname=test_concurrent_wr_rd
add wave sim:tb/*

run -all