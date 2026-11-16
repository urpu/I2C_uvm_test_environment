class I2C_test_base extends uvm_test;

    `uvm_component_utils(I2C_test_base)

    function new(string name = "I2C_test_base", uvm_component parent);
        super.new(name, parent);
    endfunction

    I2C_env env;

    I2C_c1_sequence_base c1_sqnce;
    I2C_c2_sequence_base c2_sqnce;
    I2C_c3_sequence_base c3_sqnce;
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = I2C_env::type_id::create("env", this);
        c1_sqnce = I2C_c1_sequence_base::type_id::create("c1_sqnce", this);
        c2_sqnce = I2C_c2_sequence_base::type_id::create("c2_sqnce", this);
        c3_sqnce = I2C_c3_sequence_base::type_id::create("c3_sqnce", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        fork
            c1_sqnce.start(env.agt.c1_sequencer);
            c2_sqnce.start(env.agt.c2_sequencer);
            c3_sqnce.start(env.agt.c3_sequencer);
        join
        phase.drop_objection(this);
    endtask


endclass