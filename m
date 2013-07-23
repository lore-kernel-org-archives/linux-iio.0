Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/4] iio: accel: st_accel: Use devm_iio_device_alloc
Date: Tue, 23 Jul 2013 12:17:09 +0530
Message-Id: <1374562030-28621-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374562030-28621-1-git-send-email-sachin.kamat@linaro.org>
References: <1374562030-28621-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_core.c |    1 -
 drivers/iio/accel/st_accel_i2c.c  |   15 ++++-----------
 drivers/iio/accel/st_accel_spi.c  |   15 ++++-----------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index aef3c9b..1458343 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -517,7 +517,6 @@ void st_accel_common_remove(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 		st_accel_deallocate_ring(indio_dev);
 	}
-	iio_device_free(indio_dev);
 }
 EXPORT_SYMBOL(st_accel_common_remove);
 
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 58d164d..d7bedbd 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -25,11 +25,9 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 	struct st_sensor_data *adata;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*adata));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto iio_device_alloc_error;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*adata));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	adata = iio_priv(indio_dev);
 	adata->dev = &client->dev;
@@ -38,14 +36,9 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 
 	err = st_accel_common_probe(indio_dev, client->dev.platform_data);
 	if (err < 0)
-		goto st_accel_common_probe_error;
+		return err;
 
 	return 0;
-
-st_accel_common_probe_error:
-	iio_device_free(indio_dev);
-iio_device_alloc_error:
-	return err;
 }
 
 static int st_accel_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 21ed929..1956396 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -24,11 +24,9 @@ static int st_accel_spi_probe(struct spi_device *spi)
 	struct st_sensor_data *adata;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*adata));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto iio_device_alloc_error;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adata));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	adata = iio_priv(indio_dev);
 	adata->dev = &spi->dev;
@@ -37,14 +35,9 @@ static int st_accel_spi_probe(struct spi_device *spi)
 
 	err = st_accel_common_probe(indio_dev, spi->dev.platform_data);
 	if (err < 0)
-		goto st_accel_common_probe_error;
+		return err;
 
 	return 0;
-
-st_accel_common_probe_error:
-	iio_device_free(indio_dev);
-iio_device_alloc_error:
-	return err;
 }
 
 static int st_accel_spi_remove(struct spi_device *spi)
-- 
1.7.9.5
