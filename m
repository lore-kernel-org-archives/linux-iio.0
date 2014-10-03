Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45242 "EHLO
	mx08-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752922AbaJCPgM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 3 Oct 2014 11:36:12 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 7/7] iio:common: Set the device pointer into ST common sensors library
Date: Fri,  3 Oct 2014 17:35:41 +0200
Message-Id: <1412350541-29431-7-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1412350541-29431-1-git-send-email-denis.ciocca@st.com>
References: <1412350541-29431-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/accel/st_accel_i2c.c               | 1 -
 drivers/iio/accel/st_accel_spi.c               | 1 -
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 1 +
 drivers/iio/common/st_sensors/st_sensors_spi.c | 1 +
 drivers/iio/gyro/st_gyro_i2c.c                 | 1 -
 drivers/iio/gyro/st_gyro_spi.c                 | 1 -
 drivers/iio/magnetometer/st_magn_i2c.c         | 1 -
 drivers/iio/magnetometer/st_magn_spi.c         | 1 -
 drivers/iio/pressure/st_pressure_i2c.c         | 1 -
 drivers/iio/pressure/st_pressure_spi.c         | 1 -
 10 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 40adc7e..c7246bd 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -79,7 +79,6 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	adata = iio_priv(indio_dev);
-	adata->dev = &client->dev;
 	st_sensors_of_i2c_probe(client, st_accel_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, adata);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index 2090d80..12ec293 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -29,7 +29,6 @@ static int st_accel_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	adata = iio_priv(indio_dev);
-	adata->dev = &spi->dev;
 
 	st_sensors_spi_configure(indio_dev, spi, adata);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index bb6f308..98cfee29 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -72,6 +72,7 @@ void st_sensors_i2c_configure(struct iio_dev *indio_dev,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->name = client->name;
 
+	sdata->dev = &client->dev;
 	sdata->tf = &st_sensors_tf_i2c;
 	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
 }
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 251baf6..78a6a1a 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -111,6 +111,7 @@ void st_sensors_spi_configure(struct iio_dev *indio_dev,
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi->modalias;
 
+	sdata->dev = &spi->dev;
 	sdata->tf = &st_sensors_tf_spi;
 	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
 }
diff --git a/drivers/iio/gyro/st_gyro_i2c.c b/drivers/iio/gyro/st_gyro_i2c.c
index 94d01fb..64480b1 100644
--- a/drivers/iio/gyro/st_gyro_i2c.c
+++ b/drivers/iio/gyro/st_gyro_i2c.c
@@ -67,7 +67,6 @@ static int st_gyro_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	gdata = iio_priv(indio_dev);
-	gdata->dev = &client->dev;
 	st_sensors_of_i2c_probe(client, st_gyro_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, gdata);
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index 3e7a01a..e59bead 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -29,7 +29,6 @@ static int st_gyro_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	gdata = iio_priv(indio_dev);
-	gdata->dev = &spi->dev;
 
 	st_sensors_spi_configure(indio_dev, spi, gdata);
 
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index f8a6823..92e5c15 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -51,7 +51,6 @@ static int st_magn_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	mdata = iio_priv(indio_dev);
-	mdata->dev = &client->dev;
 	st_sensors_of_i2c_probe(client, st_magn_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, mdata);
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index f642142..7adacf1 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -29,7 +29,6 @@ static int st_magn_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	mdata = iio_priv(indio_dev);
-	mdata->dev = &spi->dev;
 
 	st_sensors_spi_configure(indio_dev, spi, mdata);
 
diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
index 8859e93..137788b 100644
--- a/drivers/iio/pressure/st_pressure_i2c.c
+++ b/drivers/iio/pressure/st_pressure_i2c.c
@@ -51,7 +51,6 @@ static int st_press_i2c_probe(struct i2c_client *client,
 		return -ENOMEM;
 
 	press_data = iio_priv(indio_dev);
-	press_data->dev = &client->dev;
 	st_sensors_of_i2c_probe(client, st_press_of_match);
 
 	st_sensors_i2c_configure(indio_dev, client, press_data);
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 10c9624..1ffa6d4 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -29,7 +29,6 @@ static int st_press_spi_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	press_data = iio_priv(indio_dev);
-	press_data->dev = &spi->dev;
 
 	st_sensors_spi_configure(indio_dev, spi, press_data);
 
-- 
1.9.1

