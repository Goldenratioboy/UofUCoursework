transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/hexTo7Seg.v}
vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/fibfsm.v}
vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/_3710alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/Wrapper.v}
vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/regfile.v}

vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/FSM_Logical.v}
vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/FSM_Logical_tb.v}
vlog -vlog01compat -work work +incdir+C:/Users/steen/Desktop/ECE-3710/regfile {C:/Users/steen/Desktop/ECE-3710/regfile/Wrapper.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  FSM_Logical_tb

add wave *
view structure
view signals
run 1 sec
