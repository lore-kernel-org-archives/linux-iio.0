Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f177.google.com ([209.85.210.177]:36378 "EHLO
        mail-wj0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760543AbdAEJ0K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 04:26:10 -0500
Received: by mail-wj0-f177.google.com with SMTP id ew7so16598608wjc.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Jan 2017 01:26:10 -0800 (PST)
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
Subject: [PATCH v7 5/8] IIO: add bindings for STM32 timer trigger driver
Date: Thu,  5 Jan 2017 10:25:41 +0100
Message-Id: <1483608344-9012-6-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define bindings for STM32 timer trigger

version 4:
- remove triggers enumeration from DT
- add reg parameter

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
 .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
new file mode 100644
index 0000000..36a6c4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -0,0 +1,23 @@
+STMicroelectronics STM32 Timers IIO timer bindings
+
+Must be a sub-node of an STM32 Timers device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required parameters:
+- compatible:	Must be "st,stm32-timer-trigger".
+- reg:		Define triggers configuration of the hardware IP.
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
+		timer {
+			compatible = "st,stm32-timer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1

