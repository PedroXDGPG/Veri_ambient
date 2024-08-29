class test #(parameter width = 16, parameter depth = 8);

  comando_test_sb_mbx       test_sb_mbx;
  comando_test_agent_mbx    test_agent_mbx;

  parameter num_transacciones = 10;
  parameter max_retardo = 4;
  solicitud_sb orden;
  instrucciones_agente instr_agent;
  solicitud_sb instr_sb;

  // Definición del ambiente de la prueba
  ambiente #(.depth(depth), .width(width)) ambiente_inst;
  // Definición de la interface a la que se conectará el DUT
  virtual fifo_if #(.width(width)) _if;

  // definición de las condiciones iniciales del test
  function new();
    // instanciación de los mailboxes
    test_sb_mbx = new();
    test_agent_mbx = new();
    // Definición y conexión del driver
    ambiente_inst = new();
    ambiente_inst._if = _if;
    ambiente_inst.test_sb_mbx = test_sb_mbx;
    ambiente_inst.scoreboard_inst.test_sb_mbx = test_sb_mbx;
    ambiente_inst.test_agent_mbx = test_agent_mbx;
    ambiente_inst.agent_inst.test_agent_mbx = test_agent_mbx;
    ambiente_inst.agent_inst.num_transacciones = num_transacciones;
    ambiente_inst.agent_inst.max_retardo = max_retardo;
  endfunction

endclass