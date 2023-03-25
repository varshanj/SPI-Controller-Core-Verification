class slave_monitor extends uvm_monitor;

    `uvm_component_utils (slave_monitor)

    virtual slave_intf.MON_MP vif;
    slave_agent_config cfg;
    slave_xtn data;
    uvm_analysis_port #(slave_xtn) monitor_port;

    int ctrl;
    bit [6:0] char_len;
    bit drv_edge;
    bit lsb;
    int i;

    extern function new(string name="slave_monitor",uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    extern function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern task collect_data();

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function slave_monitor::new(string name="slave_monitor",uvm_component parent);
	    super.new(name, parent);
	    monitor_port = new("Monitor_port",this);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    function void slave_monitor::build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(slave_agent_config)::get(this, "", "slave_agent_config",cfg))
            `uvm_fatal("CONFIG","Getting config database failed")

        if (!uvm_config_db #(int)::get(this,"","int",ctrl))
            `uvm_fatal("CONFIG","Getting config database failed")

        char_len = ctrl [6:0];
        drv_edge = ctrl [9];
        lsb = ctrl [11];

        data = slave_xtn::type_id::create("data",this);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    function void slave_monitor::connect_phase(uvm_phase phase);
        vif = cfg.vif;
        super.connect_phase(phase);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task slave_monitor::run_phase(uvm_phase phase);        
        forever 
            collect_data();
    endtask
    
    /////////////////////////////////////////////////////////////////////////////////////

    task slave_monitor::collect_data();
        repeat(10)
            @(vif.mon_cb);
        if (drv_edge) begin
            if (char_len == 0) begin
                if (lsb) begin
                    for (i = 0; i <= 127; i++) begin
                        @(negedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                    end
                end
                else begin
                    for (i = 127; i>=0 ; i--) begin
                        @(negedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                    end
                end
            end
            else begin
                if (lsb) begin
                    for (i = 0; i < char_len; i++) begin
                        @(negedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                            $display("from mon miso[%0d] = %b at %t \n *******",i,data.miso[i],$time);
                    end
                end
                else begin
                    for (i = char_len-1; i >= 0; i--) begin
                        @(negedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                            $display("AAAA from mon miso[%0d] = %b at %t \n *******",i,data.miso[i],$time);
                    end
                end
            end
        end
        else begin 
            if (char_len == 0) begin
                if (lsb) begin
                    for (i = 0; i<128; i++) begin
                        @(posedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                    end
                end
                else begin
                    for (i = 127; i>=0 ; i--) begin
                        @(posedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                    end
                end
            end
            else begin
                if (lsb) begin
                    for (i = 0; i < char_len; i++) begin
                        @(posedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                            $display("from mon miso[%0d] = %b at %t \n *******",i,data.miso[i],$time);
                    end
                end
                else begin
                    for (i = char_len-1; i >= 0; i--) begin
                        @(posedge vif.mon_cb.s_clk)
                            data.miso[i] = vif.mon_cb.miso;
                            data.mosi[i] = vif.mon_cb.mosi;
                    end
                end
            end
        end
        monitor_port.write(data);
        data.print();
        //$display("from s_mon t=%t", $time);
    endtask

///****************************************************************************************************///
