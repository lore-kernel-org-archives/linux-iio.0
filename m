Return-Path: <SRS0=n5mi=JH=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jic23@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	fabrice.gasnier@st.com,
	benjamin.gaignard@st.com,
	robh+dt@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mark.rutland@arm.com,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v7 07/10] dt-bindings: counter: Document stm32 quadrature encoder
Date: Thu, 21 Jun 2018 17:08:34 -0400
Message-Id: <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Add bindings for STM32 Timer quadrature encoder.
It is a sub-node of STM32 Timer which implement the
quadratic encoder part of the hardware.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../bindings/counter/stm32-timer-cnt.txt      | 31 +++++++++++++++++++
 .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

diff --git a/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
new file mode 100644
index 000000000000..c52fcdd4bf6c
--- /dev/null
+++ b/Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt
@@ -0,0 +1,31 @@
+STMicroelectronics STM32 Timer quadrature encoder
+
+STM32 Timer provides quadrature encoder to detect
+angular position and direction of rotary elements,
+from IN1 and IN2 input signals.
+
+Must be a sub-node of an STM32 Timer device tree node.
+See ../mfd/stm32-timers.txt for details about the parent node.
+
+Required properties:
+- compatible:		Must be "st,stm32-timer-counter".
+- pinctrl-names: 	Set to "default".
+- pinctrl-0: 		List of phandles pointing to pin configuration nodes,
+			to set CH1/CH2 pins in mode of operation for STM32
+			Timer input on external pin.
+
+Example:
+	timers@40010000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "st,stm32-timers";
+		reg = <0x40010000 0x400>;
+		clocks = <&rcc 0 160>;
+		clock-names = "int";
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
+	};
diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
index 1db6e0057a63..ff9c14ada30b 100644
--- a/Documentation/devicetree/bindings/mfd/stm32-timers.txt
+++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
@@ -23,6 +23,7 @@ Optional parameters:
 Optional subnodes:
 - pwm:			See ../pwm/pwm-stm32.txt
 - timer:		See ../iio/timer/stm32-timer-trigger.txt
+- counter:		See ../counter/stm32-timer-cnt.txt
 
 Example:
 	timers@40010000 {
@@ -43,4 +44,10 @@ Example:
 			compatible = "st,stm32-timer-trigger";
 			reg = <0>;
 		};
+
+		counter {
+			compatible = "st,stm32-timer-counter";
+			pinctrl-names = "default";
+			pinctrl-0 = <&tim1_in_pins>;
+		};
 	};
-- 
2.17.1
