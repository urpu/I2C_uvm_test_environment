class I2C_c1_sequence_base extends uvm_sequence;

    `uvm_object_utils(I2C_c1_sequence_base)

    function new(string name = "I2C_c1_sequence_base");
        super.new(name);
    endfunction

    I2C_subsequence_s2 s2 = I2C_subsequence_s2::type_id::create("s2");
    I2C_subsequence_s1 s1 = I2C_subsequence_s1::type_id::create("s1");

    virtual task body();
        s2.start(m_sequencer);
        s1.start(m_sequencer);
    endtask

endclass




class I2C_c2_sequence_base extends I2C_c1_sequence_base;

    `uvm_object_utils(I2C_c2_sequence_base)

    function new(string name = "I2C_c2_sequence_base");
        super.new(name);
    endfunction

endclass




class I2C_c3_sequence_base extends I2C_c1_sequence_base;

    `uvm_object_utils(I2C_c3_sequence_base)

    function new(string name = "I2C_c3_sequence_base");
        super.new(name);
    endfunction
endclass
