Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:53567 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754967AbaFPJ3Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Jun 2014 05:29:16 -0400
From: Denis Carikli <denis@eukrea.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Markus Pargmann <mpa@pengutronix.de>,
	Denis Carikli <denis@eukrea.com>
Subject: [PATCH v3 4/6] ARM: dts: imx25: Add TSC and ADC support
Date: Mon, 16 Jun 2014 11:28:51 +0200
Message-Id: <1402910933-20534-4-git-send-email-denis@eukrea.com>
In-Reply-To: <1402910933-20534-1-git-send-email-denis@eukrea.com>
References: <1402910933-20534-1-git-send-email-denis@eukrea.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v2->v3:
- Added ADC controller support: making a separate patch
  for it would have been overkill.
- Moved the common TSC and ADC sub-nodes inside this patch
  instead of having a copy in each dts using it.
---
 arch/arm/boot/dts/imx25.dtsi |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 98783f5..3187342 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -264,13 +264,37 @@
 				status = "disabled";
 			};
 
-			tsc: tsc@50030000 {
-				compatible = "fsl,imx25-adc", "fsl,imx21-tsc";
-				reg = <0x50030000 0x4000>;
+			tscadc: tscadc@50030000 {
+				compatible = "fsl,imx25-tsadc";
+				reg = <0x50030000 0xc>;
 				interrupts = <46>;
 				clocks = <&clks 119>;
 				clock-names = "ipg";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges;
 				status = "disabled";
+
+				adc: adc@50030800 {
+					compatible = "fsl,imx25-gcq";
+					reg = <0x50030800 0x60>;
+					interrupt-parent = <&tscadc>;
+					interrupts = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+				};
+
+				tsc: tcq@50030400 {
+					compatible = "fsl,imx25-tcq";
+					reg = <0x50030400 0x60>;
+					interrupt-parent = <&tscadc>;
+					interrupts = <0>;
+					fsl,wires = <4>;
+					status = "disabled";
+				};
 			};
 
 			ssi1: ssi@50034000 {
-- 
1.7.9.5

