class slave_xtn extends uvm_sequence_item;

    `uvm_object_utils (slave_xtn)

    rand bit [127:0] miso;
    bit [127:0] mosi;
    bit [7:0] ss_pad_o;

    extern function new(string name = "slave_xtn");
    extern function void do_print (uvm_printer printer);

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function slave_xtn::new(string name ="slave_xtn");
        super.new(name);
    endfunction: new

    /////////////////////////////////////////////////////////////////////////////////////

    function void slave_xtn::do_print(uvm_printer printer);
        printer.print_field("MISO", this.miso, 128, UVM_BIN);
        printer.print_field("MOSI", this.mosi, 128, UVM_BIN);
        printer.print_field("SS_PAD", this.ss_pad_o, 8, UVM_DEC);
    endfunction

///****************************************************************************************************///

