class master_xtn extends uvm_sequence_item;

    `uvm_object_utils (master_xtn)

    rand bit [4:0] wb_adr_i;
    rand bit [31:0] wb_dat_i;
    rand bit wb_we_i;

    bit [31:0] wb_dat_o;
    bit [3:0] wb_sel_i = 4'b1111;
    bit wb_stb_i = 1;
    bit wb_cyl_i = 1;

    bit [31:0] TX [0:3];
    bit [31:0] RX [0:3];
    bit [31:0] DIV_REG;
    bit [31:0] SS_REG;
    bit [31:0] CTRL_REG;

    extern function new(string name = "master_xtn");
    extern function void do_print (uvm_printer printer);

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function master_xtn::new(string name ="master_xtn");
        super.new(name);
    endfunction: new

    /////////////////////////////////////////////////////////////////////////////////////

    function void master_xtn::do_print(uvm_printer printer);
        printer.print_field("ADDR", this.wb_adr_i, 5, UVM_HEX);
        printer.print_field("WE_En", this.wb_we_i, 1, UVM_BIN);
        printer.print_field("DAT", this.wb_dat_i, 32, UVM_DEC);
        printer.print_field("DIV_REG", this.DIV_REG, 32, UVM_DEC);
        printer.print_field("SS_REG", this.SS_REG, 32, UVM_DEC);
        printer.print_field("CTRL_REG", this.CTRL_REG, 32, UVM_BIN);
        printer.print_field("TXX[0]", this.TX[0], 32, UVM_BIN);
        printer.print_field("TXX[1]", this.TX[1], 32, UVM_BIN);
        printer.print_field("TXX[2]", this.TX[2], 32, UVM_BIN);
        printer.print_field("TXX[3]", this.TX[3], 32, UVM_BIN);
        printer.print_field("RXX[0]", this.RX[0], 32, UVM_BIN);
        printer.print_field("RXX[1]", this.RX[1], 32, UVM_BIN);
        printer.print_field("RXX[2]", this.RX[2], 32, UVM_BIN);
        printer.print_field("RXX[3]", this.RX[3], 32, UVM_BIN);
    endfunction

///****************************************************************************************************///

