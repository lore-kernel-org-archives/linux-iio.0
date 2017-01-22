Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36655 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbdAVSR1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 22 Jan 2017 13:17:27 -0500
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org
Cc: carlo@caione.org, catalin.marinas@arm.com, will.deacon@arm.com,
        narmstrong@baylibre.com, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 1/3] Documentation: dt-bindings: add the Amlogic Meson SAR ADC documentation
Date: Sun, 22 Jan 2017 19:17:12 +0100
Message-Id: <20170122181714.6259-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
References: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This adds the devicetree binding documentation for the SAR ADC found in
Amlogic Meson SoCs.
Currently only the GXBB, GXL and GXM SoCs are supported.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Andreas Färber <afaerber@suse.de>
---
 .../bindings/iio/adc/amlogic,meson-saradc.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
new file mode 100644
index 000000000000..f9e3ff2c656e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -0,0 +1,32 @@
+* Amlogic Meson SAR (Successive Approximation Register) A/D converter
+
+Required properties:
+- compatible:	depending on the SoC this should be one of:
+			- "amlogic,meson-gxbb-saradc" for GXBB
+			- "amlogic,meson-gxl-saradc" for GXL
+			- "amlogic,meson-gxm-saradc" for GXM
+		along with the generic "amlogic,meson-saradc"
+- reg:		the physical base address and length of the registers
+- clocks:	phandle and clock identifier (see clock-names)
+- clock-names:	mandatory clocks:
+			- "clkin" for the reference clock (typically XTAL)
+			- "core" for the SAR ADC core clock
+		optional clocks:
+			- "sana" for the analog clock
+			- "adc_clk" for the ADC (sampling) clock
+			- "adc_sel" for the ADC (sampling) clock mux
+- vref-supply:	the regulator supply for the ADC reference voltage
+- #io-channel-cells: must be 1, see ../iio-bindings.txt
+
+Example:
+	saradc: adc@8680 {
+		compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
+		#io-channel-cells = <1>;
+		reg = <0x0 0x8680 0x0 0x34>;
+		clocks = <&xtal>,
+			 <&clkc CLKID_SAR_ADC>,
+			 <&clkc CLKID_SANA>,
+			 <&clkc CLKID_SAR_ADC_CLK>,
+			 <&clkc CLKID_SAR_ADC_SEL>;
+		clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
+	};
-- 
2.11.0

