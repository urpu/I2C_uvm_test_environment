class I2C_agent extends uvm_agent;

    `uvm_component_utils(I2C_agent)

    function new(string name = "u_agent_base", uvm_component parent);
        super.new(name, parent);
    endfunction

    uvm_sequencer #(con_seq_item) c1_sequencer;
    uvm_sequencer #(con_seq_item) c2_sequencer;
    uvm_sequencer #(con_seq_item) c3_sequencer;

    I2C_c1_driver c1_drv;
    I2C_c2_driver c2_drv;
    I2C_c3_driver c3_drv;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        c1_drv = I2C_c1_driver::type_id::create("c1_drv", this);
        c2_drv = I2C_c2_driver::type_id::create("c2_drv", this);
        c3_drv = I2C_c3_driver::type_id::create("c3_drv", this);
        c1_sequencer = new("c1_sequencer", this);
        c2_sequencer = new("c2_sequencer", this);
        c3_sequencer = new("c3_sequencer", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        c1_drv.seq_item_port.connect(c1_sequencer.seq_item_export);
        c2_drv.seq_item_port.connect(c2_sequencer.seq_item_export);
        c3_drv.seq_item_port.connect(c3_sequencer.seq_item_export);
    endfunction


endclass