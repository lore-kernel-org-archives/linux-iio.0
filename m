Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:35786 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab1IUKHr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2011 06:07:47 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org, greg@kroah.com
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/14] staging: iio: Move sensor drivers to sub menus
Date: Wed, 21 Sep 2011 11:15:50 +0100
Message-Id: <1316600162-15581-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
References: <1316600162-15581-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

We have a lot of drivers now, so the iio sub menu becomes quite large.
This patch creates sub menus for the different sensors.

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/Kconfig              |    4 +++-
 drivers/staging/iio/adc/Kconfig                |    4 +++-
 drivers/staging/iio/addac/Kconfig              |    4 +++-
 drivers/staging/iio/dac/Kconfig                |    4 +++-
 drivers/staging/iio/dds/Kconfig                |    4 +++-
 drivers/staging/iio/gyro/Kconfig               |    4 +++-
 drivers/staging/iio/impedance-analyzer/Kconfig |    4 +++-
 drivers/staging/iio/imu/Kconfig                |    4 +++-
 drivers/staging/iio/light/Kconfig              |    4 +++-
 drivers/staging/iio/magnetometer/Kconfig       |    3 ++-
 drivers/staging/iio/meter/Kconfig              |    4 +++-
 drivers/staging/iio/resolver/Kconfig           |    3 ++-
 12 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 81a33b6..bf38114 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -1,7 +1,7 @@
 #
 # Accelerometer drivers
 #
-comment "Accelerometers"
+menu "Accelerometers"
 
 config ADIS16201
 	tristate "Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer"
@@ -100,3 +100,5 @@ config SCA3000
 	help
 	  Say yes here to build support for the VTI SCA3000 series of SPI
 	  accelerometers. These devices use a hardware ring buffer.
+
+endmenu
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 0482073..27dda13 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -1,7 +1,7 @@
 #
 # ADC drivers
 #
-comment "Analog to digital convertors"
+menu "Analog to digital convertors"
 
 config AD7150
 	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
@@ -229,3 +229,5 @@ config MAX1363_RING_BUFFER
 	help
 	  Say yes here to include ring buffer support in the MAX1363
 	  ADC driver.
+
+endmenu
diff --git a/drivers/staging/iio/addac/Kconfig b/drivers/staging/iio/addac/Kconfig
index 9847baf..869540e 100644
--- a/drivers/staging/iio/addac/Kconfig
+++ b/drivers/staging/iio/addac/Kconfig
@@ -1,7 +1,7 @@
 #
 # ADDAC drivers
 #
-comment "Analog digital bi-direction convertors"
+menu "Analog digital bi-direction convertors"
 
 config ADT7316
 	tristate "Analog Devices ADT7316/7/8 ADT7516/7/9 temperature sensor, ADC and DAC driver"
@@ -23,3 +23,5 @@ config ADT7316_I2C
 	help
 	  Say yes here to build I2C bus support for Analog Devices ADT7316/7/8
 	  and ADT7516/7/9.
+
+endmenu
diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index 7ddae35..3000156 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -1,7 +1,7 @@
 #
 # DAC drivers
 #
-comment "Digital to analog convertors"
+menu "Digital to analog convertors"
 
 config AD5624R_SPI
 	tristate "Analog Devices AD5624/44/64R DAC spi driver"
@@ -62,3 +62,5 @@ config MAX517
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called max517.
+
+endmenu
diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/dds/Kconfig
index e07431d..93b7141 100644
--- a/drivers/staging/iio/dds/Kconfig
+++ b/drivers/staging/iio/dds/Kconfig
@@ -1,7 +1,7 @@
 #
 # Direct Digital Synthesis drivers
 #
-comment "Direct Digital Synthesis"
+menu "Direct Digital Synthesis"
 
 config AD5930
 	tristate "Analog Devices ad5930/5932 driver"
