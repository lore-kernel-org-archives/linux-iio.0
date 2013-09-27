Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64644 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab3I0Qc0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:26 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 03/14] iio: st_gyro: Add dt bindings
Date: Fri, 27 Sep 2013 18:32:07 +0200
Message-id: <1380299538-22047-4-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add OF support for the st_gyro.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/gyro/st_gyro.h      |   15 +++++++--------
 drivers/iio/gyro/st_gyro_core.c |    8 +++++---
 drivers/iio/gyro/st_gyro_i2c.c  |   18 ++++++++++++++++--
 drivers/iio/gyro/st_gyro_spi.c  |   18 ++++++++++++++++--
 4 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index f8f2bf8..81e5ec3 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -15,24 +15,23 @@
 #include <linux/iio/common/st_sensors.h>
 
 #define L3G4200D_GYRO_DEV_NAME		"l3g4200d"
-#define LSM330D_GYRO_DEV_NAME		"lsm330d_gyro"
-#define LSM330DL_GYRO_DEV_NAME		"lsm330dl_gyro"
-#define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc_gyro"
+#define LSM330D_GYRO_DEV_NAME		"lsm330d-gyro"
+#define LSM330DL_GYRO_DEV_NAME		"lsm330dl-gyro"
+#define LSM330DLC_GYRO_DEV_NAME		"lsm330dlc-gyro"
 #define L3GD20_GYRO_DEV_NAME		"l3gd20"
 #define L3GD20H_GYRO_DEV_NAME		"l3gd20h"
-#define L3G4IS_GYRO_DEV_NAME		"l3g4is_ui"
-#define LSM330_GYRO_DEV_NAME		"lsm330_gyro"
+#define L3G4IS_GYRO_DEV_NAME		"l3g4is-ui"
+#define LSM330_GYRO_DEV_NAME		"lsm330-gyro"
 
 /**
  * struct st_sensors_platform_data - gyro platform data
  * @drdy_int_pin: DRDY on gyros is available only on INT2 pin.
  */
-static const struct st_sensors_platform_data gyro_pdata = {
+static const struct st_sensors_platform_data default_gyro_pdata = {
 	.drdy_int_pin = 2,
 };
 
-int st_gyro_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_gyro_common_probe(struct iio_dev *indio_dev);
 void st_gyro_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index d53d91a..42f45af 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -302,8 +302,7 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
 #define ST_GYRO_TRIGGER_OPS NULL
 #endif
 
-int st_gyro_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata)
+int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 	int irq = gdata->get_irq_data_ready(indio_dev);
@@ -326,7 +325,10 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
 						&gdata->sensor->fs.fs_avl[0];
 	gdata->odr = gdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev, pdata);
+	if (!gdata->dev->platform_data && !gdata->dev->of_node)
+		gdata->drdy_int_pin = default_gyro_pdata.drdy_int_pin;
+
+	err = st_sensors_init_sensor(indio_dev);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 16b8b8d..9c4245b 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -34,8 +34,8 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev);
+
 	if (err < 0)
 		return err;
 
@@ -62,10 +62,24 @@ static const struct i2c_device_id st_gyro_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_gyro_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_gyro_dt_match[] = {
+	{ .compatible = "st,l3g4200d" },
+	{ .compatible = "st,lsm330d-gyro" },
+	{ .compatible = "st,lsm330dl-gyro" },
+	{ .compatible = "st,lsm330dlc-gyro" },
+	{ .compatible = "st,l3gd20" },
+	{ .compatible = "st,l3gd20h" },
+	{ .compatible = "st,l3g4is-ui" },
+	{ .compatible = "st,lsm330-gyro" },
+};
+#endif
+
 static struct i2c_driver st_gyro_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-gyro-i2c",
+		.of_match_table = of_match_ptr(st_gyro_dt_match),
 	},
 	.probe = st_gyro_i2c_probe,
 	.remove = st_gyro_i2c_remove,
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 94763e2..1287af3 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -33,8 +33,8 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev);
+
 	if (err < 0)
 		return err;
 
@@ -61,10 +61,24 @@ static const struct spi_device_id st_gyro_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_gyro_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_gyro_dt_match[] = {
+	{ .compatible = "st,l3g4200d" },
+	{ .compatible = "st,lsm330d-gyro" },
+	{ .compatible = "st,lsm330dl-gyro" },
+	{ .compatible = "st,lsm330dlc-gyro" },
+	{ .compatible = "st,l3gd20" },
+	{ .compatible = "st,l3gd20h" },
+	{ .compatible = "st,l3g4is-ui" },
+	{ .compatible = "st,lsm330-gyro" },
+};
+#endif
+
 static struct spi_driver st_gyro_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-gyro-spi",
+		.of_match_table = of_match_ptr(st_gyro_dt_match),
 	},
 	.probe = st_gyro_spi_probe,
 	.remove = st_gyro_spi_remove,
-- 
1.7.9.5

