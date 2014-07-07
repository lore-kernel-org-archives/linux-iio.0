Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Denis CIOCCA <denis.ciocca@st.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org
Subject: [RESEND PATCH 2/3] iio: st_sensors: add device tree bindings
Date: Mon,  7 Jul 2014 11:48:06 +0200
Message-Id: <1404726486-2610-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This adds some basic, simple device tree bindings to the STMicro
MEMS sensor drivers.

Cc: devicetree@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../devicetree/bindings/iio/st-sensors.txt         | 54 ++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/st-sensors.txt

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
new file mode 100644
index 000000000000..a7a0a15913ad
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -0,0 +1,54 @@
+STMicroelectronics MEMS sensors
+
+The STMicroelectronics sensor devices are pretty straight-forward I2C or
+SPI devices, all sharing the same device tree descriptions no matter what
+type of sensor it is.
+
+Required properties:
+- compatible: see the list of valid compatible strings below
+- reg: the I2C or SPI address the device will respond to
+
+Optional properties:
+- vdd-supply: an optional regulator that needs to be on to provide VDD
+  power to the sensor.
+- vddio-supply: an optional regulator that needs to be on to provide the
+  VDD IO power to the sensor.
+- st,drdy-int-pin: the pin on the package that will be used to signal
+  "data ready" (valid values: 1 or 2). This property is not configurable
+  on all sensors.
+
+Sensors may also have applicable pin control settings, those use the
+standard bindings from pinctrl/pinctrl-bindings.txt.
+
+Valid compatible strings:
+
+Accelerometers:
+- st,lsm303dlh-accel
+- st,lsm303dlhc-accel
+- st,lis3dh-accel
+- st,lsm330d-accel
+- st,lsm330dl-accel
+- st,lsm330dlc-accel
+- st,lis331dlh-accel
+- st,lsm303dl-accel
+- st,lsm303dlm-accel
+- st,lsm330-accel
+
+Gyroscopes:
+- st,l3g4200d-gyro
+- st,lsm330d-gyro
+- st,lsm330dl-gyro
+- st,lsm330dlc-gyro
+- st,l3gd20-gyro
+- st,l3g4is-gyro
+- st,lsm330-gyro
+
+Magnetometers:
+- st,lsm303dlhc-magn
+- st,lsm303dlm-magn
+- st,lis3mdl-magn
+
+Pressure sensors:
+- st,lps001wp-press
+- st,lps25h-press
+- st,lps331ap-press
-- 
1.9.3
