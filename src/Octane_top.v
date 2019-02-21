/*****************************************************************************
//
// Description:   SP4_Octane.v
//                
// *****************************************************************************
//
// Copyright 2017 ADVANCED MICRO DEVICES, INC.  All Rights Reserved.
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

`include "FPGA_code_revision_define.v"

module SP4_Octane(

//	input  FPGA_24M_CLK ,
//	input [1:0] FPGA_BRD_ID ,
	
//	input  [8:1] FPGA_SW1 ,
	
//	input  P0_33_PWROK ,
//	input  P0_PROCHOT_L ,
//	input wire P0_SLP_S5_L ,
//	input wire P0_SLP_S3_L ,
//	input  VDD_33_DUAL_PG ,
		
//	input   P0_VDD_SOC_RUN_VRHOT_L ,
//	output  P0_KBRST_L ,
//	output  P0_PRESENT_HDT ,

//	input  NMI_BTN_L ,
//	input  FPGA_BTN_L ,
//	input  FPGA_P0_THERMTRIP_L ,
//	output FPGA_SLT_SBTSI_THERMTRIP_L ,
//	input  FPGA_VDD_CORE_DUAL_PG ,

	output wire [6:0] LED_SEG_1,	// G F E D C B A 
	output wire [6:0] LED_SEG_2,
	output wire [6:0] LED_SEG_3,
	output wire [6:0] LED_SEG_4,
//	output wire LED_DP_1 ,
//	output wire LED_DP_2 ,
//	output wire LED_DP_3 ,
//	output wire LED_DP_4 ,
//	output wire [3:0] LED_DIG_SEL ,

//	output wire P0_VDD_18_RUN_EN ,
//	input  wire P0_VDD_18_RUN_PG ,

//	output wire P0_VDD_18_DUAL_EN , 
//	input  wire P0_VDD_18_DUAL_PG ,
	
//	output wire P0_VDD_MEM_CD_SUS_EN , 
//	input  wire P0_VDD_MEM_CD_SUS_PG ,

//	output wire P0_VDD_MEM_VPP_CD_SUS_EN , 
//	input  wire P0_VDD_MEM_VPP_CD_SUS_PG ,

//	output wire P0_VDD_MEM_VTT_CD_SUS_EN , 
//	input  wire P0_VDD_MEM_VTT_CD_SUS_PG ,

//	output wire P0_VDD_SPD_CD_SUS_EN , 
//	input  wire P0_VDD_SPD_CD_SUS_PG ,

//	output wire P0_VDD_MEM_AB_SUS_EN , 
//	input  wire P0_VDD_MEM_AB_SUS_PG ,

//	output wire P0_VDD_SPD_AB_SUS_EN , 
//	input  wire P0_VDD_SPD_AB_SUS_PG ,

//	output wire P0_VDD_MEM_VPP_AB_SUS_EN , 
//	input  wire P0_VDD_MEM_VPP_AB_SUS_PG ,

//	output wire P0_VDD_MEM_VTT_AB_SUS_EN , 
//	input  wire P0_VDD_MEM_VTT_AB_SUS_PG ,

//	output wire P0_VDD_SOC_DUAL_EN , 
//	input  wire P0_VDD_SOC_DUAL_PG ,

//	output wire P0_VDD_SOC_RUN_EN , 
//	input  wire P0_VDD_SOC_RUN_PG ,

//	output wire P0_VDD_CORE_RUN_EN , 
//	input  wire P0_VDD_CORE_RUN_PG ,

//	input  MGMT_VDD_MEM_DUAL_PG ,
//	input  MGMT_VDD_VPP_DUAL_PG ,
//	input  MGMT_VDD_CORE_DUAL_PG ,

//	input  MGMT_ASSERT_P0_PROCHOT ,
//	input  MGMT_ASSERT_LOCAL_LOCK ,
//	output MGMT_SYS_MON_P0_PROCHOT_L ,
//	input  MGMT_ASSERT_RST_BTN ,
//	input  MGMT_ASSERT_PWR_BTN ,
//	input  MGMT_ASSERT_WARM_RESET_BTN ,
//	input  MGMT_SMBUS_ALERT_3_L ,
//	input  MGMT_SMBUS_CLK_3 ,
//	input  MGMT_SMBUS_DATA_3 ,

//	input MGMT_ASSERT_BMC_READY ,
//	input MGMT_ASSERT_NMI_BTN ,
//	input MGMT_AC_LOSS_L ,
	
//	input  P0_VDD_CORE_RUN_VRHOT_L ,
//	input  P0_VDD_MEM_CD_SUS_VRHOT_L ,
//	input  P0_VDD_MEM_AB_SUS_VRHOT_L ,
	
//	input  P0_33_RESET_L ,

	inout  [3:0] LPC_LAD ,
	input  LPC_FRAME_L ,
	input  FPGA_LPC_RST_L ,
	input  FPGA_LPC_CLK
	
//	input  P0_VDD_MEM_AB_12_RUN_PLUG_PRSNT ,
//	input  P0_VDD_MEM_CD_12_RUN_PLUG_PRSNT ,
//	input  P0_VDD_12_RUN_PLUG_PRSNT ,
	
//	output reg P0_FPGA_SMBUS_DATA ,
//	input  	  P0_FPGA_SMBUS_CLK ,

//	input  FPGA_SPI_MISO ,
//	output reg FPGA_SPI_CLK ,
//	output reg FPGA_SPI_MOSI ,
//	output reg FPGA_SPI_CS_L ,
//	output P0_LOCAL_SPI_ROM_SEL_L ,
	
//	input  P0_PRESENT_L ,
//	output wire HDT_CONN_PWROK ,
//	input  HDT_CONN_RESET_L ,
//	input  SENSOR_THERM_L ,
	
//	input  COLD_RST_BTN_L ,
//	input  WARM_RST_BTN_L ,
//	input  wire PWR_BTN_L,
//	input  wire ATX_PWR_OK ,
//	output  P0_PWR_BTN_L ,	
	
//	output wire ATX_PS_ON , 
//	output ASSERT_P0_RESET_L ,
//	output ASSERT_P0_PROCHOT_L ,
//	output ASSERT_P0_PWROK_L ,
//	output P0_PWR_GOOD ,
//	output P0_RSMRST_L , 
	
//	output FPGA_P0_PWROK_RESET_BUF_EN_L ,
//	output wire FPGA_5_DUAL_EN ,
//	output P0_PROCHOT_LED ,
//	output PCIE_SLOT4_HP_FON_L ,

//	output  P0_SYS_RESET_L ,

//	output RESET_LED_L ,
//	output PWR_GOOD_LED ,
//	output PWROK_LED ,
//	output reg FP_PWR_LED , //Front Panel Power LED
//	output P0_NMI_SYNC_FLOOD_L ,

//	output P0_NV_FORCE_SELF_REFRESH ,

//	input wire DAP_EXT_P0_CORE_RUN_VOLTAGE_PG,
//	input  CPU_ORIENT_OP_L , //not required anymore.
//	output  PIN_P1_R2210 , //Debug output pin.
//	output  PIN_R1_R2211   //Debug output pin.

);

/**************************************************************
*                    Internal General wires                   *
**************************************************************/

