Return-Path: <SRS0=wzNZ=5O=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
	<linux-iio@vger.kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>,
	<jic23@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v4 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger edge type
Date: Fri, 9 Jun 2017 10:07:18 +0300
Message-ID: <1496992039-17964-4-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
References: <1496992039-17964-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Added ADTRG edge type property as interrupt edge type value

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
  Changes in v4:
 - Modified bindings to be similar with interrupts

 arch/arm/boot/dts/sama5d2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71..483a387 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1267,6 +1267,7 @@
 				atmel,min-sample-rate-hz = <200000>;
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
+				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
 
-- 
2.7.4
