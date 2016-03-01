Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:1644 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbcCAL42 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Mar 2016 06:56:28 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v4 4/4] iio: ad5755: Add full DT binding documentation
Date: Tue, 1 Mar 2016 12:56:16 +0100
Message-ID: <1456833376-29758-4-git-send-email-sean.nyekjaer@prevas.dk>
In-Reply-To: <1456833376-29758-3-git-send-email-sean.nyekjaer@prevas.dk>
References: <1456833376-29758-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1456833376-29758-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1456833376-29758-3-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
Still missing some ideas to dc-dc-phase and mode options :-)

Changes since v3:
- replaced '_' with '-'
- Now used actual values instead of register values.

Changes since v2:
 - Removed defines, alot easier to read :-)

 .../devicetree/bindings/iio/dac/ad5755.txt         | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
index 4c91583..83b4c3f 100644
--- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
+++ b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
@@ -15,10 +15,104 @@ Recommended properties:
  - spi-max-frequency: Definition as per
 		Documentation/devicetree/bindings/spi/spi-bus.txt
 
+Optional properties:
+See include/dt-bindings/iio/ad5755.h
+ - adi,ext-dc-dc-compenstation-resistor: boolean set if the hardware have an
+					 external resistor and thereby bypasses
+					 the internal compensation resistor.
+ - adi,dc-dc-phase:
+	Valid values for DC DC Phase control is:
+	0: All dc-to-dc converters clock on the same edge.
+	1: Channel A and Channel B clock on the same edge,
+	   Channel C and Channel D clock on opposite edges.
+	2: Channel A and Channel C clock on the same edge,
+	   Channel B and Channel D clock on opposite edges.
+	3: Channel A, Channel B, Channel C, and Channel D
+	   clock 90 degrees out of phase from each other.
+ - adi,dc-dc-freq:
+	Valid values for DC DC frequency is [Hz]:
+	250000
+	410000
+	650000
+ - adi,dc-dc-maxv:
+	Valid values for the maximum allowed Vboost voltage supplied by
+	the dc-to-dc converter is [mV]:
+	23000
+	24500
+	27000
+	29500
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
+ - adi,ext-current-sense-resistor: boolean set if the hardware a external
+				   current sense resistor.
+ - adi,enable-voltage-overrange: boolean enable voltage overrange
+ - adi,slew: Array of slewrate settings should contain 3 fields:
+	1: Should be either 0 or 1 in order to enable or disable slewrate.
+	2: Slew rate settings:
+		Valid values for the slew rate update frequency:
+		64000
+		32000
+		16000
+		8000
+		4000
+		2000
+		1000
+		500
+		250
+		125
+		64
+		32
+		16
+		8
+		4
+		0
+	3: Slew step size:
+		Valid values for the step size LSBs:
+		1
+		2
+		4
+		16
+		32
+		64
+		128
+		256
+
 Example:
 dac@0 {
 	compatible = "adi,ad5755";
 	reg = <0>;
 	spi-max-frequency = <1000000>;
 	spi-cpha;
+	adi,dc-dc-phase = <0>;
+	adi,dc-dc-freq = <1>;
+	adi,dc-dc-maxv = <0>;
+	channel@0 {
+		adi,mode = <4>;
+		adi,ext-current-sense-resistor;
+		adi,slew = <0 64000 1>;
+	};
+	channel@1 {
+		adi,mode = <4>;
+		adi,ext-current-sense-resistor;
+		adi,slew = <0 64000 1>;
+	};
+	channel@2 {
+		adi,mode = <4>;
+		adi,ext-current-sense-resistor;
+		adi,slew = <0 64000 1>;
+	};
+	channel@3 {
+		adi,mode = <4>;
+		adi,ext-current-sense-resistor;
+		adi,slew = <0 64000 1>;
+	};
 };
-- 
2.7.2