//FPGA VERSION that will be displayed on pressing the FPGA button.
//reg [31:0] FPGA_VERSION = {`FPGA_bitmap_type, {3'h1, `major_FPGA_code_rev_number}, {3'h0,`minor_FPGA_code_rev_number1}, {3'h0,`minor_FPGA_code_rev_number2} };

//board_rev_sp4r2 = 0 = SP4, 1=SP4r2
//reg board_rev_sp4r2 = 1'b0;

//wire Reset;
//wire Reset_l;


//wire CLK0_BUF, CLKFX_BUF;

//reg PWR_BTN_L_released;
//reg PWR_BTN_L_debounced_1;

//wire PWR_BTN_L_debounced;
	
//reg [4:0]powerup_counter ;
//reg fpga_power_stable;
		
//wire [7:0] temp_seg_a;
//reg [31:0] led_bus_4char;

//wire [31:0] led7seg_pwrseq;

//wire final_pwrgd;

//wire ATX_PS_ON_wire;
//wire [7:0] debug_leds;
//
//wire clk_2Hz ;
//wire clk_50Hz ;
//wire clk_5kHz ;
//wire clk_800kHz ;
//wire clk_1600kHz ;

//wire P0_VDD_18_RUN_EN_wire ;
//wire P0_VDD_18_DUAL_EN_wire ;

