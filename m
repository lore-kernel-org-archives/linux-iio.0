Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:52531 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751347AbaBHNkt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 08:40:49 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:gyro: Bugfix L3GD20H gyroscope support
Date: Sat,  8 Feb 2014 14:37:21 +0100
Message-Id: <1391866641-26226-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fix L3GD20H gyroscope support. The driver was not able
to manage the sensor: during probe function and wai check,
the driver stops and writes: "device name and WhoAmI mismatch."
The correct value of L3GD20H WAI is 0xd7 instead of 0xd4.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro.h                     |   6 +-
 drivers/iio/gyro/st_gyro_core.c                | 102 +++++++++++++++++++++++--
 drivers/iio/gyro/st_gyro_i2c.c                 |   3 +-
 drivers/iio/gyro/st_gyro_spi.c                 |   3 +-
 include/linux/platform_data/st_sensors_pdata.h |   2 +-
 5 files changed, 101 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index f8f2bf8..3d829fc 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -24,10 +24,10 @@
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 
 /**
- * struct st_sensors_platform_data - gyro platform data
- * @drdy_int_pin: DRDY on gyros is available only on INT2 pin.
+ * struct st_sensors_platform_data - default gyro platform data
+ * @drdy_int_pin: default gyro DRDY is available on INT2 pin.
  */
