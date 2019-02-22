/*****************************************************************************
//
// Description:   7segment_controller.v
//                
// ****************************************************************************
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
//*****************************************************************************
/****************************************************************************
 *
 * bit[7] : undefined. Set to 0.
 * bit[6] : undefined. Set to 0.
 * bit[5] : 1=enables the "."
 * bit[4:0] : 0-9, A-F, plus special characters 
 ****************************************************************************/

`timescale 1 ns/1 ps
//`include "led_defines.h"

module leds_7seg_controller (

//	output reg debug,
  // Int Bus Inputs
  input IntClk,
//  input Reset,

  input [15:0]  data,	
  
  // LED Outputs
  output reg [6:0] LedSeg_1,
  output reg [6:0] LedSeg_2
//  output reg [6:0] LedSeg_3,
//  output reg [6:0] LedSeg_4
//  output	  LedSeg_DP_1,
//  output	  LedSeg_DP_2,
//  output	  LedSeg_DP_3,
//  output	  LedSeg_DP_4
//  output wire [3:0] LED_DIG_SEL

);

//reg [4:0] LedDataInNib;//5-bits
//reg [4:0] LedDigPre;

//reg [6:0] LedDig7Seg[3:0];

//reg LedClk;
//reg [3:0] LedDig;

//assign LED_DIG_SEL = LedDig;

//reg [23:0] scaling_counter;
//reg [7:0] segment_counter;
//reg [7:0] data_byte;

	//Generate a lower frequency clock for driving the LEDs	
/*
	always @(posedge IntClk) begin
		LedClk <= scaling_counter[10];
		scaling_counter[23:0] <= scaling_counter[23:0] + 1'b1;
	end // always
*/	
/*
	//Generate a lower frequency for driving digits
	always @(posedge IntClk) begin
		if(Reset == 1'b1) begin
			segment_counter[7:0] <= 8'h00;
			LedDig[3:0] <= 4'b0000; //deselect all;
			data_byte[7:0] <= 8'h00;
//			debug <= 1'b1;
		end
		else begin
			segment_counter[7:0] <= segment_counter[7:0] + 1'b1;
//			debug <= segment_counter[0];

			case(segment_counter[6:3])
				4'b0001 | 4'b0010 |	4'b0011 : 
					begin 
					LedDig[3:0] <= 4'b1000; //Digit 0;
					data_byte[7:0] <= data[7:0];
					end

				4'b0101 | 4'b0110 | 4'b0111 : 
					begin 
					LedDig[3:0] <= 4'b0100; //Digit 1;
					data_byte[7:0] <= data[15:8];
					end

				4'b1001 | 4'b1010 | 	4'b1011 : 
					begin 
					LedDig[3:0] <= 4'b0010; //Digit 2;
					data_byte[7:0] <= data[23:16];
					end

				4'b1101 | 4'b1110 |	4'b1111 : 
					begin 
					LedDig[3:0] <= 4'b0001; //Digit 3;
					data_byte[7:0] <= data[31:24];
					end
				
				default:
				 begin
				//very much required for blanking
					LedDig[3:0] <= 4'b0000; //Digit 0;
					data_byte[7:0] <= 5'h10;//blank
				 end
			endcase//case
		
			LedDataInNib <= data_byte[4:0];
			LedSeg_DP <= data_byte[5];
			
		end // if(Reset)
	end // always
*/
//   assign LedSeg_DP_1 = data[5];

always @(posedge IntClk) begin
    //Decode the data
    case(data[3:0])
		5'h0: LedSeg_1 = ~7'b0111111;
		5'h1: LedSeg_1 = ~7'b0000110;
		5'h2: LedSeg_1 = ~7'b1011011;
		5'h3: LedSeg_1 = ~7'b1001111;
		5'h4: LedSeg_1 = ~7'b1100110;
		5'h5: LedSeg_1 = ~7'b1101101;
		5'h6: LedSeg_1 = ~7'b1111101;
		5'h7: LedSeg_1 = ~7'b0000111;
		5'h8: LedSeg_1 = ~7'b1111111;
		5'h9: LedSeg_1 = ~7'b1101111;
		5'hA: LedSeg_1 = ~7'b1110111;
		5'hB: LedSeg_1 = ~7'b1111100;
		5'hC: LedSeg_1 = ~7'b0111001;
		5'hD: LedSeg_1 = ~7'b1011110;
		5'hE: LedSeg_1 = ~7'b1111001;
		5'hF: LedSeg_1 = ~7'b1110001;
    endcase
end
always @(posedge IntClk) begin
    //Decode the data
    case(data[7:4])
		5'h0: LedSeg_2 = ~7'b0111111;
		5'h1: LedSeg_2 = ~7'b0000110;
		5'h2: LedSeg_2 = ~7'b1011011;
		5'h3: LedSeg_2 = ~7'b1001111;
		5'h4: LedSeg_2 = ~7'b1100110;
		5'h5: LedSeg_2 = ~7'b1101101;
		5'h6: LedSeg_2 = ~7'b1111101;
		5'h7: LedSeg_2 = ~7'b0000111;
		5'h8: LedSeg_2 = ~7'b1111111;
		5'h9: LedSeg_2 = ~7'b1101111;
		5'hA: LedSeg_2 = ~7'b1110111;
		5'hB: LedSeg_2 = ~7'b1111100;
		5'hC: LedSeg_2 = ~7'b0111001;
		5'hD: LedSeg_2 = ~7'b1011110;
		5'hE: LedSeg_2 = ~7'b1111001;
		5'hF: LedSeg_2 = ~7'b1110001;
    endcase
end
    
endmodule
