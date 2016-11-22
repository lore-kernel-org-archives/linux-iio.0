Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38285 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755328AbcKVQNy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 11:13:54 -0500
Received: by mail-wm0-f45.google.com with SMTP id f82so33240777wmf.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2016 08:13:53 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: fabrice.gasnier@st.com, gerald.baeza@st.com,
        arnaud.pouliquen@st.com, linus.walleij@linaro.org,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 1/7] add binding for stm32 multifunctions timer driver
Date: Tue, 22 Nov 2016 17:13:21 +0100
Message-Id: <1479831207-32699-2-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add bindings information for stm32 timer MFD

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../devicetree/bindings/mfd/stm32-timer.txt        | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timer.txt

diff --git a/Documentation/devicetree/bindings/mfd/stm32-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
new file mode 100644
index 0000000..3cefce1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/stm32-timer.txt
@@ -0,0 +1,53 @@
+STM32 multifunctions timer driver
+
+stm32 timer MFD allow to handle at the same time pwm and IIO timer devices
+
+Required parameters:
+- compatible: must be one of the follow value:
+	"st,stm32-mfd-timer1"
+	"st,stm32-mfd-timer2"
+	"st,stm32-mfd-timer3"
+	"st,stm32-mfd-timer4"
+	"st,stm32-mfd-timer5"
+	"st,stm32-mfd-timer6"
+	"st,stm32-mfd-timer7"
+	"st,stm32-mfd-timer8"
+	"st,stm32-mfd-timer9"
+	"st,stm32-mfd-timer10"
+	"st,stm32-mfd-timer11"
+	"st,stm32-mfd-timer12"
+	"st,stm32-mfd-timer13"
+	"st,stm32-mfd-timer14"
+
+- reg :			Physical base address and length of the controller's
+			registers.
+- clock-names: 		Set to "mfd_timer_clk".
+- clocks: 		Phandle of the clock used by the timer module.
+			For Clk properties, please refer to [1].
+- interrupts :		Reference to the timer interrupt
+
+Optional parameters:
+- resets :		Reference to a reset controller asserting the timer
+
+Optional subnodes:
+- pwm:			See Documentation/devicetree/bindings/pwm/pwm-stm32.txt
+- iiotimer:		See Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Example:
+	mfd_timer1: mfdtimer1@40010000 {
+		compatible = "st,stm32-mfd-timer1";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "mfd_timer_clk";
+		interrupts = <27>;
+
+		pwm1: pwm1@40010000 {
+			compatible = "st,stm32-pwm1";
+		};
+
+		iiotimer1: iiotimer1@40010000 {
+			compatible = "st,stm32-iio-timer1";
+		};
+	};
-- 
1.9.1

