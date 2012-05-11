Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47744 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759845Ab2EKNg2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 09:36:28 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, jic23@kernel.org, nicolas.ferre@atmel.com
Subject: [PATCH 8/9] ARM: AT91: Add ADC driver to the at91sam9x5 dtsi
Date: Fri, 11 May 2012 15:35:39 +0200
Message-Id: <1336743340-4578-9-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |   38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index dd4ed74..6b3ef43 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -190,6 +190,44 @@
 				interrupts = <27 4>;
 				status = "disabled";
 			};
+
+			adc0: adc@f804c000 {
+				compatible = "atmel,at91sam9260-adc";
+				reg = <0xf804c000 0x100>;
+				interrupts = <19 4>;
+				atmel,adc-use-external;
+				atmel,adc-channels-used = <0xffff>;
+				atmel,adc-vref = <3300>;
+				atmel,adc-num-channels = <12>;
+				atmel,adc-startup-time = <40>;
+				atmel,adc-channel-base = <0x50>;
+				atmel,adc-drdy-mask = <0x1000000>;
+				atmel,adc-status-register = <0x30>;
+				atmel,adc-trigger-register = <0xc0>;
+
+				trigger@0 {
+					trigger-name = "external-rising";
+					trigger-value = <0x1>;
+					trigger-external;
+				};
+
+				trigger@1 {
+					trigger-name = "external-falling";
+					trigger-value = <0x2>;
+					trigger-external;
+				};
+
+				trigger@2 {
+					trigger-name = "external-any";
+					trigger-value = <0x3>;
+					trigger-external;
+				};
+
+				trigger@3 {
+					trigger-name = "continuous";
+					trigger-value = <0x6>;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
-- 
1.7.9.5

