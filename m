Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21063 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752708AbdAZO3m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 09:29:42 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>
Subject: [PATCH v2 7/7] ARM: dts: stm32: Enable pwm1 and pwm3 on stm32f429i-eval
Date: Thu, 26 Jan 2017 15:28:35 +0100
Message-ID: <1485440915-30119-8-git-send-email-fabrice.gasnier@st.com>
In-Reply-To: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
References: <1485440915-30119-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define and enable pwm1 and pwm3, timers1 & 3 trigger outputs on
on stm32f429i-eval board.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v2:
- Fix typo
- Sort phandles
---
 arch/arm/boot/dts/stm32429i-eval.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
index 2181220..507ee9d 100644
--- a/arch/arm/boot/dts/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/stm32429i-eval.dts
@@ -157,6 +157,34 @@
 	};
 };
 
+&timers1 {
+	status = "okay";
+
+	pwm {
+		pinctrl-0 = <&pwm1_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	timer@0 {
+		status = "okay";
+	};
+};
+
+&timers3 {
+	status = "okay";
+
+	pwm {
+		pinctrl-0 = <&pwm3_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	timer@2 {
+		status = "okay";
+	};
+};
+
 &usart1 {
 	pinctrl-0 = <&usart1_pins_a>;
 	pinctrl-names = "default";
-- 
1.9.1

