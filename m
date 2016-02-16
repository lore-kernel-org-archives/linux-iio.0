Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:35859 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932430AbcBPO0L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 16 Feb 2016 09:26:11 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 4/4] iio: ad5755: Add full DT binding documentation
Date: Tue, 16 Feb 2016 15:25:57 +0100
Message-ID: <1455632757-21748-4-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1455632757-21748-3-git-send-email-sean.nyekjaer@prevas.dk>
References: <1455632757-21748-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1455632757-21748-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1455632757-21748-3-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Changes since v2:
 - Removed defines, alot easier to read :-)

 .../devicetree/bindings/iio/dac/ad5755.txt         | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
index 4c91583..751204b 100644
--- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
@@ -15,10 +15,104 @@ Recommended properties:
  - spi-max-frequency: Definition as per
 		Documentation/devicetree/bindings/spi/spi-bus.txt
 
+Optional properties:
+See include/dt-bindings/iio/ad5755.h
+ - adi,ext_dc_dc_compenstation_resistor: boolean set if the hardware have an
+					 external resistor and thereby bypasses
+					 the internal compensation resistor.
+ - adi,dc_dc_phase:
+	Valid values for DC DC Phase control is:
+	0: All dc-to-dc converters clock on the same edge.
+	1: Channel A and Channel B clock on the same edge,
+	   Channel C and Channel D clock on opposite edges.
+	2: Channel A and Channel C clock on the same edge,
+	   Channel B and Channel D clock on opposite edges.
+	3: Channel A, Channel B, Channel C, and Channel D
+	   clock 90 degrees out of phase from each other.
+ - adi,dc_dc_freq:
+	Valid values for DC DC frequency is:
+	0: 250 kHz.
+	1: 410 kHz.
+	2: 650 kHz.
+ - adi,dc_dc_maxv:
+	Valid values for the maximum allowed Vboost voltage supplied by
+	the dc-to-dc converter is:
+	0: 23 V.
+	1: 24.5 V.
+	2: 27 V.
+	3: 29.5 V.
+
+Optional for every channel:
+ - adi,mode:
+	Valid values for DAC modes is:
+	0: 0 V to 5 V voltage range.
+	1: 0 V to 10 V voltage range.
+	2: Plus minus 5 V voltage range.
+	3: Plus minus 10 V voltage range.
+	4: 4 mA to 20 mA current range.
+	5: 0 mA to 20 mA current range.
+	6: 0 mA to 24 mA current range.
+ - adi,ext_current_sense_resistor: boolean set if the hardware a external
+				   current sense resistor.
+ - adi,enable_voltage_overrange: boolean enable voltage overrange
+ - adi,slew: Array of slewrate settings should contain 3 fields:
+	1: Should be either 0 or 1 in order to enable or disable slewrate.
+	2: Slew rate settings:
+		Valid values for the slew rate update frequency:
+		0: 64 kHz
+		1: 32 kHz
+		2: 16 kHz
+		3: 8 kHz
+		4: 4 kHz
+		5: 2 kHz
+		6: 1 kHz
+		7: 500 Hz
+		8: 250 Hz
+		9: 125 Hz
+		10: 64 Hz
+		11: 32 Hz
+		12: 16 Hz
+		13: 8 Hz
+		14: 4 Hz
+		15: 0.5 Hz
+	3: Slew step size:
+		Valid values for the step size LSBs:
+		0: 1
+		1: 2
+		2: 4
+		3: 16
+		4: 32
+		5: 64
+		6: 128
+		7: 256
+
 Example:
 dac@0 {
 	compatible = "adi,ad5755";
 	reg = <0>;
 	spi-max-frequency = <1000000>;
 	spi-cpha;
+	adi,dc_dc_phase = <0>;
+	adi,dc_dc_freq = <1>;
+	adi,dc_dc_maxv = <0>;
+	channel@0 {
+		adi,mode = <4>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 0 0>;
+	};
+	channel@1 {
+		adi,mode = <4>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 0 0>;
+	};
+	channel@2 {
+		adi,mode = <4>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 0 0>;
+	};
+	channel@3 {
+		adi,mode = <4>;
+		adi,ext_current_sense_resistor;
+		adi,slew = <0 0 0>;
+	};
 };
-- 
2.7.1

