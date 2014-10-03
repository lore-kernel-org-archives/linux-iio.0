Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:45263 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752800AbaJCPgK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Oct 2014 11:36:10 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/7] iio:gyro: Removed unnecessary parameter on common_probe function
Date: Fri,  3 Oct 2014 17:35:37 +0200
Message-Id: <1412350541-29431-3-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1412350541-29431-1-git-send-email-denis.ciocca@st.com>
References: <1412350541-29431-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro.h      | 3 +--
 drivers/iio/gyro/st_gyro_core.c | 6 +++---
 drivers/iio/gyro/st_gyro_i2c.c  | 3 +--
 drivers/iio/gyro/st_gyro_spi.c  | 3 +--
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro.h b/drivers/iio/gyro/st_gyro.h
index c197360..5353d63 100644
--- a/drivers/iio/gyro/st_gyro.h
+++ b/drivers/iio/gyro/st_gyro.h
@@ -30,8 +30,7 @@ static const struct st_sensors_platform_data gyro_pdata = {
 	.drdy_int_pin = 2,
 };
 
-int st_gyro_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata);
+int st_gyro_common_probe(struct iio_dev *indio_dev);
 void st_gyro_common_remove(struct iio_dev *indio_dev);
 
 #ifdef CONFIG_IIO_BUFFER
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 9d41b68..f07a233 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -309,8 +309,7 @@ static const struct iio_trigger_ops st_gyro_trigger_ops = {
 #define ST_GYRO_TRIGGER_OPS NULL
 #endif
 
-int st_gyro_common_probe(struct iio_dev *indio_dev,
-					struct st_sensors_platform_data *pdata)
+int st_gyro_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *gdata = iio_priv(indio_dev);
 	int irq = gdata->get_irq_data_ready(indio_dev);
@@ -336,7 +335,8 @@ int st_gyro_common_probe(struct iio_dev *indio_dev,
 					&gdata->sensor_settings->fs.fs_avl[0];
 	gdata->odr = gdata->sensor_settings->odr.odr_avl[0].hz;
 
-	err = st_sensors_init_sensor(indio_dev, pdata);
+	err = st_sensors_init_sensor(indio_dev,
+				(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 8fa0ad2..94d01fb 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -72,8 +72,7 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index b4ad3be..3e7a01a 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -33,8 +33,7 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
-	err = st_gyro_common_probe(indio_dev,
-				(struct st_sensors_platform_data *)&gyro_pdata);
+	err = st_gyro_common_probe(indio_dev);
 	if (err < 0)
 		return err;
 
-- 
1.9.1