//wire P0_VDD_MEM_VTT_CD_SUS_EN_wire ;
//wire P0_VDD_MEM_CD_SUS_EN_wire ;
//wire P0_VDD_MEM_VPP_CD_SUS_EN_wire ;
//wire P0_VDD_SPD_CD_SUS_EN_wire ;

//wire P0_VDD_MEM_AB_SUS_EN_wire ;
//wire P0_VDD_SPD_AB_SUS_EN_wire ;
//wire P0_VDD_MEM_VPP_AB_SUS_EN_wire ;
//wire P0_VDD_MEM_VTT_AB_SUS_EN_wire ;

//wire P0_VDD_CORE_RUN_EN_wire ;
//wire P0_VDD_SOC_RUN_EN_wire ;
//wire P0_VDD_SOC_DUAL_EN_wire ;
	
//wire wire_P0_SLP_S5_L;
//wire wire_P0_SLP_S3_L;

//wire wire_board_type;
//wire wire_all_voltages_force_on;
//wire wire_p0_boot_local_rom;
//wire wire_pcie_slot4_hp_force_on;

//wire FPGA_SW1_3_debounced;
//wire led7seg_control;

//wire P0_VDD_SPD_CD_SUS_PG_seq;
//wire P0_VDD_MEM_CD_SUS_PG_seq;
//wire P0_VDD_MEM_VTT_CD_SUS_PG_seq;
//wire P0_VDD_MEM_VPP_CD_SUS_PG_seq;

//reg [3:0] reset_gen_counter = 4'hF;
//reg soft_reset = 1'b1;

//assign PIN_P1_R2210 = MGMT_ASSERT_LOCAL_LOCK ;
//assign PIN_R1_R2211 = MGMT_ASSERT_PWR_BTN ;

//assign Reset =  soft_reset; 
//assign led7seg_control = final_pwrgd;

//assign HDT_CONN_PWROK = PWROK_LED;
//Generate a soft reset for now.
//This can be avoided by initializing all the nets and registers with an initial value.
/*
always @(posedge clk_5kHz) begin
	if(reset_gen_counter[3:0] > 0 ) begin
		reset_gen_counter <= reset_gen_counter - 1'b1;
	end
	soft_reset <= reset_gen_counter[3] | reset_gen_counter[2] | reset_gen_counter[1] | reset_gen_counter[0] ;
end
*/
//mux to control/handover the LEDs to LPC port for LPC post code display after power sequence is complete.

//always @(posedge clk_5kHz) begin
//	if(FPGA_BTN_L == 1'b0) begin
//		//show the FPGA version when the FPGA button is pressed.
//		led_bus_4char[31:0] <= FPGA_VERSION[31:0];
//	end
//	else begin
		//if(led7seg_control == 0)
			//led_bus_4char[31:0] <=  led7seg_pwrseq[31:0] ;
		//else 
//			led_bus_4char[31:0] <=	{4'h0,lpc_port_reg[15:12], 4'h0,lpc_port_reg[11:8], 4'h0,lpc_port_reg[7:4], 4'h0,lpc_port_reg[3:0]} ;
//	end

//end//always(LED display)


//debounce debounce_pwr_sw( .switch_in(PWR_BTN_L), .debounce_out(PWR_BTN_L_debounced), .clk(clk_5kHz) );

//Note: SW OFF= high, ON=LOW
//=============== FPGA Switch assignment =========================
//assign wire_board_type 					= ~FPGA_SW1[8];//SW OFF=Normal; ON= ATE board (wait for pwr button)
//assign wire_p0_boot_local_rom			= ~FPGA_SW1[7];//SW OFF=Boot from BMC; ON= Boot Local
//assign wire_all_voltages_force_on	= ~FPGA_SW1[6];//SW OFF=Normal; ON= All voltages will be forced ON.
//assign wire_pcie_slot4_hp_force_on  =  FPGA_SW1[5];//SW OFF=Hotplug ON; ON=No HP force ON
//assign wire_prochot_test				= ~FPGA_SW1[4];//SW OFF=Normal mode; ON= Force Prochot
//assign wire_dap_bypass		   		= ~FPGA_SW1[3];//SW OFF=Normal mode; ON= Do not enable VDD_CORE
//assign wire_P0_SLP_S5_L = (  ~FPGA_SW1[2] | P0_SLP_S5_L ) | 1'b0 ;//SW OFF=Normal State; ON= Deassert S5 state
//assign wire_P0_SLP_S3_L = (  ~FPGA_SW1[1] | P0_SLP_S3_L ) | 1'b0 ;//SW OFF=Normal State; ON= Deassert S3 state 

