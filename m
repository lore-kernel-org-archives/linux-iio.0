Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51532 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750748AbcGLTEW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jul 2016 15:04:22 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	Chen-Yu Tsai <wens@csie.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 1/2] iio: sun4i-lradc: Add binding documentation
Date: Tue, 12 Jul 2016 21:04:11 +0200
Message-Id: <1468350252-11405-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Document the bindings for the Allwinner LRADC.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 .../devicetree/bindings/iio/adc/sun4i-lradc.txt       | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt b/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
new file mode 100644
index 000000000000..c75a6067b8a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/sun4i-lradc.txt
@@ -0,0 +1,19 @@
+Allwinner sun4i Low Resolution ADC
+----------------------------------
+
+Required properties:
+ - compatible: "allwinner,sun4i-a10-lradc"
+ - reg: mmio address range of the chip
+ - interrupts: interrupt to which the chip is connected
+ - vref-supply: powersupply for the lradc reference voltage
+ - #io-channel-cells = <1>; As ADC has multiple outputs
+
+Example:
+
+	lradc: lradc@01c22800 {
+		compatible = "allwinner,sun4i-a10-lradc";
+		reg = <0x01c22800 0x100>;
+		interrupts = <31>;
+		vref-supply = <&reg_vcc3v0>;
+		#io-channel-cells = <1>;
+	};
-- 
2.8.1

