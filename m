Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64644 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab3I0Qc1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:27 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 04/14] iio: st_mang: Add dt bindings
Date: Fri, 27 Sep 2013 18:32:08 +0200
Message-id: <1380299538-22047-5-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add OF support for the st_magn.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/magnetometer/st_magn.h      |    3 +--
 drivers/iio/magnetometer/st_magn_core.c |    5 ++---
 drivers/iio/magnetometer/st_magn_i2c.c  |   12 +++++++++++-
 drivers/iio/magnetometer/st_magn_spi.c  |   12 +++++++++++-
 4 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 694e33e..7e81d00 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -18,8 +18,7 @@
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
 #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
 
-int st_magn_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_magn_common_probe(struct iio_dev *indio_dev);
 void st_magn_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 82461ef..4460075 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -345,8 +345,7 @@ static const struct iio_info magn_info = {
 	.write_raw = &st_magn_write_raw,
 };
 
-int st_magn_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata)
+int st_magn_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *mdata = iio_priv(indio_dev);
 	int irq = mdata->get_irq_data_ready(indio_dev);
@@ -369,7 +368,7 @@ int st_magn_common_probe(struct iio_dev *indio_dev,
 						&mdata->sensor->fs.fs_avl[0];
 	mdata->odr = mdata->sensor->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev, pdata);
+	err = st_sensors_init_sensor(indio_dev);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 892e0fe..72a7cc2 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -34,7 +34,7 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, mdata);
 
-	err = st_magn_common_probe(indio_dev, NULL);
+	err = st_magn_common_probe(indio_dev);
 	if (err < 0)
 		return err;
 
@@ -57,10 +57,20 @@ static const struct i2c_device_id st_magn_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_magn_dt_match[] = {
+	{ .compatible = "st,lsm303dlhc_magn" },
+	{ .compatible = "st,lsm303dlm_magn" },
+	{ .compatible = "st,lis3mdl" },
+	{ }
+};
+#endif
+
 static struct i2c_driver st_magn_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-magn-i2c",
+		.of_match_table = of_match_ptr(st_magn_dt_match),
 	},
 	.probe = st_magn_i2c_probe,
 	.remove = st_magn_i2c_remove,
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index a6143ea..55c9691 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -33,7 +33,7 @@ static int st_magn_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, mdata);
 
-	err = st_magn_common_probe(indio_dev, NULL);
+	err = st_magn_common_probe(indio_dev);
 	if (err < 0)
 		return err;
 
@@ -56,10 +56,20 @@ static const struct spi_device_id st_magn_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_magn_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_magn_dt_match[] = {
+	{ .compatible = "st,lsm303dlhc_magn" },
+	{ .compatible = "st,lsm303dlm_magn" },
+	{ .compatible = "st,lis3mdl" },
+	{ }
+};
+#endif
+
 static struct spi_driver st_magn_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-magn-spi",
+		.of_match_table = of_match_ptr(st_magn_dt_match),
 	},
 	.probe = st_magn_spi_probe,
 	.remove = st_magn_spi_remove,
-- 
1.7.9.5

