vlog +define+DEBUG ece571_cpu_pkg.sv ece571_alu.sv ece571_regfile.sv ece571_cpu.sv ece571_cpu_tb.sv



#vlog ece571_cpu_pkg.sv
#vlog ece571_alu.sv
#vlog ece571_regfile.sv
#vlog ece571_cpu.sv
#vlog ece571_cpu_tb.sv

vsim work.ece571_cpu_tb
vsim -voptargs=+acc work.ece571_cpu_tb
add wave sim:ece571_cpu_tb/*

run -all
