import env_pkg::*;
class driver;
mailbox s2d_mb;
packet pkt;
virtual alu_if vif;

function new (mailbox s2d_mb, virtual alu_if vif);
    this.s2d_mb = s2d_mb;
    this.vif    = vif;
endfunction

task drive (int no_of_trans);
$display("------------ start driver ------------");
for (int i=0; i<no_of_trans; i++) begin
    s2d_mb.get(pkt);
    @(negedge vif.clk);
    vif.reset     = pkt.reset;
    vif.valid_in  = pkt.valid_in;
    vif.a         = pkt.a;
    vif.b         = pkt.b;
    vif.cin       = pkt.cin;
    vif.ctl       = pkt.ctl;
    $display("time: %0t driver packet     = %p", $time, pkt);
    -> start_mon;
end
endtask
endclass