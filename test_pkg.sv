`include "uvm_macros.svh"

`include "parameters_pkg.sv"

`include "./I2C_module/I2C.sv"

`include "interface.sv"

package test_pkg;
import uvm_pkg::*;

import parameters_pkg::*;

`include "./pkg_files/sequence_item.svh"

`include "./pkg_files/driver.svh"

`include "./pkg_files/agent.svh"

`include "./pkg_files/environment.svh"

`include "./pkg_files/subsequences.svh"

`include "./pkg_files/sequence.svh"

`include "./pkg_files/test.svh"

endpackage