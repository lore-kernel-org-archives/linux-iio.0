Return-Path: <stefan@agner.ch>
From: Stefan Agner <stefan@agner.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	B38611@freescale.com,
	maitysanchayan@gmail.com,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 3/3] ARM: dts: add property for maximum ADC clock frequencies
Date: Mon, 16 Mar 2015 16:10:14 +0100
Message-Id: <1426518614-20201-4-git-send-email-stefan@agner.ch>
In-Reply-To: <1426518614-20201-1-git-send-email-stefan@agner.ch>
References: <1426518614-20201-1-git-send-email-stefan@agner.ch>
List-ID: <linux-iio@vger.kernel.org>

The ADC clock frequency is limited depending on modes used. Add
device tree property which allow to set the mode used and the
maximum frequency ratings for the instance. These allows to
set the ADC clock to a frequency which is within specification
according to the actual mode used.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 Documentation/devicetree/bindings/iio/adc/vf610-adc.txt | 9 +++++++++
 arch/arm/boot/dts/vfxxx.dtsi                            | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
index 1a4a43d..3eb40e2 100644
--- a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
@@ -11,6 +11,13 @@ Required properties:
 - clock-names: Must contain "adc", matching entry in the clocks property.
 - vref-supply: The regulator supply ADC reference voltage.
 
+Recommended properties:
+- fsl,adck-max-frequency: Maximum frequencies according to datasheets operating
+  requirements. Three values are required, depending on conversion mode:
+  - Frequency in normal mode (ADLPC=0, ADHSC=0)
+  - Frequency in high-speed mode (ADLPC=0, ADHSC=1)
+  - Frequency in low-power mode (ADLPC=1, ADHSC=0)
+
 Example:
 adc0: adc@4003b000 {
 	compatible = "fsl,vf610-adc";
@@ -18,5 +25,7 @@ adc0: adc@4003b000 {
 	interrupts = <0 53 0x04>;
 	clocks = <&clks VF610_CLK_ADC0>;
 	clock-names = "adc";
+	fsl,adck-max-frequency = <30000000>, <40000000>,
+				<20000000>;
 	vref-supply = <&reg_vcc_3v3_mcu>;
 };
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index a29c7ce..c6609bd 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -189,6 +189,8 @@
 				clocks = <&clks VF610_CLK_ADC0>;
 				clock-names = "adc";
 				status = "disabled";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							<20000000>;
 			};
 
 			wdoga5: wdog@4003e000 {
@@ -387,6 +389,8 @@
 				clocks = <&clks VF610_CLK_ADC1>;
 				clock-names = "adc";
 				status = "disabled";
+				fsl,adck-max-frequency = <30000000>, <40000000>,
+							<20000000>;
 			};
 
 			esdhc1: esdhc@400b2000 {
-- 
2.3.3
