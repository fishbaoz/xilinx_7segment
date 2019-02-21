`timescale 1ns / 1ps
// *****************************************************************************
//
// Description:   Control.v
//                
// *****************************************************************************
//
// Copyright 2016 ADVANCED MICRO DEVICES, INC.  All Rights Reserved.
//
// AMD is granting you permission to use this software (the Materials)
// pursuant to the terms and conditions of your Software License Agreement
// with AMD.  This header does *NOT* give you permission to use the Materials
// or any rights under AMD's intellectual property.  Your use of any portion
// of these Materials shall constitute your acceptance of those terms and
// conditions.  If you do not agree to the terms and conditions of the Software
// License Agreement, please do not use any portion of these Materials.
//
// CONFIDENTIALITY:  The Materials and all other information, identified as
// confidential and provided to you by AMD shall be kept confidential in
// accordance with the terms and conditions of the Software License Agreement.
//
// LIMITATION OF LIABILITY: THE MATERIALS AND ANY OTHER RELATED INFORMATION
// PROVIDED TO YOU BY AMD ARE PROVIDED "AS IS" WITHOUT ANY EXPRESS OR IMPLIED
// WARRANTY OF ANY KIND, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
// MERCHANTABILITY, NONINFRINGEMENT, TITLE, FITNESS FOR ANY PARTICULAR PURPOSE,
// OR WARRANTIES ARISING FROM CONDUCT, COURSE OF DEALING, OR USAGE OF TRADE.
// IN NO EVENT SHALL AMD OR ITS LICENSORS BE LIABLE FOR ANY DAMAGES WHATSOEVER
// (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, BUSINESS
// INTERRUPTION, OR LOSS OF INFORMATION) ARISING OUT OF AMD'S NEGLIGENCE,
// GROSS NEGLIGENCE, THE USE OF OR INABILITY TO USE THE MATERIALS OR ANY OTHER
// RELATED INFORMATION PROVIDED TO YOU BY AMD, EVEN IF AMD HAS BEEN ADVISED OF
// THE POSSIBILITY OF SUCH DAMAGES.  BECAUSE SOME JURISDICTIONS PROHIBIT THE
// EXCLUSION OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES,
// THE ABOVE LIMITATION MAY NOT APPLY TO YOU.
//
// AMD does not assume any responsibility for any errors which may appear in
// the Materials or any other related information provided to you by AMD, or
// result from use of the Materials or any related information.
//
// You agree that you will not reverse engineer or decompile the Materials.
//
// NO SUPPORT OBLIGATION: AMD is not obligated to furnish, support, or make any
// further information, software, technical information, know-how, or show-how
// available to you.  Additionally, AMD retains the right to modify the
// Materials at any time, without notice, and is not obligated to provide such
// modified Materials to you.
//
// U.S. GOVERNMENT RESTRICTED RIGHTS: The Materials are provided with
// "RESTRICTED RIGHTS." Use, duplication, or disclosure by the Government is
// subject to the restrictions as set forth in FAR 52.227-14 and
// DFAR252.227-7013, et seq., or its successor.  Use of the Materials by the
// Government constitutes acknowledgement of AMD's proprietary rights in them.
//
// EXPORT ASSURANCE:  You agree and certify that neither the Materials, nor any
// direct product thereof will be exported directly or indirectly, into any
// country prohibited by the United States Export Administration Act and the
// regulations thereunder, without the required authorization from the U.S.
// government nor will be used for any purpose prohibited by the same.
// *****************************************************************************/

module control(

	//inputs
	input clk ,
	input clk_5kHz ,
	//input [8:1] FPGA_SW1 ,
	//replaced the switch with individual wires.
	input sw_p0_hdt_bypass ,
	input sw_p0_boot_local_rom ,
	input sw_pcie_slot4_hp_force_on ,  // switch is off by default (force on)
	input sw_smi_test ,
	input sw_prochot_test ,
	input sw_post_code_pwr_cycle ,
	input sw_pwr_good_pwr_cycle ,
	//end switches
	
	input P0_33_PWROK ,
	input P0_PRESENT_L ,

	input P0_33_RESET_L ,
	input P0_PWRGD_OUT ,
	input PWR_BTN_L ,
	input MGMT_ASSERT_PWR_BTN ,
	input COLD_RST_BTN_L ,
	input WARM_RST_BTN_L ,
	input MGMT_ASSERT_RST_BTN ,
	input NMI_BTN_L ,
	input MGMT_ASSERT_NMI_BTN ,
	input MGMT_ASSERT_LOCAL_LOCK ,	
	input P0_PROCHOT_L ,
	input MGMT_ASSERT_P0_PROCHOT ,
	input MGMT_AC_LOSS_L ,
	input P0_FPGA_SMBUS_DATA ,		//not used
	input P0_FPGA_SMBUS_CLK ,		//not used
	//input MGMT_SMBUS_ALERT_L ,		//not used
	input MGMT_SMBUS_CLK ,			//not used
	input MGMT_SMBUS_DATA ,			//not used
	input SLP_S3_L ,			//for tristating signals during S3 state
	input SLP_S5_L ,			//for tristating signals during S5 state
	input FPGA_BTN_L ,
	input group_2_pg ,
	input physical_pg ,
	input shutdown_error ,
	input [31:0] port_reg ,

	//outputs
	output reg P0_VDD_CORE_RUN_PWROK ,
	output reg P0_VDD_SOC_RUN_PWROK ,

	output ASSERT_P0_PWROK_L ,
	output PWROK_LED ,
	output ASSERT_P0_RESET_L ,
	output RESET_LED_L ,
	output P0_KBRST_L ,
	output P0_PRESENT_HDT ,
	output P0_PWR_GOOD ,
	output reg P0_PWR_BTN_L ,
	output P0_SYS_RESET_L ,
	output PWR_GOOD_LED ,
	output P0_NMI_SYNC_FLOOD_L ,
	output P0_NV_FORCE_SELF_REFRESH ,
	output MGMT_SYS_MON_P0_PROCHOT_L ,
	output P0_PROCHOT_LED ,
	output ASSERT_P0_PROCHOT_L ,
	output P0_LOCAL_SPI_ROM_SEL_L ,
	output PCIE_SLOT4_HP_FON_L ,
	output [3:0] prochot_duty_cycle_state ,
	//output prochot_test ,
	output reg pwr_cycle_pwr_on 

);

//regs
reg [14:0] counter = 15'b0;
reg post_code_match = 1'b0; 

//wires
wire smi_l;
wire prochot_l;
//wire [3:0] prochot_duty_cycle_state;

//parameters
parameter [14:0] wait_pwr_up_counter_delay = 15'h7530;	//6sec
parameter [14:0] assert_pwr_up_counter_delay = 15'h7A95;  //6.27sec	
	
//PWROK logic
always @ (posedge clk_5kHz) begin
	 P0_VDD_CORE_RUN_PWROK	<= ~P0_PRESENT_L ? P0_33_PWROK : (physical_pg & P0_33_PWROK);
	 P0_VDD_SOC_RUN_PWROK 	<= P0_VDD_CORE_RUN_PWROK ;
end


assign PWROK_LED = ~P0_PRESENT_L ? P0_33_PWROK : physical_pg;

assign ASSERT_P0_PWROK_L = 1'b0;	// 1 = PWROK IS FORCED LOW, 0 = PWROK IS NOT AFFECTED


reg [7:0]counter_1msec_delay = 8'h00;//counts upto 1 msec
reg reset_counter_done = 1'b0;

//generate a delay for reset
always @ (posedge clk_5kHz) begin 
	//200 usec x 160 = 32 msec
	if(COLD_RST_BTN_L == 1'b1 ) begin
		if(counter_1msec_delay[7:0] > 8'd160) begin
				//counter_1msec_delay[7:0] <= 1'b0;
				reset_counter_done <= 1'b1;
			end
			else begin
				counter_1msec_delay[7:0] <= counter_1msec_delay[7:0] + 1'b1;
				reset_counter_done <= 1'b0;
			end // counter
	end//cold reset
	else begin
		reset_counter_done <= 1'b0;
		counter_1msec_delay[7:0] <= 8'h00;
	end //physical_pg
end


//RESET logic
assign ASSERT_P0_RESET_L = (~WARM_RST_BTN_L );//& reset_counter_done );	// 1 = RESET_L IS FORCED LOW, 0 = RESET_L IS NOT AFFECTED

//working line
//TODO: Need some cleanup and verification here.
assign P0_SYS_RESET_L = (COLD_RST_BTN_L & ~MGMT_ASSERT_RST_BTN & reset_counter_done); //group_2_pg; //reset_counter_done; //MGMT_ASSERT_LOCAL_LOCK ? (~MGMT_ASSERT_RST_BTN) : (COLD_RST_BTN_L & ~MGMT_ASSERT_RST_BTN);	// can be used as cold reset, and clears processor s5 registers
//TODO: investigate why P0_SYS_RESET_L is not working as expected.
//assign P0_SYS_RESET_L = MGMT_ASSERT_LOCAL_LOCK ? (~MGMT_ASSERT_RST_BTN) : (COLD_RST_BTN_L & ~MGMT_ASSERT_RST_BTN);	// can be used as cold reset, and clears processor s5 registers

assign RESET_LED_L = ~P0_PRESENT_L ? P0_33_RESET_L : (physical_pg & P0_33_RESET_L);		//RESET_L passthrough for HDT CONN, BMC, and ~LED


//HDT processor bypass logic
assign P0_PRESENT_HDT = (~P0_PRESENT_L & ~sw_p0_hdt_bypass) ? 1'bz : 1'b0;		


//PWR GOOD logic
assign P0_PWR_GOOD = physical_pg & COLD_RST_BTN_L;  // can be used as cold reset, but does not clear processor S5 registers


//PG LED
assign PWR_GOOD_LED = physical_pg & COLD_RST_BTN_L;

//can optionally be used for warm reset, but may need BIOS programming to set up
// Tristate the signal if CPU is in S5 state.
assign P0_KBRST_L = (SLP_S5_L == 1'b0) ? 1'bz : 1'b1;		

//NVDIMM SAVE
// Tristate the signal if CPU is in S5 state.
assign P0_NV_FORCE_SELF_REFRESH = (SLP_S5_L == 1'b0) ? 1'bz : ~MGMT_AC_LOSS_L ;

//Tristate the signal if CPU is in S5 state.
wire wire_P0_NMI_SYNC_FLOOD_L;
assign wire_P0_NMI_SYNC_FLOOD_L = MGMT_ASSERT_LOCAL_LOCK ? (~MGMT_ASSERT_NMI_BTN) : (NMI_BTN_L & ~MGMT_ASSERT_NMI_BTN & ~(sw_smi_test & ~smi_l));
assign P0_NMI_SYNC_FLOOD_L = (SLP_S5_L == 1'b0) ? 1'bz : wire_P0_NMI_SYNC_FLOOD_L ;

//PROCHOT
assign MGMT_SYS_MON_P0_PROCHOT_L = P0_PROCHOT_L | P0_PRESENT_L | ~P0_33_RESET_L;
assign P0_PROCHOT_LED = ~(P0_PROCHOT_L | P0_PRESENT_L | ~P0_33_RESET_L);


assign ASSERT_P0_PROCHOT_L = (MGMT_ASSERT_P0_PROCHOT | (sw_prochot_test & ~prochot_l) & ~P0_PRESENT_L & P0_33_RESET_L);


//SPI ROM local boot
assign P0_LOCAL_SPI_ROM_SEL_L = ~sw_p0_boot_local_rom;


//HP slot force on
assign PCIE_SLOT4_HP_FON_L = ~sw_pcie_slot4_hp_force_on;


//buttons


//pwr btn controls and pwr cycling
always @ (posedge clk_5kHz)
	begin 
		if(sw_post_code_pwr_cycle & ~shutdown_error & ~P0_PRESENT_L & group_2_pg)
			begin
				pwr_cycle_pwr_on <= 1'b1;
				if(P0_33_PWROK)
					//if(port80 code == xx)then pwr cycle
					begin
						counter <= 15'b0;
						if((port_reg[7:4] == 4'hc) & (port_reg[3:0] == 4'h0))
							begin
								post_code_match <= 1'b1;
								P0_PWR_BTN_L <= 1'b0;
							end
						else if(post_code_match)
							begin
								P0_PWR_BTN_L <= 1'b0;
							end
						else
							begin
								P0_PWR_BTN_L <= 1'b1;
							end
					end
				else
					begin
						post_code_match <= 1'b0;
						if(counter < wait_pwr_up_counter_delay)	//waits for a time to let voltages go down
							begin
								P0_PWR_BTN_L <= 1'b1;
								counter <= counter + 1;
							end
						else if(counter < assert_pwr_up_counter_delay)	//simulated pwr button assertion, then deassertion
							begin
								P0_PWR_BTN_L <= 1'b0;
								counter <= counter + 1;
							end
						else
							begin
								P0_PWR_BTN_L <= 1'b1;
							end
					end
			end			
		else if(sw_pwr_good_pwr_cycle & ~shutdown_error & ~P0_PRESENT_L & group_2_pg)
			begin
				pwr_cycle_pwr_on <= 1'b1;
				post_code_match <= 1'b0;
				if(physical_pg & P0_33_PWROK & P0_33_RESET_L)	//if processor releases reset, pwr cycle
					begin
						P0_PWR_BTN_L <= 1'b0;
						counter <= 15'b0;
					end
				else
					begin
						if(counter < wait_pwr_up_counter_delay)	//waits for a time to let voltages go down
							begin
								P0_PWR_BTN_L <= 1'b1;
								counter <= counter + 1;
							end
						else if(counter < assert_pwr_up_counter_delay)	//simulated pwr button assertion, then deassertion
							begin
								P0_PWR_BTN_L <= 1'b0;
								counter <= counter + 1;
							end
						else
							begin
								P0_PWR_BTN_L <= 1'b1;
							end
					end
			end
			
		else if(sw_pwr_good_pwr_cycle & ~shutdown_error & group_2_pg)
			begin
				P0_PWR_BTN_L <= 1'b1;
				post_code_match <= 1'b0;
				if(physical_pg)	//if all regs return PG then pwr cycle
					begin
						pwr_cycle_pwr_on <= 1'b0;
						counter <= 15'b0;
					end
				else
					begin
						if(counter < wait_pwr_up_counter_delay)	//waits for a time to let voltages go down
							begin
								pwr_cycle_pwr_on <= 1'b0;
								counter <= counter + 1;
							end
						else
							begin
								pwr_cycle_pwr_on <= 1'b1;
							end
					end
			end			
			
		else if(shutdown_error)
			begin
				P0_PWR_BTN_L <= 1'b1;
				counter <= 15'b0;
				post_code_match <= 1'b0;
				pwr_cycle_pwr_on <= 1'b1;
			end
		else if(MGMT_ASSERT_LOCAL_LOCK)
			begin
				P0_PWR_BTN_L <= ~MGMT_ASSERT_PWR_BTN;
				counter <= 15'b0;
				post_code_match <= 1'b0;
				pwr_cycle_pwr_on <= 1'b1;
			end
		else
			begin
				P0_PWR_BTN_L <= ~MGMT_ASSERT_PWR_BTN & PWR_BTN_L;
				counter <= 15'b0;
				post_code_match <= 1'b0;
				pwr_cycle_pwr_on <= 1'b1;
			end	
	end


//sw_smi_test diesel_sw_smi_test (
////inputs
//clk,
//P0_33_RESET_L,
////outputs
//smi_l
//);
	
//prochot_duty_cycle_test diesel_prochot_duty_cycle_test(
////inputs
//clk,
//P0_33_RESET_L,
//FPGA_BTN_L,
////outputs
//prochot_l,
//prochot_duty_cycle_state
//);		

endmodule
