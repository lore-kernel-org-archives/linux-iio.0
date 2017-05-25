Return-Path: <SRS0=Hb49=47=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@microchip.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v3 1/4] ARM: dts: at91: sama5d2_xplained: enable ADTRG pin
Date: Thu, 25 May 2017 14:17:11 +0300
Message-ID: <1495711034-28410-2-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
References: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Enable pinctrl for ADTRG pin (PD31) for ADC hardware trigger support.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 0bef9e0..04754b1 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -303,7 +303,7 @@
 				vddana-supply = <&vdd_3v3_lp_reg>;
 				vref-supply = <&vdd_3v3_lp_reg>;
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_adc_default>;
+				pinctrl-0 = <&pinctrl_adc_default &pinctrl_adtrg_default>;
 				status = "okay";
 			};
 
@@ -322,6 +322,20 @@
 					bias-disable;
 				};
 
+				/*
+				 * The ADTRG pin can work on any edge type.
+				 * In here it's being pulled up, so need to
+				 * connect it to ground to get an edge e.g.
+				 * Trigger can be configured on falling, rise
+				 * or any edge, and the pull-up can be changed
+				 * to pull-down or left floating according to
+				 * needs.
+				 */
+				pinctrl_adtrg_default: adtrg_default {
+					pinmux = <PIN_PD31__ADTRG>;
+					bias-pull-up;
+				};
+
 				pinctrl_charger_chglev: charger_chglev {
 					pinmux = <PIN_PA12__GPIO>;
 					bias-disable;
-- 
2.7.4
