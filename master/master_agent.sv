class master_agent extends uvm_agent;

    `uvm_component_utils (master_agent)

    master_agent_config a_cfg;
    master_driver m_drv;
    master_monitor m_mon;
    master_sequencer m_seqr;

    extern function new(string name = "master_agent",  uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function master_agent::new(string name = "master_agent",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    /////////////////////////////////////////////////////////////////////////////////////

    function void master_agent::build_phase(uvm_phase phase);
        if(!uvm_config_db #(master_agent_config)::get(this,"","master_agent_config",a_cfg))
            `uvm_fatal("CONFIG","Getting config database failed")

        m_mon = master_monitor::type_id::create("m_mon",this);
        if(a_cfg.is_active == UVM_ACTIVE) begin
            m_drv = master_driver::type_id::create("m_drv",this);
            m_seqr = master_sequencer::type_id::create("m_seqr",this);
        end
        super.build_phase(phase);
    endfunction: build_phase

    /////////////////////////////////////////////////////////////////////////////////////

    function void master_agent::connect_phase(uvm_phase phase);
        if(a_cfg.is_active == UVM_ACTIVE) begin
            m_drv.seq_item_port.connect(m_seqr.seq_item_export);
        end
    endfunction

///****************************************************************************************************///


