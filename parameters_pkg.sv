package parameters_pkg;
    parameter BYTES_SEND_LOG    = 2;
    parameter BYTES_RECEIVE_LOG = 2;
    parameter BITS_SEND_MAX     = (2**BYTES_SEND_LOG-1)<<3;
    parameter ADDR_TARGET_t1    = 7'b1000111;
    parameter ADDR_TARGET_t2    = 7'b1001111;
    // parameters below are for targets, but "receive" and "send" mean
    // receive and send for controller, so there might be confusion
    parameter BYTES_SEND_t1     = 3;
    parameter BYTES_SEND_t2     = 2;
    parameter BYTES_RECEIVE_t1  = 1;
    parameter BYTES_RECEIVE_t2  = 2;
    // parameters for driver
    parameter TIME_TO_HOLD_DATA  = 32000;
    parameter TIME_TO_HOLD_START = TIME_TO_HOLD_DATA/2;


endpackage