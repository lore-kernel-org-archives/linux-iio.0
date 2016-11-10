Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] iio: st_sensors: centralize SPI probe() code
Date: Thu, 10 Nov 2016 11:19:02 +0100
Message-Id: <1478773142-23081-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The probe() calls for the ST Sensors SPI modules were all doing
pretty much the same things for the different IIO subsubsystems,
they were all allocating the same state container struct just
giving different names to the same variable. Move it all to the
common code in st_sensors_spi.c to avoid code duplication.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_spi.c               | 13 ++++---------
 drivers/iio/common/st_sensors/st_sensors_spi.c | 21 +++++++++++++++++----
 drivers/iio/gyro/st_gyro_spi.c                 | 13 ++++---------
 drivers/iio/magnetometer/st_magn_spi.c         | 13 ++++---------
 drivers/iio/pressure/st_pressure_spi.c         | 13 ++++---------
 include/linux/iio/common/st_sensors_spi.h      |  4 ++--
 6 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index efd43941d45d..35ead37e0077 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -21,19 +21,14 @@
 static int st_accel_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
-	struct st_sensor_data *adata;
 	int err;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adata));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	adata = iio_priv(indio_dev);
-
-	st_sensors_spi_configure(indio_dev, spi, adata);
+	err = st_sensors_spi_probe(spi, &indio_dev);
+	if (err)
+		return err;
 
 	err = st_accel_common_probe(indio_dev);
-	if (err < 0)
+	if (err)
 		return err;
 
 	return 0;
diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 5b377373f48d..3f31a29058e1 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -103,10 +103,17 @@ static const struct st_sensor_transfer_function st_sensors_tf_spi = {
 	.read_multiple_byte = st_sensors_spi_read_multiple_byte,
 };
 
-void st_sensors_spi_configure(struct iio_dev *indio_dev,
-			struct spi_device *spi, struct st_sensor_data *sdata)
+int st_sensors_spi_probe(struct spi_device *spi,
+			 struct iio_dev **ret_indio_dev)
 {
-	spi_set_drvdata(spi, indio_dev);
+	struct iio_dev *indio_dev;
+	struct st_sensor_data *sdata;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*sdata));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	sdata = iio_priv(indio_dev);
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi->modalias;
@@ -114,8 +121,14 @@ void st_sensors_spi_configure(struct iio_dev *indio_dev,
 	sdata->dev = &spi->dev;
 	sdata->tf = &st_sensors_tf_spi;
 	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
+
+	spi_set_drvdata(spi, indio_dev);
+
+	*ret_indio_dev = indio_dev;
+
+	return 0;
 }
-EXPORT_SYMBOL(st_sensors_spi_configure);
+EXPORT_SYMBOL(st_sensors_spi_probe);
 
 MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics ST-sensors spi driver");
diff --git a/drivers/iio/gyro/st_gyro_spi.c b/drivers/iio/gyro/st_gyro_spi.c
index fbf2faed501c..ce73c55b6b2c 100644
--- a/drivers/iio/gyro/st_gyro_spi.c
+++ b/drivers/iio/gyro/st_gyro_spi.c
@@ -21,19 +21,14 @@
 static int st_gyro_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
-	struct st_sensor_data *gdata;
 	int err;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*gdata));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	gdata = iio_priv(indio_dev);
-
-	st_sensors_spi_configure(indio_dev, spi, gdata);
+	err = st_sensors_spi_probe(spi, &indio_dev);
+	if (err)
+		return err;
 
 	err = st_gyro_common_probe(indio_dev);
-	if (err < 0)
+	if (err)
 		return err;
 
 	return 0;
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 6325e7dc8e03..c35c4d1135df 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -21,19 +21,14 @@
 static int st_magn_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
-	struct st_sensor_data *mdata;
 	int err;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*mdata));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	mdata = iio_priv(indio_dev);
-
-	st_sensors_spi_configure(indio_dev, spi, mdata);
+	err = st_sensors_spi_probe(spi, &indio_dev);
+	if (err)
+		return err;
 
 	err = st_magn_common_probe(indio_dev);
-	if (err < 0)
+	if (err)
 		return err;
 
 	return 0;
diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
index 550508025af1..d97dcddae064 100644
--- a/drivers/iio/pressure/st_pressure_spi.c
+++ b/drivers/iio/pressure/st_pressure_spi.c
@@ -21,19 +21,14 @@
 static int st_press_spi_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
-	struct st_sensor_data *press_data;
 	int err;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*press_data));
-	if (indio_dev == NULL)
-		return -ENOMEM;
-
-	press_data = iio_priv(indio_dev);
-
-	st_sensors_spi_configure(indio_dev, spi, press_data);
+	err = st_sensors_spi_probe(spi, &indio_dev);
+	if (err)
+		return err;
 
 	err = st_press_common_probe(indio_dev);
-	if (err < 0)
+	if (err)
 		return err;
 
 	return 0;
diff --git a/include/linux/iio/common/st_sensors_spi.h b/include/linux/iio/common/st_sensors_spi.h
index d964a3563dc6..ae89c9bbd842 100644
--- a/include/linux/iio/common/st_sensors_spi.h
+++ b/include/linux/iio/common/st_sensors_spi.h
@@ -14,7 +14,7 @@
 #include <linux/spi/spi.h>
 #include <linux/iio/common/st_sensors.h>
 
-void st_sensors_spi_configure(struct iio_dev *indio_dev,
-			struct spi_device *spi, struct st_sensor_data *sdata);
+int st_sensors_spi_probe(struct spi_device *spi,
+			 struct iio_dev **ret_indio_dev);
 
 #endif /* ST_SENSORS_SPI_H */
-- 
2.7.4
