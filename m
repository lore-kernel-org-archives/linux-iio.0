Return-Path: <denis.ciocca@st.com>
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org,
	j.anaszewski@samsung.com
Cc: lars@metafoo.de, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 1/1] iio: Added ST-sensors platform data to select the DRDY interrupt pin
Date: Mon, 20 May 2013 11:38:47 +0200
Message-Id: <1369042727-11210-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1369042727-11210-1-git-send-email-denis.ciocca@st.com>
References: <1369042727-11210-1-git-send-email-denis.ciocca@st.com>
List-ID: <linux-iio@vger.kernel.org>

This patch add support to redirect the DRDY interrupt on INT1 or INT2
on accelerometer and pressure sensors.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel.h                    |   11 +++++-
 drivers/iio/accel/st_accel_core.c               |   27 +++++++++-----
 drivers/iio/accel/st_accel_i2c.c                |    2 +-
 drivers/iio/accel/st_accel_spi.c                |    2 +-
 drivers/iio/common/st_sensors/st_sensors_core.c |   43 +++++++++++++++++++----
 drivers/iio/gyro/st_gyro.h                      |   11 +++++-
 drivers/iio/gyro/st_gyro_core.c                 |   13 +++----
 drivers/iio/gyro/st_gyro_i2c.c                  |    3 +-
 drivers/iio/gyro/st_gyro_spi.c                  |    3 +-
 drivers/iio/magnetometer/st_magn.h              |    3 +-
 drivers/iio/magnetometer/st_magn_core.c         |    5 +--
 drivers/iio/magnetometer/st_magn_i2c.c          |    2 +-
 drivers/iio/magnetometer/st_magn_spi.c          |    2 +-
 drivers/iio/pressure/st_pressure.h              |   14 ++++++--
 drivers/iio/pressure/st_pressure_core.c         |   15 +++++---
 drivers/iio/pressure/st_pressure_i2c.c          |    2 +-
 drivers/iio/pressure/st_pressure_spi.c          |    2 +-
 include/linux/iio/common/st_sensors.h           |   11 ++++--
 include/linux/platform_data/st_sensors_pdata.h  |   24 +++++++++++++
 19 files changed, 153 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/platform_data/st_sensors_pdata.h

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 37949b9..80253fb 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -25,7 +25,16 @@
 #define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
 #define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
 
-int st_accel_common_probe(struct iio_dev *indio_dev);
+/**
+ * struct st_sensors_platform_data - default accel platform data
+ * @drdy_int_pin: default DRDY on accel is available on INT1 pin.
+ */
+static const struct st_sensors_platform_data default_accel_pdata = {
+	.drdy_int_pin = 1,
+};
+
+int st_accel_common_probe(struct iio_dev *indio_dev,
+				struct st_sensors_platform_data *pdata);
 void st_accel_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 2b8a7bd..bb8a217 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -63,7 +63,8 @@
 #define ST_ACCEL_1_BDU_ADDR			0x23
 #define ST_ACCEL_1_BDU_MASK			0x80
 #define ST_ACCEL_1_DRDY_IRQ_ADDR		0x22
-#define ST_ACCEL_1_DRDY_IRQ_MASK		0x10
+#define ST_ACCEL_1_DRDY_IRQ_INT1_MASK		0x10
+#define ST_ACCEL_1_DRDY_IRQ_INT2_MASK		0x08
 #define ST_ACCEL_1_MULTIREAD_BIT		true
 
 /* CUSTOM VALUES FOR SENSOR 2 */
@@ -87,7 +88,8 @@
 #define ST_ACCEL_2_BDU_ADDR			0x23
 #define ST_ACCEL_2_BDU_MASK			0x80
 #define ST_ACCEL_2_DRDY_IRQ_ADDR		0x22
-#define ST_ACCEL_2_DRDY_IRQ_MASK		0x02
+#define ST_ACCEL_2_DRDY_IRQ_INT1_MASK		0x02
+#define ST_ACCEL_2_DRDY_IRQ_INT2_MASK		0x10
 #define ST_ACCEL_2_MULTIREAD_BIT		true
 
 /* CUSTOM VALUES FOR SENSOR 3 */
@@ -119,7 +121,8 @@
 #define ST_ACCEL_3_BDU_ADDR			0x20
 #define ST_ACCEL_3_BDU_MASK			0x08
 #define ST_ACCEL_3_DRDY_IRQ_ADDR		0x23
