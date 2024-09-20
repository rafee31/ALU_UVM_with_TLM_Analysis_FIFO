class alu_base_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_base_sequence)
  
  alu_sequence_item reset_pkt;

  function new(string name="alu_base_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
        
    // reset_pkt = alu_sequence_item::type_id::create("reset_pkt"); // not needed when using uvm_do/uvm_do_with macro

    // start_item(reset_pkt);
    // 	assert(reset_pkt.randomize() with {rst==1;});
    // finish_item(reset_pkt);
    `uvm_do_with (reset_pkt, {reset_pkt.rst==1;});  // alternative to the above 3 lines
    
  endtask
  
endclass

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class alu_test_sequence extends uvm_sequence #(alu_sequence_item);
  
  
    `uvm_object_utils(alu_test_sequence)
  
  alu_sequence_item item;
  
  function new(string name="alu_test_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    
    item = alu_sequence_item::type_id::create("item");  // not needed when using uvm_do/uvm_do_with macro

    repeat (256) begin 
    // for (int i = 0; i <= 2000 ; i++) begin
      start_item(item);
        // assert(item.randomize() with {rst==0; item.a==i;});
        assert(item.randomize() with {rst==0;});
      finish_item(item);
      
      
      // `uvm_do_with (item, {rst==0; item.a==i;});  // alternative to the above 3 lines
      // `uvm_do_with (item, {item.rst==0;});
    end
    
  endtask
  
  
endclass


