`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

`include "interface.sv"
`include "design.sv"
`include "sequence_item.sv"
`include "sequence.sv"
// `include "sequencer.sv"   // if user-extended sequencer is used
`include "driver.sv"
`include "monitor.sv"
`include "ref_model.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "subscriber.sv"
`include "env.sv"
`include "test.sv"



module top;
  
  logic clk;
  
  alu_interface intf(.clk(clk));
  
  alu dut(.clk(clk), 
          .rst(intf.rst), 
          .A(intf.a), 
          .B(intf.b), 
          .ALU_Sel(intf.op_code), 
          .ALU_Out(intf.result), 
          .CarryOut(intf.carry_out)
         );
  
  initial begin
    
    uvm_config_db #(virtual alu_interface)::set(null,"*", "vif", intf);
    
  end
  
  initial begin
  
    run_test("alu_test");
  
  end
  
  initial begin
    clk = 0;
    #5;
    forever begin
    	clk = ~clk;
      	#5;
    end
  end
  
  
  initial begin
  
    $dumpfile("wave.vcd");
    $dumpvars();
  
  end
  
endmodule