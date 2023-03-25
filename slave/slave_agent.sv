class slave_agent extends uvm_agent;

    `uvm_component_utils (slave_agent)

    slave_agent_config a_cfg;
    slave_driver s_drv;
    slave_monitor s_mon;
    slave_sequencer s_seqr;

    extern function new(string name = "slave_agent",  uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function slave_agent::new(string name = "slave_agent",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    /////////////////////////////////////////////////////////////////////////////////////

    function void slave_agent::build_phase(uvm_phase phase);
        if(!uvm_config_db #(slave_agent_config)::get(this,"","slave_agent_config",a_cfg))
            `uvm_fatal("CONFIG","Getting config database failed")

        s_mon = slave_monitor::type_id::create("s_mon",this);
        if(a_cfg.is_active == UVM_ACTIVE) begin
            s_drv = slave_driver::type_id::create("s_drv",this);
            s_seqr = slave_sequencer::type_id::create("s_seqr",this);
        end
        super.build_phase(phase);
    endfunction: build_phase

    /////////////////////////////////////////////////////////////////////////////////////

    function void slave_agent::connect_phase(uvm_phase phase);
        if(a_cfg.is_active == UVM_ACTIVE) begin
            s_drv.seq_item_port.connect(s_seqr.seq_item_export);
        end
    endfunction

///****************************************************************************************************///