//assign wire_smi_test = 0; //hardcoded for now

 
//always @(posedge clk_50Hz) begin
//	board_rev_sp4r2 <= FPGA_BRD_ID[0];
//end

//If board is SP4r2, then fake the powergoods of memory channel CD regulators using the Enable of the regulator. 
//assign P0_VDD_SPD_CD_SUS_PG_seq 		= ( board_rev_sp4r2 == 1'b1) ? P0_VDD_SPD_CD_SUS_EN_wire : P0_VDD_SPD_CD_SUS_PG ; 
//assign P0_VDD_MEM_CD_SUS_PG_seq 		= ( board_rev_sp4r2 == 1'b1) ? P0_VDD_MEM_CD_SUS_EN_wire : P0_VDD_MEM_CD_SUS_PG ; 
//assign P0_VDD_MEM_VTT_CD_SUS_PG_seq = ( board_rev_sp4r2 == 1'b1) ? P0_VDD_MEM_VTT_CD_SUS_EN_wire : P0_VDD_MEM_VTT_CD_SUS_PG ; 
//assign P0_VDD_MEM_VPP_CD_SUS_PG_seq = ( board_rev_sp4r2 == 1'b1) ? P0_VDD_MEM_VPP_CD_SUS_EN_wire : P0_VDD_MEM_VPP_CD_SUS_PG ; 

