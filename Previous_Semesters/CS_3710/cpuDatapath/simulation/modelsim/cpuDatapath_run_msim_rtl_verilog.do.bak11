transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/cpuDatapath {C:/Users/delij/Documents/ECE 3710/ECE-3710/cpuDatapath/_3710alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/cpuDatapath {C:/Users/delij/Documents/ECE 3710/ECE-3710/cpuDatapath/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/cpuDatapath {C:/Users/delij/Documents/ECE 3710/ECE-3710/cpuDatapath/FSM.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/cpuDatapath {C:/Users/delij/Documents/ECE 3710/ECE-3710/cpuDatapath/cpuDatapath.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/cpuDatapath {C:/Users/delij/Documents/ECE 3710/ECE-3710/cpuDatapath/memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/cpuDatapath {C:/Users/delij/Documents/ECE 3710/ECE-3710/cpuDatapath/cpu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  cpu_tb

add wave *
view structure
view signals
run -all
