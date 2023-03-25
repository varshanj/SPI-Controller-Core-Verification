class master_agent_config extends uvm_object;

    `uvm_object_utils (master_agent_config)

    virtual wishbone_intf vintf;
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    function new(string name = "master_agent_config");
        super.new(name);
    endfunction
endclass
