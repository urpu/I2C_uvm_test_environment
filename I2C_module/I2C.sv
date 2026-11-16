`include "./I2C_module/target_I2C.sv"
`include "./I2C_module/master_I2C.sv"
//Multi-controller multi-target (3 controllers and 2 target devices) I2C system with clock stretching, clock synchronization and arbitration logic
module I2C
#(
parameter BYTES_SEND_LOG=2,                        
parameter BYTES_RECEIVE_LOG=2,                   
parameter BITS_SEND_MAX = (2**BYTES_SEND_LOG-1)<<3
)
(
//Input Declarations
input logic clk,                                                 //For simplicity both controller and target clocks are 50MHz
input logic rst,                                                 //Active high logic

input logic start_1,                                            //Initial communication by controller 1
input logic [BITS_SEND_MAX-1:0] data_send_1,                     //Data to be sent from controller 1
input logic [BYTES_SEND_LOG-1:0] num_bytes_send_1,               //Number of bytes to be sent from controller 1
input logic [BYTES_RECEIVE_LOG-1:0] num_bytes_receive_1,         //Number of bytes to be recevied in controller 1
input logic [7:0] addr_target_1,                                 //Target address for controller 1

input logic start_2,                                             //Initial communication by controller 2
input logic [BITS_SEND_MAX-1:0] data_send_2,                     //Data to be sent from controller 2
input logic [BYTES_SEND_LOG-1:0] num_bytes_send_2,               //Number of bytes to be sent from controller 2
input logic [BYTES_RECEIVE_LOG-1:0] num_bytes_receive_2,         //Number of bytes to be recevied in controller 2
input logic [7:0] addr_target_2,                                 //Target address for controller 2

input logic start_3,                                             //Initial communication by controller 3
input logic [BITS_SEND_MAX-1:0] data_send_3,                     //Data to be sent from controller 3
input logic [BYTES_SEND_LOG-1:0] num_bytes_send_3,               //Number of bytes to be sent from controller 3
input logic [BYTES_RECEIVE_LOG-1:0] num_bytes_receive_3,         //Number of bytes to be recevied in controller 3
input logic [7:0] addr_target_3,                                 //Target address for controller 3

output tri1 SCL,                                                 //Mimicking open-drain configuration for the SCL line using 'tri1'
output tri1 SDA                                                 //Mimicking open-drain configuration for the SDA line using 'tri1'
);

import parameters_pkg::*;


//Controller instantiations
master_I2C #(.TLOW(250), .THIGH(180), .BYTES_SEND_LOG(BYTES_SEND_LOG), .BYTES_RECEIVE_LOG(BYTES_SEND_LOG)) m1( .rst(rst),
                    .clk(clk),
                    .start(start_1),
                    .addr_target(addr_target_1),
                    .num_bytes_send(num_bytes_send_1),
                    .num_bytes_receive(num_bytes_receive_1),
                    .data_send(data_send_1),
                    .SDA_bidir(SDA),
                    .SCL_bidir(SCL)
                    );
	
master_I2C #(.TLOW(300), .THIGH(225), .BYTES_SEND_LOG(BYTES_SEND_LOG), .BYTES_RECEIVE_LOG(BYTES_SEND_LOG)) m2( .rst(rst),
                    .clk(clk),
                    .start(start_2),
                    .addr_target(addr_target_2),
                    .num_bytes_send(num_bytes_send_2),
                    .num_bytes_receive(num_bytes_receive_2),
                    .data_send(data_send_2),
                    .SDA_bidir(SDA),
                    .SCL_bidir(SCL)
                    );

master_I2C #(.TLOW(300), .THIGH(225), .BYTES_SEND_LOG(BYTES_SEND_LOG), .BYTES_RECEIVE_LOG(BYTES_SEND_LOG)) m3( .rst(rst),
                    .clk(clk),
                    .start(start_3),
                    .addr_target(addr_target_3),
                    .num_bytes_send(num_bytes_send_3),
                    .num_bytes_receive(num_bytes_receive_3),
                    .data_send(data_send_3),
                    .SDA_bidir(SDA),
                    .SCL_bidir(SCL)
                    );

//Targets instantiations
// parameters BYTES_RECEIVE and BYTES_SEND mean recieve and send for controllers
target_I2C #(.ADDR_TARGET(ADDR_TARGET_t1), .BYTES_SEND(BYTES_RECEIVE_t1), .BYTES_RECEIVE(BYTES_SEND_t1)) t1 (.rst(rst),
                    .clk(clk),
                    .data_send(8'b11001110),
                    .SCL_bidir(SCL),
                    .SDA_bidir(SDA)
                    );

target_I2C #(.ADDR_TARGET(ADDR_TARGET_t2), .BYTES_SEND(BYTES_RECEIVE_t2), .BYTES_RECEIVE(BYTES_SEND_t2)) t2 (.rst(rst),
                    .clk(clk),
                    .data_send(16'b1101110011111111),
                    .SCL_bidir(SCL),
                    .SDA_bidir(SDA)
                    );

endmodule
