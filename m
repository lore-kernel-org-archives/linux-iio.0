Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52359 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbcEVTjh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 May 2016 15:39:37 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC] iio: accel: st_accel: Add lis3l02dq support
Date: Sun, 22 May 2016 20:39:29 +0100
Message-Id: <1463945969-18866-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Time to finally kill off the venerable (it was one of my first drivers)
lis3l02dq driver in favour of adding support in the st sensors framework.

This does loose us the event support that driver always had, but I think
that will reappear at some point and in the meantime the maintenance
advantages of dropping the 'special' driver for this one part outweigh
the issues.

It's worth noting this part is ancient and I may well be the only person
who still has any on hardware running recent kernels.

It has a few 'quirks'.
 - No WAI register so that just became optional.
 - A BDU option that really does block updates.  Completely.
   Whatever you do, you don't get any more data with it set.
   It is documented the same as more modern parts but I presume they
   are actually clearing for updates after a read of both bytes!
 - Fixed scale.
 - It's too quick.  Even at slowest rate (280Hz) I can't read out fast
   enough on my board (stargate 2) to beat new data coming in. Linus'
   repeat read patch doesn't help in this case. It just means I get 10
   readings before dying... So in reality this will get used with
   software triggers only unless someone has this long out of production
   device on a quick board.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Denis CIOCCA <denis.ciocca@st.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/accel/st_accel.h                    |  1 +
 drivers/iio/accel/st_accel_core.c               | 64 +++++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c                |  4 ++
 drivers/iio/accel/st_accel_spi.c                |  1 +
 drivers/iio/common/st_sensors/st_sensors_core.c | 26 +++++-----
 5 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 57f83a67948c..f8dfdb690563 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -29,6 +29,7 @@
 #define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
 #define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
 #define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
+#define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index dc73f2d85e6d..17c643727aff 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -215,6 +215,22 @@
 #define ST_ACCEL_6_IHL_IRQ_MASK			0x80
 #define ST_ACCEL_6_MULTIREAD_BIT		true
 
+/* CUSTOM VALUES FOR SENSOR 7 */
+#define ST_ACCEL_7_ODR_ADDR			0x20
+#define ST_ACCEL_7_ODR_MASK			0x30
+#define ST_ACCEL_7_ODR_AVL_280HZ_VAL		0x00
+#define ST_ACCEL_7_ODR_AVL_560HZ_VAL		0x01
+#define ST_ACCEL_7_ODR_AVL_1120HZ_VAL		0x02
+#define ST_ACCEL_7_ODR_AVL_4480HZ_VAL		0x03
+#define ST_ACCEL_7_PW_ADDR			0x20
+#define ST_ACCEL_7_PW_MASK			0xc0
+#define ST_ACCEL_7_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(488)
+#define ST_ACCEL_7_BDU_ADDR			0x21
+#define ST_ACCEL_7_BDU_MASK			0x40
+#define ST_ACCEL_7_DRDY_IRQ_ADDR		0x21
+#define ST_ACCEL_7_DRDY_IRQ_INT1_MASK		0x04
+#define ST_ACCEL_7_MULTIREAD_BIT		false
+
 static const struct iio_chan_spec st_accel_8bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -662,6 +678,54 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = ST_ACCEL_6_MULTIREAD_BIT,
 		.bootime = 2,
 	},
+	{
+		/* No WAI register present */
+		.sensors_supported = {
+			[0] = LIS3L02DQ_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_12bit_channels,
+		.odr = {
+			.addr = ST_ACCEL_7_ODR_ADDR,
+			.mask = ST_ACCEL_7_ODR_MASK,
+			.odr_avl = {
+				{ 280, ST_ACCEL_7_ODR_AVL_280HZ_VAL, },
+				{ 560, ST_ACCEL_7_ODR_AVL_560HZ_VAL, },
+				{ 1120, ST_ACCEL_7_ODR_AVL_1120HZ_VAL, },
+				{ 4480, ST_ACCEL_7_ODR_AVL_4480HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_ACCEL_7_PW_ADDR,
+			.mask = ST_ACCEL_7_PW_MASK,
+			.value_on = ST_SENSORS_DEFAULT_POWER_ON_VALUE,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.gain = ST_ACCEL_7_FS_AVL_2_GAIN,
+				},
+			},
+		},
+		/* 
+		 * The part has a BDU bit but if set the data is never
+		 * updated so don't set it.
+		 */
+		.bdu = {
+		},
+		.drdy_irq = {
+			.addr = ST_ACCEL_7_DRDY_IRQ_ADDR,
+			.mask_int1 = ST_ACCEL_7_DRDY_IRQ_INT1_MASK,
+			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
+		},
+		.multi_read_bit = ST_ACCEL_7_MULTIREAD_BIT,
+		.bootime = 2,
+	},
 };
 
 static int st_accel_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 7333ee9fb11b..1fb61d8382e0 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -80,6 +80,9 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,h3lis331dl-accel",
 		.data = H3LIS331DL_DRIVER_NAME,
 	},
+	{
+		.compatible = "st,lis3l02dq",
+		.data = LIS3L02DQ_DRIVER_NAME,
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -130,6 +133,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
 	{ LIS2DH12_ACCEL_DEV_NAME },
+	{ LIS3L02DQ_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index fcd5847a3fd3..efd43941d45d 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -59,6 +59,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
 	{ LIS2DH12_ACCEL_DEV_NAME },
+	{ LIS3L02DQ_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dffe00692169..b672d2e1d568 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -523,7 +523,7 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
 			int num_sensors_list,
 			const struct st_sensor_settings *sensor_settings)
 {
-	int i, n, err;
+	int i, n, err = 0;
 	u8 wai;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
@@ -543,17 +543,21 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
 		return -ENODEV;
 	}
 
-	err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
-					sensor_settings[i].wai_addr, &wai);
-	if (err < 0) {
-		dev_err(&indio_dev->dev, "failed to read Who-Am-I register.\n");
-		return err;
-	}
+	if (sensor_settings[i].wai_addr) {
+		err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
+					   sensor_settings[i].wai_addr, &wai);
+		if (err < 0) {
+			dev_err(&indio_dev->dev,
+				"failed to read Who-Am-I register.\n");
+			return err;
+		}
 
-	if (sensor_settings[i].wai != wai) {
-		dev_err(&indio_dev->dev, "%s: WhoAmI mismatch (0x%x).\n",
-						indio_dev->name, wai);
-		return -EINVAL;
+		if (sensor_settings[i].wai != wai) {
+			dev_err(&indio_dev->dev,
+				"%s: WhoAmI mismatch (0x%x).\n",
+				indio_dev->name, wai);
+			return -EINVAL;
+		}
 	}
 
 	sdata->sensor_settings =
-- 
2.8.2

