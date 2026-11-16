class I2C_env extends uvm_env;

    `uvm_component_utils(I2C_env)

    function new(string name = "I2C_env", uvm_component parent);
        super.new(name, parent);
    endfunction


    I2C_agent agt;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = I2C_agent::type_id::create("agt", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction


endclass