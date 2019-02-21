/****************************************************************************
* Internal Use Only
* Copyright 2003  - All Rights Reserved
*
*
* Module:       jtag_2_spi
* Parent:       dinar1.icm.v
* Designer:     goetting
*
*
* RCS information:
*
* Revision Number : $Revision: 1.1 $
* Revision Date   : $Date: 2007/12/13 11:24:10 $
* Last Written By : $Author: goetting $
*
* Created:      Tue Nov 20 09:37:13 2007
*
* (description)
****************************************************************************/
`timescale 1ns / 100ps

module jtag_2_spi (
input   FPGA_24MHZ_CLK,
output wire [31:0]      jtag2spi_dbg
         // debug output
);


//output  [35:0]      control0;

//--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8

wire                spi_cs_l;             // CS for SPI Flash
wire                drck1, drck2;
wire                sel1, sel2;
wire                tdi;
wire                tdo1,tdo2;
wire                shift, capture;
wire    [35:0]      control0;

//--+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8

// *** 1. the JTAG TAP Controller Instance ***

  icon ICON     (
      .tdo_in(tdo2),
      .tdi_out(tdi),
      .reset_out(reset),
      .shift_out(shift),
      .update_out(update),
      .sel_out(sel2),
      .drck_out(drck2),
      .control0(control0)
    );

assign tdo1       = 1'b0;
assign capture    = 1'b0;
assign drck1      = 1'b1;
assign sel1       = 1'b0;


// *** 2. the SPI Flash Instance ***

  SPI_ACCESS #(.SIM_DEVICE("3S200AN")) SPI_FLASH (
     .MISO(tdo2),        //output
     .CLK(drck2),
     .CSB(spi_cs_l),
     .MOSI(tdi)          // input
     ) ;


// *** 3. the glue logic ***
// this will become the chip-select for the SPI_ACCESS

assign spi_cs_l = !(sel2 & shift);


// *** 4. debug assignments ***

//assign jtag2spi_dbg[15] = 1'b0;
//assign jtag2spi_dbg[14] = 1'b0;
//assign jtag2spi_dbg[13] = drck2;
//assign jtag2spi_dbg[12] = 1'b0;
//assign jtag2spi_dbg[11] = reset;
//assign jtag2spi_dbg[10] = drck2;
//assign jtag2spi_dbg[9]  = update;
//assign jtag2spi_dbg[8]  = tdo2;
//assign jtag2spi_dbg[7]  = shift;
//assign jtag2spi_dbg[6]  = sel2;
//assign jtag2spi_dbg[5]  = sel1;
//assign jtag2spi_dbg[4]  = capture;
//assign jtag2spi_dbg[3]  = drck1;
//assign jtag2spi_dbg[2]  = tdi;
//assign jtag2spi_dbg[1]  = tdo1;
//assign jtag2spi_dbg[0]  = spi_cs_l;


// *** 5. the ILA sample module/memory module instance ***

ila_4kx32 ILA_4KX32 (
    .control(control0),
    .clk(FPGA_24MHZ_CLK),
    .data(jtag2spi_dbg[31:0]),
    .trig0(jtag2spi_dbg[31:0])
    );

endmodule


