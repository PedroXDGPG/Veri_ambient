`timescale 1ns/1ps

//-----------------------------------------------//
// Modulo para correr la prueba //
//-----------------------------------------------//
`include "fifo.sv"
`include "interface_transactions.sv"
`include "driver.sv"
`include "checker.sv"
`include "score_board.sv"
`include "agent.sv"
`include "ambiente.sv"
`include "test.sv"

module test_bench;
  reg clk = 0;
  parameter width = 16;
  parameter depth = 8;
  test #( .depth(depth), .width(width) ) t0;

  fifo_if #( .width(width) ) _if(.clk(clk));
  always #5 clk = ~clk;

  fifo_flops #( .depth(depth), .bits(width) ) uut(
    .Din(_if.data_in),
    .Dout(_if.data_out),
    .push(_if.push),
    .pop(_if.pop),
    .clk(_if.clk),
    .full(_if.full),
    .pndng(_if.pndng),
    .rst(_if.rst)
  );

  initial begin
    clk = 0;
    t0 = new();
    to._if = _if;
    to.ambiente_inst.driver_inst.vif = _if;
    fork
      t0.run();
    join_none
  end

  always @(posedge clk) begin
    if ($time > 100000) begin
      $display("Test_bench: Tiempo límite de prueba en el test_bench alcanzado");
      $finish;
    end
  end
endmodule