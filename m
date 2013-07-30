Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 3/3] iio: pressure: st_pressure: Use devm_iio_device_alloc
Date: Tue, 30 Jul 2013 11:54:23 +0530
Message-Id: <1375165463-23453-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1375165463-23453-1-git-send-email-sachin.kamat@linaro.org>
References: <1375165463-23453-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/pressure/st_pressure_core.c |    1 -
 drivers/iio/pressure/st_pressure_i2c.c  |   15 ++++-----------
 drivers/iio/pressure/st_pressure_spi.c  |   15 ++++-----------
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index b8ecc87..093b045 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -270,7 +270,6 @@ void st_press_common_remove(struct iio_dev *indio_dev)
 		st_sensors_deallocate_trigger(indio_dev);
 		st_press_deallocate_ring(indio_dev);
 	}
-	iio_device_free(indio_dev);
 }
 EXPORT_SYMBOL(st_press_common_remove);
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 3065993..08aac5e 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -25,11 +25,9 @@ static int st_press_i2c_probe(struct i2c_client *client,
 	struct st_sensor_data *pdata;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*pdata));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto iio_device_alloc_error;
-	}
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*pdata));
+	if (!indio_dev)
+		return -ENOMEM;
 
 	pdata = iio_priv(indio_dev);
 	pdata->dev = &client->dev;
@@ -38,14 +36,9 @@ static int st_press_i2c_probe(struct i2c_client *client,
 
 	err = st_press_common_probe(indio_dev, client->dev.platform_data);
 	if (err < 0)
-		goto st_press_common_probe_error;
+		return err;
 
 	return 0;
-
-st_press_common_probe_error:
-	iio_device_free(indio_dev);
-iio_device_alloc_error:
-	return err;
 }
 
 static int st_press_i2c_remove(struct i2c_client *client)
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index b2aded6..399a29b 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -24,11 +24,9 @@ static int st_press_spi_probe(struct spi_device *spi)
 	struct st_sensor_data *pdata;
 	int err;
 
-	indio_dev = iio_device_alloc(sizeof(*pdata));
-	if (indio_dev == NULL) {
-		err = -ENOMEM;
-		goto iio_device_alloc_error;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*pdata));
+	if (indio_dev == NULL)
+		return -ENOMEM;
 
 	pdata = iio_priv(indio_dev);
 	pdata->dev = &spi->dev;
@@ -37,14 +35,9 @@ static int st_press_spi_probe(struct spi_device *spi)
 
 	err = st_press_common_probe(indio_dev, spi->dev.platform_data);
 	if (err < 0)
-		goto st_press_common_probe_error;
+		return err;
 
 	return 0;
-
-st_press_common_probe_error:
-	iio_device_free(indio_dev);
-iio_device_alloc_error:
-	return err;
 }
 
 static int st_press_spi_remove(struct spi_device *spi)
-- 
1.7.9.5
