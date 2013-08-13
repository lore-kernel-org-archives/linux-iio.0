Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jic23@cam.ac.uk,
	sachin.kamat@linaro.org,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 8/9] iio: gyro: st_gyro: Use devm_iio_device_alloc
Date: Tue, 13 Aug 2013 12:04:34 +0530
Message-Id: <1376375675-11595-8-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
References: <1376375675-11595-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/gyro/st_gyro_core.c |    1 -
 drivers/iio/gyro/st_gyro_i2c.c  |   15 ++++-----------
 drivers/iio/gyro/st_gyro_spi.c  |   15 ++++-----------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 85fa8d3..e13c2b0 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -366,7 +366,6 @@ void st_gyro_common_remove(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 		st_gyro_deallocate_ring(indio_dev);
 	}
-	iio_device_free(indio_dev);
 }
 EXPORT_SYMBOL(st_gyro_common_remove);
 
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index c7a29a4..16b8b8d 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -25,11 +25,9 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	struct st_sensor_data *gdata;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*gdata));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto iio_device_alloc_error;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*gdata));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	gdata = iio_priv(indio_dev);
 	gdata->dev = &client->dev;
@@ -39,14 +37,9 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 	err = st_gyro_common_probe(indio_dev,
 				(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
-		goto st_gyro_common_probe_error;
+		return err;
 
 	return 0;
-
-st_gyro_common_probe_error:
-	iio_device_free(indio_dev);
-iio_device_alloc_error:
-	return err;
 }
 
 static int st_gyro_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 14b0762..94763e2 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -24,11 +24,9 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	struct st_sensor_data *gdata;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*gdata));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto iio_device_alloc_error;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*gdata));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	gdata = iio_priv(indio_dev);
 	gdata->dev = &spi->dev;
@@ -38,14 +36,9 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 	err = st_gyro_common_probe(indio_dev,
 				(struct st_sensors_platform_data *)&gyro_pdata);
 	if (err < 0)
-		goto st_gyro_common_probe_error;
+		return err;
 
 	return 0;
-
-st_gyro_common_probe_error:
-	iio_device_free(indio_dev);
-iio_device_alloc_error:
-	return err;
 }
 
 static int st_gyro_spi_remove(struct spi_device *spi)
-- 
1.7.9.5