/*
control octane_control(
	//inputs
	.clk ( Clk24In ) ,
	.clk_5kHz ( clk_5kHz ) ,
	
	.sw_p0_hdt_bypass ( 1'b0 ) ,//wire_p0_hdt_bypass; not used in Octane which is 1P. hardcoded to 0.
	.sw_p0_boot_local_rom ( wire_p0_boot_local_rom ) ,
	.sw_pcie_slot4_hp_force_on ( wire_pcie_slot4_hp_force_on ) ,
	.sw_smi_test ( wire_smi_test ) , 
	.sw_prochot_test ( wire_prochot_test ) ,
	.sw_post_code_pwr_cycle ( 1'b0 ) ,//Hardcoded due to lack of switches
	.sw_pwr_good_pwr_cycle  ( 1'b0 ) ,//Hardcoded due to lack of switches
	
	.P0_33_PWROK ( P0_33_PWROK ) ,
	.P0_PRESENT_L ( P0_PRESENT_L ) ,
	.P0_33_RESET_L ( P0_33_RESET_L ) ,
	.P0_PWRGD_OUT ( P0_PWRGD_OUT ) ,
	.PWR_BTN_L ( PWR_BTN_L_debounced ) ,
	.MGMT_ASSERT_PWR_BTN ( MGMT_ASSERT_PWR_BTN ) ,
	.COLD_RST_BTN_L ( COLD_RST_BTN_L ) ,
	.WARM_RST_BTN_L ( WARM_RST_BTN_L ) ,
	.MGMT_ASSERT_RST_BTN ( MGMT_ASSERT_RST_BTN ) ,
	.NMI_BTN_L ( NMI_BTN_L ) ,
	.MGMT_ASSERT_NMI_BTN ( MGMT_ASSERT_NMI_BTN ) ,
	.MGMT_ASSERT_LOCAL_LOCK ( MGMT_ASSERT_LOCAL_LOCK ) ,
	.P0_PROCHOT_L ( P0_PROCHOT_L ) ,
	.MGMT_ASSERT_P0_PROCHOT ( MGMT_ASSERT_P0_PROCHOT ) ,
	.MGMT_AC_LOSS_L ( MGMT_AC_LOSS_L ) ,
	.P0_FPGA_SMBUS_DATA ( P0_FPGA_SMBUS_DATA ) ,
	.P0_FPGA_SMBUS_CLK ( P0_FPGA_SMBUS_CLK ) ,
	.MGMT_SMBUS_CLK ( MGMT_SMBUS_CLK ) ,
	.MGMT_SMBUS_DATA ( MGMT_SMBUS_DATA ) ,
	.SLP_S3_L ( wire_P0_SLP_S3_L ) ,
	.SLP_S5_L ( wire_P0_SLP_S5_L ) ,
	.FPGA_BTN_L ( FPGA_BTN_L ) ,
	.group_2_pg ( group_2_pg ) ,
	.physical_pg ( final_pwrgd ) ,
	.shutdown_error ( shutdown_error ) ,
	.port_reg ( lpc_port_reg ) ,
	
	//outputs 
	.P0_VDD_CORE_RUN_PWROK (  ) , // P0_VDD_CORE_RUN_PG; not required on Octane as there is a single controller for Core & SoC
	.P0_VDD_SOC_RUN_PWROK ( P0_VDD_SOC_RUN_EN_wire ) ,

	.ASSERT_P0_PWROK_L ( ASSERT_P0_PWROK_L ) ,

	.PWROK_LED ( PWROK_LED ) ,
	.ASSERT_P0_RESET_L ( ASSERT_P0_RESET_L ) ,
	.RESET_LED_L ( RESET_LED_L ) ,
	.P0_KBRST_L ( P0_KBRST_L ) ,
	.P0_PRESENT_HDT ( P0_PRESENT_HDT ) ,

	.P0_PWR_GOOD ( P0_PWR_GOOD ) ,

	.P0_PWR_BTN_L ( P0_PWR_BTN_L ) ,
	.P0_SYS_RESET_L ( P0_SYS_RESET_L ) ,
	.PWR_GOOD_LED ( PWR_GOOD_LED ) ,
	.P0_NMI_SYNC_FLOOD_L ( P0_NMI_SYNC_FLOOD_L ) ,
	.P0_NV_FORCE_SELF_REFRESH ( P0_NV_FORCE_SELF_REFRESH ) ,
	.MGMT_SYS_MON_P0_PROCHOT_L ( MGMT_SYS_MON_P0_PROCHOT_L ) ,
	.P0_PROCHOT_LED ( P0_PROCHOT_LED ) ,
	.ASSERT_P0_PROCHOT_L ( ASSERT_P0_PROCHOT_L ) ,
	.P0_LOCAL_SPI_ROM_SEL_L ( P0_LOCAL_SPI_ROM_SEL_L ) ,
	.PCIE_SLOT4_HP_FON_L ( PCIE_SLOT4_HP_FON_L ) ,
	.prochot_duty_cycle_state ( prochot_duty_cycle_state ) , // TODO: not connected yet.
	//.prochot_test ( prochot_test ) ,
	.pwr_cycle_pwr_on ( pwr_cycle_pwr_on ) 
); // control
*/
//
//================== Power Sequencer instance ==================
//

