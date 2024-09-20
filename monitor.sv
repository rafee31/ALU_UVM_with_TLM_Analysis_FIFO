class alu_monitor extends uvm_monitor;
  
  `uvm_component_utils(alu_monitor)
  
  virtual alu_interface vif;
  
  alu_sequence_item item;
  
  uvm_analysis_port #(alu_sequence_item) mon_analysis_port;
  
  function new(string name = "alu_monitor ", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor", UVM_HIGH)
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    if(!(uvm_config_db #(virtual alu_interface)::get(this,"*", "vif", vif))) begin
      `uvm_error(get_type_name(), "Failed to get VIF from config DB!");
    end
    
    mon_analysis_port = new("mon_analysis_port", this);
    
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)
  endfunction
  
  virtual task run_phase(uvm_phase phase);

    `uvm_info(get_type_name(), "Inside run_phase!", UVM_HIGH)
    
    forever begin
     
      wait(!vif.rst);
      
      item = alu_sequence_item::type_id::create("item");
      //sample inputs
      @(posedge vif.clk);
      item.a = vif.a;
      item.b = vif.b;
      item.op_code = vif.op_code;
      
      //sample outputs
      @(posedge vif.clk);
      item.result = vif.result;
      item.carry_out = vif.carry_out;
      
      mon_analysis_port.write(item);
      
    end
    
  endtask
  
endclass