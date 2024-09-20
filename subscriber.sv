class alu_subscriber extends uvm_subscriber #(alu_sequence_item);

  	alu_sequence_item item;
  
	`uvm_component_utils(alu_subscriber)
	
	covergroup CovGrp;
        option.auto_bin_max = 256;
        // option.per_instance = 1;

        a       : coverpoint item.a;
        b       : coverpoint item.b {
                bins feature1 	= {1};
                bins feature2 	= {2};
                bins feature3 	= {3};
                bins feature4 	= {4};
                bins feature5 	= {5};
                bins feature6 	= {6};
                bins feature7 	= {7};
                bins feature8 	= {8};
                bins feature9 	= {9};
                bins feature10 	= {10};
                // bins feature1 	= {[1:10]};
                ignore_bins ign[]= {0,[11:$]};
            }
        op_code : coverpoint item.op_code;

        // result : coverpoint item.result;
	endgroup
  
  
  
  	 function new(input string name = "alu_subscriber", uvm_component parent = null); 
		super.new(name, parent);
        item = alu_sequence_item::type_id::create("item");
        CovGrp = new();	
  	endfunction: new

   
	virtual function void write(input alu_sequence_item t);

		`uvm_info(get_type_name(),"Data received from Monitor", UVM_NONE)
		// t.print();			    // print transctions
        CovGrp.sample();		// sample coverage whenever received an objects from ap

		`uvm_info(get_type_name(), $sformatf("Coverage = %0.2f %%", CovGrp.get_inst_coverage()), UVM_NONE); 
		
	endfunction

	


endclass          