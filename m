Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60072 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab1BERwO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2011 12:52:14 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: mensch0815@googlemail.com,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 4/5] staging:iio:gyro: add adis16251 support to adis16260 driver.
Date: Sat,  5 Feb 2011 17:52:04 +0000
Message-Id: <1296928325-14967-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1296928325-14967-1-git-send-email-jic23@cam.ac.uk>
References: <1296928325-14967-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These parts are very similar and the adis16260 driver supports
a lot of additional functionality.

Precursor to removal of adis16251 driver.

Note that some supported devices were missing from Kconfig help text
and are also added in this patch.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/Kconfig          |    4 +-
 drivers/staging/iio/gyro/adis16260_core.c |   49 +++++++++++++++++++++++------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index 236f15f..5bba4b0 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -25,13 +25,13 @@ config ADIS16130
 	  Angular Rate Sensor driver.
 
 config ADIS16260
-	tristate "Analog Devices ADIS16260 ADIS16265 Digital Gyroscope Sensor SPI driver"
+	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_RING_BUFFER
 	select IIO_SW_RING if IIO_RING_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADIS16260 ADIS16265
-	  programmable digital gyroscope sensor.
+	  ADIS16250 ADIS16255 and ADIS16251 programmable digital gyroscope sensors.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called adis16260.
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 045e27d..69a29ec 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -238,10 +238,24 @@ error_ret:
 	return ret ? ret : len;
 }
 
+static ssize_t adis16260_read_frequency_available(struct device *dev,
+						  struct device_attribute *attr,
+						  char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	if (spi_get_device_id(st->us)->driver_data)
+		return sprintf(buf, "%s\n", "0.129 ~ 256");
+	else
+		return sprintf(buf, "%s\n", "256 2048");
+}
+
 static ssize_t adis16260_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
 {
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
 	int ret, len = 0;
 	u16 t;
 	int sps;
@@ -250,7 +264,11 @@ static ssize_t adis16260_read_frequency(struct device *dev,
 			&t);
 	if (ret)
 		return ret;
-	sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
+
+	if (spi_get_device_id(st->us)->driver_data) /* If an adis16251 */
+		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 8 : 256;
+	else
+		sps =  (t & ADIS16260_SMPL_PRD_TIME_BASE) ? 66 : 2048;
 	sps /= (t & ADIS16260_SMPL_PRD_DIV_MASK) + 1;
 	len = sprintf(buf, "%d SPS\n", sps);
 	return len;
@@ -272,16 +290,21 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 		return ret;
 
 	mutex_lock(&indio_dev->mlock);
-
-	t = (2048 / val);
-	if (t > 0)
-		t--;
-	t &= ADIS16260_SMPL_PRD_DIV_MASK;
+	if (spi_get_device_id(st->us)) {
+		t = (256 / val);
+		if (t > 0)
+			t--;
+		t &= ADIS16260_SMPL_PRD_DIV_MASK;
+	} else {
+		t = (2048 / val);
+		if (t > 0)
+			t--;
+		t &= ADIS16260_SMPL_PRD_DIV_MASK;
+	}
 	if ((t & ADIS16260_SMPL_PRD_DIV_MASK) >= 0x0A)
 		st->us->max_speed_hz = ADIS16260_SPI_SLOW;
 	else
 		st->us->max_speed_hz = ADIS16260_SPI_FAST;
-
 	ret = adis16260_spi_write_reg_8(dev,
 			ADIS16260_SMPL_PRD,
 			t);
@@ -302,7 +325,10 @@ static ssize_t adis16260_read_gyro_scale(struct device *dev,
 	if (st->negate)
 		ret = sprintf(buf, "-");
 	/* Take the iio_dev status lock */
-	ret += sprintf(buf + ret, "%s\n", "0.00127862821");
+	if (spi_get_device_id(st->us)->driver_data)
+		ret += sprintf(buf + ret, "%s\n", "0.00031974432");
+	else
+		ret += sprintf(buf + ret, "%s\n", "0.00127862821");
 
 	return ret;
 }
@@ -475,7 +501,9 @@ static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("256 2048");
+
+static IIO_DEVICE_ATTR(sampling_frequency_available,
+		       S_IRUGO, adis16260_read_frequency_available, NULL, 0);
 
 static IIO_CONST_ATTR_NAME("adis16260");
 
@@ -525,7 +553,7 @@ static ADIS16260_GYRO_ATTR_SET(_Z);
 		&iio_dev_attr_in1_raw.dev_attr.attr,			\
 		&iio_const_attr_in1_scale.dev_attr.attr,		\
 		&iio_dev_attr_sampling_frequency.dev_attr.attr,		\
-		&iio_const_attr_sampling_frequency_available.dev_attr.attr, \
+		&iio_dev_attr_sampling_frequency_available.dev_attr.attr, \
 		&iio_dev_attr_reset.dev_attr.attr,			\
 		&iio_const_attr_name.dev_attr.attr,			\
 		NULL							\
@@ -693,6 +721,7 @@ static const struct spi_device_id adis16260_id[] = {
 	{"adis16265", 0},
 	{"adis16250", 0},
 	{"adis16255", 0},
+	{"adis16251", 1},
 	{}
 };
 
-- 
1.7.3.4

