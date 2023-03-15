
//toolenv cadence-ius--18.09.005 xrun \
-uvmhome /tools/cadence-ius/18.09.005/tools/methodology/UVM/CDNS-1.2 

-incdir sv
-incdir tb

+UVM_TESTNAME=base_test
//+UVM_TESTNAME=single_reset_high_test
+UVM_NO_RELNOTES
+define+UVM_REPORT_DISABLE_FILE_LINE
-uvmlinedebug
-run

sv/clk_pkg.sv
sv/design.sv

tb/testbench.sv
