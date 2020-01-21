transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

<<<<<<< HEAD
vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/alu {C:/Users/steen/Desktop/ECE-3710/alu/_3710alu.v}

vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/alu {C:/Users/steen/Desktop/ECE-3710/alu/tb_alu_rand.v}
=======
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/alu {C:/Users/delij/Documents/ECE 3710/ECE-3710/alu/hexTo7Seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/alu {C:/Users/delij/Documents/ECE 3710/ECE-3710/alu/_3710alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/alu {C:/Users/delij/Documents/ECE 3710/ECE-3710/alu/wrap.v}

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/alu {C:/Users/delij/Documents/ECE 3710/ECE-3710/alu/tb_alu_cc.v}
>>>>>>> master

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  tb_alu_cc

add wave *
view structure
view signals
run -all
