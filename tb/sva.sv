module sva (alu_if alu_if);

property valid;
    @(posedge alu_if.clk) disable iff (!alu_if.reset) alu_if.valid_in |=> alu_if.valid_out;
endproperty

assert property (valid);
cover  property (valid);

endmodule
