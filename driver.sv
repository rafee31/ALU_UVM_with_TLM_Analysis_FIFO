class alu_driver extends uvm_driver#(alu_sequence_item);
  
  `uvm_component_utils(alu_driver)
  
  virtual alu_interface vif;
  
  alu_sequence_item item;  
  
  function new(string name = "alu_driver", uvm_component parent=null);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Inside Constructor", UVM_HIGH)
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info(get_type_name(), "Build Phase!", UVM_HIGH)
    if(!(uvm_config_db #(virtual alu_interface)::get(this,"*", "vif", vif))) begin
      `uvm_error(get_type_name(), "Failed to get VIF from config DB!")
    end
    
  endfunction
  
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_type_name(), "Connect Phase!", UVM_HIGH)
  endfunction
  
  virtual task run_phase(uvm_phase phase);
        
    `uvm_info(get_type_name(), "Inside run_phase", UVM_HIGH)
    
    forever begin
       
      seq_item_port.get_next_item(item);
        drive_item();
      seq_item_port.item_done();
      
    end
    
  endtask

  virtual task drive_item();
      @(posedge vif.clk);
      vif.rst <= item.rst;
      vif.a <= item.a;
      vif.b <= item.b;
      vif.op_code <= item.op_code;
      @(posedge vif.clk);
  endtask
  
endclass