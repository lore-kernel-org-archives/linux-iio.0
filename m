Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f177.google.com ([209.85.210.177]:36463 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932327AbcLHMV7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2016 07:21:59 -0500
Received: by mail-wj0-f177.google.com with SMTP id tk12so92068809wjb.3
        for <linux-iio@vger.kernel.org>; Thu, 08 Dec 2016 04:21:59 -0800 (PST)
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
Subject: [PATCH v5 1/7] MFD: add bindings for STM32 General Purpose Timer driver
Date: Thu,  8 Dec 2016 13:20:44 +0100
Message-Id: <1481199650-22484-2-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1481199650-22484-1-git-send-email-benjamin.gaignard@st.com>
References: <1481199650-22484-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add bindings information for STM32 General Purpose Timer

version 2:
- rename stm32-mfd-timer to stm32-gptimer
- only keep one compatible string

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/mfd/stm32-general-purpose-timer.txt   | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
new file mode 100644
index 0000000..ce67755
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.txt
@@ -0,0 +1,39 @@
+STM32 General Purpose Timer driver bindings
+
+Required parameters:
+- compatible: must be "st,stm32-gptimer"
+
+- reg:			Physical base address and length of the controller's
+			registers.
+- clock-names: 		Set to "clk_int".
+- clocks: 		Phandle to the clock used by the timer module.
+			For Clk properties, please refer to ../clock/clock-bindings.txt
+
+Optional parameters:
+- resets:		Phandle to the parent reset controller.
+			See ../reset/st,stm32-rcc.txt
+
+Optional subnodes:
+- pwm:			See ../pwm/pwm-stm32.txt
+- timer:		See ../iio/timer/stm32-timer-trigger.txt
+
+Example:
+	timers@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-gptimer";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm@0 {
+			compatible = "st,stm32-pwm";
+			pinctrl-0	= <&pwm1_pins>;
+			pinctrl-names	= "default";
+		};
+
+		timer@0 {
+			compatible = "st,stm32-timer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1

