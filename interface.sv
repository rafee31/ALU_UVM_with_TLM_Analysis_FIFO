interface alu_interface(input logic clk);

  logic rst;
  logic [7:0] a, b;
  logic [1:0] op_code;
  logic [7:0] result;
  logic carry_out;

  // property test_assertion;
  //   // disable iff (!rst_n)
  //   @(posedge clk) $rose(carry_out);
  // endproperty
  

  // assrt_test_assertion: assert property (test_assertion);
    
  // cvr_test_assertion: cover property (test_assertion);
  
endinterface
