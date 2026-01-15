import env_pkg::*;
class packet;
    //Input signals
    rand logic       reset;
    rand logic       valid_in;  //validate logic signals
    rand logic [3:0] a;         //port A
    rand logic [3:0] b;         //port B 
    rand logic       cin;       //carry logic from carry flag register 
    rand ctl_e       ctl;       //functionality control for ALU 
    //Output signals
         logic       valid_out; //validate logic signals
         logic [3:0] alu;       //the result 
         logic       carry;     //carry logic 
         logic       zero;      //zero output 
         int         pkt_num;

    // constraints
    constraint reset_c {reset dist   {0:=1,1:=9};}
    constraint ctl_c   {ctl   inside {[B:ROR]};}

endclass