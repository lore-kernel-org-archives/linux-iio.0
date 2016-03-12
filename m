Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:34988 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbcCLMbD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 07:31:03 -0500
From: Joachim Eastwood <manabian@gmail.com>
To: jic23@kernel.org
Cc: Joachim Eastwood <manabian@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] dt: document NXP LPC1850 ADC driver bindings
Date: Sat, 12 Mar 2016 13:30:15 +0100
Message-Id: <1457785817-32328-3-git-send-email-manabian@gmail.com>
In-Reply-To: <1457785817-32328-1-git-send-email-manabian@gmail.com>
References: <1457785817-32328-1-git-send-email-manabian@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/iio/adc/lpc1850-adc.txt     | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt b/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
new file mode 100644
index 000000000000..0bcae5140bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/lpc1850-adc.txt
@@ -0,0 +1,21 @@
+NXP LPC1850 ADC bindings
+
+Required properties:
+- compatible: Should be "nxp,lpc1850-adc"
+- reg: Offset and length of the register set for the ADC device
+- interrupts: The interrupt number for the ADC device
+- clocks: The root clock of the ADC controller
+- vref-supply: The regulator supply ADC reference voltage
+- resets: phandle to reset controller and line specifier
+
+Example:
+
+adc0: adc@400e3000 {
+	compatible = "nxp,lpc1850-adc";
+	reg = <0x400e3000 0x1000>;
+	interrupts = <17>;
+	clocks = <&ccu1 CLK_APB3_ADC0>;
+	vref-supply = <&reg_vdda>;
+	resets = <&rgu 40>;
+	status = "disabled";
+};
-- 
1.8.0

