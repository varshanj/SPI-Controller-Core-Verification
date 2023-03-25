class master_sequence extends uvm_sequence #(master_xtn);

    `uvm_object_utils (master_sequence)

    int ctrl;

    function new(string name = "master_sequence");
        super.new(name);
    endfunction

    task body();
        if (!uvm_config_db #(int)::get(null,get_full_name(),"int",this.ctrl))
            `uvm_fatal("CONFIG","Getting config database failed")
    endtask

endclass

///***********************************************************************///

class master_rd_sequence extends master_sequence;
    
    `uvm_object_utils (master_rd_sequence)

    function new(string name = "master_rd_sequence");
        super.new(name);
    endfunction

    task body();

        super.body();
        req = master_xtn::type_id::create("req");
        foreach (req.RX[i]) begin 
            start_item(req);
            assert(req.randomize with {wb_adr_i == ('h4*i);
                                       wb_we_i == 0;});
            finish_item(req);
        end

    endtask

endclass

///***********************************************************************///

class extended_master_sequence1 extends master_sequence;

    `uvm_object_utils (extended_master_sequence1)

    extern function new (string name = "ex_m_seq1");
    extern task body();

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function extended_master_sequence1::new (string name = "ex_m_seq1");
        super.new(name);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task extended_master_sequence1::body();

        super.body();

        req = master_xtn::type_id::create("req");
        foreach (req.TX[i]) begin 
            start_item(req);
            assert(req.randomize with {wb_adr_i == ('h4*i);
                                       wb_we_i == 1;});
            finish_item(req);
        end

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h14;
                                       wb_dat_i == 1;
                                       wb_we_i == 1;});
            finish_item(req);

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h18;
                                       wb_dat_i == 8'b1;
                                       wb_we_i == 1;});
            finish_item(req);            

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h10;
                                       wb_dat_i == ctrl;
                                       wb_we_i == 1;});
            finish_item(req);

    endtask

///***********************************************************************///

class extended_master_sequence2 extends master_sequence;

    `uvm_object_utils (extended_master_sequence2)

    extern function new (string name = "ex_m_seq2");
    extern task body();

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function extended_master_sequence2::new (string name = "ex_m_seq2");
        super.new(name);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task extended_master_sequence2::body();

        super.body();

        req = master_xtn::type_id::create("req");
        foreach (req.TX[i]) begin 
            start_item(req);
            assert(req.randomize with {wb_adr_i == ('h4*i);
                                       wb_we_i == 1;});
            finish_item(req);
        end

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h14;
                                       wb_dat_i == 4;
                                       wb_we_i == 1;});
            finish_item(req);

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h18;
                                       wb_dat_i == 8'b110_0000;
                                       wb_we_i == 1;});
            finish_item(req);            

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h10;
                                       wb_dat_i == ctrl;
                                       wb_we_i == 1;});
            finish_item(req);

    endtask

///***********************************************************************///

class extended_master_sequence3 extends master_sequence;

    `uvm_object_utils (extended_master_sequence3)

    extern function new (string name = "ex_m_seq3");
    extern task body();

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function extended_master_sequence3::new (string name = "ex_m_seq3");
        super.new(name);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task extended_master_sequence3::body();

        super.body();

        req = master_xtn::type_id::create("req");
        foreach (req.TX[i]) begin 
            start_item(req);
            assert(req.randomize with {wb_adr_i == ('h4*i);
                                       wb_we_i == 1;});
            finish_item(req);
        end

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h14;
                                       wb_dat_i == 7;
                                       wb_we_i == 1;});
            finish_item(req);

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h18;
                                       wb_dat_i == 8'b1001_0000;
                                       wb_we_i == 1;});
            finish_item(req);            

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h10;
                                       wb_dat_i == ctrl;
                                       wb_we_i == 1;});
            finish_item(req);

    endtask

///***********************************************************************///

class extended_master_sequence4 extends master_sequence;

    `uvm_object_utils (extended_master_sequence4)

    extern function new (string name = "ex_m_seq4");
    extern task body();

endclass

    /////////////////////////////////////////////////////////////////////////////////////

    function extended_master_sequence4::new (string name = "ex_m_seq4");
        super.new(name);
    endfunction

    /////////////////////////////////////////////////////////////////////////////////////

    task extended_master_sequence4::body();

        super.body();

        req = master_xtn::type_id::create("req");
        foreach (req.TX[i]) begin 
            start_item(req);
            assert(req.randomize with {wb_adr_i == ('h4*i);
                                       wb_we_i == 1;});
            finish_item(req);
        end

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h14;
                                       wb_dat_i == 11;
                                       wb_we_i == 1;});
            finish_item(req);

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h18;
                                       wb_dat_i == 8'b1111_0000;
                                       wb_we_i == 1;});
            finish_item(req);            

            start_item(req);
            assert(req.randomize with {wb_adr_i == 'h10;
                                       wb_dat_i == ctrl;
                                       wb_we_i == 1;});
            finish_item(req);

    endtask

///***********************************************************************///

