Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:49329 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S941846AbcJYQ05 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 12:26:57 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>
Subject: [PATCH 10/10] ARM: dts: stm32f429: Add dma support to adc
Date: Tue, 25 Oct 2016 18:25:22 +0200
Message-ID: <1477412722-24061-11-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
References: <1477412722-24061-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Configure STM32 ADC to use dma by default.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index 3fcd941..a00f7a6 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -186,6 +186,8 @@
 				#io-channel-cells = <1>;
 				reg = <0x0>;
 				clocks = <&rcc 0 168>;
+				dmas = <&dma2 0 0 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -201,6 +203,8 @@
 				#io-channel-cells = <1>;
 				reg = <0x100>;
 				clocks = <&rcc 0 169>;
+				dmas = <&dma2 3 1 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
@@ -216,6 +220,8 @@
 				#io-channel-cells = <1>;
 				reg = <0x200>;
 				clocks = <&rcc 0 170>;
+				dmas = <&dma2 1 2 0x400 0x0>;
+				dma-names = "rx";
 				status = "disabled";
 			};
 
-- 
1.9.1

