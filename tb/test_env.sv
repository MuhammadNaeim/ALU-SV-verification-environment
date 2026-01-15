import env_pkg::*;
class test_env;
mailbox    s2d_mb;
mailbox    log_mon, log_stim;
stim_gen   alu_stim;
driver     alu_drv;
monitor    alu_mon;
scoreboard alu_sb;
coverage   alu_cv;

virtual alu_if vif;

function new (virtual alu_if vif);
    this.vif = vif;
    // mailboxes
    s2d_mb   = new();
    log_mon  = new();
    log_stim = new();
    // env classes
    alu_stim = new(s2d_mb);
    alu_drv  = new(s2d_mb, vif);
    alu_mon  = new(log_mon, log_stim, vif);
    alu_sb   = new(log_mon,  vif);
    alu_cv   = new(log_stim);
endfunction

task run;
    $display("system test");
    fork
        alu_stim.stim_task(no_of_trans);
        alu_mon.sample(no_of_trans);
        alu_drv.drive(no_of_trans);
        alu_sb.check(no_of_trans);
        alu_cv.cover_task(no_of_trans);
    join
endtask
endclass