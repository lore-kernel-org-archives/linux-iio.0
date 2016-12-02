Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f177.google.com ([209.85.210.177]:33431 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754978AbcLBKRt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2016 05:17:49 -0500
Received: by mail-wj0-f177.google.com with SMTP id xy5so227831123wjc.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Dec 2016 02:17:48 -0800 (PST)
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
Subject: [PATCH v3 5/7] IIO: add bindings for stm32 timer trigger driver
Date: Fri,  2 Dec 2016 11:17:20 +0100
Message-Id: <1480673842-20804-6-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define bindings for stm32 timer trigger

version 3:
- change file name
- add cross reference with mfd bindings

version 2:
- only keep one compatible
- add DT parameters to set lists of the triggers:
  one list describe the triggers created by the device
  another one give the triggers accepted by the device

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/iio/timer/stm32-timer-trigger.txt     | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
new file mode 100644
index 0000000..858816d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -0,0 +1,39 @@
+timer trigger bindings for STM32
+
+Must be a sub-node of STM32 general purpose timer driver
+Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
+
+Required parameters:
+- compatible:		must be "st,stm32-iio-timer"
+- interrupts:		Interrupt for this device
+			See ../interrupt-controller/st,stm32-exti.txt
+
+Optional parameters:
+- st,input-triggers-names:	List of the possible input triggers for
+				the device
+- st,output-triggers-names:	List of the possible output triggers for
+				the device
+
+Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32-timer-trigger.h
+
+Example:
+	gptimer1: gptimer1@40010000 {
+		compatible = "st,stm32-gptimer";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		timer1@0 {
+			compatible = "st,stm32-timer-trigger";
+			interrupts = <27>;
+			st,input-triggers-names = TIM5_TRGO,
+						  TIM2_TRGO,
+						  TIM4_TRGO,
+						  TIM3_TRGO;
+			st,output-triggers-names = TIM1_TRGO,
+						   TIM1_CH1,
+						   TIM1_CH2,
+						   TIM1_CH3,
+						   TIM1_CH4;
+		};
+	};
-- 
1.9.1

