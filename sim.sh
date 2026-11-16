echo "Compiling..."
vlog  test_pkg.sv testbench.sv
echo "Running..."
vsim testbench -do questa.tcl  -voptargs="+acc" +UVM_USE_OVM_RUN_SEMANTIC