-static const struct st_sensors_platform_data gyro_pdata = {
+static const struct st_sensors_platform_data default_gyro_pdata = {
 	.drdy_int_pin = 2,
 };
 
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index d53d91a..c4fbe3a 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -35,6 +35,7 @@
 #define ST_GYRO_DEFAULT_OUT_Z_L_ADDR		0x2c
 
 /* FULLSCALE */
+#define ST_GYRO_FS_AVL_245DPS			245
 #define ST_GYRO_FS_AVL_250DPS			250
 #define ST_GYRO_FS_AVL_500DPS			500
 #define ST_GYRO_FS_AVL_2000DPS			2000
@@ -87,6 +88,31 @@
 #define ST_GYRO_2_DRDY_IRQ_INT2_MASK		0x08
 #define ST_GYRO_2_MULTIREAD_BIT			true
 
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define ST_GYRO_3_WAI_EXP			0xd7
+#define ST_GYRO_3_ODR_ADDR			0x20
+#define ST_GYRO_3_ODR_MASK			0xc0
+#define ST_GYRO_3_ODR_AVL_100HZ_VAL		0x00
+#define ST_GYRO_3_ODR_AVL_200HZ_VAL		0x01
+#define ST_GYRO_3_ODR_AVL_400HZ_VAL		0x02
+#define ST_GYRO_3_ODR_AVL_800HZ_VAL		0x03
+#define ST_GYRO_3_PW_ADDR			0x20
+#define ST_GYRO_3_PW_MASK			0x08
+#define ST_GYRO_3_FS_ADDR			0x23
+#define ST_GYRO_3_FS_MASK			0x30
+#define ST_GYRO_3_FS_AVL_245_VAL		0x00
+#define ST_GYRO_3_FS_AVL_500_VAL		0x01
+#define ST_GYRO_3_FS_AVL_2000_VAL		0x02
+#define ST_GYRO_3_FS_AVL_245_GAIN		IIO_DEGREE_TO_RAD(8750)
+#define ST_GYRO_3_FS_AVL_500_GAIN		IIO_DEGREE_TO_RAD(17500)
+#define ST_GYRO_3_FS_AVL_2000_GAIN		IIO_DEGREE_TO_RAD(70000)
+#define ST_GYRO_3_BDU_ADDR			0x23
+#define ST_GYRO_3_BDU_MASK			0x80
+#define ST_GYRO_3_DRDY_IRQ_ADDR			0x22
+#define ST_GYRO_3_DRDY_IRQ_INT1_MASK		0x80
+#define ST_GYRO_3_DRDY_IRQ_INT2_MASK		0x08
+#define ST_GYRO_3_MULTIREAD_BIT			true
+
 static const struct iio_chan_spec st_gyro_16bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -167,11 +193,10 @@ static const struct st_sensors st_gyro_sensors[] = {
 		.wai = ST_GYRO_2_WAI_EXP,
 		.sensors_supported = {
 			[0] = L3GD20_GYRO_DEV_NAME,
-			[1] = L3GD20H_GYRO_DEV_NAME,
-			[2] = LSM330D_GYRO_DEV_NAME,
-			[3] = LSM330DLC_GYRO_DEV_NAME,
-			[4] = L3G4IS_GYRO_DEV_NAME,
-			[5] = LSM330_GYRO_DEV_NAME,
+			[1] = LSM330D_GYRO_DEV_NAME,
+			[2] = LSM330DLC_GYRO_DEV_NAME,
+			[3] = L3G4IS_GYRO_DEV_NAME,
+			[4] = LSM330_GYRO_DEV_NAME,
 		},
 		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
 		.odr = {
@@ -226,6 +251,65 @@ static const struct st_sensors st_gyro_sensors[] = {
 		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
 		.bootime = 2,
 	},
+	{
+		.wai = ST_GYRO_3_WAI_EXP,
+		.sensors_supported = {
+			[0] = L3GD20H_GYRO_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_gyro_16bit_channels,
+		.odr = {
+			.addr = ST_GYRO_3_ODR_ADDR,
+			.mask = ST_GYRO_3_ODR_MASK,
+			.odr_avl = {
+				{ 100, ST_GYRO_3_ODR_AVL_100HZ_VAL, },
+				{ 200, ST_GYRO_3_ODR_AVL_200HZ_VAL, },
+				{ 400, ST_GYRO_3_ODR_AVL_400HZ_VAL, },
+				{ 800, ST_GYRO_3_ODR_AVL_800HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_GYRO_3_PW_ADDR,
+			.mask = ST_GYRO_3_PW_MASK,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = ST_GYRO_3_FS_ADDR,
+			.mask = ST_GYRO_3_FS_MASK,
+			.fs_avl = {
+				[0] = {
+					.num = ST_GYRO_FS_AVL_245DPS,
+					.value = ST_GYRO_3_FS_AVL_245_VAL,
+					.gain = ST_GYRO_3_FS_AVL_245_GAIN,
+				},
+				[1] = {
+					.num = ST_GYRO_FS_AVL_500DPS,
+					.value = ST_GYRO_3_FS_AVL_500_VAL,
+					.gain = ST_GYRO_3_FS_AVL_500_GAIN,
+				},
+				[2] = {
+					.num = ST_GYRO_FS_AVL_2000DPS,
+					.value = ST_GYRO_3_FS_AVL_2000_VAL,
+					.gain = ST_GYRO_3_FS_AVL_2000_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_GYRO_3_BDU_ADDR,
+			.mask = ST_GYRO_3_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_GYRO_3_DRDY_IRQ_ADDR,
+			.mask_int1 = ST_GYRO_3_DRDY_IRQ_INT1_MASK,
+			.mask_int2 = ST_GYRO_3_DRDY_IRQ_INT2_MASK,
+		},
+		.multi_read_bit = ST_GYRO_3_MULTIREAD_BIT,
+		.bootime = 2,
+	},
 };
 
 static int st_gyro_read_raw(struct iio_dev *indio_dev,
@@ -303,7 +387,7 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
 #endif
 
 int st_gyro_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata)
+				struct st_sensors_platform_data *plat_data)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 	int irq = gdata->get_irq_data_ready(indio_dev);
@@ -326,7 +410,11 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
 						&gdata->sensor->fs.fs_avl[0];
 	gdata->odr = gdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev, pdata);
+	if (!plat_data)
+		plat_data =
+			(struct st_sensors_platform_data *)&default_gyro_pdata;
+
+	err = st_sensors_init_sensor(indio_dev, plat_data);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 16b8b8d..7d1331a 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -34,8 +34,7 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev, client->dev.platform_data);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 94763e2..f0c730f 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -33,8 +33,7 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev, spi->dev.platform_data);
 	if (err < 0)
 		return err;
 
diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index 7538391..1e2b26c 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -14,7 +14,7 @@
 /**
  * struct st_sensors_platform_data - Platform data for the ST sensors
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
- *	Available only for accelerometer and pressure sensors.
+ *	Available only for accelerometers, gyroscopes and pressure sensors.
  *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
  */
 struct st_sensors_platform_data {
-- 
1.8.5.3

