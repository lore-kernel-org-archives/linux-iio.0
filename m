Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58562 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752727AbdASNf0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 08:35:26 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH 6/7] ARM: dts: stm32: Enable dma by default on stm32f4 adc
Date: Thu, 19 Jan 2017 14:34:13 +0100
Message-ID: <1484832854-6314-7-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Configure STM32F4 ADC to use dma by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 11d2715..e85db07 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -207,6 +207,8 @@
 				clocks = <&rcc 0 168>;
 				interrupt-parent = <&adc>;
 				interrupts = <0>;
+				dmas = <&dma2 0 0 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -217,6 +219,8 @@
 				clocks = <&rcc 0 169>;
 				interrupt-parent = <&adc>;
 				interrupts = <1>;
+				dmas = <&dma2 3 1 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -227,6 +231,8 @@
 				clocks = <&rcc 0 170>;
 				interrupt-parent = <&adc>;
 				interrupts = <2>;
+				dmas = <&dma2 1 2 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 		};
-- 
1.9.1

