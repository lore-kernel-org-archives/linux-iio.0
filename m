Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:35684 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbcAFQNO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 6 Jan 2016 11:13:14 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>, <pmeerw@pmeerw.net>,
	<robh@kernel.org>, Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 3/5] ARM: at91/dt: sama5d2: add adc device
Date: Wed, 6 Jan 2016 17:12:37 +0100
Message-ID: <1452096759-19438-4-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1452096759-19438-1-git-send-email-ludovic.desroches@atmel.com>
References: <1452096759-19438-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the ADC device, and remove the adc_op_clk which is useless since the
adc sampling frequency is configured with sysfs.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 3f750f6..1bd8899 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -88,12 +88,6 @@
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
-
-		adc_op_clk: adc_op_clk{
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <1000000>;
-		};
 	};
 
 	ns_sram: sram@00200000 {
@@ -1085,6 +1079,18 @@
 				status = "disabled";
 			};
 
+			adc: adc@fc030000 {
+				compatible = "atmel,sama5d2-adc";
+				reg = <0xfc030000 0x100>;
+				interrupts = <40 IRQ_TYPE_LEVEL_HIGH 7>;
+				clocks = <&adc_clk>;
+				clock-names = "adc_clk";
+				atmel,min-sample-rate = <200000>;
+				atmel,max-sample-rate = <20000000>;
+				atmel,startup-time-ms = <4>;
+				status = "disabled";
+			};
+
 			pioA: pinctrl@fc038000 {
 				compatible = "atmel,sama5d2-pinctrl";
 				reg = <0xfc038000 0x600>;
-- 
2.5.0

