Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:53423 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbcBCObN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Feb 2016 09:31:13 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v2 4/4] iio: ad5755: Add full DT binding documentation
Date: Wed, 3 Feb 2016 15:31:04 +0100
Message-ID: <1454509864-32285-4-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1454509864-32285-3-git-send-email-sean.nyekjaer@prevas.dk>
References: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-3-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Changes since v1:
- this patch added

 .../devicetree/bindings/iio/dac/ad5755.txt         | 83 ++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
index 4c91583..3aac20d 100644
--- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
@@ -15,10 +15,93 @@ Recommended properties:
  - spi-max-frequency: Definition as per
 		Documentation/devicetree/bindings/spi/spi-bus.txt
 
+Optional properties:
+See include/dt-bindings/iio/ad5755.h
+ - adi,ext_dc_dc_compenstation_resistor: boolean set if using compensation resistor
+ - adi,dc_dc_phase: can be set to
+	AD5755_DC_DC_PHASE_ALL_SAME_EDGE
+	AD5755_DC_DC_PHASE_A_B_SAME_EDGE_C_D_OPP_EDGE
+	AD5755_DC_DC_PHASE_A_C_SAME_EDGE_B_D_OPP_EDGE
+	AD5755_DC_DC_PHASE_90_DEGREE
+ - adi,dc_dc_freq:
+	AD5755_DC_DC_FREQ_250kHZ
+	AD5755_DC_DC_FREQ_410kHZ
+	AD5755_DC_DC_FREQ_650kHZ
+ - adi,dc_dc_maxv:
+	AD5755_DC_DC_MAXV_23V
+	AD5755_DC_DC_MAXV_24V5
+	AD5755_DC_DC_MAXV_27V
+	AD5755_DC_DC_MAXV_29V5
+
+Optional for every channel:
+	 - adi,mode:
+		AD5755_MODE_VOLTAGE_0V_5V
+		AD5755_MODE_VOLTAGE_0V_10V
+		AD5755_MODE_VOLTAGE_PLUSMINUS_5V
+		AD5755_MODE_VOLTAGE_PLUSMINUS_10V
+		AD5755_MODE_CURRENT_4mA_20mA
+		AD5755_MODE_CURRENT_0mA_20mA
+		AD5755_MODE_CURRENT_0mA_24mA
+	 - adi,ext_current_sense_resistor: boolean set if using external
+					   current sense resistor
+	 - adi,enable_voltage_overrange: boolean enable voltage overrange
+	 - adi,slew: Array of slewrate settings should contain 3 fields:
+		1: Should be either 0 or 1 in order to enable or disable slew
+		2: Slew rate settings:
+			AD5755_SLEW_RATE_64k
+			AD5755_SLEW_RATE_32k
+			AD5755_SLEW_RATE_16k
+			AD5755_SLEW_RATE_8k
+			AD5755_SLEW_RATE_4k
+			AD5755_SLEW_RATE_2k
+			AD5755_SLEW_RATE_1k
+			AD5755_SLEW_RATE_500
+			AD5755_SLEW_RATE_250
+			AD5755_SLEW_RATE_125
+			AD5755_SLEW_RATE_64
+			AD5755_SLEW_RATE_32
+			AD5755_SLEW_RATE_16
+			AD5755_SLEW_RATE_8
+			AD5755_SLEW_RATE_4
+			AD5755_SLEW_RATE_0_5
+		3: Slew step size:
+			AD5755_SLEW_STEP_SIZE_1
+			AD5755_SLEW_STEP_SIZE_2
+			AD5755_SLEW_STEP_SIZE_4
+			AD5755_SLEW_STEP_SIZE_8
+			AD5755_SLEW_STEP_SIZE_16
+			AD5755_SLEW_STEP_SIZE_32
+			AD5755_SLEW_STEP_SIZE_64
+			AD5755_SLEW_STEP_SIZE_128
+			AD5755_SLEW_STEP_SIZE_256
+
 Example:
 dac@0 {
 	compatible = "adi,ad5755";
 	reg = <0>;
 	spi-max-frequency = <1000000>;
 	spi-cpha;
+	adi,dc_dc_phase = <AD5755_DC_DC_PHASE_ALL_SAME_EDGE>;
+	adi,dc_dc_freq = <AD5755_DC_DC_FREQ_410kHZ>;
+	adi,dc_dc_maxv = <AD5755_DC_DC_MAXV_23V>;
+	channel@0 {
+		adi,mode = <AD5755_MODE_CURRENT_4mA_20mA>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 AD5755_SLEW_RATE_64k AD5755_SLEW_STEP_SIZE_1>;
+	};
+	channel@1 {
+		adi,mode = <AD5755_MODE_CURRENT_4mA_20mA>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 AD5755_SLEW_RATE_64k AD5755_SLEW_STEP_SIZE_1>;
+	};
+	channel@2 {
+		adi,mode = <AD5755_MODE_CURRENT_4mA_20mA>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 AD5755_SLEW_RATE_64k AD5755_SLEW_STEP_SIZE_1>;
+	};
+	channel@3 {
+		adi,mode = <AD5755_MODE_CURRENT_4mA_20mA>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 AD5755_SLEW_RATE_64k AD5755_SLEW_STEP_SIZE_1>;
+	};
 };
-- 
2.7.0

