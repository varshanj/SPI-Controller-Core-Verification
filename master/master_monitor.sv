class master_monitor extends uvm_monitor;

    `uvm_component_utils (master_monitor)

    virtual wishbone_intf.MON_MP intf;
    master_agent_config cfg;
    master_xtn data;
    uvm_analysis_port #(master_xtn) monitor_port;

    extern function new(string name="master_monitor",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_data();

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function master_monitor::new(string name="master_monitor",uvm_component parent);
	    super.new(name,parent);
	    monitor_port = new("Monitor_port",this);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    function void master_monitor::build_phase(uvm_phase phase);
	    if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",cfg))
		    `uvm_fatal("CONFIG","cannot get config data");
        data = master_xtn::type_id::create("data");
	    super.build_phase(phase);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    function void master_monitor::connect_phase(uvm_phase phase);
        intf = cfg.vintf;
        super.connect_phase(phase);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task master_monitor::run_phase(uvm_phase phase);
        forever 
            collect_data();
    endtask
    
    /////////////////////////////////////////////////////////////////////////////////////

    task master_monitor::collect_data();
        @(intf.mon_cb);
        wait(intf.mon_cb.wb_ack_o)
        data.wb_we_i = intf.mon_cb.wb_we_i;
        data.wb_adr_i = intf.mon_cb.wb_adr_i;
        if (intf.mon_cb.wb_we_i == 1) begin
            if (intf.mon_cb.wb_adr_i == 'h0) 
                data.TX[0] = intf.mon_cb.wb_dat_i;            
            else if (intf.mon_cb.wb_adr_i == 'h4) 
                data.TX[1] = intf.mon_cb.wb_dat_i;            
            else if (intf.mon_cb.wb_adr_i == 'h8) 
                data.TX[2] = intf.mon_cb.wb_dat_i;            
            else if (intf.mon_cb.wb_adr_i == 'hc) 
                data.TX[3] = intf.mon_cb.wb_dat_i;            
            else if (intf.mon_cb.wb_adr_i == 'h10) 
                data.CTRL_REG = intf.mon_cb.wb_dat_i;
            else if (intf.mon_cb.wb_adr_i == 'h14) 
                data.DIV_REG = intf.mon_cb.wb_dat_i;            
            else if (intf.mon_cb.wb_adr_i == 'h18) 
                data.SS_REG = intf.mon_cb.wb_dat_i;  
        end
        else if (intf.mon_cb.wb_we_i == 0)begin            
            if (intf.mon_cb.wb_adr_i == 'h0) 
                data.RX[0] = intf.mon_cb.wb_dat_o;            
            else if (intf.mon_cb.wb_adr_i == 'h4) 
                data.RX[1] = intf.mon_cb.wb_dat_o;            
            else if (intf.mon_cb.wb_adr_i == 'h8) 
                data.RX[2] = intf.mon_cb.wb_dat_o;            
            else if (intf.mon_cb.wb_adr_i == 'hc) 
                data.RX[3] = intf.mon_cb.wb_dat_o;
        end
        monitor_port.write(data);
        //$display("from m_mon t=%t", $time);
        //data.print();
    endtask

///****************************************************************************************************///
