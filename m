Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wj0-f173.google.com ([209.85.210.173]:34864 "EHLO
        mail-wj0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752600AbcLFMkJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Dec 2016 07:40:09 -0500
Received: by mail-wj0-f173.google.com with SMTP id v7so319037951wjy.2
        for <linux-iio@vger.kernel.org>; Tue, 06 Dec 2016 04:39:59 -0800 (PST)
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
Subject: [PATCH v4 5/7] IIO: add bindings for STM32 timer trigger driver
Date: Tue,  6 Dec 2016 13:38:47 +0100
Message-Id: <1481027929-13704-6-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
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
index 0000000..fbaeba9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt
@@ -0,0 +1,23 @@
+STMicroelectronics STM32 General Purpose Timer IIO timer bindings
+
+Must be a sub-node of an STM32 General Purpose Timer device tree node.
+See ../mfd/stm32-general-purpose-timer.txt for details about the parent node.
+
+Required parameters:
+- compatible:	Must be "st,stm32-timer-trigger".
+- reg:		Define triggers configuration of the hardware IP.
+
+Example:
+	gptimer@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-gptimer";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "clk_int";
+
+		timer@0 {
+			compatible = "st,stm32-timer-trigger";
+			reg = <0>;
+		};
+	};
-- 
1.9.1