/*
SP4_power_sequencer SP4_power_sequencer_inst(
	.clk_24MHz(Clk24In),
	.clk_5kHz ( clk_5kHz ) ,
	.OVERRIDE_PWR_PLUG_PRSNT( 0 ) , //Do not override plug present; Debug signal.
	.Reset(Reset),
  
   .P0_VDD_18_DUAL_EN ( P0_VDD_18_DUAL_EN_wire), 
	.P0_VDD_18_DUAL_PG (P0_VDD_18_DUAL_PG),

	.P0_VDD_SOC_DUAL_EN (P0_VDD_SOC_DUAL_EN_wire), 
	.P0_VDD_SOC_DUAL_PG (P0_VDD_SOC_DUAL_PG),
	
   .P0_VDD_18_RUN_EN ( P0_VDD_18_RUN_EN_wire),
	.P0_VDD_18_RUN_PG (P0_VDD_18_RUN_PG),

	.P0_VDD_MEM_CD_SUS_EN ( P0_VDD_MEM_CD_SUS_EN_wire),
	.P0_VDD_MEM_CD_SUS_PG (P0_VDD_MEM_CD_SUS_PG_seq),

	.P0_VDD_MEM_VPP_CD_SUS_EN ( P0_VDD_MEM_VPP_CD_SUS_EN_wire ), 
	.P0_VDD_MEM_VPP_CD_SUS_PG ( P0_VDD_MEM_VPP_CD_SUS_PG_seq),

	.P0_VDD_MEM_VTT_CD_SUS_EN (P0_VDD_MEM_VTT_CD_SUS_EN_wire ), 
	.P0_VDD_MEM_VTT_CD_SUS_PG (P0_VDD_MEM_VTT_CD_SUS_PG_seq),

	.P0_VDD_SPD_CD_SUS_EN (P0_VDD_SPD_CD_SUS_EN_wire ),
	.P0_VDD_SPD_CD_SUS_PG (P0_VDD_SPD_CD_SUS_PG_seq),

	.P0_VDD_MEM_AB_SUS_EN (P0_VDD_MEM_AB_SUS_EN_wire  ), 
	.P0_VDD_MEM_AB_SUS_PG (P0_VDD_MEM_AB_SUS_PG),

	.P0_VDD_SPD_AB_SUS_EN ( P0_VDD_SPD_AB_SUS_EN_wire ), 
	.P0_VDD_SPD_AB_SUS_PG (P0_VDD_SPD_AB_SUS_PG),

	.P0_VDD_MEM_VPP_AB_SUS_EN ( P0_VDD_MEM_VPP_AB_SUS_EN_wire ),
	.P0_VDD_MEM_VPP_AB_SUS_PG (P0_VDD_MEM_VPP_AB_SUS_PG),

	.P0_VDD_MEM_VTT_AB_SUS_EN (P0_VDD_MEM_VTT_AB_SUS_EN_wire),
	.P0_VDD_MEM_VTT_AB_SUS_PG (P0_VDD_MEM_VTT_AB_SUS_PG),

	.P0_VDD_SOC_RUN_EN ( ), //no seperate SOC_RUN on Octane
	.P0_VDD_SOC_RUN_PG ( P0_VDD_SOC_RUN_PG ),

	.P0_VDD_CORE_RUN_EN (P0_VDD_CORE_RUN_EN_wire),
	.P0_VDD_CORE_RUN_PG ( P0_VDD_CORE_RUN_PG),
	.DAP_EXT_P0_CORE_RUN_VOLTAGE_PG ( DAP_EXT_P0_CORE_RUN_VOLTAGE_PG ),

	.MGMT_VDD_MEM_DUAL_PG ( MGMT_VDD_MEM_DUAL_PG ) ,
	.MGMT_VDD_VPP_DUAL_PG ( MGMT_VDD_VPP_DUAL_PG ) ,
	.MGMT_VDD_CORE_DUAL_PG ( MGMT_VDD_CORE_DUAL_PG ) ,
	.MGMT_ASSERT_BMC_READY ( MGMT_ASSERT_BMC_READY ), 
	.FPGA_5_DUAL_EN (FPGA_5_DUAL_EN), 
	
	.P0_VDD_MEM_AB_12_RUN_PLUG_PRSNT ( P0_VDD_MEM_AB_12_RUN_PLUG_PRSNT ) ,
	.P0_VDD_MEM_CD_12_RUN_PLUG_PRSNT ( P0_VDD_MEM_CD_12_RUN_PLUG_PRSNT ) ,
	.P0_VDD_12_RUN_PLUG_PRSNT ( P0_VDD_12_RUN_PLUG_PRSNT ) ,
	.VDD_33_DUAL_PG (VDD_33_DUAL_PG),
	
	.P0_SLP_S5_L( wire_P0_SLP_S5_L ),
	.P0_SLP_S3_L( wire_P0_SLP_S3_L ),
	.P0_PRESENT_L( P0_PRESENT_L ),
	.P0_VDD_MEM_AB_SUS_VRHOT_L (P0_VDD_MEM_AB_SUS_VRHOT_L) ,
	.P0_VDD_MEM_CD_SUS_VRHOT_L (P0_VDD_MEM_CD_SUS_VRHOT_L) ,
	.P0_VDD_CORE_RUN_VRHOT_L (P0_VDD_CORE_RUN_VRHOT_L) ,
	.P0_VDD_SOC_RUN_VRHOT_L (P0_VDD_SOC_RUN_VRHOT_L) , // NOT really created on Octane. tie it in a clean way. 
	.FPGA_P0_THERMTRIP_L (FPGA_P0_THERMTRIP_L ) ,
	.SENSOR_THERM_L (SENSOR_THERM_L ) ,
	.FPGA_SLT_SBTSI_THERMTRIP_L ( FPGA_SLT_SBTSI_THERMTRIP_L ) ,
	.P0_33_PWROK (P0_33_PWROK),
	.PWR_BTN_L( PWR_BTN_L_debounced ), 
	.BOARD_TYPE( wire_board_type ), 
	.P0_RSMRST_L( P0_RSMRST_L ),
	.GLOBAL_FORCE_ON( wire_all_voltages_force_on ), //used during FCT.
	.CPU_ORIENT_GOOD ( ~CPU_ORIENT_OP_L   ) , 
	.ATX_PS_ON(ATX_PS_ON),
	.ATX_PWR_OK(ATX_PWR_OK),
	.DEBUG_STATE( ),
	.FPGA_P0_PWROK_RESET_BUF_EN_L ( FPGA_P0_PWROK_RESET_BUF_EN_L ) , 
	.ERROR ( temp_seg_a[5] ),
	.LED7SEG_ERROR_CODE ( led7seg_pwrseq[31:0] ),
	.FINAL_PWRGD ( final_pwrgd  ),
	.group_2_pg ( group_2_pg  ),
	.dap_bypass ( wire_dap_bypass ),
	.pwr_cycle_pwr_on ( pwr_cycle_pwr_on ) 

); //SP4_power_sequencer_inst
*/
//wire Clk24In;
//wire [15:0] lpc_port_reg;
/*
leds_7seg_controller leds_7seg_controller_inst(
//  .debug			(),
  .IntClk		(FPGA_24M_CLK),
  .Reset			(1'b0),//(Reset),
  .data			({4'h0,lpc_port_reg[15:12], 4'h0,lpc_port_reg[11:8], 4'h0,lpc_port_reg[7:4], 4'h0,lpc_port_reg[3:0]}),//(led_bus_4char),
  // LED Outputs
  .LedSeg_1		(LED_SEG_1),
  .LedSeg_2		(LED_SEG_2),
  .LedSeg_3		(LED_SEG_3),
  .LedSeg_4		(LED_SEG_4),  
  .LedSeg_DP_1	(LED_DP_1),
  .LedSeg_DP_2	(LED_DP_2),
  .LedSeg_DP_3	(LED_DP_3),
  .LedSeg_DP_4	(LED_DP_4)  
//  .LED_DIG_SEL ( LED_DIG_SEL )
);
*/




