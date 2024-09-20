class alu_agent extends uvm_agent;
  
  `uvm_component_utils(alu_agent)
  
  // alu_sequencer seqr;              // for using user-extended sequencer
  uvm_sequencer #(alu_sequence_item) seqr;  // for using uvm default sequencer
  alu_driver drv;
  alu_monitor mon;
  ref_model mref;
  
  function new(string name = "alu_agent", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor", UVM_HIGH)
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    
    // seqr = alu_sequencer::type_id::create("seqr", this);     // for using user-extended sequencer
    seqr = uvm_sequencer #(alu_sequence_item)::type_id::create("seqr",this);     // for using uvm default sequencer
    drv = alu_driver::type_id::create("drv", this);
    mon = alu_monitor::type_id::create("mon", this);
    mref = ref_model::type_id::create("mref",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)
    
    drv.seq_item_port.connect(seqr.seq_item_export);
    
  endfunction
  
  
endclass