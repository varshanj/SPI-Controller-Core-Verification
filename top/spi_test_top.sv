`timescale 1ns / 10ps

module top;

    import uvm_pkg::*;
    import spi_pkg::*;

    bit clock;
    always #10 clock = ~clock;

    wishbone_intf master(clock);
    slave_intf slave(clock);

    spi_top DUT (.wb_clk_i(clock), .wb_rst_i(master.wb_rst_i), .wb_adr_i(master.wb_adr_i),
                 .wb_dat_i(master.wb_dat_i), .wb_dat_o(master.wb_dat_o), .wb_sel_i(master.wb_sel_i), 
                 .wb_we_i(master.wb_we_i), .wb_stb_i(master.wb_stb_i), .wb_cyc_i(master.wb_cyl_i), 
                 .wb_ack_o(master.wb_ack_o), .wb_err_o(master.wb_err_o), .wb_int_o(master.wb_int_o),

                 .ss_pad_o(slave.ss_pad_o), .sclk_pad_o(slave.s_clk), .mosi_pad_o(slave.mosi), .miso_pad_i(slave.miso));       

    initial begin
        uvm_config_db #(virtual wishbone_intf):: set(null, "*", "wishbone_intf", master);
        uvm_config_db #(virtual slave_intf):: set(null, "*", "slave_intf", slave);
        run_test();
    end

endmodule
