class alu_test extends uvm_test;
  
  `uvm_component_utils(alu_test)
  
  alu_env env;
  alu_base_sequence reset_seq;
  alu_test_sequence test_seq;
  
  function new(string name = "alu_test", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor", UVM_HIGH)
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    
    env = alu_env::type_id::create("env", this);
    reset_seq = alu_base_sequence::type_id::create("reset_seq");
    test_seq = alu_test_sequence::type_id::create("test_seq");
  endfunction

  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
    $display("TOPOLOGY PRINTED ABOVE");
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Connect Phase!", UVM_LOW)
  endfunction
  

  virtual task reset_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "Reset Phase!", UVM_LOW)
    
    phase.raise_objection(this);
    
      reset_seq.start(env.agnt.seqr);
      #10;
      
    phase.drop_objection(this);
    
  endtask

  virtual task main_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "Main Phase!", UVM_LOW)
    
    phase.raise_objection(this);
    
      test_seq.start(env.agnt.seqr);
      #10;
      
    phase.drop_objection(this);
    
  endtask  
  
endclass