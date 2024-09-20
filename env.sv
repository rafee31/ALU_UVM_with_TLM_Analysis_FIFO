class alu_env extends uvm_env;
  
  `uvm_component_utils(alu_env)
  
  
  alu_agent agnt;
  alu_scoreboard scb;
  alu_subscriber subs;
  
  function new(string name = "alu_env", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor", UVM_HIGH)
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    
    agnt = alu_agent::type_id::create("agnt", this);
    scb = alu_scoreboard::type_id::create("scb", this);
    subs = alu_subscriber::type_id::create("subs", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    
    super.connect_phase(phase);
    
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)
    
    agnt.mon.mon_analysis_port.connect(scb.sco_data_fifo.analysis_export);
    agnt.mon.mon_analysis_port.connect(subs.analysis_export);
    agnt.mref.ref_model_analysis_port.connect(scb.sco_data_ref_fifo.analysis_export);
    
  endfunction
  
  
endclass