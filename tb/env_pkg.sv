package env_pkg;
    int no_of_trans = 500;
    int correct, error;
    typedef enum logic [3:0] {B , INCR_B , DECR_B , ADD , ADD_C , SUB , SUB_C , AND , OR , XOR , SHL , SHR , ROL , ROR, INVALID_1, INVALID_2} ctl_e;
    event start_mon;

    `include "packet.sv"
    `include "stim_gen.sv"
    `include "driver.sv"
    `include "monitor.sv" 
    `include "scoreboard.sv"
    `include "coverage.sv"

endpackage