-#define ST_ACCEL_3_DRDY_IRQ_MASK		0x80
+#define ST_ACCEL_3_DRDY_IRQ_INT1_MASK		0x80
+#define ST_ACCEL_3_DRDY_IRQ_INT2_MASK		0x00
 #define ST_ACCEL_3_IG1_EN_ADDR			0x23
 #define ST_ACCEL_3_IG1_EN_MASK			0x08
 #define ST_ACCEL_3_MULTIREAD_BIT		false
@@ -222,7 +225,8 @@ static const struct st_sensors st_accel_sensors[] = {
 		},
 		.drdy_irq = {
 			.addr = ST_ACCEL_1_DRDY_IRQ_ADDR,
-			.mask = ST_ACCEL_1_DRDY_IRQ_MASK,
+			.mask_int1 = ST_ACCEL_1_DRDY_IRQ_INT1_MASK,
+			.mask_int2 = ST_ACCEL_1_DRDY_IRQ_INT2_MASK,
 		},
 		.multi_read_bit = ST_ACCEL_1_MULTIREAD_BIT,
 		.bootime = 2,
@@ -283,7 +287,8 @@ static const struct st_sensors st_accel_sensors[] = {
 		},
 		.drdy_irq = {
 			.addr = ST_ACCEL_2_DRDY_IRQ_ADDR,
-			.mask = ST_ACCEL_2_DRDY_IRQ_MASK,
+			.mask_int1 = ST_ACCEL_2_DRDY_IRQ_INT1_MASK,
+			.mask_int2 = ST_ACCEL_2_DRDY_IRQ_INT2_MASK,
 		},
 		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
 		.bootime = 2,