lpc_decode lpc_decode_inst(
	//lpc decode inputs
	.lclk ( FPGA_LPC_CLK ) ,
	.lrst ( FPGA_LPC_RST_L) ,
	.lframe ( LPC_FRAME_L ),
	.lad ( LPC_LAD ),
	//lpc decode outputs
//	.port_reg (lpc_port_reg) ,
//	.IntClk			(FPGA_24M_CLK),
	
	.LedSeg_2		(LED_SEG_2),
//	.LedSeg_3		(LED_SEG_3),
//	.LedSeg_4		(LED_SEG_4)  
//	.LedSeg_DP_1	(LED_DP_1),
//	.LedSeg_DP_2	(LED_DP_2),
//	.LedSeg_DP_3	(LED_DP_3),
//	.LedSeg_DP_4	(LED_DP_4),  

	.LedSeg_1		(LED_SEG_1)	 
	//lpc decode inouts

);
	
/*		
always @(posedge clk_50Hz) begin
	if(Reset == 1'b1) begin
		powerup_counter[4:0] <=   5'b00000;
		fpga_power_stable <= 1'b0;
	end
	else begin
		if( powerup_counter[4:0] < 5'b11111) begin
			powerup_counter[4:0] <=  powerup_counter[4:0] + 1'b1;
			fpga_power_stable <= 1'b0;
		end
		else begin
			fpga_power_stable <= 1'b1;
		end
	end
end	//FPGA power stable counter
*/

/*
always @(posedge clk_50Hz) begin
	PWR_BTN_L_debounced_1 <= PWR_BTN_L_debounced;
	PWR_BTN_L_released <= PWR_BTN_L_debounced & ! PWR_BTN_L_debounced_1 & fpga_power_stable;
end
*/	

