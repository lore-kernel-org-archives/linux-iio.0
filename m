Return-Path: <SRS0=Hb49=47=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@microchip.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v3 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger
Date: Thu, 25 May 2017 14:17:13 +0300
Message-ID: <1495711034-28410-4-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
References: <1495711034-28410-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add ADTRG hardware pin possible edge types as nodes
and default edge as property to the ADC

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71..a06ca8d 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1267,7 +1267,18 @@
 				atmel,min-sample-rate-hz = <200000>;
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
+				atmel,trigger-edge-type = <&external_rising>;
 				status = "disabled";
+
+				/* possible edge type for ADTRG trigger pin */
+				adtrg: adtrg {
+					external_rising: external_rising {
+					};
+					external_falling: external_falling {
+					};
+					external_any: external_any {
+					};
+				};
 			};
 
 			pioA: pinctrl@fc038000 {
-- 
2.7.4
