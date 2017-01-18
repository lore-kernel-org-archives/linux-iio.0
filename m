Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37979 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753729AbdAROVy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 09:21:54 -0500
Received: by mail-wm0-f53.google.com with SMTP id r144so27428501wme.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Jan 2017 06:21:28 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linaro-kernel@lists.linaro.org,
        benjamin.gaignard@linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v8 8/8] ARM: dts: stm32: Enable pwm1 and pwm3 for stm32f469-disco
Date: Wed, 18 Jan 2017 15:20:51 +0100
Message-Id: <1484749251-14445-9-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define and enable pwm1 and pwm3 for stm32f469 discovery board

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32f469-disco.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
index 8a163d7..92552d3 100644
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
-- 
1.9.1

