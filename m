Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:50589 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750920Ab3ATM4Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Jan 2013 07:56:25 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] Rework the Makefile / Kconfig for the st accel driver so that all options work.
Date: Sun, 20 Jan 2013 12:56:15 +0000
Message-Id: <1358686575-16779-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1358686575-16779-1-git-send-email-jic23@kernel.org>
References: <50FBE8F8.7010300@kernel.org>
 <1358686575-16779-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/iio/accel/Kconfig        | 42 ++--------------------------------------
 drivers/iio/accel/Makefile       |  7 +++++--
 drivers/iio/accel/st_accel_i2c.c |  2 +-
 drivers/iio/accel/st_accel_spi.c |  2 +-
 4 files changed, 9 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index dbc1af0..c396ae1 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -40,55 +40,17 @@ config IIO_ST_ACCEL_3AXIS
 	  - st_accel_i2c (necessary for the I2C devices [optional*]);
 	  - st_accel_spi (necessary for the SPI devices [optional*]);
 	  - st_accel_buffer (necessary for triggered buffer [optional]);
-	  
-	  (*) one of these is necessary to do something.
-
-config IIO_ST_ACCEL_I2C_3AXIS
-	tristate
-	depends on IIO_ST_ACCEL_3AXIS
-
-config IIO_ST_ACCEL_SPI_3AXIS
-	tristate
-	depends on IIO_ST_ACCEL_3AXIS
-
-config IIO_ST_ACCEL_BUFFER
-	tristate
-	depends on IIO_ST_ACCEL_3AXIS
-	depends on (IIO_ST_ACCEL_I2C_3AXIS || IIO_ST_ACCEL_SPI_3AXIS)
-
-config IIO_ST_ACCEL_3AXIS
-	tristate "STMicroelectronics accelerometers 3-Axis Driver"
-	depends on (I2C || SPI_MASTER) && SYSFS
-	select IIO_ST_SENSORS_CORE
-	select IIO_ST_ACCEL_I2C_3AXIS if (I2C)
-	select IIO_ST_ACCEL_SPI_3AXIS if (SPI_MASTER)
-	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
-	select IIO_ST_ACCEL_BUFFER if (IIO_TRIGGERED_BUFFER)
-	help
-	  Say yes here to build support for STMicroelectronics accelerometers:
-	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
-	  LIS331DLH, LSM303DL, LSM303DLM, LSM330.
 
-	  This driver can also be built as a module. If so, will be created
-	  these modules:
-	  - st_accel_core (core functions for the driver [it is mandatory]);
-	  - st_accel_i2c (necessary for the I2C devices [optional*]);
-	  - st_accel_spi (necessary for the SPI devices [optional*]);
-	  - st_accel_buffer (necessary for triggered buffer [optional]);
-	  
 	  (*) one of these is necessary to do something.
 
 config IIO_ST_ACCEL_I2C_3AXIS
 	tristate
 	depends on IIO_ST_ACCEL_3AXIS
+	depends on IIO_ST_SENSORS_I2C
 
 config IIO_ST_ACCEL_SPI_3AXIS
 	tristate
 	depends on IIO_ST_ACCEL_3AXIS
-
-config IIO_ST_ACCEL_BUFFER
-	tristate
-	depends on IIO_ST_ACCEL_3AXIS
-	depends on (IIO_ST_ACCEL_I2C_3AXIS || IIO_ST_ACCEL_SPI_3AXIS)
+	depends on IIO_ST_SENSORS_SPI
 
 endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 820c17a..8d7a1c6 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -5,7 +5,10 @@
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
 
-obj-$(CONFIG_IIO_ST_ACCEL_3AXIS) += st_accel_core.o
+obj-$(CONFIG_IIO_ST_ACCEL_3AXIS) += st_accel.o
+st_accel-y := st_accel_core.o
+st_accel-$(CONFIG_IIO_BUFFER) += st_accel_buffer.o
+
 obj-$(CONFIG_IIO_ST_ACCEL_I2C_3AXIS) += st_accel_i2c.o
 obj-$(CONFIG_IIO_ST_ACCEL_SPI_3AXIS) += st_accel_spi.o
-obj-$(CONFIG_IIO_ST_ACCEL_BUFFER) += st_accel_buffer.o
+
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index e782717..066a9fb 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -17,7 +17,7 @@
 
 #include <linux/iio/accel/st_accel.h>
 #include <linux/iio/common/st_sensors.h>
-
+#include <linux/iio/common/st_i2c.h>
 
 static int st_accel_i2c_probe(struct i2c_client *client,
 						const struct i2c_device_id *id)
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 92e78ba..67532eb 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -17,7 +17,7 @@
 
 #include <linux/iio/accel/st_accel.h>
 #include <linux/iio/common/st_sensors.h>
-
+#include <linux/iio/common/st_spi.h>
 
 static int st_accel_spi_probe(struct spi_device *spi)
 {
-- 
1.8.1

