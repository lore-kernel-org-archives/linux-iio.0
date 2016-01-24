Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:pressure:Kconfig white space cleanup.
Date: Sun, 24 Jan 2016 17:06:50 +0000
Message-Id: <1453655210-13420-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Clearly a high degree of cut and paste has gone on in this file, propogating
a particularly random combination of tabs and spaces.  This patch at least
should make it all consistent going forward.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/pressure/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index e8f60dbf646e..cf03a43545a1 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -10,11 +10,11 @@ config BMP280
 	depends on I2C
 	select REGMAP_I2C
 	help
-	 Say yes here to build support for Bosch Sensortec BMP280
-	 pressure and temperature sensor.
+	  Say yes here to build support for Bosch Sensortec BMP280
+	  pressure and temperature sensor.
 
-	 To compile this driver as a module, choose M here: the module
-	 will be called bmp280.
+	  To compile this driver as a module, choose M here: the module
+	  will be called bmp280.
 
 config HID_SENSOR_PRESS
 	depends on HID_SENSOR_HUB
@@ -27,8 +27,8 @@ config HID_SENSOR_PRESS
 	  Say yes here to build support for the HID SENSOR
 	  Pressure driver
 
-          To compile this driver as a module, choose M here: the module
-          will be called hid-sensor-press.
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-sensor-press.
 
 config MPL115
 	tristate
@@ -41,8 +41,8 @@ config MPL115_I2C
 	  Say yes here to build support for the Freescale MPL115A2
 	  pressure sensor connected via I2C.
 
-          To compile this driver as a module, choose M here: the module
-          will be called mpl115_i2c.
+	  To compile this driver as a module, choose M here: the module
+	  will be called mpl115_i2c.
 
 config MPL115_SPI
 	tristate "Freescale MPL115A1 pressure sensor driver"
@@ -52,8 +52,8 @@ config MPL115_SPI
 	  Say yes here to build support for the Freescale MPL115A1
 	  pressure sensor connected via SPI.
 
-          To compile this driver as a module, choose M here: the module
-          will be called mpl115_spi.
+	  To compile this driver as a module, choose M here: the module
+	  will be called mpl115_spi.
 
 config MPL3115
 	tristate "Freescale MPL3115A2 pressure sensor driver"
@@ -64,8 +64,8 @@ config MPL3115
 	  Say yes here to build support for the Freescale MPL3115A2
 	  pressure sensor / altimeter.
 
-          To compile this driver as a module, choose M here: the module
-          will be called mpl3115.
+	  To compile this driver as a module, choose M here: the module
+	  will be called mpl3115.
 
 config MS5611
 	tristate "Measurement Specialties MS5611 pressure sensor driver"
@@ -97,7 +97,7 @@ config MS5611_SPI
 config MS5637
 	tristate "Measurement Specialties MS5637 pressure & temperature sensor"
 	depends on I2C
-        select IIO_MS_SENSORS_I2C
+	select IIO_MS_SENSORS_I2C
 	help
 	  If you say yes here you get support for the Measurement Specialties
 	  MS5637 pressure and temperature sensor.
@@ -143,7 +143,7 @@ config T5403
 	  Say yes here to build support for the EPCOS T5403 pressure sensor
 	  connected via I2C.
 
-          To compile this driver as a module, choose M here: the module
-          will be called t5403.
+	  To compile this driver as a module, choose M here: the module
+	  will be called t5403.
 
 endmenu
-- 
2.6.4
