`include "test_env.sv"
import env_pkg::*;

module top;
bit clk;
test_env env;

initial forever #5 clk = ~clk;

alu_if alu_if (clk);
bind top sva sva_inst (alu_if);

alu dut (
.clk       (clk),
.reset     (alu_if.reset),
.valid_in  (alu_if.valid_in),
.a         (alu_if.a),
.b         (alu_if.b),
.cin       (alu_if.cin),
.ctl       (alu_if.ctl),
.valid_out (alu_if.valid_out),
.alu       (alu_if.alu),
.carry     (alu_if.carry),
.zero      (alu_if.zero)
);

initial begin
    reset_task();
end

initial begin
    // run
    env = new(alu_if);
    env.run();
    // report
    $display("errors: %0d, correct: %0d", error, correct);
    $stop;
end

task reset_task;
    $display("system reset");
    alu_if.reset = 1;
    #10;
    alu_if.reset = 0;
    #10;
    alu_if.reset = 1;
endtask
endmodule