class I2C_c1_driver extends uvm_driver#(con_seq_item);

    `uvm_component_utils(I2C_c1_driver)

    function new(string name = "I2C_c1_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    con_seq_item c_si;

    virtual controller_intf c_intf;

    virtual I2C_lines i2c_intf;

    virtual debug_interface di;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_resource_db#(virtual controller_intf)::read_by_name(get_full_name(), "c_intf", c_intf, this)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name, ".vif" });
        end
        if (!uvm_resource_db#(virtual I2C_lines)::read_by_name(get_full_name(), "i2c_intf", i2c_intf, this)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name, ".vif" });
        end
        if (!uvm_resource_db#(virtual debug_interface)::read_by_name(get_full_name(), "di", di, this)) begin
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name, ".vif" });
        end
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            wait(c_intf.rst);
            fork
                run_con();
            join_none
            wait(~c_intf.rst);
            disable fork;
        end
    endtask


    int CONTROLLER = 1;

    virtual task run_con();
        c_intf.start[CONTROLLER-1]              <= '0;
        c_intf.data_send[CONTROLLER-1]          <= '0;
        c_intf.num_bytes_send[CONTROLLER-1]     <= '0;
        c_intf.num_bytes_receive[CONTROLLER-1]  <= '0;
        c_intf.addr_target[CONTROLLER-1]        <= '0;
        repeat(1000) @(posedge c_intf.clk);
        forever begin
            seq_item_port.get_next_item(c_si);
            c_intf.start[CONTROLLER-1]              <= c_si.start;
            c_intf.data_send[CONTROLLER-1]          <= c_si.data_send;
            c_intf.num_bytes_send[CONTROLLER-1]     <= c_si.num_bytes_send;
            c_intf.num_bytes_receive[CONTROLLER-1]  <= c_si.num_bytes_receive;
            c_intf.addr_target[CONTROLLER-1]        <= {1'b1, c_si.addr_target};
            seq_item_port.item_done();

            repeat(1000) @(posedge c_intf.clk);
            c_intf.start[CONTROLLER-1]  <= '0;

            check_condition();
        end
    endtask


    virtual task check_condition();
        bit did_something_happened;
        detect_if_nothing_happens(did_something_happened);
        if (did_something_happened) begin
            detect_stop_condition();
        end
        else begin
        end
    endtask


    virtual task detect_if_nothing_happens(output bit did_something_happened);
        int c = 0;
        did_something_happened = 0;
        repeat(127) begin
            repeat(100) @(posedge i2c_intf.clk);
            if (i2c_intf.SCL == 1 && i2c_intf.SDA == 1)
                c += 1;
            else
                break;
        end
        if (c < 127)
            did_something_happened = 1;
        else
            did_something_happened = 0;
    endtask


    virtual task detect_stop_condition();
        int state = 0;
        forever begin
            di.db <= state;
            @(posedge i2c_intf.clk)
            if (state == 0) begin
                if (i2c_intf.SCL == 0 && i2c_intf.SDA == 0)
                    state = 1;
                else
                    continue;
            end
            else if (state == 1) begin
                if      (i2c_intf.SCL == 0 && i2c_intf.SDA == 0)
                    continue;
                else if (i2c_intf.SCL == 1 && i2c_intf.SDA == 0)
                    state = 2;
                else 
                    state = 0;
            end
            else if (state == 2) begin
                if      (i2c_intf.SCL == 1 && i2c_intf.SDA == 0)
                    continue;
                else if (i2c_intf.SCL == 1 && i2c_intf.SDA == 1)
                    state = 3;
                else 
                    state = 0;
            end
            else if (state == 3) begin
                state = 0;
                break;
            end
            else begin 
                `uvm_fatal("detect stop condition cycle", "fix this shit lmao")
            end
        end
    endtask

endclass: I2C_c1_driver




class I2C_c2_driver extends I2C_c1_driver;

    `uvm_component_utils(I2C_c2_driver)

    function new(string name = "I2C_c2_driver", uvm_component parent);
        super.new(name, parent);
    endfunction


    virtual task run_con();
        CONTROLLER = 2;
        super.run_con();
    endtask

endclass: I2C_c2_driver




class I2C_c3_driver extends I2C_c1_driver;

    `uvm_component_utils(I2C_c3_driver)

    function new(string name = "I2C_c3_driver", uvm_component parent);
        super.new(name, parent);
    endfunction


    virtual task run_con();
        CONTROLLER = 3;
        super.run_con();
    endtask

endclass: I2C_c3_driver