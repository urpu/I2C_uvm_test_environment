class con_seq_item extends uvm_sequence_item;

    `uvm_object_utils(con_seq_item)
    
    function new(string name = "con_seq_item");
        super.new(name);
    endfunction

    rand bit                          start;                                    
    rand bit [BITS_SEND_MAX -1:0]     data_send;            
    rand bit [BYTES_SEND_LOG-1:0]     num_bytes_send;      
    rand bit [BYTES_RECEIVE_LOG-1:0]  num_bytes_receive;
    rand bit [7:0]                    addr_target;   


    constraint target_address {addr_target[7:1] inside {ADDR_TARGET_t1, ADDR_TARGET_t2};}

    constraint no_both_receive_and_send {(addr_target[0] == '0) -> (num_bytes_send != '0 && num_bytes_receive == '0);
                                         (addr_target[0] == '1) -> (num_bytes_send == '0 && num_bytes_receive != '0);}

    constraint bytes_to_send_and_receive {if (addr_target[7:1] == ADDR_TARGET_t1){
                                              num_bytes_send == BYTES_SEND_t1 || num_bytes_receive == BYTES_RECEIVE_t1;}
                                          else {
                                              num_bytes_send == BYTES_SEND_t2 || num_bytes_receive == BYTES_RECEIVE_t2;}}

    constraint bit_amount_to_send {(data_send < 2**(num_bytes_send*8));}
                  

endclass
