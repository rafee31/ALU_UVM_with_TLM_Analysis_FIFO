class ref_model extends uvm_monitor;
`uvm_component_utils(ref_model)

uvm_analysis_port #(alu_sequence_item) ref_model_analysis_port;;
alu_sequence_item item;
virtual alu_interface vif;

    function new(input string inst = "ref_model", uvm_component parent = null);
    super.new(inst,parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    ref_model_analysis_port = new("ref_model_analysis_port", this);
    if(!uvm_config_db#(virtual alu_interface)::get(this,"","vif",vif))//uvm_test_top.env.agent.drv.aif
      `uvm_error("ref_model","Unable to access Interface");
    endfunction
    
    function void predict();
      case(item.op_code)
       2'b00 : item.result = item.a + item.b;
       2'b01 : item.result = item.a - item.b;
       2'b10 : item.result = item.a * item.b;
       2'b11 : item.result = item.a / item.b;      
      endcase
    endfunction
    
    virtual task run_phase(uvm_phase phase);
    forever begin

        wait(!vif.rst);
        item = alu_sequence_item::type_id::create("item");
        @(posedge vif.clk);
        item.a   = vif.a;
        item.b   = vif.b;
        item.op_code   = vif.op_code;
        predict();
        @(posedge vif.clk);
        `uvm_info("MON_REF_MODEL", $sformatf("a:%0d  b:%0d op_code:%0d result:%0d", item.a, item.b,item.op_code,item.result), UVM_NONE);  
        
        ref_model_analysis_port.write(item);
        
    end
   endtask 

endclass