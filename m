Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:64647 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755Ab3I0Qc2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Sep 2013 12:32:28 -0400
From: Lukasz Czerwinski <l.czerwinski@samsung.com>
To: jic23@cam.ac.uk
Cc: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: [RFC v2 PATCH 05/14] iio: st_pressure: Add dt bindings
Date: Fri, 27 Sep 2013 18:32:09 +0200
Message-id: <1380299538-22047-6-git-send-email-l.czerwinski@samsung.com>
In-reply-to: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add OF support for the st_pressure.

Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/iio/pressure/st_pressure.h      |    3 +--
 drivers/iio/pressure/st_pressure_core.c |   10 ++++------
 drivers/iio/pressure/st_pressure_i2c.c  |   11 ++++++++++-
 drivers/iio/pressure/st_pressure_spi.c  |   11 ++++++++++-
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
index 049c21a..3b9e2fd 100644
--- a/drivers/iio/pressure/st_pressure.h
+++ b/drivers/iio/pressure/st_pressure.h
@@ -25,8 +25,7 @@ static const struct st_sensors_platform_data default_press_pdata = {
 	.drdy_int_pin = 1,
 };
 
-int st_press_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_press_common_probe(struct iio_dev *indio_dev);
 void st_press_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 58083f9..f78bd33 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -348,8 +348,7 @@ static void st_press_power_disable(struct iio_dev *indio_dev)
 		regulator_disable(pdata->vdd_io);
 }
 
-int st_press_common_probe(struct iio_dev *indio_dev,
-				struct st_sensors_platform_data *plat_data)
+int st_press_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *pdata = iio_priv(indio_dev);
 	int irq = pdata->get_irq_data_ready(indio_dev);
@@ -378,11 +377,10 @@ int st_press_common_probe(struct iio_dev *indio_dev,
 	pdata->odr = pdata->sensor->odr.odr_avl[0].hz;
 
 	/* Some devices don't support a data ready pin. */
-	if (!plat_data && pdata->sensor->drdy_irq.addr)
-		plat_data =
-			(struct st_sensors_platform_data *)&default_press_pdata;
+	if (!pdata->dev->platform_data && !pdata->dev->of_node)
+		pdata->drdy_int_pin = default_press_pdata.drdy_int_pin;
 
-	err = st_sensors_init_sensor(indio_dev, plat_data);
+	err = st_sensors_init_sensor(indio_dev);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 51eab7f..6983a6d 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -34,7 +34,7 @@ static int st_press_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, pdata);
 
-	err = st_press_common_probe(indio_dev, client->dev.platform_data);
+	err = st_press_common_probe(indio_dev);
 	if (err < 0)
 		return err;
 
@@ -55,10 +55,19 @@ static const struct i2c_device_id st_press_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st_press_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_pressure_dt_match[] = {
+	{ .compatible = "st,lps331ap" },
+	{ .compatible = "st,lps001wp" },
+	{ },
+};
+#endif
+
 static struct i2c_driver st_press_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-press-i2c",
+		.of_match_table = of_match_ptr(st_pressure_dt_match),
 	},
 	.probe = st_press_i2c_probe,
 	.remove = st_press_i2c_remove,
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 399a29b..4045988 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -33,7 +33,7 @@ static int st_press_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, pdata);
 
-	err = st_press_common_probe(indio_dev, spi->dev.platform_data);
+	err = st_press_common_probe(indio_dev);
 	if (err < 0)
 		return err;
 
@@ -53,10 +53,19 @@ static const struct spi_device_id st_press_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, st_press_id_table);
 
+#ifdef CONFIG_OF
+static struct of_device_id st_pressure_dt_match[] = {
+	{ .compatible = "st,lps331ap" },
+	{ .compatible = "st,lps001wp" },
+	{ },
+};
+#endif
+
 static struct spi_driver st_press_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "st-press-spi",
+		.of_match_table = of_match_ptr(st_pressure_dt_match),
 	},
 	.probe = st_press_spi_probe,
 	.remove = st_press_spi_remove,
-- 
1.7.9.5

