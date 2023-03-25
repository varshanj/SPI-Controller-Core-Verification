class slave_agent_config extends uvm_object;

    `uvm_object_utils (slave_agent_config)

    virtual slave_intf vif;
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    function new(string name = "slave_agent_config");
        super.new(name);
    endfunction
endclass
