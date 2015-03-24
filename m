Return-Path: <stefan@agner.ch>
From: Stefan Agner <stefan@agner.ch>
To: jic23@kernel.org,
	shawn.guo@linaro.org,
	kernel@pengutronix.de
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
Subject: [PATCH v4 3/3] ARM: dts: add property for maximum ADC clock frequencies
Date: Tue, 24 Mar 2015 13:47:49 +0100
Message-Id: <1427201269-4902-4-git-send-email-stefan@agner.ch>
In-Reply-To: <1427201269-4902-1-git-send-email-stefan@agner.ch>
References: <1427201269-4902-1-git-send-email-stefan@agner.ch>
List-ID: <linux-iio@vger.kernel.org>

The ADC clock frequency is limited depending on modes used. Add
device tree property which allow to set the mode used and the
maximum frequency ratings for the instance. These allows to
set the ADC clock to a frequency which is within specification
according to the actual mode used.

Acked-by: Fugang Duan <B38611@freescale.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

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
