import env_pkg::*;
interface alu_if (input clk);
    //Input signals
    logic       reset;
    logic       valid_in;  //validate logic signals
    logic [3:0] a;         //port A
    logic [3:0] b;         //port B 
    logic       cin;       //carry logic from carry flag register 
    ctl_e       ctl;       //functionality control for ALU 
    //Output signals
    logic       valid_out; //validate logic signals
    logic [3:0] alu;       //the result 
    logic       carry;     //carry logic 
    logic       zero;      //zero output 
endinterface
