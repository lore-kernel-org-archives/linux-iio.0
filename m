Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43103 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750911AbdLaVIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 31 Dec 2017 16:08:24 -0500
Received: by mail-pl0-f66.google.com with SMTP id z5so26100473plo.10
        for <linux-iio@vger.kernel.org>; Sun, 31 Dec 2017 13:08:24 -0800 (PST)
From: Martin Kelly <martin@martingkelly.com>
To: linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH] iio: gyro: st_gyro: add support for the LSM9DS1
Date: Sun, 31 Dec 2017 13:06:52 -0800
Message-Id: <20171231210652.18820-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

Update the sensor settings to support the LSM9DS1 sensor.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 .../devicetree/bindings/iio/st-sensors.txt         |  1 +
 drivers/iio/gyro/Kconfig                           |  3 +-
 drivers/iio/gyro/st_gyro.h                         |  1 +
 drivers/iio/gyro/st_gyro_core.c                    | 95 ++++++++++++++++++++++
 drivers/iio/gyro/st_gyro_i2c.c                     |  5 ++
 drivers/iio/gyro/st_gyro_spi.c                     |  5 ++
 6 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 6f626f73417e..e3d2b5d5d707 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -59,6 +59,7 @@ Gyroscopes:
 - st,l3g4is-gyro
 - st,lsm330-gyro
 - st,lsm9ds0-gyro
+- st,lsm9ds1-gyro
 
 Magnetometers:
 - st,lsm303agr-magn
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 3126cf05e6b9..0d63c84c5312 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -111,7 +111,8 @@ config IIO_ST_GYRO_3AXIS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics gyroscopes:
-	  L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330, LSM9DS0.
+	  L3G4200D, LSM330DL, L3GD20, LSM330DLC, L3G4IS, LSM330, LSM9DS0,
+          LSM9DS1.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index 48923ae6ac3b..f89de446d066 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -23,6 +23,7 @@
 #define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 #define LSM9DS0_GYRO_DEV_NAME		"lsm9ds0_gyro"
+#define LSM9DS1_GYRO_DEV_NAME		"lsm9ds1_gyro"
 
 /**
  * struct st_sensors_platform_data - gyro platform data
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index b31064ba37b9..ebfce311e855 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -56,6 +56,23 @@ static const struct iio_chan_spec st_gyro_16bit_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
+/* The LSM9DS1 uses different output registers that the other chips. */
+static const struct iio_chan_spec st_gyro_lsm9ds1_16bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			0x18),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			0x1a),
+	ST_SENSORS_LSM_CHANNELS(IIO_ANGL_VEL,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			0x1c),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
 static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 	{
 		.wai = 0xd3,
@@ -285,6 +302,84 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
+	{
+		.wai = 0x68,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LSM9DS1_GYRO_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_gyro_lsm9ds1_16bit_channels,
+		.odr = {
+			.addr = 0x10,
+			.mask = 0xe0,
+			.odr_avl = {
+				{ .hz = 15, .value = 0x01, },
+				{ .hz = 60, .value = 0x02, },
+				{ .hz = 119, .value = 0x03, },
+				{ .hz = 238, .value = 0x04, },
+				{ .hz = 476, .value = 0x05, },
+				{ .hz = 952, .value = 0x06, },
+			},
+		},
+		.pw = {
+			.addr = 0x10,
+			.mask = 0xe0,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = 0x1e,
+			.mask = 0x38,
+		},
+		.fs = {
+			.addr = 0x10,
+			.mask = 0x38,
+			.fs_avl = {
+				[0] = {
+					.num = ST_GYRO_FS_AVL_250DPS,
+					.value = 0x00,
+					.gain = IIO_DEGREE_TO_RAD(8750),
+				},
+				[1] = {
+					.num = ST_GYRO_FS_AVL_500DPS,
+					.value = 0x01,
+					.gain = IIO_DEGREE_TO_RAD(17500),
+				},
+				[2] = {
+					.num = ST_GYRO_FS_AVL_2000DPS,
+					/* 2 is "Not Available". */
+					.value = 0x03,
+					.gain = IIO_DEGREE_TO_RAD(70000),
+				},
+			},
+		},
+		.bdu = {
+			.addr = 0x22,
+			.mask = 0x40,
+		},
+		.drdy_irq = {
+			.int1 = {
+				.addr = 0x0c,
+				.mask = 0x02,
+			},
+			.int2 = {
+				.addr = 0x0d,
+				.mask = 0x02,
+			},
+			.addr_ihl = 0x22,
+			.mask_ihl = 0x20,
+			.stat_drdy = {
+				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
+				.mask = 0x02,
+			},
+		},
+		.sim = {
+			.addr = 0x22,
+			.value = BIT(3),
+		},
+		.multi_read_bit = false,
+		.bootime = 2,
+	},
 };
 
 static int st_gyro_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index b405b82b9177..97faa3ddac17 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -56,6 +56,10 @@ static const struct of_device_id st_gyro_of_match[] = {
 		.compatible = "st,lsm9ds0-gyro",
 		.data = LSM9DS0_GYRO_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm9ds1-gyro",
+		.data = LSM9DS1_GYRO_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_gyro_of_match);
@@ -104,6 +108,7 @@ static const struct i2c_device_id st_gyro_id_table[] = {
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{ LSM9DS0_GYRO_DEV_NAME },
+	{ LSM9DS1_GYRO_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 0b52ed577dc2..7d4661cc260c 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -61,6 +61,10 @@ static const struct of_device_id st_gyro_of_match[] = {
 		.compatible = "st,lsm9ds0-gyro",
 		.data = LSM9DS0_GYRO_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm9ds1-gyro",
+		.data = LSM9DS1_GYRO_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_gyro_of_match);
@@ -108,6 +112,7 @@ static const struct spi_device_id st_gyro_id_table[] = {
 	{ L3G4IS_GYRO_DEV_NAME },
 	{ LSM330_GYRO_DEV_NAME },
 	{ LSM9DS0_GYRO_DEV_NAME },
+	{ LSM9DS1_GYRO_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
-- 
2.11.0

