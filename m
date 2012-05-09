Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45340 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864Ab2EIJHH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 05:07:07 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: thomas@free-electrons.com, patrice.vilchez@atmel.com,
	nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Subject: [PATCH 9/9] Add DTSI for the G20 SoC
Date: Wed,  9 May 2012 11:06:06 +0200
Message-Id: <1336554366-16957-10-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g20.dtsi |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
index 773ef48..2b1ad83 100644
--- a/arch/arm/boot/dts/at91sam9g20.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20.dtsi
@@ -197,6 +197,41 @@
 				interrupts = <10 4>;
 				status = "disabled";
 			};
+
+			adc0: adc@fffe0000 {
+				compatible = "atmel,at91sam9g20-adc";
+				reg = <0xfffe0000 0x100>;
+				interrupts = <5 4>;
+				atmel,adc-use-external-triggers;
+				atmel,adc-channels-used = <0xf>;
+				atmel,adc-vref = <3300>;
+				atmel,adc-num-channels = <4>;
+				atmel,adc-startup-time = <10>;
+				atmel,adc-channel-base = <0x30>;
+				atmel,adc-drdy-mask = <0x10000>;
+				atmel,adc-status-register = <0x1c>;
+				atmel,adc-trigger-register = <0x04>;
+
+				trigger@0 {
+					trigger-name = "timer-counter-0";
+					trigger-value = <0x1>;
+				};
+				trigger@1 {
+					trigger-name = "timer-counter-1";
+					trigger-value = <0x3>;
+				};
+
+				trigger@2 {
+					trigger-name = "timer-counter-2";
+					trigger-value = <0x5>;
+				};
+
+				trigger@3 {
+					trigger-name = "external";
+					trigger-value = <0x13>;
+					trigger-external;
+				};
+			};
 		};
 
 		nand0: nand@40000000 {
-- 
1.7.9.5

