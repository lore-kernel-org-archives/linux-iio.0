Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f182.google.com ([209.85.210.182]:35688 "EHLO
        mail-wj0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933404AbcLIOQm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Dec 2016 09:16:42 -0500
Received: by mail-wj0-f182.google.com with SMTP id v7so15728442wjy.2
        for <linux-iio@vger.kernel.org>; Fri, 09 Dec 2016 06:16:41 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org, benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v6 8/8] ARM: dts: stm32: Enable pw1 and pwm3 for stm32f469-disco
Date: Fri,  9 Dec 2016 15:15:19 +0100
Message-Id: <1481292919-26587-9-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define and enable pwm1 and pwm3 for stm32f469 discovery board

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8a163d7..0750a71 100644
--- a/arch/arm/boot/dts/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/stm32f469-disco.dts
@@ -81,3 +81,31 @@
 &usart3 {
 	status = "okay";
 };
+
+&timers1 {
+	status = "okay";
+
+	pwm {
+		pinctrl-0 = <&pwm1_pins>;
+		pinctrl-names = "default";
+		status = "okay";
+	};
+
+	timer {
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
+	timer {
+		status = "okay";
+	};
+};
-- 
1.9.1

