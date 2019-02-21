`timescale 1ns / 1ps             
/*****************************************************************************
//
// Description:   clocks.v
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

module clocks(

	//inputs
	input clk_24MHz,

	//outputs
	output reg clk_2Hz,
	output reg clk_50Hz,
	output reg clk_5kHz,
	output reg clk_800kHz,
	output reg clk_1600kHz
);

reg [15:0] big_counter = 16'h0;
reg [10:0] small_counter = 11'h0;
reg [10:0] counter_50Hz = 11'h0;
reg [3:0] counter_1600kHz = 4'h0;

	
always @ (posedge clk_24MHz)
	begin	
		if(big_counter [15:0] > 12'd2400)//2400
			begin
				big_counter [15:0] <= 12'h0;
				clk_5kHz <= ~clk_5kHz;
			end
		else
			begin
				big_counter [15:0] <= big_counter [15:0] + 1;
			end
	end	
	
	
always @ (posedge clk_5kHz)
	begin	
		if(small_counter [10:0] > 11'h4E2)
			begin
				small_counter [10:0] <= 11'h0;
				clk_2Hz <= ~clk_2Hz;
			end
		else
			begin
				small_counter [10:0] <= small_counter [10:0] + 1;
			end
	end	
	
		
	
always @ (posedge clk_5kHz)
	begin	
		if(counter_50Hz [10:0] > 11'h027)
			begin
				counter_50Hz [10:0] <= 11'h0;
				clk_50Hz <= ~clk_50Hz;
			end
		else
			begin
				counter_50Hz [10:0] <= counter_50Hz [10:0] + 1;
			end
end	
	
always @ (posedge clk_24MHz)
	begin
		if (counter_1600kHz == 4'h8)
			begin
				counter_1600kHz <= 0;
				clk_1600kHz <= ~clk_1600kHz;
			end
		else
			begin
				counter_1600kHz <= counter_1600kHz + 1;
			end
	end

always @ (posedge clk_1600kHz)
	begin
		clk_800kHz <= ~clk_800kHz;
	end				




endmodule
