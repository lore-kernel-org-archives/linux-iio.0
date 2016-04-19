Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18586 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506AbcDSMC0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Apr 2016 08:02:26 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Denis Ciocca <denis.ciocca@st.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
Subject: [PATCH] iio: st_gyro: Add lsm9ds0-gyro support
Date: Tue, 19 Apr 2016 15:02:11 +0300
Message-Id: <ac4fe7acfefefbb33219fc395838443c00bce8ba.1461067167.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This device has an identical interface to other supported sensors and the patch
only adds IDs.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 Documentation/devicetree/bindings/iio/st-sensors.txt | 1 +
 drivers/iio/gyro/Kconfig                             | 2 +-
 drivers/iio/gyro/st_gyro.h                           | 1 +
 drivers/iio/gyro/st_gyro_core.c                      | 1 +
 drivers/iio/gyro/st_gyro_i2c.c                       | 5 +++++
 drivers/iio/gyro/st_gyro_spi.c                       | 1 +
 6 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 637e283..5844cf7 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -51,6 +51,7 @@ Gyroscopes:
 - st,l3gd20-gyro
 - st,l3g4is-gyro
 - st,lsm330-gyro
+- st,lsm9ds0-gyro
 
 Magnetometers:
 - st,lsm303agr-magn
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index e816d29..205a844 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -93,7 +93,7 @@ config IIO_ST_GYRO_3AXIS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics gyroscopes:
-	  L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330.
+	  L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330, LSM9DS0.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index 5353d63..a5c5c4e 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -21,6 +21,7 @@
 #define L3GD20_GYRO_DEV_NAME		"l3gd20"
 #define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
+#define LSM9DS0_GYRO_DEV_NAME		"lsm9ds0_gyro"
 
 /**
  * struct st_sensors_platform_data - gyro platform data
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index be9057e..52a3c87 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -204,6 +204,7 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 			[2] = LSM330DLC_GYRO_DEV_NAME,
 			[3] = L3G4IS_GYRO_DEV_NAME,
 			[4] = LSM330_GYRO_DEV_NAME,
+			[5] = LSM9DS0_GYRO_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
 		.odr = {
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 6848451..40056b8 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -48,6 +48,10 @@ static const struct of_device_id st_gyro_of_match[] = {
 		.compatible = "st,lsm330-gyro",
 		.data = LSM330_GYRO_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm9ds0-gyro",
+		.data = LSM9DS0_GYRO_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_gyro_of_match);
@@ -93,6 +97,7 @@ static const struct i2c_device_id st_gyro_id_table[] = {
 	{ L3GD20_GYRO_DEV_NAME },
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
+	{ LSM9DS0_GYRO_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index d2b7a5f..fbf2fae 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -54,6 +54,7 @@ static const struct spi_device_id st_gyro_id_table[] = {
 	{ L3GD20_GYRO_DEV_NAME },
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
+	{ LSM9DS0_GYRO_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
-- 
2.5.5

