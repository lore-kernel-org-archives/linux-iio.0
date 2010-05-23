Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: devel@driverdev.osuosl.org,
	Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] staging: iio: standardize kconfig/makefile spacing/style
Date: Sun, 23 May 2010 03:00:02 -0400
Message-Id: <1274598002-8978-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

Standardize the spacing/style across the IIO build files:
	- comment block in Kconfigs
	- newlines at ends of files
	- trailing lines at ends of files
	- indent with one tab, not spaces or mixed

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/Makefile         |    3 +-
 drivers/staging/iio/accel/Kconfig    |   50 +++++++++++++++++-----------------
 drivers/staging/iio/accel/Makefile   |    3 +-
 drivers/staging/iio/adc/Makefile     |    2 +-
 drivers/staging/iio/gyro/Makefile    |    2 +-
 drivers/staging/iio/imu/Kconfig      |    8 +++---
 drivers/staging/iio/imu/Makefile     |    3 +-
 drivers/staging/iio/light/Kconfig    |    1 -
 drivers/staging/iio/trigger/Makefile |    3 +-
 9 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 3502b39..fff717e 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -14,5 +14,4 @@ obj-y += adc/
 obj-y += gyro/
 obj-y += imu/
 obj-y += light/
-
-obj-y += trigger/
\ No newline at end of file
+obj-y += trigger/
diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index b4e57d1..5926c03 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -4,29 +4,29 @@
 comment "Accelerometers"
 
 config ADIS16209
-       tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
-       depends on SPI
-       select IIO_TRIGGER if IIO_RING_BUFFER
-       select IIO_SW_RING if IIO_RING_BUFFER
-       help
-         Say yes here to build support for Analog Devices adis16209 dual-axis digital inclinometer
-	 and accelerometer.
+	tristate "Analog Devices ADIS16209 Dual-Axis Digital Inclinometer and Accelerometer"
+	depends on SPI
+	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_SW_RING if IIO_RING_BUFFER
+	help
+	  Say yes here to build support for Analog Devices adis16209 dual-axis digital inclinometer
+	  and accelerometer.
 
 config ADIS16220
-       tristate "Analog Devices ADIS16220 Programmable Digital Vibration Sensor driver"
-       depends on SPI
-       help
-         Say yes here to build support for Analog Devices adis16220 programmable
-         digital vibration sensor.
+	tristate "Analog Devices ADIS16220 Programmable Digital Vibration Sensor"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices adis16220 programmable
+	  digital vibration sensor.
 
 config ADIS16240
-       tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
-       depends on SPI
-       select IIO_TRIGGER if IIO_RING_BUFFER
-       select IIO_SW_RING if IIO_RING_BUFFER
-       help
-         Say yes here to build support for Analog Devices adis16240 programmable
-	 impact Sensor and recorder.
+	tristate "Analog Devices ADIS16240 Programmable Impact Sensor and Recorder"
+	depends on SPI
+	select IIO_TRIGGER if IIO_RING_BUFFER
+	select IIO_SW_RING if IIO_RING_BUFFER
+	help
+	  Say yes here to build support for Analog Devices adis16240 programmable
+	  impact Sensor and recorder.
 
 config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
@@ -46,9 +46,9 @@ config LIS3L02DQ
 	  and an event interface via a character device.
 
 config SCA3000
-       depends on IIO_RING_BUFFER
-       depends on SPI
-       tristate "VTI SCA3000 series accelerometers"
-       help
-         Say yes here to build support for the VTI SCA3000 series of SPI
-	 accelerometers. These devices use a hardware ring buffer.
\ No newline at end of file
+	depends on IIO_RING_BUFFER
+	depends on SPI
+	tristate "VTI SCA3000 series accelerometers"
+	help
+	  Say yes here to build support for the VTI SCA3000 series of SPI
+	  accelerometers. These devices use a hardware ring buffer.
diff --git a/drivers/staging/iio/accel/Makefile b/drivers/staging/iio/accel/Makefile
index c34b136..ff84703 100644
--- a/drivers/staging/iio/accel/Makefile
+++ b/drivers/staging/iio/accel/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for industrial I/O accelerometer drivers
 #
+
 adis16209-y             := adis16209_core.o
 adis16209-$(CONFIG_IIO_RING_BUFFER) += adis16209_ring.o adis16209_trigger.o
 obj-$(CONFIG_ADIS16209) += adis16209.o
@@ -19,4 +20,4 @@ lis3l02dq-$(CONFIG_IIO_RING_BUFFER) += lis3l02dq_ring.o
 obj-$(CONFIG_LIS3L02DQ)	+= lis3l02dq.o
 
 sca3000-y		:= sca3000_core.o sca3000_ring.o
-obj-$(CONFIG_SCA3000)	+= sca3000.o
\ No newline at end of file
+obj-$(CONFIG_SCA3000)	+= sca3000.o
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index 18c9376..688510f 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -1,4 +1,4 @@
-
+#
 # Makefile for industrial I/O ADC drivers
 #
 
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 6d2c547..b5f0dc0 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -1,4 +1,4 @@
-
+#
 # Makefile for digital gyroscope sensor drivers
 #
 
diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 6308d6f..48a712e 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -24,10 +24,10 @@ config ADIS16350
 
 config ADIS16400
 	tristate "Analog Devices ADIS16400/5 IMU SPI driver"
- 	depends on SPI
+	depends on SPI
 	select IIO_SW_RING
 	select IIO_RING_BUFFER
 	select IIO_TRIGGER
- 	help
- 	  Say yes here to build support for Analog Devices adis16400/5 triaxial
- 	  inertial sensor with Magnetometer.
\ No newline at end of file
+	help
+	  Say yes here to build support for Analog Devices adis16400/5 triaxial
+	  inertial sensor with Magnetometer.
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
index 31df735..f3b450b 100644
--- a/drivers/staging/iio/imu/Makefile
+++ b/drivers/staging/iio/imu/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for Inertial Measurement Units
 #
+
 adis16300-y             := adis16300_core.o
 adis16300-$(CONFIG_IIO_RING_BUFFER) += adis16300_ring.o adis16300_trigger.o
 obj-$(CONFIG_ADIS16300) += adis16300.o
@@ -11,4 +12,4 @@ obj-$(CONFIG_ADIS16350) += adis16350.o
 
 adis16400-y             := adis16400_core.o
 adis16400-$(CONFIG_IIO_RING_BUFFER) += adis16400_ring.o adis16400_trigger.o
-obj-$(CONFIG_ADIS16400) += adis16400.o
\ No newline at end of file
+obj-$(CONFIG_ADIS16400) += adis16400.o
diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index 80cb6e5..3ddc478 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -12,4 +12,3 @@ config SENSORS_TSL2563
 
 	 This driver can also be built as a module.  If so, the module
 	 will be called tsl2563.
-
diff --git a/drivers/staging/iio/trigger/Makefile b/drivers/staging/iio/trigger/Makefile
index e5f96d2..10aeca5 100644
--- a/drivers/staging/iio/trigger/Makefile
+++ b/drivers/staging/iio/trigger/Makefile
@@ -1,5 +1,6 @@
 #
 # Makefile for triggers not associated with iio-devices
 #
+
 obj-$(CONFIG_IIO_PERIODIC_RTC_TRIGGER) += iio-trig-periodic-rtc.o
-obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
\ No newline at end of file
+obj-$(CONFIG_IIO_GPIO_TRIGGER) += iio-trig-gpio.o
-- 
1.7.1
