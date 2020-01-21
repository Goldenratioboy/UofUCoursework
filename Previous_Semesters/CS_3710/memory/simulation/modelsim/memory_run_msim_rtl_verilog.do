transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/regFile {C:/Users/delij/Documents/ECE 3710/ECE-3710/regFile/hexTo7Seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/memory {C:/Users/delij/Documents/ECE 3710/ECE-3710/memory/memory_fsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/memory {C:/Users/delij/Documents/ECE 3710/ECE-3710/memory/memory.v}

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/memory {C:/Users/delij/Documents/ECE 3710/ECE-3710/memory/memory_fsm.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  memory_fsm

add wave *
view structure
view signals
run -all
