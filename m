Return-Path: <SRS0=ii5x=6N=st.com=fabrice.gasnier@kernel.org>
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/4] ARM: dts: stm32: Add DAC support on stm32f429
Date: Mon, 10 Jul 2017 15:24:00 +0200
Message-ID: <1499693040-12994-5-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add support for DAC (Digital to Analog Converter) to STM32F429.
STM32F429 DAC has two output channels.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index b2a2b5c..f15f633 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -354,6 +354,31 @@
 			status = "disabled";
 		};
 
+		dac: dac@40007400 {
+			compatible = "st,stm32f4-dac-core";
+			reg = <0x40007400 0x400>;
+			resets = <&rcc STM32F4_APB1_RESET(DAC)>;
+			clocks = <&rcc 0 STM32F4_APB1_CLOCK(DAC)>;
+			clock-names = "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			dac1: dac@1 {
+				compatible = "st,stm32-dac";
+				#io-channels-cells = <1>;
+				reg = <1>;
+				status = "disabled";
+			};
+
+			dac2: dac@2 {
+				compatible = "st,stm32-dac";
+				#io-channels-cells = <1>;
+				reg = <2>;
+				status = "disabled";
+			};
+		};
+
 		usart7: serial@40007800 {
 			compatible = "st,stm32-usart", "st,stm32-uart";
 			reg = <0x40007800 0x400>;
-- 
1.9.1
