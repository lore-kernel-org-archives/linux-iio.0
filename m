Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38421 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755756AbcKVQOC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2016 11:14:02 -0500
Received: by mail-wm0-f44.google.com with SMTP id f82so33247011wmf.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Nov 2016 08:14:01 -0800 (PST)
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
Subject: [PATCH 5/7] add bindings for stm32 IIO timer drivers
Date: Tue, 22 Nov 2016 17:13:25 +0100
Message-Id: <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
In-Reply-To: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Define bindings for stm32 IIO timer

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 .../bindings/iio/timer/stm32-iio-timer.txt         | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt

diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
new file mode 100644
index 0000000..b80025e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/timer/stm32-iio-timer.txt
@@ -0,0 +1,33 @@
+timer IIO trigger bindings for STM32
+
+Must be a child of STM32 multifunctions timer driver
+
+Required parameters:
+- compatible: must be one of the follow value:
+	"st,stm32-iio-timer1"
+	"st,stm32-iio-timer2"
+	"st,stm32-iio-timer3"
+	"st,stm32-iio-timer4"
+	"st,stm32-iio-timer5"
+	"st,stm32-iio-timer6"
+	"st,stm32-iio-timer7"
+	"st,stm32-iio-timer8"
+	"st,stm32-iio-timer9"
+	"st,stm32-iio-timer10"
+	"st,stm32-iio-timer11"
+	"st,stm32-iio-timer12"
+	"st,stm32-iio-timer13"
+	"st,stm32-iio-timer14"
+
+Example:
+	mfd_timer1: mfdtimer1@40010000 {
+		compatible = "st,stm32-mfd-timer1";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "mfd_timer_clk";
+		interrupts = <27>;
+
+		trigger1: trigger1@40010000 {
+			compatible = "st,stm32-iio-timer1";
+		};
+	};
-- 
1.9.1

