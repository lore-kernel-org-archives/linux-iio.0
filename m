Return-Path: <ludovic.tancerel@maplehightech.com>
From: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	ludovic.tancerel@maplehightech.com,
	William.Markezana@meas-spec.com
Subject: [PATCH V2 6/6] iio: Add ms8607 meas-spec driver support
Date: Thu, 30 Jul 2015 11:25:45 +0200
Message-Id: <1438248345-25820-7-git-send-email-ludovic.tancerel@maplehightech.com>
In-Reply-To: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com>
References: <1438248345-25820-1-git-send-email-ludovic.tancerel@maplehightech.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-meas-spec |  1 +
 drivers/iio/humidity/htu21.c                      | 32 ++++++++++++++++++++---
 drivers/iio/pressure/Kconfig                      | 13 +++++++++
 drivers/iio/pressure/ms5637.c                     |  6 ++++-
 4 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
index 7b09d3a..df70dda6 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
+++ b/Documentation/ABI/testing/sysfs-bus-iio-meas-spec
@@ -12,3 +12,4 @@ Description:
                 Enable or disable heater function by writing either
 		'1' or '0'.
                 Same reading values apply
+		This ABI is available for htu21, ms8607
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 870b631..4720cbc 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -1,6 +1,7 @@
 /*
  * htu21.c - Support for Measurement-Specialties
  *           htu21 temperature & humidity sensor
+ *	     and humidity part of MS8607 sensor
  *
  * Copyright (c) 2014 Measurement-Specialties
  *
@@ -10,6 +11,8 @@
  *
  * Datasheet:
  *  http://www.meas-spec.com/downloads/HTU21D.pdf
+ * Datasheet:
+ *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
  *
  */
 
@@ -25,6 +28,11 @@
 
 #define HTU21_RESET				0xFE
 
+enum {
+	HTU21,
+	MS8607
+};
+
 static const int htu21_samp_freq[4] = { 20, 40, 70, 120 };
 /* String copy of the above const for readability purpose */
 static const char htu21_show_samp_freq[] = "20 40 70 120";
@@ -107,6 +115,17 @@ static const struct iio_chan_spec htu21_channels[] = {
 	 }
 };
 
+/* Meas Spec recommendation is to not read temperature
+ * on this driver part for MS8607
+ */
+static const struct iio_chan_spec ms8607_channels[] = {
+	{
+		.type = IIO_HUMIDITYRELATIVE,
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	 }
+};
+
 static ssize_t htu21_show_battery_low(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
@@ -189,8 +208,14 @@ int htu21_probe(struct i2c_client *client,
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = htu21_channels;
-	indio_dev->num_channels = ARRAY_SIZE(htu21_channels);
+
+	if (id->driver_data == MS8607) {
+		indio_dev->channels = ms8607_channels;
+		indio_dev->num_channels = ARRAY_SIZE(ms8607_channels);
+	} else {
+		indio_dev->channels = htu21_channels;
+		indio_dev->num_channels = ARRAY_SIZE(htu21_channels);
+	}
 
 	i2c_set_clientdata(client, indio_dev);
 
@@ -207,7 +232,8 @@ int htu21_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id htu21_id[] = {
-	{"htu21", 0},
+	{"htu21", HTU21},
+	{"ms8607-h", MS8607},
 	{}
 };
 
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 8142cfe..e6a7fd5 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -90,6 +90,19 @@ config MS5637
 	  This driver can also be built as a module. If so, the module will
 	  be called ms5637.
 
+config MS8607
+	tristate "Measurement Specialties MS8607 pressure, temperature & humidity sensor"
+	depends on I2C
+        select IIO_MS_SENSORS_I2C
+        select HTU21
+        select MS5637
+	help
+	  If you say yes here you get support for the Measurement Specialties
+	  MS8607 pressure, temperature and humidity sensor.
+
+	  This is based on HTU21 and MS5637 drivers. If built as a module,
+	  modules to load will be htu21 and ms5637.
+
 config IIO_ST_PRESS
 	tristate "STMicroelectronics pressure sensor Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index e2073fd..c185aa0 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -1,5 +1,5 @@
 /*
- * ms5637.c - Support for Measurement-Specialties ms5637
+ * ms5637.c - Support for Measurement-Specialties ms5637 and ms8607
  *            pressure & temperature sensor
  *
  * Copyright (c) 2015 Measurement-Specialties
@@ -10,8 +10,11 @@
  *
  * Datasheet:
  *  http://www.meas-spec.com/downloads/MS5637-02BA03.pdf
+ * Datasheet:
+ *  http://www.meas-spec.com/downloads/MS8607-02BA01.pdf
  *
  */
+
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -168,6 +171,7 @@ static int ms5637_probe(struct i2c_client *client,
 
 static const struct i2c_device_id ms5637_id[] = {
 	{"ms5637", 0},
+	{"ms8607-tp", 1},
 	{}
 };
 
-- 
2.3.7
