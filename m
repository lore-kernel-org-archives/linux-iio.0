Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47213 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489Ab2EINCx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 09:02:53 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, grant.likely@secretlab.ca
Subject: [PATCH 7/9] ARM: AT91: Add ADC driver to the at91sam9g45 dtsi
Date: Wed,  9 May 2012 15:02:06 +0200
Message-Id: <1336568528-29877-8-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
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

