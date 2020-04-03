transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/vga {C:/Users/delij/Documents/ECE 3710/ECE-3710/vga/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/vga {C:/Users/delij/Documents/ECE 3710/ECE-3710/vga/vga_bitgen.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/vga {C:/Users/delij/Documents/ECE 3710/ECE-3710/vga/vga_wrapper.v}

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/vga {C:/Users/delij/Documents/ECE 3710/ECE-3710/vga/vga_tb.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/vga {C:/Users/delij/Documents/ECE 3710/ECE-3710/vga/vga_ctrl.v}
vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/vga {C:/Users/delij/Documents/ECE 3710/ECE-3710/vga/vga_bitgen.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  vga_ctrl

add wave *
view structure
view signals
run -all
