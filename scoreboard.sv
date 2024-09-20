class alu_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(alu_scoreboard)


  alu_sequence_item tr, trref;

  uvm_tlm_analysis_fifo#(alu_sequence_item) sco_data_fifo;
  uvm_tlm_analysis_fifo#(alu_sequence_item) sco_data_ref_fifo;
    
  function new(string name = "alu_scoreboard", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor", UVM_HIGH)
  endfunction
  
  
  virtual function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    
    tr    = alu_sequence_item::type_id::create("tr");
    trref = alu_sequence_item::type_id::create("tr_ref");
    sco_data_fifo = new("sco_data_fifo", this);
    sco_data_ref_fifo = new("sco_data_ref_fifo", this); 
    
  endfunction

  virtual task run_phase(uvm_phase phase); 
        forever begin
          sco_data_fifo.get(tr);
          sco_data_ref_fifo.get(trref);

          
          if(tr.compare(trref))
          `uvm_info("SCO", $sformatf("Transaction Passed! ACT=%d, EXP=%d", tr.result, trref.result), UVM_NONE)
          else
          `uvm_error("SCO", $sformatf("Transaction failed! ACT=%d, EXP=%d", tr.result, trref.result))
        end
  endtask
  

  
endclass