@@ -57,3 +57,5 @@ config AD9951
 	help
 	  Say yes here to build support for Analog Devices DDS chip
 	  ad9951, provides direct access via sysfs.
+
+endmenu
diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index ae2e7d3..86774e3 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -1,7 +1,7 @@
 #
 # IIO Digital Gyroscope Sensor drivers configuration
 #
-comment "Digital gyroscope sensors"
+menu "Digital gyroscope sensors"
 
 config ADIS16060
 	tristate "Analog Devices ADIS16060 Yaw Rate Gyroscope with SPI driver"
@@ -45,3 +45,5 @@ config ADXRS450
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called adxrs450.
+
+endmenu
diff --git a/drivers/staging/iio/impedance-analyzer/Kconfig b/drivers/staging/iio/impedance-analyzer/Kconfig
index 9e91a9b..cce1ce3 100644
--- a/drivers/staging/iio/impedance-analyzer/Kconfig
+++ b/drivers/staging/iio/impedance-analyzer/Kconfig
@@ -1,7 +1,7 @@
 #
 # Impedance Converter, Network Analyzer drivers
 #
-comment "Network Analyzer, Impedance Converters"
+menu "Network Analyzer, Impedance Converters"
 
 config AD5933
 	tristate "Analog Devices AD5933, AD5934 driver"
@@ -14,3 +14,5 @@ config AD5933
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5933.
+
+endmenu
diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index e0e0144..233c76a 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -1,7 +1,7 @@
 #
 # IIO imu drivers configuration
 #
-comment "Inertial measurement units"
+menu "Inertial measurement units"
 
 config ADIS16400
 	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
@@ -13,3 +13,5 @@ config ADIS16400
 	  adis16354, adis16355, adis16360, adis16362, adis16364, adis16365,
 	  adis16400 and adis16405 triaxial inertial sensors (adis16400 series
 	  also have magnetometers).
+
+endmenu
diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index 1ad2d56..e7e9159 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -1,7 +1,7 @@
 #
 # Light sensors
 #
-comment "Light sensors"
+menu "Light sensors"
 
 config SENSORS_ISL29018
         tristate "ISL 29018 light and proximity sensor"
@@ -30,3 +30,5 @@ config TSL2583
 	help
 	 Provides support for the TAOS tsl2580, tsl2581 and tsl2583 devices.
 	 Access ALS data via iio, sysfs.
+
+endmenu
diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
index 81b579d..b8c149d 100644
--- a/drivers/staging/iio/magnetometer/Kconfig
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -1,7 +1,7 @@
 #
 # Magnetometer sensors
 #
-comment "Magnetometer sensors"
+menu "Magnetometer sensors"
 
 config SENSORS_AK8975
 	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
@@ -23,3 +23,4 @@ config SENSORS_HMC5843
 	  To compile this driver as a module, choose M here: the module
 	  will be called hmc5843
 
+endmenu
diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index 12e36e4..a8deab2 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -1,7 +1,7 @@
 #
 # IIO meter drivers configuration
 #
-comment "Active energy metering IC"
+menu "Active energy metering IC"
 
 config ADE7753
 	tristate "Analog Devices ADE7753/6 Single-Phase Multifunction Metering IC Driver"
@@ -59,3 +59,5 @@ config ADE7854_SPI
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ade7854-spi.
+
+endmenu
diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
index 6ecd79e..07c309b 100644
--- a/drivers/staging/iio/resolver/Kconfig
+++ b/drivers/staging/iio/resolver/Kconfig
@@ -1,7 +1,7 @@
 #
 # Resolver/Synchro drivers
 #
-comment "Resolver to digital converters"
+menu "Resolver to digital converters"
 
 config AD2S90
 	tristate "Analog Devices ad2s90 driver"
@@ -25,3 +25,4 @@ config AD2S1210
 	  Say yes here to build support for Analog Devices spi resolver
 	  to digital converters, ad2s1210, provides direct access via sysfs.
 
+endmenu
-- 
1.7.3.4

