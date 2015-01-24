Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40210 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbbAXOCs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Jan 2015 09:02:48 -0500
From: Markus Pargmann <mpa@pengutronix.de>
To: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: Denis Carikli <denis@eukrea.com>,
	=?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 5/6] ARM: dts: imx25: Add TSC and ADC support
Date: Sat, 24 Jan 2015 15:01:42 +0100
Message-Id: <1422108103-15052-6-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Denis Carikli <denis@eukrea.com>

Signed-off-by: Denis Carikli <denis@eukrea.com>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx25.dtsi | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 58d3c3cf2923..73ebc63353ef 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -265,13 +265,37 @@
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
2.1.4

