Return-Path: <SRS0=acV6=7M=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <ludovic.desroches@microchip.com>,
	<linux-iio@vger.kernel.org>, <jic23@kernel.org>,
	<alexandre.belloni@free-electrons.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lars@metafoo.de>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH 2/3] ARM: dts: at91: sama5d2: added dma property for ADC device
Date: Thu, 10 Aug 2017 15:34:58 +0300
Message-ID: <1502368499-6739-3-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
References: <1502368499-6739-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Added DMA property for ADC device

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 8067c71..2f1dc77 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1267,6 +1267,8 @@
 				atmel,min-sample-rate-hz = <200000>;
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
+				dmas = <&dma0 (AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1) | AT91_XDMAC_DT_PERID(25))>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
-- 
2.7.4
