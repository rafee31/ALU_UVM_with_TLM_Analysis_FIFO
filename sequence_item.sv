class alu_sequence_item extends uvm_sequence_item;

  rand bit rst;
  randc bit [7:0] a;
  // rand bit [7:0] a;
  randc bit [7:0] b;
  randc bit [1:0] op_code;
  
  bit [7:0] result;
  bit carry_out;

  `uvm_object_utils_begin(alu_sequence_item)
    `uvm_field_int(rst,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(a,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(b,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(op_code,UVM_ALL_ON | UVM_DEC)
    
    `uvm_field_int(result,UVM_ALL_ON | UVM_DEC)
  `uvm_object_utils_end


  function new(string name="alu_sequence_item");
    super.new(name);
  endfunction
  
  // constraint input1_c {unique{a};}
  // constraint input2_c {b inside {[1:10]};}

endclass