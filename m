Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:26046 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbdFONbZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jun 2017 09:31:25 -0400
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <jic23@kernel.org>,
        <robh@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v5 1/4] ARM: dts: at91: sama5d2_xplained: enable ADTRG pin
Date: Thu, 15 Jun 2017 16:24:54 +0300
Message-ID: <1497533097-12052-2-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
References: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Enable pinctrl for ADTRG pin (PD31) for ADC hardware trigger support.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
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

