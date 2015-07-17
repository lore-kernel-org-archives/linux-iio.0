Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 2/8] iio:magnetometer:bmc150_magn: sort entry alphabetically
Date: Fri, 17 Jul 2015 10:52:25 +0200
Message-Id: <187b63157fb2a62f1d4d4820a5fb4b914298c7a7.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437090791.git.knaack.h@gmx.de>
References: <cover.1437090791.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Sort the entry for bmc105_magn in Kconfig and Makefile to its correct
position. Also add the minor module information for completeness.

Fixes: c91746a2361d ("iio: magn: Add support for BMC150 magnetometer")

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/magnetometer/Kconfig  | 33 ++++++++++++++++++---------------
 drivers/iio/magnetometer/Makefile |  3 +--
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index efb9350b0d76..868abada3409 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -24,6 +24,24 @@ config AK09911
 	help
 	  Deprecated: AK09911 is now supported by AK8975 driver.
 
+config BMC150_MAGN
+	tristate "Bosch BMC150 Magnetometer Driver"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for the BMC150 magnetometer.
+
+	  Currently this only supports the device via an i2c interface.
+
+	  This is a combo module with both accelerometer and magnetometer.
+	  This driver is only implementing magnetometer part, which has
+	  its own address and register map.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called bmc150_magn.
+
 config MAG3110
 	tristate "Freescale MAG3110 3-Axis Magnetometer"
 	depends on I2C
@@ -87,19 +105,4 @@ config IIO_ST_MAGN_SPI_3AXIS
 	depends on IIO_ST_MAGN_3AXIS
 	depends on IIO_ST_SENSORS_SPI
 
-config BMC150_MAGN
-	tristate "Bosch BMC150 Magnetometer Driver"
-	depends on I2C
-	select REGMAP_I2C
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for the BMC150 magnetometer.
-
-	  Currently this only supports the device via an i2c interface.
-
-	  This is a combo module with both accelerometer and magnetometer.
-	  This driver is only implementing magnetometer part, which has
-	  its own address and register map.
-
 endmenu
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 33b1d4d54ee7..2c72df458ec2 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -4,6 +4,7 @@
 
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AK8975)	+= ak8975.o
+obj-$(CONFIG_BMC150_MAGN) += bmc150_magn.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
@@ -14,5 +15,3 @@ st_magn-$(CONFIG_IIO_BUFFER) += st_magn_buffer.o
 
 obj-$(CONFIG_IIO_ST_MAGN_I2C_3AXIS) += st_magn_i2c.o
 obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) += st_magn_spi.o
-
-obj-$(CONFIG_BMC150_MAGN) += bmc150_magn.o
-- 
2.4.3
