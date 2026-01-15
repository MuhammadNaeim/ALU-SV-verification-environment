import env_pkg::*;
class stim_gen;

mailbox s2d_mb;
packet  pkt;

function new (mailbox s2d_mb);
    this.s2d_mb = s2d_mb;
endfunction

task stim_task (int no_of_trans);
    $display("------------ start stim ------------");
    for (int i=0; i<no_of_trans; i++) begin
        pkt = new();
        pkt.pkt_num = i;
        randomize: assert(pkt.randomize());
        s2d_mb.put(pkt);
        $display("time: %0t stim packet = %p", $time, pkt);
    end
endtask
endclass
