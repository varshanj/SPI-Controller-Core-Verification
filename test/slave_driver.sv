class slave_driver extends uvm_driver #(slave_xtn);

    `uvm_component_utils (slave_driver)

    bit [31:0] ctrl;
    bit [6:0] char_len;
    bit drv_edge;
    bit lsb;
    int i;

    slave_agent_config cfg;
    virtual slave_intf.DRV_MP vif;

    extern function new(string name = "slave_driver",  uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task drv2dut(slave_xtn xtn);

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function slave_driver::new(string name = "slave_driver",  uvm_component parent);
        super.new(name,parent);
    endfunction


    /////////////////////////////////////////////////////////////////////////////////////
    function void slave_driver::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(slave_agent_config)::get(this, "", "slave_agent_config",cfg))
            `uvm_fatal("CONFIG","Getting config database failed")

        if (!uvm_config_db #(int)::get(this,"","int",ctrl))
            `uvm_fatal("CONFIG","Getting config database failed")
        $display("ctrl= %d",ctrl);
        char_len = ctrl [6:0];
        drv_edge = ctrl[9];
        lsb = ctrl [11];
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    function void slave_driver::connect_phase(uvm_phase phase);
        vif = cfg.vif;
        super.connect_phase(phase);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task slave_driver::run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(req);
            drv2dut(req);
            seq_item_port.item_done();
        end
    endtask

    /////////////////////////////////////////////////////////////////////////////////////

    task slave_driver::drv2dut(slave_xtn xtn);
        xtn.print();

        if (drv_edge) begin
            if (char_len == 0) begin
                if (lsb) begin
                    for (i = 0; i <= 127; i++) begin
                        @(posedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                    end
                end
                else begin
                    for (i = 127; i>=0 ; i--) begin
                        @(posedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                    end
                end
            end
            else begin
                if (lsb) begin
                    for (i = 0; i < char_len; i++) begin
                        @(posedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                            $display("from drv miso[%0d] = %b at %t",i,xtn.miso[i],$time);
                    end
                end
                else begin
                    for (i = char_len-1; i >= 0; i--) begin
                        @(posedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                    end
                end
            end
        end
        else begin 
            if (char_len == 0) begin
                if (lsb) begin
                    for (i = 0; i<128; i++) begin
                        @(negedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                    end
                end
                else begin
                    for (i = 127; i>=0 ; i--) begin
                        @(negedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                    end
                end
            end
            else begin
                if (lsb) begin
                    for (i = 0; i < char_len; i++) begin
                        @(negedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                            $display("from drv miso[%0d] = %b at %t",i,xtn.miso[i],$time);
                    end
                end
                else begin
                    for (i = char_len-1; i >= 0; i--) begin
                        @(negedge vif.drv_cb.s_clk)
                            vif.drv_cb.miso <= xtn.miso[i];
                    end
                end
            end
        end

    endtask


///****************************************************************************************************///
