Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:12249 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdFONbj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Jun 2017 09:31:39 -0400
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ludovic.desroches@microchip.com>, <jic23@kernel.org>,
        <robh@kernel.org>
CC: <eugen.hristev@microchip.com>
Subject: [PATCH v5 3/4] ARM: dts: at91: sama5d2: add ADC hw trigger edge type
Date: Thu, 15 Jun 2017 16:24:56 +0300
Message-ID: <1497533097-12052-4-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
References: <1497533097-12052-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added ADTRG edge type property as interrupt edge type value

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
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

