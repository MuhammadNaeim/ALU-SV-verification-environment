import env_pkg::*;
class coverage;
    mailbox log_stim;
    packet pkt;

    // coverage
    covergroup covgp;
        a_cp  : coverpoint pkt.a;
        b_cp  : coverpoint pkt.b;
        ctl_cp: coverpoint pkt.ctl {
            bins transition[]      = ([B:ROR] => [B:ROR]);
            illegal_bins out_range = {INVALID_1, INVALID_2};
        }
        alu_cp: coverpoint pkt.alu {
            bins zero   = { 4'h0};
            bins max    = { 4'hF};
            bins others = {[4'h1:4'hE]};
        }
    endgroup

    task cover_task (int no_of_trans);
        $display("------------ start coverage ------------");
        for (int i=0; i<no_of_trans; i++) begin
            log_stim.get(pkt);
            // $display("time: %0t coverage packet   = %p", $time, pkt);
            covgp.sample();
            $display("-------------------------------------------------------------------------------------------------------------------------------------");
        end
    endtask

    function new(mailbox log_stim);
        this.log_stim = log_stim;
        covgp = new();
    endfunction
endclass