`timescale 1ns / 1ps
/*****************************************************************************
//
// Description:   power_sequencer.v
//                
//*****************************************************************************
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
//*****************************************************************************/

module SP4_power_sequencer(
	input clk_24MHz,
	input clk_5kHz,
	input Reset,
	input OVERRIDE_PWR_PLUG_PRSNT , //controlled by a hardcoded signal in top module

	output wire P0_VDD_18_RUN_EN ,
	input P0_VDD_18_RUN_PG ,

	output wire P0_VDD_18_DUAL_EN , //Group-A
	input  P0_VDD_18_DUAL_PG ,
	
	output wire P0_VDD_SOC_DUAL_EN , //Group-A
	input  P0_VDD_SOC_DUAL_PG ,
	
	output wire  P0_VDD_MEM_AB_SUS_EN , //Group-C
	input  P0_VDD_MEM_AB_SUS_PG ,
	
	output wire  P0_VDD_SPD_AB_SUS_EN , //Group-C
	input  P0_VDD_SPD_AB_SUS_PG ,

	output wire  P0_VDD_MEM_VPP_AB_SUS_EN , //Group-C
	input  P0_VDD_MEM_VPP_AB_SUS_PG ,

	output wire  P0_VDD_MEM_VTT_AB_SUS_EN , //Group-C
	input  P0_VDD_MEM_VTT_AB_SUS_PG ,
	
	output wire  P0_VDD_SPD_CD_SUS_EN , //Group-C
	input  P0_VDD_SPD_CD_SUS_PG ,
	
	output wire  P0_VDD_MEM_CD_SUS_EN , //Group-C
	input  P0_VDD_MEM_CD_SUS_PG ,

	output wire  P0_VDD_MEM_VPP_CD_SUS_EN , //Group-C
	input  P0_VDD_MEM_VPP_CD_SUS_PG ,

	output wire  P0_VDD_MEM_VTT_CD_SUS_EN , //Group-C
	input  P0_VDD_MEM_VTT_CD_SUS_PG ,

	output wire P0_VDD_SOC_RUN_EN , //Group-D
	input  wire P0_VDD_SOC_RUN_PG ,

	output wire P0_VDD_CORE_RUN_EN , //Group-D
	input  wire P0_VDD_CORE_RUN_PG ,
	input  wire DAP_EXT_P0_CORE_RUN_VOLTAGE_PG,
	
	input P0_VDD_MEM_AB_12_RUN_PLUG_PRSNT ,
	input P0_VDD_MEM_CD_12_RUN_PLUG_PRSNT ,
	input P0_VDD_12_RUN_PLUG_PRSNT ,
	
	input MGMT_ASSERT_BMC_READY ,
	input MGMT_VDD_MEM_DUAL_PG ,
	input MGMT_VDD_VPP_DUAL_PG ,
	input MGMT_VDD_CORE_DUAL_PG ,
	input VDD_33_DUAL_PG ,

	input P0_VDD_MEM_AB_SUS_VRHOT_L ,
	input P0_VDD_MEM_CD_SUS_VRHOT_L ,
	input P0_VDD_CORE_RUN_VRHOT_L ,
	input P0_VDD_SOC_RUN_VRHOT_L ,
	input FPGA_P0_THERMTRIP_L ,
	input wire SENSOR_THERM_L,
	output wire FPGA_SLT_SBTSI_THERMTRIP_L ,
	input P0_33_PWROK ,
	input wire ATX_PWR_OK,
	input wire PWR_BTN_L,
	input wire BOARD_TYPE,
	input wire P0_SLP_S5_L,
	input wire P0_SLP_S3_L,
	input wire P0_PRESENT_L,

	output wire ATX_PS_ON, 
	output reg P0_RSMRST_L, 		
	output wire FPGA_5_DUAL_EN ,
	output reg FPGA_P0_PWROK_RESET_BUF_EN_L ,
	
	input wire GLOBAL_FORCE_ON , 
	input wire CPU_ORIENT_GOOD ,  
	output wire ERROR ,
	output reg [31:0] LED7SEG_ERROR_CODE,
	output wire FINAL_PWRGD,
	output reg group_2_pg,
	input wire pwr_cycle_pwr_on,
	input wire dap_bypass,
	output wire DEBUG_STATE

);

parameter LED_CHAR_0			= 8'h00;
parameter LED_CHAR_1			= 8'h01;
parameter LED_CHAR_5			= 8'h05;
parameter LED_CHAR_A			= 8'h0A;
parameter LED_CHAR_E			= 8'h0E;
parameter LED_CHAR_BLANK 	= 8'h10; 
parameter LED_CHAR_h 		= 8'h11;
parameter LED_CHAR_H 		= 8'h12;
parameter LED_CHAR_L 		= 8'h13; 
parameter LED_CHAR_P 		= 8'h14; 
parameter LED_CHAR_t 		= 8'h15; 
parameter LED_CHAR_u 		= 8'h16; 
parameter LED_CHAR_Udot		= 8'h3A;
parameter LED_CHAR_y 		= 8'h17;
parameter LED_CHAR_r 		= 8'h18; 
parameter LED_CHAR_hypen 	= 8'h19; 
parameter LED_CHAR_udot 		= 8'h36; 
//
//parameters to help during debug. used to force a rail ON or OFF more easy.
parameter FORCE_VDD_18_RUN_EN	=	1'b0;
parameter FORCE_VDD_18_DUAL_EN	=	1'b0;
parameter FORCE_VDD_CORE_RUN_EN 	=	1'b0;	
parameter FORCE_VDD_SOC_DUAL_EN	=	1'b0;
parameter FORCE_VDD_SOC_RUN_EN 	=	1'b1;
parameter FORCE_VDD_MEM_AB_SUS_EN	=	1'b0;
parameter FORCE_VDD_SPD_AB_SUS_EN	=	1'b0;
parameter FORCE_VDD_MEM_VPP_AB_SUS_EN	=	1'b0;
parameter FORCE_VDD_MEM_VTT_AB_SUS_EN	=	1'b0;
parameter FORCE_VDD_MEM_CD_SUS_EN	=	1'b0;
parameter FORCE_VDD_SPD_CD_SUS_EN	=	1'b0;
parameter FORCE_VDD_MEM_VPP_CD_SUS_EN	=	1'b0;
parameter FORCE_VDD_MEM_VTT_CD_SUS_EN 	=	1'b0;

parameter FORCE_FPGA_5_DUAL_EN 	=	1'b0;	
parameter FORCE_ATX_PS_ON	=	1'b0;	

//============== STATE ========================
parameter STATE_OFF 						= 5'd0;
parameter STATE_WAIT						= 5'd1;
parameter STATE_ATX_ON 					= 5'd2;
parameter STATE_ENABLE_GROUP_A_S5 	= 5'd3;
parameter STATE_CHECK_PG_GROUP_A_S5 = 5'd4;
parameter STATE_WAITFOR_GROUP_B_S3	= 5'd5;
parameter STATE_ENABLE_GROUP_B_S3	= 5'd6;
parameter STATE_CHECK_PG_GROUP_B_S3 = 5'd7;
parameter STATE_WAITFOR_GROUP_C_S0 	= 5'd8;
parameter STATE_ENABLE_GROUP_C_S0 	= 5'd9;
parameter STATE_CHECK_PG_GROUP_C_S0 = 5'd10;
parameter STATE_FULL_ON					= 5'd11;
parameter STATE_ATX_ON_WAIT 			= 5'd12;
parameter STATE_ENABLE_ATX 			= 5'd13;
parameter STATE_CHECK_PG_ATX 			= 5'd14;
parameter STATE_ENABLE_GROUP_B_S0 	= 5'd15;
parameter STATE_CHECK_PG_GROUP_B_S0 = 5'd16;
parameter STATE_POWER_S3 				= 5'd17;
parameter STATE_POWER_S5 				= 5'd18;
parameter STATE_ERROR 					= 5'd30;
parameter STATE_31_UNKNOWN 			= 5'd31;

parameter WAIT_1MS		= 8'd5;

parameter DELAY_10MSEC	= 8'd50;//at 5 KHz => 200uSec * 50 = 10 msec

parameter BOARD_STANDARD	=	1'b0;	
parameter BOARD_ATE			=	1'b1;	
///////////////////////////////////////////////////////////////////////////////////////////////////////////

//Group-A-S5
reg P0_VDD_18_DUAL_EN_reg;
reg P0_VDD_SOC_DUAL_EN_reg; 

//Group-B-S3
reg P0_VDD_MEM_AB_SUS_EN_reg; 
reg P0_VDD_SPD_AB_SUS_EN_reg; 
reg P0_VDD_MEM_VPP_AB_SUS_EN_reg; 
reg P0_VDD_MEM_VTT_AB_SUS_EN_reg; 
reg P0_VDD_SPD_CD_SUS_EN_reg; 
reg P0_VDD_MEM_CD_SUS_EN_reg; 
reg P0_VDD_MEM_VPP_CD_SUS_EN_reg; 
reg P0_VDD_MEM_VTT_CD_SUS_EN_reg; 

//Group-B-S0
reg P0_VDD_18_RUN_EN_reg;
reg ATX_PS_ON_reg;
reg FPGA_5_DUAL_EN_reg;

//Group-C-S0
reg P0_VDD_SOC_RUN_EN_reg; 
reg P0_VDD_CORE_RUN_EN_reg;

reg reg_FPGA_SLT_SBTSI_THERMTRIP_L = 1'b1;
reg [9:0] startup_delay_counter = 10'b0;
reg startup_delay_counter_done = 1'b0;
reg [7:0] rsmrst_delay_counter = 8'b0;
reg rsmrst_delay_counter_done = 1'b0;

reg [9:0]physical_pg_delay_counter ;
reg physical_pg_delay_counter_done ;
				
reg group_1_pg = 1'b0;
reg group_2_en = 1'b0;
//reg group_2_pg = 1'b0;
reg group_3_en = 1'b0;
reg group_3_mem_ab_pg = 1'b0;
reg group_3_mem_cd_pg = 1'b0;
reg group_3_pg = 1'b0;
reg group_4_en = 1'b0;
reg group_4_pg = 1'b0;
reg group_5_en = 1'b0;
reg group_5_pg = 1'b0;
reg group_6_en = 1'b0;
reg group_6_pg = 1'b0;

reg physical_pg ;
reg pwr_btn_pressed;
reg reg_pwr_btn_L_1;

//flag that indicates an error in power sequencing
reg error_reg;

//counts a 8-bit value to delay the next rail
reg [7:0] delay_counter;

reg  seq_clk;
reg [22:0] seq_clk_reg;

(* fsm_encoding = "user" *) reg [4:0] state;
(* fsm_encoding = "user" *) reg [4:0] state_after_wait;

reg p0_mem_ab_pwr_plug_prsnt;
reg p0_mem_cd_pwr_plug_prsnt;
reg p0_core_pwr_plug_prsnt;
reg p0_vdd_core_run_pg_filt;
reg p0_vdd_core_run_en_filt;
reg p0_vdd_soc_run_pg_filt;

reg bmc_ready ;

reg error_byte1;
reg error_byte0;

reg fake_s3 = 1'b0;

assign ERROR = error_reg;
assign FINAL_PWRGD = physical_pg;

assign P0_VDD_18_RUN_EN = ( P0_VDD_18_RUN_EN_reg   & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON ;
assign P0_VDD_18_DUAL_EN = (P0_VDD_18_DUAL_EN_reg & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON ; //Group-A
assign P0_VDD_SOC_DUAL_EN = (P0_VDD_SOC_DUAL_EN_reg   & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON ; //Group-A
assign P0_VDD_MEM_AB_SUS_EN = ( P0_VDD_MEM_AB_SUS_EN_reg  & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON  ; //Group-C
assign P0_VDD_SPD_AB_SUS_EN = ( P0_VDD_SPD_AB_SUS_EN_reg  & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON ; //Group-C
assign P0_VDD_MEM_VPP_AB_SUS_EN = ( P0_VDD_MEM_VPP_AB_SUS_EN_reg  & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON  ; //Group-C
assign P0_VDD_MEM_VTT_AB_SUS_EN = ( P0_VDD_MEM_VTT_AB_SUS_EN_reg  & CPU_ORIENT_GOOD )  | GLOBAL_FORCE_ON ; //Group-C
assign P0_VDD_SPD_CD_SUS_EN = ( P0_VDD_SPD_CD_SUS_EN_reg  & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON ; //Group-C
assign P0_VDD_MEM_CD_SUS_EN = ( P0_VDD_MEM_CD_SUS_EN_reg  & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON  ; //Group-C
assign P0_VDD_MEM_VPP_CD_SUS_EN = ( P0_VDD_MEM_VPP_CD_SUS_EN_reg  & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON  ; //Group-C
assign P0_VDD_MEM_VTT_CD_SUS_EN = ( P0_VDD_MEM_VTT_CD_SUS_EN_reg  & CPU_ORIENT_GOOD )  | GLOBAL_FORCE_ON ; //Group-C
assign P0_VDD_SOC_RUN_EN = ( P0_VDD_SOC_RUN_EN_reg  & CPU_ORIENT_GOOD )  | GLOBAL_FORCE_ON ; //Group-D
assign P0_VDD_CORE_RUN_EN = ( P0_VDD_CORE_RUN_EN_reg  & CPU_ORIENT_GOOD )  | GLOBAL_FORCE_ON ; //Group-D
assign FPGA_5_DUAL_EN 	= ( FPGA_5_DUAL_EN_reg & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON ; //Group-D
assign ATX_PS_ON 			= ( ATX_PS_ON_reg & CPU_ORIENT_GOOD ) | GLOBAL_FORCE_ON ;

//Generate a lower frequency clock for driving the power sequencing statemachine
//TODO: may be redundant now. cleanup in next version.
always @(posedge clk_24MHz) 
	begin
			seq_clk_reg[22:0] <= seq_clk_reg[22:0] + 1'b1 ;
			seq_clk <= seq_clk_reg[18];		
	end // always


//just latch the BMC_READY signal when the board is powering for first time.
//if FPGA is reset, we may not get BMC ready again.
always @(posedge seq_clk)
	begin
			bmc_ready <= MGMT_ASSERT_BMC_READY;
	end


///////  power plug filtering (using SW3)  ////////
always @ (posedge clk_5kHz)	
	begin
		p0_mem_ab_pwr_plug_prsnt <= (P0_VDD_MEM_AB_12_RUN_PLUG_PRSNT | OVERRIDE_PWR_PLUG_PRSNT);
		p0_mem_cd_pwr_plug_prsnt <= (P0_VDD_MEM_CD_12_RUN_PLUG_PRSNT | OVERRIDE_PWR_PLUG_PRSNT);
		p0_core_pwr_plug_prsnt   <= (P0_VDD_12_RUN_PLUG_PRSNT  | ~OVERRIDE_PWR_PLUG_PRSNT);
	end

reg sensor_thermal_error = 1'b0;
reg p0_mem_ab_thermal_error  = 1'b0;
reg p0_mem_cd_thermal_error  = 1'b0;
reg p0_core_thermal_error  = 1'b0;
reg p0_soc_thermal_error  = 1'b0;
reg p0_thermtrip_error  = 1'b0;

///////  thermal error filtering  //////	
//VERIFY the SOC related points	
always @ (posedge clk_5kHz)  
	begin
		sensor_thermal_error <= ~SENSOR_THERM_L & ATX_PS_ON;
		p0_mem_ab_thermal_error <= ~P0_VDD_MEM_AB_SUS_VRHOT_L & (P0_VDD_MEM_AB_SUS_EN | P0_VDD_MEM_VPP_AB_SUS_EN);
		p0_mem_cd_thermal_error <= ~P0_VDD_MEM_CD_SUS_VRHOT_L & (P0_VDD_MEM_CD_SUS_EN | P0_VDD_MEM_VPP_CD_SUS_EN);
		p0_core_thermal_error <= ~P0_VDD_CORE_RUN_VRHOT_L & P0_VDD_CORE_RUN_EN;
		p0_soc_thermal_error <= ~P0_VDD_SOC_RUN_VRHOT_L & P0_VDD_SOC_RUN_EN; 
		p0_thermtrip_error <= ~FPGA_P0_THERMTRIP_L & ~P0_PRESENT_L & P0_33_PWROK;
	end	

assign FPGA_SLT_SBTSI_THERMTRIP_L = reg_FPGA_SLT_SBTSI_THERMTRIP_L;
always @ (posedge p0_thermtrip_error)
	begin
		reg_FPGA_SLT_SBTSI_THERMTRIP_L <= 1'b0;
	end
	
//use the same clock as used for state-machine
always @ (posedge clk_5kHz) begin
	reg_pwr_btn_L_1 <= PWR_BTN_L;                       //---\_____ [PWR_BTN_L]
	pwr_btn_pressed <= (~PWR_BTN_L) & reg_pwr_btn_L_1 ; //-----\___ [PWR_BTN_L_1]
end

//////// physical pg delay  ////////////	
always @ (posedge clk_5kHz)
	begin
		if (~group_6_pg)
			begin
				physical_pg_delay_counter <= 8'h0;
				physical_pg_delay_counter_done <= 1'b0;
			end
		else if (physical_pg_delay_counter < 8'hFE)  // 50ms delay
			begin
				physical_pg_delay_counter <= physical_pg_delay_counter + 1;
				physical_pg_delay_counter_done <= 1'b0;
			end
		else
			begin
				physical_pg_delay_counter <= 8'hFF;
				physical_pg_delay_counter_done <= 1'b1;
			end
end//physical pg delay
	
//Mux for bypassing CORE/SOC powergoods in DAP mode.	
always @ (posedge clk_5kHz) begin
		if (dap_bypass == 1'b1) 
			begin
			//Bypassed CORE & SOC used by DAP
				p0_vdd_core_run_en_filt <= P0_VDD_SOC_RUN_EN & P0_VDD_SOC_RUN_PG;
				p0_vdd_core_run_pg_filt <= DAP_EXT_P0_CORE_RUN_VOLTAGE_PG;
				p0_vdd_soc_run_pg_filt  <= DAP_EXT_P0_CORE_RUN_VOLTAGE_PG;
			end		
		else
			begin
			//Normal mode.
				p0_vdd_core_run_en_filt <= P0_VDD_CORE_RUN_EN;
				p0_vdd_core_run_pg_filt <= P0_VDD_CORE_RUN_PG;
				p0_vdd_soc_run_pg_filt <= P0_VDD_SOC_RUN_PG;
			end
end

//Power-good
always @(posedge clk_5kHz) begin

		if(Reset == 1'b1) begin
			group_1_pg <= 1'b0;
			group_2_pg <= 1'b0;
			group_3_mem_ab_pg <= 1'b0;
			group_3_mem_cd_pg <= 1'b0;
			group_3_pg <= 1'b0;
			group_4_pg <= 1'b0;
			group_5_pg <= 1'b0;
			group_6_pg <= 1'b0;
	
			physical_pg <= 1'b0;
			FPGA_5_DUAL_EN_reg <= 1'b0 ;
		end
		else begin
			//group_1 = Group-A_S5
			group_1_pg <= VDD_33_DUAL_PG & MGMT_VDD_VPP_DUAL_PG & MGMT_VDD_MEM_DUAL_PG & MGMT_VDD_CORE_DUAL_PG  & startup_delay_counter_done;//& p0_present	& bmc_ready & ~fpga_brd_id_error 
			//group_2 = Group-A_S5
			group_2_pg <= P0_VDD_18_DUAL_PG & P0_VDD_SOC_DUAL_PG ;
			//group_3 = Group-B_S3
			group_3_mem_ab_pg <= P0_VDD_SPD_AB_SUS_PG &  P0_VDD_MEM_VPP_AB_SUS_PG &  P0_VDD_MEM_AB_SUS_PG  & P0_VDD_MEM_VTT_AB_SUS_PG ;
			group_3_mem_cd_pg <= P0_VDD_SPD_CD_SUS_PG &  P0_VDD_MEM_VPP_CD_SUS_PG &  P0_VDD_MEM_CD_SUS_PG  & P0_VDD_MEM_VTT_CD_SUS_PG ;
			group_3_pg <= group_3_mem_ab_pg & group_3_mem_cd_pg ;
			//group_4 = Group-B_S3
			group_4_pg <= ATX_PWR_OK & p0_mem_ab_pwr_plug_prsnt &  p0_mem_cd_pwr_plug_prsnt &  p0_core_pwr_plug_prsnt ;
			//group_5 = Group-B_S0
			group_5_pg <= P0_VDD_18_RUN_PG ;
			//group_6 = Group-C_S0
			group_6_en <= group_5_pg & group_5_en;
			group_6_pg <= p0_vdd_core_run_pg_filt & p0_vdd_soc_run_pg_filt ;//P0_VDD_SOC_RUN_PG  & 
			
			physical_pg <= group_1_pg & group_2_pg & group_3_pg & group_4_pg & group_5_pg & group_6_pg & physical_pg_delay_counter_done;
			
			FPGA_5_DUAL_EN_reg <= ATX_PWR_OK;
		end
		
end // always		


// ===========  startup delay  ===============
always @ (posedge clk_5kHz)
	begin
		if (startup_delay_counter < 10'h3E8)  // 200ms delay
			begin
				startup_delay_counter <= startup_delay_counter + 1;
				startup_delay_counter_done <= 1'b0;
			end
		else
			begin
				startup_delay_counter <= 10'h3E9;
				startup_delay_counter_done <= 1'b1;
			end
end //always @ (posedge clk_5kHz)


//============= RSMRST delay  ==================	
always @ (posedge clk_5kHz) begin
	if(Reset == 1'b1) begin
		P0_RSMRST_L <= 1'b0;
		rsmrst_delay_counter_done <= 1'b0;
		rsmrst_delay_counter <= 8'h0;
	end
	else begin
		P0_RSMRST_L <= rsmrst_delay_counter_done ;
		
			if(group_2_pg == 1'b1)	begin
				//group_2_pg == 1
				 if(rsmrst_delay_counter < 8'hFE)  // 50ms delay: 250 * 200 usec period
					begin
						rsmrst_delay_counter <= rsmrst_delay_counter + 1;
						rsmrst_delay_counter_done <= 1'b0;
					end
				else
					begin
						rsmrst_delay_counter <= 8'hFF;
						rsmrst_delay_counter_done <= 1'b1;
					end		
			end 
			else begin
				//group_2_pg == 0
				rsmrst_delay_counter_done <= 1'b0;
				rsmrst_delay_counter <= 8'h0;
			end //if(group_2_pg == 1)			
	end//reset
end //always @ (posedge clk_5kHz)	

//=============== PWROK_RESET_BUF_EN  ==================	
always @(posedge seq_clk) begin
	FPGA_P0_PWROK_RESET_BUF_EN_L = ~physical_pg;
end

//===================================================================	
//	Power sequence statemachine
//===================================================================	
always @(posedge clk_5kHz) begin
		if(Reset == 1'b1) begin
			
			error_reg <= 1'b0;
			
			LED7SEG_ERROR_CODE[31:0] <= {8'h00, 8'h0F, 8'h0F, 8'h30} ; //OFF {0 F F .}
			
			ATX_PS_ON_reg <= 1'b0;
			state <= STATE_OFF;
			state_after_wait <= STATE_OFF;
			delay_counter[7:0] <= 8'h00;

			P0_VDD_18_RUN_EN_reg <= 1'b0;
			P0_VDD_18_DUAL_EN_reg <= 1'b0;
			P0_VDD_SOC_DUAL_EN_reg <= 1'b0;
			P0_VDD_CORE_RUN_EN_reg <= 1'b0;
			P0_VDD_SOC_RUN_EN_reg <= 1'b0;
			P0_VDD_MEM_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_CD_SUS_EN_reg <= 1'b0;
			P0_VDD_SPD_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_SPD_CD_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VPP_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VPP_CD_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VTT_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VTT_CD_SUS_EN_reg <= 1'b0;
			
		end //Reset
		
		else begin
		
	
		case (state[4:0])
      
		STATE_OFF : begin 
	
			P0_VDD_18_DUAL_EN_reg <= 1'b0;
			P0_VDD_18_RUN_EN_reg <= 1'b0;
			P0_VDD_SOC_DUAL_EN_reg <= 1'b0;
			P0_VDD_CORE_RUN_EN_reg <= 1'b0;
			P0_VDD_SOC_RUN_EN_reg <= 1'b0;
			P0_VDD_SPD_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_SPD_CD_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_CD_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VPP_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VPP_CD_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VTT_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VTT_CD_SUS_EN_reg <= 1'b0;
			
			//used to store the one-hot power good status during error condition.Debug variable; currently not used.
			error_byte1 <= 8'h00;
			error_byte0 <= 8'h00;
			
			delay_counter[7:0] <= DELAY_10MSEC;
			LED7SEG_ERROR_CODE[31:0] <= {8'h00, 8'h0F, 8'h0F, 8'h30} ; //OFF {0 F F .}
			
			if(BOARD_TYPE == BOARD_ATE ) begin
			
				//If ATE board, do not powerup untill user hits pwr button. Wait indefinetely.
				if( pwr_btn_pressed == 1'b1) begin
					state <= STATE_ENABLE_GROUP_A_S5;	
				end	
				else begin	
					state <= STATE_OFF;
				end
				
			end
			else begin
				//For non ATE boards, enable powering up as soon as ATX is on
				state <= STATE_ENABLE_GROUP_A_S5;	
			end
			
      end//STATE_OFF
		
		 STATE_ENABLE_GROUP_A_S5 : begin
			 
			 LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h00, 8'h03} ; //"P u 0 3" (Redundant display message)
			 
			 P0_VDD_18_DUAL_EN_reg  <= 1'b1;
			 P0_VDD_SOC_DUAL_EN_reg <= 1'b1;
			 
			 //set the wait some 10 msec after enabling them for supplies to stablize.
			 //Note: STATE_WAIT may be redundant. delete this state in later versions.
			 delay_counter[7:0] <= DELAY_10MSEC;
			 state <= STATE_WAIT;
			 
			 //set the next state after the wait
			 state_after_wait <= STATE_CHECK_PG_GROUP_A_S5;
			 
      end //STATE_ENABLE_GROUP_A_S5
		
		STATE_CHECK_PG_GROUP_A_S5 : begin
			 
			 LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h01, {6'b0, P0_VDD_18_DUAL_PG, P0_VDD_SOC_DUAL_PG }} ; //"P u 1 x"

			 if( (P0_VDD_18_DUAL_PG == 1'b1) && (P0_VDD_SOC_DUAL_PG == 1'b1) )begin
				//all is ok. Go to next state depending on next "trigger" SLP_S5 ?
				state <= STATE_WAITFOR_GROUP_B_S3;
				error_reg <= 1'b0;
			 end
			 else begin
				//one of the PG is not received; keep waiting indefinetely. 
				error_reg <= 1'b1;
				state <= STATE_CHECK_PG_GROUP_A_S5;
			 end
      end //STATE_CHECK_PG_GROUP_A_S5
		
		STATE_WAITFOR_GROUP_B_S3 : begin  //Wait for S5/S3 signals
		
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0B, 8'h01 } ; //"P u B 1" (Redundant display message)
		
			 if( ( P0_SLP_S5_L == 1'b0) )begin 
			  //SLP_S5_L asserted, Go to S-5 state
				//LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_BLANK, 8'h05, LED_CHAR_hypen, 8'h05} ; //{  S - 5}
				state <= STATE_POWER_S5;
			 end
			 else begin 
			 
				if( ( P0_SLP_S3_L == 1'b0) )begin 
				  //SLP_S5_L deasserted; SLP_S3_L asserted. Go to S-3 state
					//LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_BLANK, 8'h05, LED_CHAR_hypen, 8'h03} ; //{  S - 3}
					state <= STATE_POWER_S3;
				end
				else begin
				  //De-asserted SLP_S5 & S3, proceed with powerup.
					state <= STATE_ENABLE_GROUP_B_S3;
				end
	
			 end
      end //STATE_WAITFOR_GROUP_B_S3 
		
		 STATE_ENABLE_GROUP_B_S3 : begin  //
				LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0B, 8'h02 } ; //"P u B 2" (Redundant display message)
				////////////////////////////////////////////////////////////////////////
				//TODO: temporary fix as S3 is not working on Octane Rev-00A.
				//unless the ATX is powered on , the MEM_[AB/CD]_SUS rails will not power on 
				ATX_PS_ON_reg <= 1'b1;//TODO: Hardcoded to fix board issue.
				//on Rev-C boards,  need to adjust Vin threshold of the regulator to 4 V or so.
				////////////////////////////////////////////////////////////////////////
				
				P0_VDD_MEM_AB_SUS_EN_reg <= 1'b1;
				P0_VDD_MEM_CD_SUS_EN_reg <= 1'b1;

				P0_VDD_SPD_AB_SUS_EN_reg <= 1'b1;
				P0_VDD_SPD_CD_SUS_EN_reg <= 1'b1;

				P0_VDD_MEM_VPP_AB_SUS_EN_reg <= 1'b1;
				P0_VDD_MEM_VPP_CD_SUS_EN_reg <= 1'b1;

				P0_VDD_MEM_VTT_AB_SUS_EN_reg <= 1'b1;
				P0_VDD_MEM_VTT_CD_SUS_EN_reg <= 1'b1;

				//set the wait duration after PS_on for supplies to stablize
				delay_counter[7:0] <= DELAY_10MSEC;
				state <= STATE_WAIT;

				//set the next state after the wait
				state_after_wait <= STATE_CHECK_PG_GROUP_B_S3;
			end //STATE_ENABLE_GROUP_B_S3
		
		STATE_CHECK_PG_GROUP_B_S3 : begin  //"P U. A B" (Note the capital 'U' to differentate between other codes.
			 LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_Udot,
			 {4'h0, P0_VDD_MEM_AB_SUS_PG, P0_VDD_MEM_VPP_AB_SUS_PG ,P0_VDD_SPD_AB_SUS_PG , P0_VDD_MEM_VTT_AB_SUS_PG }, 
			 {4'h0, P0_VDD_MEM_CD_SUS_PG, P0_VDD_MEM_VPP_CD_SUS_PG ,P0_VDD_SPD_CD_SUS_PG , P0_VDD_MEM_VTT_CD_SUS_PG  } } ; //"P U. A B"
			
  			 if( (P0_VDD_MEM_AB_SUS_PG == 1'b1) &&
				  (P0_VDD_MEM_CD_SUS_PG == 1'b1) &&
				  (P0_VDD_SPD_AB_SUS_PG == 1'b1) &&
				  (P0_VDD_SPD_CD_SUS_PG == 1'b1) &&
				  (P0_VDD_MEM_VPP_AB_SUS_PG == 1'b1) &&
				  (P0_VDD_MEM_VPP_CD_SUS_PG == 1'b1) &&
				  (P0_VDD_MEM_VTT_AB_SUS_PG == 1'b1) &&
				  (P0_VDD_MEM_VTT_CD_SUS_PG == 1'b1)
				  )begin
				//all is ok. Go to next state depending on next "trigger" SLP_S3 ?
				state <= STATE_ENABLE_ATX;
				error_reg <= 1'b0;
			 end
			 else begin
				//one of the PG is not received; keep waiting indefinetely.
				error_reg <= 1'b1;
				state <= STATE_CHECK_PG_GROUP_B_S3;
			 end
      end //STATE_CHECK_PG_GROUP_B_S3
		
		STATE_ENABLE_ATX : begin
			 	LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0C, 8'h01 } ; //"P u C 1" (Redundant display message)
				//switch on the ATX
				ATX_PS_ON_reg <= 1'b1;	
				//set the wait duration after PS_on for supplies to stablize
				delay_counter[7:0] <= DELAY_10MSEC;
				state <= STATE_WAIT;

				//set the next state after the wait
				state_after_wait <= STATE_CHECK_PG_ATX;
		end //STATE_ENABLE_ATX
		
		STATE_CHECK_PG_ATX : begin
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0A, 8'h00 } ; //"P u A 0" (ATX PSON failed ! )
			 
			 if( ATX_PWR_OK == 1'b1 )begin
				state <= STATE_ENABLE_GROUP_B_S0;
				error_reg <= 1'b0;
			 end
			 else begin
				//ATX Powergood is not received; wait indefinetely.
				error_reg <= 1'b1;
				state <= STATE_CHECK_PG_ATX;
			 end

      end //STATE_CHECK_PG_ATX
		
		STATE_ENABLE_GROUP_B_S0 : begin 

			//set the wait duration after PS_on for supplies to stablize
			delay_counter[7:0] <= WAIT_1MS;
				
			if( P0_SLP_S3_L == 1'b1 )begin 
				LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_BLANK, 8'h05, LED_CHAR_hypen, 8'h03} ; //{  S - 3}
				//Note: With ATX ON, the P0_VDD_33_RUN which is generated by ATX is also active. no seperate enable needed for 33_RUN.
			 	P0_VDD_18_RUN_EN_reg <= 1'b1;
				state <= STATE_WAIT;
				//set the next state after the wait
				state_after_wait <= STATE_CHECK_PG_GROUP_B_S0;
			 end
			 else begin
				LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0C, 8'h03 } ; //"P u C 3"
				state <= STATE_ENABLE_GROUP_B_S0;
			 end//if (P0_SLP_S3_L == 1'b1 )
				
		end //STATE_ENABLE_GROUP_B_S0
			
		STATE_CHECK_PG_GROUP_B_S0 : begin  //
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0C, 8'h05 } ; //"P u C 5"
			 
			 if( P0_VDD_18_RUN_PG == 1'b1  )begin
				error_reg <= 1'b0;
				state <= STATE_ENABLE_GROUP_C_S0;
			 end
			 else begin
				//one of the PG is not received; wait indefinetely.
				error_reg <= 1'b1;
				state <= STATE_CHECK_PG_GROUP_B_S0;
			 end

      end //STATE_CHECK_PG_GROUP_B_S0
				
		STATE_ENABLE_GROUP_C_S0 : begin
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0C, 8'h06 } ; //"P u C 6" (Redundant display message)

			//essentially a NOT of dap_bypass. TODO: Need to make this logic combinational for better user experience.
			P0_VDD_CORE_RUN_EN_reg <= (dap_bypass == 1'b1) ? 1'b0 :  1'b1;
			P0_VDD_SOC_RUN_EN_reg <= 1'b1;

			delay_counter[7:0] <= DELAY_10MSEC;
			state <= STATE_WAIT;

			//set the next state after the wait
			state_after_wait <= STATE_CHECK_PG_GROUP_C_S0;
			 
		end //STATE_ENABLE_GROUP_C_S0
			 
		STATE_CHECK_PG_GROUP_C_S0 : begin
		
			 LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, 8'h0C, {6'b000010, p0_vdd_core_run_pg_filt, p0_vdd_soc_run_pg_filt } } ; //"P u C x"; x=8/9/A
			 
			 if( (p0_vdd_core_run_pg_filt == 1'b1) && (p0_vdd_soc_run_pg_filt == 1'b1)  )begin 
				error_reg <= 1'b0;
				state <= STATE_FULL_ON;
			 end
			 else begin
				//one of the PG is not received; keep waiting indefinetely.
				error_reg <= 1'b1;
				state <= STATE_CHECK_PG_GROUP_C_S0;
			 end
			 
      end // STATE_CHECK_PG_GROUP_C_S0
		
		STATE_FULL_ON : begin

				if( P0_SLP_S5_L == 1'b0 ) begin //S5 asserted, go to S5 state 				
					state <= STATE_POWER_S5;   
				end
				else  begin
				
					if( P0_SLP_S3_L == 1'b0 ) begin  //S3 asserted, go to S3 state 
						state <= STATE_POWER_S3;   
					end
					else begin // Both S5/S3 deasserted, continue in Full on
						LED7SEG_ERROR_CODE[31:0] <= {8'h00, 8'h00, 8'h00, 8'h00} ; //{0 0 0 0}
						state <= STATE_FULL_ON;
					end
					
				end//SLP_S3	
			
		end // STATE_FULL_ON
		
		STATE_POWER_S3 : begin 
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_BLANK, 8'h05, LED_CHAR_hypen, 8'h03} ; //{  S - 3}
		
			//NOTE: ATX needs to be switched off in S3.
			ATX_PS_ON_reg <= 1'b0;
			
			P0_VDD_CORE_RUN_EN_reg <= 1'b0;
			P0_VDD_SOC_RUN_EN_reg <= 1'b0;
			P0_VDD_18_RUN_EN_reg <= 1'b0;
				
			if( P0_SLP_S5_L == 1'b0 ) begin //S5 too is asserted, go to S5 state
				state <= STATE_POWER_S5; 
			end
			else if( P0_SLP_S3_L == 1'b0 ) begin  						
				state <= STATE_POWER_S3;   
			end
			else begin
				state <= STATE_ENABLE_ATX;
			end
			
		end //STATE_POWER_S3

		STATE_POWER_S5 : begin  //
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_BLANK, 8'h05, LED_CHAR_hypen, 8'h05} ; //{  S - 5}
		
			P0_VDD_CORE_RUN_EN_reg <= 1'b0;
			P0_VDD_SOC_RUN_EN_reg <= 1'b0;
			P0_VDD_18_RUN_EN_reg <= 1'b0;
				
			P0_VDD_MEM_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_CD_SUS_EN_reg <= 1'b0;

			P0_VDD_SPD_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_SPD_CD_SUS_EN_reg <= 1'b0;

			P0_VDD_MEM_VPP_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VPP_CD_SUS_EN_reg <= 1'b0;

			P0_VDD_MEM_VTT_AB_SUS_EN_reg <= 1'b0;
			P0_VDD_MEM_VTT_CD_SUS_EN_reg <= 1'b0;
			
			ATX_PS_ON_reg <= 1'b0;	
			
			if( P0_SLP_S5_L == 1'b0 ) 
				begin
					state <= STATE_POWER_S5; 
				end
			else
				begin
					state <= STATE_ENABLE_GROUP_B_S3;
				end
			
		end //STATE_POWER_S5
		
		STATE_WAIT : begin  //Generic wait state
		//TODO: this state too appears redundant and can probably be deleted.
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, LED_CHAR_u, LED_CHAR_hypen, LED_CHAR_hypen} ; //{P u - -}
			//decrement till 0 
			delay_counter[7:0] <= delay_counter[7:0] - 1'b1;
			 
			 //wait for known duration
			 if(delay_counter[7:0] == 8'h00) begin
				state <= state_after_wait;
			 end 
			 else begin
				state <= STATE_WAIT;
			 end
			
       end //STATE_WAIT
		
		STATE_ERROR : begin  //Get stuck in the wait till user hits reset.
			LED7SEG_ERROR_CODE[31:0] <= {LED_CHAR_P, 8'h0E, 8'h18, 8'h18} ; //{P E r r}
			//TODO: add a timer after which it disables all enables and goes to power OFF
			state <= STATE_ERROR;
		end
		
		
		default : begin  // unknown state. something went bad. go back to OFF
			state <= STATE_OFF;
      end
		
		endcase
		end // if(Reset)
	end // always
	
endmodule
