Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36038 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbcB2TGD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Feb 2016 14:06:03 -0500
Received: by mail-lf0-f49.google.com with SMTP id l83so50848751lfd.3
        for <linux-iio@vger.kernel.org>; Mon, 29 Feb 2016 11:06:02 -0800 (PST)
From: Joachim Eastwood <manabian@gmail.com>
To: jic23@kernel.org
Cc: Joachim Eastwood <manabian@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	robh+dt@kernel.org
Subject: [PATCH 4/4] dt: document NXP LPC1850 DAC driver bindings
Date: Mon, 29 Feb 2016 20:05:41 +0100
Message-Id: <1456772741-9402-5-git-send-email-manabian@gmail.com>
In-Reply-To: <1456772741-9402-1-git-send-email-manabian@gmail.com>
References: <1456772741-9402-1-git-send-email-manabian@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/iio/dac/lpc1850-dac.txt      | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt b/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
new file mode 100644
index 000000000000..7d6647d4af5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
@@ -0,0 +1,20 @@
+NXP LPC1850 DAC bindings
+
+Required properties:
+- compatible: Should be "nxp,lpc1850-dac"
+- reg: Offset and length of the register set for the ADC device
+- interrupts: The interrupt number for the ADC device
+- clocks: The root clock of the ADC controller
+- vref-supply: The regulator supply ADC reference voltage
+- resets: phandle to reset controller and line specifier
+
+Example:
+dac: dac@400e1000 {
+	compatible = "nxp,lpc1850-dac";
+	reg = <0x400e1000 0x1000>;
+	interrupts = <0>;
+	clocks = <&ccu1 CLK_APB3_DAC>;
+	vref-supply = <&reg_vdda>;
+	resets = <&rgu 42>;
+	status = "disabled";
+};
-- 
1.8.0

