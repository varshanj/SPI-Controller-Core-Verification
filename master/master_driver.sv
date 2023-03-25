class master_driver extends uvm_driver #(master_xtn);

    `uvm_component_utils (master_driver)

    master_agent_config cfg;
    virtual wishbone_intf.DRV_MP vif;

    extern function new(string name = "master_driver",  uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task drv2dut(master_xtn xtn);

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function master_driver::new(string name = "master_driver",  uvm_component parent);
        super.new(name,parent);
    endfunction


    /////////////////////////////////////////////////////////////////////////////////////
    function void master_driver::build_phase(uvm_phase phase);
        if (!uvm_config_db #(master_agent_config)::get(this, "", "master_agent_config",cfg))
            `uvm_fatal("CONFIG","Getting config database failed")
        super.build_phase(phase);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    function void master_driver::connect_phase(uvm_phase phase);
        vif = cfg.vintf;
        super.connect_phase(phase);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task master_driver::run_phase(uvm_phase phase);
        @(vif.drv_cb);
        vif.drv_cb.wb_rst_i <= 1'b1; 
        vif.drv_cb.wb_stb_i <= 1'b0;
        vif.drv_cb.wb_cyl_i <= 1'b0;
        @(vif.drv_cb);
        vif.drv_cb.wb_rst_i <= 1'b0; 
        forever begin
            seq_item_port.get_next_item(req);
            drv2dut(req);
            seq_item_port.item_done();
        end
    endtask

    /////////////////////////////////////////////////////////////////////////////////////

    task master_driver::drv2dut(master_xtn xtn);
        //xtn.print();
        @(vif.drv_cb);        
        vif.drv_cb.wb_stb_i <= 1;
        vif.drv_cb.wb_cyl_i <= 1;
        vif.drv_cb.wb_adr_i <= xtn.wb_adr_i;
        vif.drv_cb.wb_we_i <= xtn.wb_we_i;
        vif.drv_cb.wb_dat_i <= xtn.wb_dat_i;
        vif.drv_cb.wb_sel_i <= 4'b1111;
        wait(vif.drv_cb.wb_ack_o);        
        vif.drv_cb.wb_stb_i <= 1'b0;
        vif.drv_cb.wb_cyl_i <= 1'b0;
    endtask


///****************************************************************************************************///
