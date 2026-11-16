interface I2C_lines(input logic clk);
    tri1 SCL;
    tri1 SDA;

    property SDA_is_not_constantly_zero;
         @(posedge clk) ~SDA |-> ##[1:16000] SDA;
    endproperty

    assert property(SDA_is_not_constantly_zero);
endinterface


interface controller_intf
     (input logic clk, input logic rst);
    import parameters_pkg::*;
    
    logic                         start             [3];   //Initial communication by controller 1
    logic [BITS_SEND_MAX-1:0]     data_send         [3];   //Data to be sent from controller 1
    logic [BYTES_SEND_LOG-1:0]    num_bytes_send    [3];   //Number of bytes to be sent from controller 1
    logic [BYTES_RECEIVE_LOG-1:0] num_bytes_receive [3];   //Number of bytes to be recevied in controller 1
    logic [7:0]                   addr_target       [3];   //Target address for controller 1

endinterface


interface debug_interface;
    logic [1:0] db;
    logic [9:0] cc;
endinterface