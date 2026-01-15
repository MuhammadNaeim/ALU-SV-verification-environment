import env_pkg::*;
class scoreboard;
    logic       reset;
    logic       valid_in, valid_in_ref;    //validate logic signals
    logic [3:0] a;                         //port A
    logic [3:0] b;                         //port B 
    logic       cin;                       //carry logic from carry flag register 
    logic [3:0] ctl;                       //functionality control for ALU 
    //Output signals
    logic       valid_out, valid_out_ref;  //validate logic signals
    logic [3:0] alu, alu_ref;              //the result 
    logic       carry, carry_ref;          //carry logic 
    logic       zero, zero_ref;            //zero output 

    mailbox log_mon;
    packet mon_pkt;
    virtual alu_if vif;

    function new(mailbox log_mon, virtual alu_if vif);
        this.log_mon  = log_mon;
        this.vif      = vif;
    endfunction
    
    task check (int no_of_trans);
        $display("------------ start scoreboard ------------");
        for (int i=0; i<no_of_trans; i++) begin
        log_mon.get(mon_pkt);
        reset     = mon_pkt.reset;
        valid_in  = mon_pkt.valid_in;
        a         = mon_pkt.a;
        b         = mon_pkt.b;
        cin       = mon_pkt.cin;
        ctl       = mon_pkt.ctl;
        valid_out = mon_pkt.valid_out;
        alu       = mon_pkt.alu;
        carry     = mon_pkt.carry;
        zero      = mon_pkt.zero;
        // outputs
        valid_out_ref = vif.valid_out;
        alu_ref       = vif.alu;
        carry_ref     = vif.carry;
        zero_ref      = vif.zero;
        // $display("time: %0t scoreboard packet = %p", $time, mon_pkt);
        
        // #1 golden_model; #1;

        if (alu_ref !== vif.alu) begin
            $display("ERROR:  monitor packet = %p", mon_pkt);
            $display("alu_ref", alu_ref);
            error++;
        end
        else begin 
            // $display("correct");
            correct++;
        end
    end
    endtask
/*
    task golden_model;
        if (valid_in) begin
        case (ctl)
            4'b0000: {carry_ref,alu_ref} = b             ;               
            4'b0001: {carry_ref,alu_ref} = b + 4'b0001   ;      
            4'b0010: {carry_ref,alu_ref} = b - 4'b0001   ;      
            4'b0011: {carry_ref,alu_ref} = a + b         ;             
            4'b0100: {carry_ref,alu_ref} = a + b + cin   ;         
            4'b0101: {carry_ref,alu_ref} = a - b         ;             
            4'b0110: {carry_ref,alu_ref} = a - b + (~cin);
            4'b0111: {carry_ref,alu_ref} = a & b         ;
            4'b1000: {carry_ref,alu_ref} = a | b         ;
            4'b1001: {carry_ref,alu_ref} = a ^ b         ;
            4'b1010: {carry_ref,alu_ref} = {b[2:0],1'b0} ;
            4'b1011: {carry_ref,alu_ref} = {1'b0,b[3:1]} ;
            4'b1100: {carry_ref,alu_ref} = {b[2:0],b[3]} ;
            4'b1101: {carry_ref,alu_ref} = {b[0],b[3:1]} ;
            default: {carry_ref,alu_ref} = 4'b0000       ;
        endcase
        end
        else alu_ref = alu_ref;
        zero_ref = ~|alu_ref;
    endtask
    */
endclass
