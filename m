Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f179.google.com ([209.85.210.179]:33280 "EHLO
        mail-wj0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762111AbdAEJZ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 04:25:59 -0500
Received: by mail-wj0-f179.google.com with SMTP id tq7so251997541wjb.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Jan 2017 01:25:59 -0800 (PST)
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
Subject: [PATCH v7 1/8] MFD: add bindings for STM32 Timers driver
Date: Thu,  5 Jan 2017 10:25:37 +0100
Message-Id: <1483608344-9012-2-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add bindings information for STM32 Timers

version 6:
- rename stm32-gtimer to stm32-timers
- change compatible
- add description about the IPs

version 2:
- rename stm32-mfd-timer to stm32-gptimer
- only keep one compatible string

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/mfd/stm32-timers.txt       | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
new file mode 100644
index 0000000..a73301d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -0,0 +1,46 @@
+STM32 Timers driver bindings
+
+This IP provides 3 types of timer along with PWM functionality:
+- advanced-control timers consist of a 16-bit auto-reload counter driven by a programmable
+  prescaler, break input feature, PWM outputs and complementary PWM ouputs channels.
+- general-purpose timers consist of a 16-bit or 32-bit auto-reload counter driven by a
+  programmable prescaler and PWM outputs.
+- basic timers consist of a 16-bit auto-reload counter driven by a programmable prescaler.
+
+Required parameters:
+- compatible: must be "st,stm32-timers"
+
+- reg:			Physical base address and length of the controller's
+			registers.
+- clock-names: 		Set to "int".
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
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		pwm {
+			compatible = "st,stm32-pwm";
+			pinctrl-0	= <&pwm1_pins>;
+			pinctrl-names	= "default";
+		};
+
+		timer {
+			compatible = "st,stm32-timer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1

