class slave_sequence extends uvm_sequence #(slave_xtn);

    `uvm_object_utils (slave_sequence)

    function new(string name = "slave_sequence");
        super.new(name);
    endfunction

endclass

///***********************************************************************///

class extended_slave_sequence1 extends slave_sequence;

    `uvm_object_utils (extended_slave_sequence1)

    extern function new (string name = "ex_s_seq1");
    extern task body();

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function extended_slave_sequence1::new (string name = "ex_s_seq1");
        super.new(name);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task extended_slave_sequence1::body();

        req = slave_xtn::type_id::create("req");       
        start_item(req);
        assert(req.randomize());
        finish_item(req);
    endtask

