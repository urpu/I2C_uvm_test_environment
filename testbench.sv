`include "uvm_macros.svh"
module testbench;
    import uvm_pkg::*;
    import test_pkg::*;

    bit clk, rst;

    I2C_lines i2c_intf(clk);

    controller_intf c_intf (clk, rst);

    debug_interface di();
    

    I2C I2C_DUT (
        .rst(rst),
        .clk(clk),
        .start_1            (c_intf.start[1]),
        .data_send_1        (c_intf.data_send[1]),
        .num_bytes_send_1   (c_intf.num_bytes_send[1]),
        .num_bytes_receive_1(c_intf.num_bytes_receive[1]),
        .addr_target_1      (c_intf.addr_target[1]),
        .start_2            (c_intf.start[2]),
        .data_send_2        (c_intf.data_send[2]),
        .num_bytes_send_2   (c_intf.num_bytes_send[2]),
        .num_bytes_receive_2(c_intf.num_bytes_receive[2]),
        .addr_target_2      (c_intf.addr_target[2]),
        .start_3            (c_intf.start[3]),
        .data_send_3        (c_intf.data_send[3]),
        .num_bytes_send_3   (c_intf.num_bytes_send[3]),
        .num_bytes_receive_3(c_intf.num_bytes_receive[3]),
        .addr_target_3      (c_intf.addr_target[3]),
        .SCL                (i2c_intf.SCL),
        .SDA                (i2c_intf.SDA)
    );

    initial begin
        clk = 0;
        forever begin
            #5; clk = ~clk;
        end
    end

    initial begin
        repeat(20) @(posedge clk);
        rst <= '0;
        repeat(20) @(posedge clk);
        rst <= '1;
        repeat(5*10**5) @(posedge clk);
        rst <= '0;
        repeat(20) @(posedge clk);
        rst <= '1;
    end


    initial begin
        repeat(10**7) @(posedge clk);
        $display("Timeout!");
        $stop();
    end
        

    initial begin
        uvm_resource_db#(virtual controller_intf)::set("*", "c_intf", c_intf);
        uvm_resource_db#(virtual I2C_lines)::set("*", "i2c_intf", i2c_intf);
        uvm_resource_db#(virtual debug_interface)::set("*", "di", di);
        run_test("I2C_test_base");
    end
    

endmodule