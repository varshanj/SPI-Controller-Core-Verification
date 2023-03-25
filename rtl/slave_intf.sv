`timescale 1ns / 10ps
interface slave_intf(input bit clock);

    logic [7:0] ss_pad_o;
    logic s_clk;
    logic mosi;
    logic miso;

    clocking drv_cb @(posedge clock);
        default input #1 output #1;
        input ss_pad_o;
        input s_clk;
        input mosi;
        output miso;
    endclocking

    clocking mon_cb @(posedge clock);
        default input #1 output #1;
        input ss_pad_o;
        input s_clk;
        input mosi;
        input miso;
    endclocking

    modport DRV_MP (clocking drv_cb);
    modport MON_MP (clocking mon_cb);

endinterface