/*
	//7-SEG LED output
	always @(posedge Clk24In) begin
		if(Reset == 1'b1) begin
			FP_PWR_LED <= 1'b0;
		end
		else begin
			FP_PWR_LED <= 1'b1;
		end // if(Reset
	end // always @(posedge OSC_24_FPGA)
	
	//TODO: 
	//Temporary pullup/downs. delete it once they are connected.
	always @(posedge Clk24In) begin
		if(Reset == 1'b1) begin
			FPGA_SPI_CS_L <= 1'b1;
			FPGA_SPI_MOSI <= 1'b0;
			FPGA_SPI_CLK <= 1'b0;
		
			P0_FPGA_SMBUS_DATA <= 1'b0;
		end
		else begin
			FPGA_SPI_CS_L <= 1'b0;
			FPGA_SPI_MOSI <= 1'b0;
			FPGA_SPI_CLK <= 1'b0;
	
			P0_FPGA_SMBUS_DATA <= 1'b0;
		end // if(Reset)
	end // always @(posedge OSC_24_FPGA)
*/

//Debug parameter
//1=input for debug 0=output for actual control of enables//
//parameter ENABLE_DIRECTION	= 1'b0; 
	
//IBUFG Rst_BUFG_INST   (.I(FPGA_BTN_L),		 .O(Reset_l));




/*
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_18_RUN_EN (
      .O(P0_VDD_18_RUN_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_18_RUN_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_18_DUAL_EN (
      .O(P0_VDD_18_DUAL_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_18_DUAL_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_MEM_CD_SUS_EN (
      .O(P0_VDD_MEM_CD_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_MEM_CD_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_MEM_VTT_CD_SUS_EN (
      .O(P0_VDD_MEM_VTT_CD_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_MEM_VTT_CD_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_MEM_VPP_CD_SUS_EN (
      .O(P0_VDD_MEM_VPP_CD_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_MEM_VPP_CD_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_SPD_CD_SUS_EN (
      .O(P0_VDD_SPD_CD_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_SPD_CD_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	
	 OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_MEM_AB_SUS_EN (
      .O(P0_VDD_MEM_AB_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_MEM_AB_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	 OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_MEM_VTT_AB_SUS_EN (
      .O(P0_VDD_MEM_VTT_AB_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_MEM_VTT_AB_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );

	
	 OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_MEM_VPP_AB_SUS_EN (
      .O(P0_VDD_MEM_VPP_AB_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_MEM_VPP_AB_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	
	 OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_SPD_AB_SUS_EN (
      .O(P0_VDD_SPD_AB_SUS_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_SPD_AB_SUS_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
	
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_CORE_RUN_EN (
      .O(P0_VDD_CORE_RUN_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_CORE_RUN_EN_wire ),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );

	//Tristate driver. 
	//if SOC_RUN is enabled, it floats the line to VR controller allowing the pullup to take over.
	OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_SOC_RUN_EN (
      .O(P0_VDD_SOC_RUN_EN),     // Buffer output (connect directly to top-level port)
      .I(1'b0),     // Buffer input  P0_VDD_SOC_RUN_EN_wire
      .T(1'b1)      // 3-state enable input; 1=Tristate
   ); // P0_VDD_SOC_RUN_EN is different on Octane.	

	 OBUFT #(
      .DRIVE(12),   // Specify the output drive strength
      .IOSTANDARD("DEFAULT"), // Specify the output I/O standard
      .SLEW("SLOW") // Specify the output slew rate
   ) OBUFT_P0_VDD_SOC_DUAL_EN (
      .O(P0_VDD_SOC_DUAL_EN),     // Buffer output (connect directly to top-level port)
      .I(P0_VDD_SOC_DUAL_EN_wire),     // Buffer input
      .T(ENABLE_DIRECTION)      // 3-state enable input 
   );
	
*/
/*
clocks octane_clocks(
	//inputs
	.clk_24MHz ( Clk24In ) ,

	//outputs
	.clk_2Hz ( clk_2Hz ),
	.clk_50Hz ( clk_50Hz ),
	.clk_5kHz ( clk_5kHz ) ,
	.clk_800kHz ( clk_800kHz ) ,
	.clk_1600kHz ( clk_1600kHz ) 

);
*/

//===== IP for programming the FPGA bitmap through SPI/JTAG interface =====// 
//BMC will use it to update the FPGA bitmap.	 
/*
jtag_2_spi jtag_2_spi_inst(
	.FPGA_24MHZ_CLK( Clk24In ),
   .jtag2spi_dbg( jtag2spi_dbg ) //Debug out pins. ignore for now.
); //end jtag_2_spi_inst
*/

endmodule 