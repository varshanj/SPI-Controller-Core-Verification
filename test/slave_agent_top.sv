class slave_agent_top extends uvm_env;

    `uvm_component_utils (slave_agent_top)

    spi_env_config e_cfg;
    slave_agent_config a_cfg;
    slave_agent s_agt;

    extern function new(string name = "slave_agent_top", uvm_component parent);
    extern function void build_phase(uvm_phase phase); 
endclass

    //////////////////////////////////////////////////////////////////////////////

    function slave_agent_top::new(string name = "slave_agent_top", uvm_component parent);
        super.new(name, parent);
    endfunction

    ///////////////////////////////////////////////////////////////////////////////

    function void slave_agent_top::build_phase(uvm_phase phase);

        if (!uvm_config_db #(spi_env_config)::get(this, "", "spi_env_config",e_cfg))
            `uvm_fatal("CONFIG", "getting database failed")

        s_agt = slave_agent::type_id::create("s_agt", this);
        a_cfg = slave_agent_config::type_id::create("a_cfg");
        a_cfg = e_cfg.s_cfg;

        uvm_config_db #(slave_agent_config)::set(this, "s_agt*","slave_agent_config",a_cfg);

        super.build_phase(phase);
    endfunction

///****************************************************************************************************///
