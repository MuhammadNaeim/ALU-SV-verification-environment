import env_pkg::*;
class monitor;
mailbox log_mon, log_stim;
packet pkt;
virtual alu_if vif;

function new (mailbox log_mon, mailbox log_stim, virtual alu_if vif);
    this.log_mon  = log_mon;
    this.log_stim = log_stim;
    this.vif      = vif;
endfunction

task sample (int no_of_trans);
$display("------------ start monitor ------------");
for (int i=0; i<no_of_trans; i++) begin
    pkt = new();
    @(posedge start_mon);
    pkt.pkt_num   = i;
    pkt.reset     = vif.reset;
    pkt.valid_in  = vif.valid_in;
    pkt.a         = vif.a;
    pkt.b         = vif.b;
    pkt.cin       = vif.cin;
    pkt.ctl       = vif.ctl;
    pkt.valid_out = vif.valid_out;
    pkt.alu       = vif.alu;
    pkt.carry     = vif.carry;
    pkt.zero      = vif.zero;
    $display("time: %0t monitor packet    = %p",$time, pkt);
    log_mon.put(pkt);
    log_stim.put(pkt);
end
endtask

endclass