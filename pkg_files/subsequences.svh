class I2C_subsequence_s1 extends uvm_sequence;
    `uvm_object_utils(I2C_subsequence_s1)

    function new(string name = "I2C_subsequence_s1");
        super.new(name);
    endfunction

    con_seq_item c_si = con_seq_item::type_id::create("c_si");

    virtual task body();
        randomized_test();
    endtask

    virtual task randomized_test();
        repeat(64) begin
            start_item(c_si);
            if (!c_si.randomize) begin
                `uvm_fatal("body", "Randomization failed lmao fix your constraints")
            end
            finish_item(c_si);
        end
    endtask

endclass



class I2C_subsequence_s2 extends uvm_sequence;
    `uvm_object_utils(I2C_subsequence_s2)

    function new(string name = "I2C_subsequence_s2");
        super.new(name);
    endfunction

    con_seq_item c_si = con_seq_item::type_id::create("c1_si");

    virtual task body();
        read_test();
        write_test();
    endtask

    virtual task read_test();
        repeat(32) begin
            start_item(c_si);
            if (!c_si.randomize with {addr_target[0] == 1'b1; start == 1'b1;}) begin
                `uvm_fatal("body", "Randomization failed lmao fix your constraints")
            end
            finish_item(c_si);
        end
    endtask

    virtual task write_test();
        repeat(32) begin
            start_item(c_si);
            if (!c_si.randomize with {addr_target[0] == 1'b0; start == 1'b1;}) begin
                `uvm_fatal("body", "Randomization failed lmao fix your constraints")
            end
            finish_item(c_si);
        end
    endtask

endclass

