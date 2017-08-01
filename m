Return-Path: <SRS0=VHTk=7D=gmail.com=s.abhisit@kernel.org>
From: s.abhisit@gmail.com
To: linus.walleij@linaro.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Abhisit Sangjan <s.abhisit@gmail.com>
Subject: [PATCH 5/5] Documentation: bindings: Add ti,lmp92001
Date: Tue,  1 Aug 2017 16:17:53 +0700
Message-Id: <1501579073-4764-1-git-send-email-s.abhisit@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Abhisit Sangjan <s.abhisit@gmail.com>

---
 .../devicetree/bindings/gpio/gpio-lmp92001.txt     | 29 ++++++++++++++++++
 .../bindings/iio/adc/ti-lmp92001-adc.txt           | 21 +++++++++++++
 .../bindings/iio/dac/ti-lmp92001-dac.txt           | 35 ++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
new file mode 100644
index 0000000..62267ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-lmp92001.txt
@@ -0,0 +1,29 @@
+* Texas Instruments' LMP92001 GPIOs
+
+Required properties:
+ - compatible: Must be set to "ti,lmp92001-gpio".
+ - reg: i2c chip address for the device.
+ - gpio-controller: Marks the device node as a gpio controller.
+ - #gpio-cells : Should be two.  The first cell is the pin number and the
+  second cell is used to specify the gpio polarity:
+        0 = Active high
+        1 = Active low
+- ti,lmp92001-gpio-dir: bit mask for direction and drive logic default. Since
+  the direction and the internal pull-down are shared register and similar to
+  open-collector drive:
+        0 = [O]utput and also meaning drive it to low
+        1 = [I]nput and also meaning open, to drive it to high is required to
+        have an external resistor
+
+Example:
+lmp92001@20 {
+        compatible = "ti,lmp92001";
+        reg = <0x20>;
+
+        lmp92001_gpio: lmp92001-gpio {
+                compatible = "ti,lmp92001-gpio";
+                gpio-controller;
+                #gpio-cells = <2>;
+                ti,lmp92001-gpio-dir = /bits/ 8 <0xff>;
+        };
+};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
new file mode 100644
index 0000000..34d7809
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-lmp92001-adc.txt
@@ -0,0 +1,21 @@
+* Texas Instruments' LMP92001 ADCs
+
+Required properties:
+ - compatible: Must be set to "ti,lmp92001-adc".
+ - reg: i2c chip address for the device.
+ - ti,lmp92001-adc-mode: adc operation, either continuous or single-shot.
+ - ti,lmp92001-adc-mask: bit mask for which channel is enable.
+        0 = Off
+        1 = On
+
+Example:
+lmp92001@20 {
+        compatible = "ti,lmp92001";
+        reg = <0x20>;
+
+        lmp92001-adc {
+                compatible = "ti,lmp92001-adc";
+                ti,lmp92001-adc-mode = "continuous";
+                ti,lmp92001-adc-mask = <0x00000079>;
+        };
+};
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt b/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
new file mode 100644
index 0000000..f058cc0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ti-lmp92001-dac.txt
@@ -0,0 +1,35 @@
+* Texas Instruments' LMP92001 DACs
+
+Required properties:
+ - compatible: Must be set to "ti,lmp92001-dac".
+ - reg: i2c chip address for the device.
+ - ti,lmp92001-dac-hiz: hi-impedance control,
+        1 = Forces all OUT[1:12] outputs to hi-z, 0 = normal
+ - ti,lmp92001-dac-outx: 
+        Cy = 0, 1 = will force associated OUTx outputs to VDD
+        Cy = 0, 0 = will force associated OUTx outputs to GND
+ - ti,lmp92001-dac-gang: What group of Cy is governed to.
+        -----------------------------------------
+        |  Cy   | CDAC:GANG = 0 | CDAC:GANG = 1 |
+        -----------------------------------------
+        |  C1   |   OUT[1:4]    |    OUT[1:3]   |
+        -----------------------------------------
+        |  C2   |   OUT[5:6]    |    OUT[4:6]   |
+        -----------------------------------------
+        |  C3   |   OUT[7:8]    |    OUT[7:9]   |
+        -----------------------------------------
+        |  C4   |   OUT[9:12]   |    OUT[10:12] |
+        ----------------------------------------- 
+
+Example:
+lmp92001@20 {
+        compatible = "ti,lmp92001";
+        reg = <0x20>;
+
+        lmp92001-dac {
+                compatible = "ti,lmp92001-dac";
+                ti,lmp92001-dac-hiz  = /bits/ 8 <0>;
+                ti,lmp92001-dac-outx = /bits/ 8 <0>;
+                ti,lmp92001-dac-gang = /bits/ 8 <0>;
+        };
+};
-- 
2.7.4
