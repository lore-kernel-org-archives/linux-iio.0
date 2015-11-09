Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1bbn0108.outbound.protection.outlook.com ([157.56.111.108]:51360
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751616AbbKIN7P (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Nov 2015 08:59:15 -0500
From: Haibo Chen <haibo.chen@freescale.com>
To: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<shawnguo@kernel.org>, <kernel@pengutronix.de>,
	<linux@arm.linux.org.uk>, <jic23@kernel.org>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>
CC: <haibo.chen@freescale.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>
Subject: [PATCH v2 3/4] ARM: dts: imx7d.dtsi: add ADC support
Date: Mon, 9 Nov 2015 21:28:23 +0800
Message-ID: <1447075704-4605-4-git-send-email-haibo.chen@freescale.com>
In-Reply-To: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
References: <1447075704-4605-1-git-send-email-haibo.chen@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add imx7d ADC support.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 arch/arm/boot/dts/imx7d.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index ebc053a..87c3319 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -583,6 +583,26 @@
 			reg = <0x30400000 0x400000>;
 			ranges;
 
+			adc1: adc@30610000 {
+				compatible = "fsl,imx7d-adc";
+				reg = <0x30610000 0x10000>;
+				interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
+				num-channels = <4>;
+				clock-names = "adc";
+				status = "disabled";
+			};
+
+			adc2: adc@30620000 {
+				compatible = "fsl,imx7d-adc";
+				reg = <0x30620000 0x10000>;
+				interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX7D_ADC_ROOT_CLK>;
+				num-channels = <4>;
+				clock-names = "adc";
+				status = "disabled";
+			};
+
 			pwm1: pwm@30660000 {
 				compatible = "fsl,imx7d-pwm", "fsl,imx27-pwm";
 				reg = <0x30660000 0x10000>;
-- 
1.9.1

