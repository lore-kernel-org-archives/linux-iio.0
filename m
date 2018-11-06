Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mxout017.mail.hostpoint.ch ([217.26.49.177]:36290 "EHLO
        mxout017.mail.hostpoint.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389406AbeKGCc5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Nov 2018 21:32:57 -0500
From: Philippe Schenker <dev@pschenker.ch>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: [PATCH 2/3] iio: adc: add STMPE ADC devicetree bindings
Date: Tue,  6 Nov 2018 17:41:15 +0100
Message-Id: <20181106164116.6299-2-dev@pschenker.ch>
In-Reply-To: <20181106164116.6299-1-dev@pschenker.ch>
References: <20181106164116.6299-1-dev@pschenker.ch>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

This adds the devicetree bindings for the STMPE ADC.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
---
 .../devicetree/bindings/iio/adc/stmpe-adc.txt | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
new file mode 100644
index 000000000000..752ef35a794d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/stmpe-adc.txt
@@ -0,0 +1,34 @@
+STMPE ADC driver
+----------------
+
+Required properties:
+ - compatible: "st,stmpe-adc"
+
+Optional properties:
+Note that the ADC is shared with the STMPE touchscreen, so if using both the
+settings should be the same.
+If the settings are not the same, the settings of the driver initialized last
+will be active.
+- st,sample-time: ADC conversion time in number of clock. (0 -> 36 clocks,
+  1 -> 44 clocks, 2 -> 56 clocks, 3 -> 64 clocks, 4 -> 80 clocks,
+  5 -> 96 clocks, 6 -> 144 clocks), recommended is 4.
+- st,mod-12b: ADC Bit mode (0 -> 10bit ADC, 1 -> 12bit ADC)
+- st,ref-sel: ADC reference source (0 -> internal reference, 1 -> external
+  reference)
+- st,adc-freq: ADC Clock speed (0 -> 1.625 MHz, 1 -> 3.25 MHz, 2 || 3 -> 6.5 MHz)
+- st,norequest-mask: bitmask specifying which ADC channels should _not_ be
+  requestable due to different usage (e.g. touch)
+
+Node name must be stmpe_adc and should be child node of stmpe node to
+which it belongs.
+
+Example:
+
+	stmpe_adc {
+		compatible = "st,stmpe-adc";
+		st,sample-time = <4>;
+		st,mod-12b = <1>;
+		st,ref-sel = <0>;
+		st,adc-freq = <1>;
+		st,norequest-mask = <0x0F>; /* dont use ADC CH3-0 */
+	};
-- 
2.19.1
