Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47732 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759775Ab2EKNg1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 09:36:27 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, jic23@kernel.org, nicolas.ferre@atmel.com
Subject: [PATCH 7/9] ARM: AT91: Add ADC driver to the at91sam9g45 dtsi
Date: Fri, 11 May 2012 15:35:38 +0200
Message-Id: <1336743340-4578-8-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336743340-4578-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/at91sam9g45.dtsi |   37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index c804214..7dbccaf 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -199,6 +199,43 @@
 				interrupts = <25 4>;
 				status = "disabled";
 			};
+
+			adc0: adc@fffb0000 {
+				compatible = "atmel,at91sam9260-adc";
+				reg = <0xfffb0000 0x100>;
+				interrupts = <20 4>;
+				atmel,adc-use-external-triggers;
+				atmel,adc-channels-used = <0xff>;
+				atmel,adc-vref = <3300>;
+				atmel,adc-num-channels = <8>;
+				atmel,adc-startup-time = <40>;
+				atmel,adc-channel-base = <0x30>;
+				atmel,adc-drdy-mask = <0x10000>;
+				atmel,adc-status-register = <0x1c>;
+				atmel,adc-trigger-register = <0x08>;
+
+				trigger@0 {
+					trigger-name = "external-rising";
+					trigger-value = <0x1>;
+					trigger-external;
+				};
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

