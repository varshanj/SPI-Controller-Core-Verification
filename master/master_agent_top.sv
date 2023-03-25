class master_agent_top extends uvm_env;

    `uvm_component_utils (master_agent_top)

    spi_env_config e_cfg;
    master_agent_config a_cfg;
    master_agent m_agt;

    extern function new(string name = "master_agent_top", uvm_component parent);
    extern function void build_phase(uvm_phase phase); 
endclass

    //////////////////////////////////////////////////////////////////////////////

    function master_agent_top::new(string name = "master_agent_top", uvm_component parent);
        super.new(name, parent);
    endfunction

    ///////////////////////////////////////////////////////////////////////////////

    function void master_agent_top::build_phase(uvm_phase phase);

        if (!uvm_config_db #(spi_env_config)::get(this, "", "spi_env_config",e_cfg))
            `uvm_fatal("CONFIG", "getting database failed")

        m_agt = master_agent::type_id::create("m_agt", this);
        a_cfg = master_agent_config::type_id::create("a_cfg");
        a_cfg = e_cfg.m_cfg;

        uvm_config_db #(master_agent_config)::set(this, "m_agt*","master_agent_config",a_cfg);

        super.build_phase(phase);
    endfunction

///****************************************************************************************************///
