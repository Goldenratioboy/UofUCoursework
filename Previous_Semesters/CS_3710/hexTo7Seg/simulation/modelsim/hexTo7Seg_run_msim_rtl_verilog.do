transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/delij/Documents/ECE\ 3710/ECE-3710/hexTo7Seg {C:/Users/delij/Documents/ECE 3710/ECE-3710/hexTo7Seg/hexTo7Seg.v}