@@ -356,7 +361,8 @@ static const struct st_sensors st_accel_sensors[] = {
 		},
 		.drdy_irq = {
 			.addr = ST_ACCEL_3_DRDY_IRQ_ADDR,
-			.mask = ST_ACCEL_3_DRDY_IRQ_MASK,
+			.mask_int1 = ST_ACCEL_3_DRDY_IRQ_INT1_MASK,
+			.mask_int2 = ST_ACCEL_3_DRDY_IRQ_INT2_MASK,
 			.ig1 = {
 				.en_addr = ST_ACCEL_3_IG1_EN_ADDR,
 				.en_mask = ST_ACCEL_3_IG1_EN_MASK,
@@ -441,7 +447,8 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #define ST_ACCEL_TRIGGER_OPS NULL
 #endif
 
-int st_accel_common_probe(struct iio_dev *indio_dev)
+int st_accel_common_probe(struct iio_dev *indio_dev,
+				struct st_sensors_platform_data *plat_data)
 {
 	int err;
 	struct st_sensor_data *adata = iio_priv(indio_dev);
@@ -463,7 +470,11 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 						&adata->sensor->fs.fs_avl[0];
 	adata->odr = adata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev);
+	if (!plat_data)
+		plat_data =
+			(struct st_sensors_platform_data *)&default_accel_pdata;
+
+	err = st_sensors_init_sensor(indio_dev, plat_data);
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index ffc9d09..58d164d 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -36,7 +36,7 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
 
-	err = st_accel_common_probe(indio_dev);
+	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 22b35bf..21ed929 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -35,7 +35,7 @@ static int st_accel_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, adata);
 
-	err = st_accel_common_probe(indio_dev);
+	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
 	if (err < 0)
 		goto st_accel_common_probe_error;
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index bd33473..5c14819a 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -17,7 +17,6 @@
 
 #include <linux/iio/common/st_sensors.h>
 
-
 #define ST_SENSORS_WAI_ADDRESS		0x0f
 
 static int st_sensors_write_data_with_mask(struct iio_dev *indio_dev,
@@ -112,7 +111,8 @@ st_sensors_match_odr_error:
 	return ret;
 }
 
-static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
+static int st_sensors_set_fullscale(struct iio_dev *indio_dev,
+							unsigned int fs)
 {
 	int err, i = 0;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
@@ -192,13 +192,39 @@ int st_sensors_set_axis_enable(struct iio_dev *indio_dev, u8 axis_enable)
 }
 EXPORT_SYMBOL(st_sensors_set_axis_enable);
 
-int st_sensors_init_sensor(struct iio_dev *indio_dev)
+int st_sensors_init_sensor(struct iio_dev *indio_dev,
+					struct st_sensors_platform_data *pdata)
 {
 	int err;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	mutex_init(&sdata->tb.buf_lock);
 
+	switch (pdata->drdy_int_pin) {
+	case 1:
+		if (sdata->sensor->drdy_irq.mask_int1 == 0) {
+			dev_err(&indio_dev->dev,
+					"DRDY on INT1 not available.\n");
+			err = -EINVAL;
+			goto init_error;
+		}
+		sdata->drdy_int_pin = 1;
+		break;
+	case 2:
+		if (sdata->sensor->drdy_irq.mask_int2 == 0) {
+			dev_err(&indio_dev->dev,
+					"DRDY on INT2 not available.\n");
+			err = -EINVAL;
+			goto init_error;
+		}
+		sdata->drdy_int_pin = 2;
+		break;
+	default:
+		dev_err(&indio_dev->dev, "DRDY on pdata not valid.\n");
+		err = -EINVAL;
+		goto init_error;
+	}
+
 	err = st_sensors_set_enable(indio_dev, false);
 	if (err < 0)
 		goto init_error;
@@ -227,7 +253,8 @@ EXPORT_SYMBOL(st_sensors_init_sensor);
 
 int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 {
-	int err;
+	int err = 0;
+	u8 drdy_mask;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	/* Enable/Disable the interrupt generator 1. */
@@ -239,10 +266,14 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 			goto st_accel_set_dataready_irq_error;
 	}
 
+	if (sdata->drdy_int_pin == 1)
+		drdy_mask = sdata->sensor->drdy_irq.mask_int1;
+	else
+		drdy_mask = sdata->sensor->drdy_irq.mask_int2;
+
 	/* Enable/Disable the interrupt generator for data ready. */
 	err = st_sensors_write_data_with_mask(indio_dev,
-			sdata->sensor->drdy_irq.addr,
-			sdata->sensor->drdy_irq.mask, (int)enable);
+		sdata->sensor->drdy_irq.addr, drdy_mask, (int)enable);
 
 st_accel_set_dataready_irq_error:
 	return err;
diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index 3ad9907..a76c1cb 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -23,7 +23,16 @@
 #define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
 #define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
 
-int st_gyro_common_probe(struct iio_dev *indio_dev);
+/**
+ * struct st_sensors_platform_data - gyro platform data
+ * @drdy_int_pin: DRDY on gyros is available only on INT2 pin.
+ */
+static const struct st_sensors_platform_data gyro_pdata = {
+	.drdy_int_pin = 2,
+};
+
+int st_gyro_common_probe(struct iio_dev *indio_dev,
+				struct st_sensors_platform_data *pdata);
 void st_gyro_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 56e9253..9c16fb0 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -58,7 +58,7 @@
 #define ST_GYRO_1_BDU_ADDR			0x23
 #define ST_GYRO_1_BDU_MASK			0x80
 #define ST_GYRO_1_DRDY_IRQ_ADDR			0x22
-#define ST_GYRO_1_DRDY_IRQ_MASK			0x08
+#define ST_GYRO_1_DRDY_IRQ_INT2_MASK		0x08
 #define ST_GYRO_1_MULTIREAD_BIT			true
 
 /* CUSTOM VALUES FOR SENSOR 2 */
@@ -82,7 +82,7 @@
 #define ST_GYRO_2_BDU_ADDR			0x23
 #define ST_GYRO_2_BDU_MASK			0x80
 #define ST_GYRO_2_DRDY_IRQ_ADDR			0x22
-#define ST_GYRO_2_DRDY_IRQ_MASK			0x08
+#define ST_GYRO_2_DRDY_IRQ_INT2_MASK		0x08
 #define ST_GYRO_2_MULTIREAD_BIT			true
 
 static const struct iio_chan_spec st_gyro_16bit_channels[] = {
@@ -156,7 +156,7 @@ static const struct st_sensors st_gyro_sensors[] = {
 		},
 		.drdy_irq = {
 			.addr = ST_GYRO_1_DRDY_IRQ_ADDR,
-			.mask = ST_GYRO_1_DRDY_IRQ_MASK,
+			.mask_int2 = ST_GYRO_1_DRDY_IRQ_INT2_MASK,
 		},
 		.multi_read_bit = ST_GYRO_1_MULTIREAD_BIT,
 		.bootime = 2,
@@ -219,7 +219,7 @@ static const struct st_sensors st_gyro_sensors[] = {
 		},
 		.drdy_irq = {
 			.addr = ST_GYRO_2_DRDY_IRQ_ADDR,
-			.mask = ST_GYRO_2_DRDY_IRQ_MASK,
+			.mask_int2 = ST_GYRO_2_DRDY_IRQ_INT2_MASK,
 		},
 		.multi_read_bit = ST_GYRO_2_MULTIREAD_BIT,
 		.bootime = 2,
@@ -300,7 +300,8 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
 #define ST_GYRO_TRIGGER_OPS NULL
 #endif
 
-int st_gyro_common_probe(struct iio_dev *indio_dev)
+int st_gyro_common_probe(struct iio_dev *indio_dev,
+					struct st_sensors_platform_data *pdata)
 {
 	int err;
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
@@ -322,7 +323,7 @@ int st_gyro_common_probe(struct iio_dev *indio_dev)
 						&gdata->sensor->fs.fs_avl[0];
 	gdata->odr = gdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 8a31050..2345833 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -36,7 +36,8 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
-	err = st_gyro_common_probe(indio_dev);
+	err = st_gyro_common_probe(indio_dev,
+			(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index f354039..0dcceb5 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -35,7 +35,8 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
-	err = st_gyro_common_probe(indio_dev);
+	err = st_gyro_common_probe(indio_dev,
+			(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
 		goto st_gyro_common_probe_error;
 
diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 7e81d00..b4940c7 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -18,7 +18,8 @@
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
 #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
 
-int st_magn_common_probe(struct iio_dev *indio_dev);
+int st_magn_common_probe(struct iio_dev *indio_dev,
+				struct st_sensors_platform_data *pdata);
 void st_magn_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 3208ba8..a6ff23d 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -343,7 +343,8 @@ static const struct iio_info magn_info = {
 	.write_raw = &st_magn_write_raw,
 };
 
-int st_magn_common_probe(struct iio_dev *indio_dev)
+int st_magn_common_probe(struct iio_dev *indio_dev,
+					struct st_sensors_platform_data *pdata)
 {
 	int err;
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
@@ -365,7 +366,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 						&mdata->sensor->fs.fs_avl[0];
 	mdata->odr = mdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev);
+	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index e6adc4a..1bed117 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -36,7 +36,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, mdata);
 
-	err = st_magn_common_probe(indio_dev);
+	err = st_magn_common_probe(indio_dev, NULL);
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 51adb79..a2333a1 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -35,7 +35,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, mdata);
 
-	err = st_magn_common_probe(indio_dev);
+	err = st_magn_common_probe(indio_dev, NULL);
 	if (err < 0)
 		goto st_magn_common_probe_error;
 
diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index d817387..84dd663 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -19,7 +19,16 @@
 #define ST_PRESS_BYTE_FOR_CHANNEL	3
 #define ST_TEMP_BYTE_FOR_CHANNEL	2
 
-int st_press_common_probe(struct iio_dev *indio_dev);
+/**
+ * struct st_sensors_platform_data - default press platform data
+ * @drdy_int_pin: default DRDY on press is available on INT1 pin.
+ */
+static const struct st_sensors_platform_data default_press_pdata = {
+	.drdy_int_pin = 1,
+};
+
+int st_press_common_probe(struct iio_dev *indio_dev,
+				struct st_sensors_platform_data *pdata);
 void st_press_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
@@ -36,8 +45,7 @@ static inline int st_press_allocate_ring(struct iio_dev *indio_dev)
 static inline void st_press_deallocate_ring(struct iio_dev *indio_dev)
 {
 }
-static int st_press_get_buffer_element(struct iio_dev *indio_dev,
-									u8 *buf)
+static int st_press_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 {
 	return 0;
 }
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index ae5703f..08b1d13 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -56,7 +56,8 @@
 #define ST_PRESS_1_BDU_ADDR			0x20
 #define ST_PRESS_1_BDU_MASK			0x04
 #define ST_PRESS_1_DRDY_IRQ_ADDR		0x22
-#define ST_PRESS_1_DRDY_IRQ_MASK		0x04
+#define ST_PRESS_1_DRDY_IRQ_INT1_MASK		0x04
+#define ST_PRESS_1_DRDY_IRQ_INT2_MASK		0x20
 #define ST_PRESS_1_MULTIREAD_BIT		true
 #define ST_PRESS_1_TEMP_OFFSET			42500
 
@@ -114,7 +115,8 @@ static const struct st_sensors st_press_sensors[] = {
 		},
 		.drdy_irq = {
 			.addr = ST_PRESS_1_DRDY_IRQ_ADDR,
-			.mask = ST_PRESS_1_DRDY_IRQ_MASK,
+			.mask_int1 = ST_PRESS_1_DRDY_IRQ_INT1_MASK,
+			.mask_int2 = ST_PRESS_1_DRDY_IRQ_INT2_MASK,
 		},
 		.multi_read_bit = ST_PRESS_1_MULTIREAD_BIT,
 		.bootime = 2,
@@ -277,7 +279,8 @@ static const struct iio_trigger_ops st_press_trigger_ops = {
 #define ST_PRESS_TRIGGER_OPS NULL
 #endif
 
-int st_press_common_probe(struct iio_dev *indio_dev)
+int st_press_common_probe(struct iio_dev *indio_dev,
+				struct st_sensors_platform_data *plat_data)
 {
 	int err;
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
@@ -299,7 +302,11 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 						&pdata->sensor->fs.fs_avl[0];
 	pdata->odr = pdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev);
+	if (!plat_data)
+		plat_data =
+			(struct st_sensors_platform_data *)&default_press_pdata;
+
+	err = st_sensors_init_sensor(indio_dev, plat_data);
 	if (err < 0)
 		goto st_press_common_probe_error;
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 7cebcc7..3065993 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -36,7 +36,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, pdata);
 
-	err = st_press_common_probe(indio_dev);
+	err = st_press_common_probe(indio_dev, client->dev.platform_data);
 	if (err < 0)
 		goto st_press_common_probe_error;
 
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 17a1490..b2aded6 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -35,7 +35,7 @@ static int st_press_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, pdata);
 
-	err = st_press_common_probe(indio_dev);
+	err = st_press_common_probe(indio_dev, spi->dev.platform_data);
 	if (err < 0)
 		goto st_press_common_probe_error;
 
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index fd81707..9e8c1e4 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -17,6 +17,8 @@
 #include <linux/iio/trigger.h>
 #include <linux/bitops.h>
 
+#include <linux/platform_data/st_sensors_pdata.h>
+
 #define ST_SENSORS_TX_MAX_LENGTH		2
 #define ST_SENSORS_RX_MAX_LENGTH		6
 
@@ -127,7 +129,8 @@ struct st_sensor_bdu {
  */
 struct st_sensor_data_ready_irq {
 	u8 addr;
-	u8 mask;
+	u8 mask_int1;
+	u8 mask_int2;
 	struct {
 		u8 en_addr;
 		u8 en_mask;
@@ -202,6 +205,7 @@ struct st_sensors {
  * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
  * @buffer_data: Data used by buffer part.
  * @odr: Output data rate of the sensor [Hz].
+ * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
  * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
  * @get_buffer_element: Function to get data from sensor and push on buffer.
  * @tf: Transfer function structure used by I/O operations.
@@ -220,6 +224,8 @@ struct st_sensor_data {
 
 	unsigned int odr;
 
+	u8 drdy_int_pin;
+
 	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
 	int (*get_buffer_element) (struct iio_dev *indio_dev, u8 *buf);
 
@@ -251,7 +257,8 @@ static inline void st_sensors_deallocate_trigger(struct iio_dev *indio_dev)
 }
 #endif
 
-int st_sensors_init_sensor(struct iio_dev *indio_dev);
+int st_sensors_init_sensor(struct iio_dev *indio_dev,
+				struct st_sensors_platform_data *pdata);
 
 int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable);
 
diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
new file mode 100644
index 0000000..1f6a4ce
--- /dev/null
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -0,0 +1,24 @@
+/*
+ * STMicroelectronics sensors platform-data driver
+ *
+ * Copyright 2013 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef ST_SENSORS_PDATA_H
+#define ST_SENSORS_PDATA_H
+
+/**
+ * struct st_sensors_platform_data - Platform data for the ST sensors
+ * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
+ * 	Available only for accelerometer and pressure sensors.
+ * 	Accelerometer DRDY on LSM330 availbale only on pin 1 (see datasheet).
+ */
+struct st_sensors_platform_data {
+	u8 drdy_int_pin;
+};
+
+#endif /* ST_SENSORS_PDATA_H */
-- 
1.7.9.5
