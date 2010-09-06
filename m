Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:56645 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436Ab0IFPLa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 6 Sep 2010 11:11:30 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: m_brugger@web.de, Michael.Hennerich@analog.com,
	Robin.Getz@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] staging:iio:adis16260 add suppport for adis16255 and adis16250.
Date: Mon,  6 Sep 2010 16:16:18 +0100
Message-Id: <1283786178-6466-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
References: <1283786178-6466-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Unusual element is addition of 'negate' and 'axis' platform data
to ensure we support all the functionality of the adis16255 driver
currently in staging.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/Kconfig                   |    8 +-
 drivers/staging/iio/gyro/adis16260.h               |    3 +
 drivers/staging/iio/gyro/adis16260_core.c          |  132 ++++++++++++++------
 drivers/staging/iio/gyro/adis16260_platform_data.h |   19 +++
 drivers/staging/iio/gyro/gyro.h                    |    9 ++
 5 files changed, 129 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index c404361..4dabd7f 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -4,10 +4,12 @@
 comment "Digital gyroscope sensors"
 
 config ADIS16260
-	tristate "Analog Devices ADIS16260/5 Digital Gyroscope Sensor SPI driver"
+
+	tristate "Analog Devices ADIS16260 and similar Digital Gyroscope Sensor SPI driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_RING_BUFFER
 	select IIO_SW_RING if IIO_RING_BUFFER
 	help
-	  Say yes here to build support for Analog Devices adis16260/5
-	  programmable digital gyroscope sensor.
+	  Say yes here to build support for Analog Devices adis16250,
+	  adis16255, adis16260 and adis16265 programmable digital
+	  gyroscope sensors.
diff --git a/drivers/staging/iio/gyro/adis16260.h b/drivers/staging/iio/gyro/adis16260.h
index 812440a..c1fd436 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -1,5 +1,6 @@
 #ifndef SPI_ADIS16260_H_
 #define SPI_ADIS16260_H_
+#include "adis16260_platform_data.h"
 
 #define ADIS16260_STARTUP_DELAY	220 /* ms */
 
@@ -92,6 +93,7 @@
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
+ * @negate:		negate the scale parameter
  **/
 struct adis16260_state {
 	struct spi_device		*us;
@@ -102,6 +104,7 @@ struct adis16260_state {
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
+	unsigned			negate:1;
 };
 
 int adis16260_set_irq(struct device *dev, bool enable);
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index 36e5757..790971f 100644
--- a/drivers/staging/iio/gyro/adis16260_core.c
+++ b/drivers/staging/iio/gyro/adis16260_core.c
@@ -134,8 +134,6 @@ static int adis16260_spi_read_reg_16(struct device *dev,
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = ADIS16260_READ_REG(lower_reg_address);
 	st->tx[1] = 0;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
 
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
@@ -293,6 +291,22 @@ static ssize_t adis16260_write_frequency(struct device *dev,
 	return ret ? ret : len;
 }
 
+static ssize_t adis16260_read_gyro_scale(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	ssize_t ret = 0;
+
+	if (st->negate)
+		ret = sprintf(buf, "-");
+	/* Take the iio_dev status lock */
+	ret += sprintf(buf + ret, "%s\n", "0.00127862821");
+
+	return ret;
+}
+
 static int adis16260_reset(struct device *dev)
 {
 	int ret;
@@ -447,18 +461,6 @@ static IIO_DEV_ATTR_IN_NAMED_RAW(supply,
 				ADIS16260_SUPPLY_OUT);
 static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.0018315");
 
-static IIO_DEV_ATTR_GYRO(adis16260_read_14bit_signed,
-		ADIS16260_GYRO_OUT);
-static IIO_CONST_ATTR_GYRO_SCALE("0.00127862821");
-static IIO_DEV_ATTR_GYRO_CALIBSCALE(S_IWUSR | S_IRUGO,
-		adis16260_read_14bit_signed,
-		adis16260_write_16bit,
-		ADIS16260_GYRO_SCALE);
-static IIO_DEV_ATTR_GYRO_CALIBBIAS(S_IWUSR | S_IRUGO,
-		adis16260_read_12bit_signed,
-		adis16260_write_16bit,
-		ADIS16260_GYRO_OFF);
-
 static IIO_DEV_ATTR_TEMP_RAW(adis16260_read_12bit_unsigned);
 static IIO_CONST_ATTR_TEMP_OFFSET("25");
 static IIO_CONST_ATTR_TEMP_SCALE("0.1453");
@@ -470,8 +472,6 @@ static IIO_CONST_ATTR(in0_scale, "0.0006105");
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16260_read_frequency,
 		adis16260_write_frequency);
-static IIO_DEV_ATTR_ANGL(adis16260_read_14bit_signed,
-		ADIS16260_ANGL_OUT);
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
 
@@ -487,38 +487,69 @@ static struct attribute_group adis16260_event_attribute_group = {
 	.attrs = adis16260_event_attributes,
 };
 
-static struct attribute *adis16260_attributes[] = {
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_raw.dev_attr.attr,
-	&iio_const_attr_gyro_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_calibscale.dev_attr.attr,
-	&iio_dev_attr_gyro_calibbias.dev_attr.attr,
-	&iio_dev_attr_angl_raw.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
-	NULL
-};
+#define ADIS16260_GYRO_ATTR_SET(axis)					\
+	IIO_DEV_ATTR_GYRO##axis(adis16260_read_14bit_signed,		\
+				ADIS16260_GYRO_OUT);			\
+	static IIO_DEV_ATTR_GYRO##axis##_SCALE(S_IRUGO,			\
+					adis16260_read_gyro_scale,	\
+					NULL,				\
+					0);				\
+	static IIO_DEV_ATTR_GYRO##axis##_CALIBSCALE(S_IRUGO | S_IWUSR,	\
+					adis16260_read_12bit_unsigned,	\
+					adis16260_write_16bit,		\
+					ADIS16260_GYRO_SCALE);		\
+	static IIO_DEV_ATTR_GYRO##axis##_CALIBBIAS(S_IWUSR | S_IRUGO,	\
+					adis16260_read_12bit_signed,	\
+					adis16260_write_16bit,		\
+					ADIS16260_GYRO_OFF);		\
+	static IIO_DEV_ATTR_ANGL##axis(adis16260_read_14bit_signed,	\
+				       ADIS16260_ANGL_OUT);
+
+static ADIS16260_GYRO_ATTR_SET();
+static ADIS16260_GYRO_ATTR_SET(_X);
+static ADIS16260_GYRO_ATTR_SET(_Y);
+static ADIS16260_GYRO_ATTR_SET(_Z);
+
+#define ADIS16260_ATTR_GROUP(axis)						\
+	struct attribute *adis16260_attributes##axis[] = {		\
+		&iio_dev_attr_in_supply_raw.dev_attr.attr,		\
+		&iio_const_attr_in_supply_scale.dev_attr.attr,		\
+		&iio_dev_attr_gyro##axis##_raw.dev_attr.attr,		\
+		&iio_dev_attr_gyro##axis##_scale.dev_attr.attr,		\
+		&iio_dev_attr_gyro##axis##_calibscale.dev_attr.attr,	\
+		&iio_dev_attr_gyro##axis##_calibbias.dev_attr.attr,	\
+		&iio_dev_attr_angl##axis##_raw.dev_attr.attr,		\
+		&iio_dev_attr_temp_raw.dev_attr.attr,			\
+		&iio_const_attr_temp_offset.dev_attr.attr,		\
+		&iio_const_attr_temp_scale.dev_attr.attr,		\
+		&iio_dev_attr_in0_raw.dev_attr.attr,			\
+		&iio_const_attr_in0_scale.dev_attr.attr,		\
+		&iio_dev_attr_sampling_frequency.dev_attr.attr,		\
+		&iio_const_attr_sampling_frequency_available.dev_attr.attr, \
+		&iio_dev_attr_reset.dev_attr.attr,			\
+		&iio_const_attr_name.dev_attr.attr,			\
+		NULL							\
+	};								\
+	static const struct attribute_group adis16260_attribute_group##axis = {	\
+		.attrs = adis16260_attributes##axis,			\
+	};
 
-static const struct attribute_group adis16260_attribute_group = {
-	.attrs = adis16260_attributes,
-};
+static ADIS16260_ATTR_GROUP();
+static ADIS16260_ATTR_GROUP(_x);
+static ADIS16260_ATTR_GROUP(_y);
+static ADIS16260_ATTR_GROUP(_z);
 
 static int __devinit adis16260_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
+	struct adis16260_platform_data *pd = spi->dev.platform_data;
 	struct adis16260_state *st = kzalloc(sizeof *st, GFP_KERNEL);
 	if (!st) {
 		ret =  -ENOMEM;
 		goto error_ret;
 	}
+	if (pd)
+		st->negate = pd->negate;
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, st);
 
@@ -545,7 +576,24 @@ static int __devinit adis16260_probe(struct spi_device *spi)
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->num_interrupt_lines = 1;
 	st->indio_dev->event_attrs = &adis16260_event_attribute_group;
-	st->indio_dev->attrs = &adis16260_attribute_group;
+	if (pd && pd->direction)
+		switch (pd->direction) {
+		case 'x':
+			st->indio_dev->attrs = &adis16260_attribute_group_x;
+			break;
+		case 'y':
+			st->indio_dev->attrs = &adis16260_attribute_group_y;
+			break;
+		case 'z':
+			st->indio_dev->attrs = &adis16260_attribute_group_z;
+			break;
+		default:
+			st->indio_dev->attrs = &adis16260_attribute_group;
+			break;
+		}
+	else
+		st->indio_dev->attrs = &adis16260_attribute_group;
+
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -635,9 +683,15 @@ err_ret:
 	return ret;
 }
 
+/*
+ * These parts do not need to differentiated until someone adds
+ * support for the on chip filtering.
+ */
 static const struct spi_device_id adis16260_id[] = {
 	{"adis16260", 0},
 	{"adis16265", 0},
+	{"adis16250", 0},
+	{"adis16255", 0},
 	{}
 };
 
diff --git a/drivers/staging/iio/gyro/adis16260_platform_data.h b/drivers/staging/iio/gyro/adis16260_platform_data.h
new file mode 100644
index 0000000..12802e9
--- /dev/null
+++ b/drivers/staging/iio/gyro/adis16260_platform_data.h
@@ -0,0 +1,19 @@
+/*
+ * ADIS16260 Programmable Digital Gyroscope Sensor Driver Platform Data
+ *
+ * Based on adis16255.h Matthia Brugger <m_brugger&web.de>
+ *
+ * Copyright (C) 2010 Fraunhofer Institute for Integrated Circuits
+  *
+ * Licensed under the GPL-2 or later.
+ */
+
+/**
+ * struct adis16260_platform_data - instance specific data
+ * @direction: x y or z
+ * @negate: flag to indicate value should be inverted.
+ **/
+struct adis16260_platform_data {
+	char direction;
+	unsigned negate:1;
+};
diff --git a/drivers/staging/iio/gyro/gyro.h b/drivers/staging/iio/gyro/gyro.h
index 98b837b..cc5355b 100644
--- a/drivers/staging/iio/gyro/gyro.h
+++ b/drivers/staging/iio/gyro/gyro.h
@@ -71,3 +71,12 @@
 
 #define IIO_DEV_ATTR_ANGL(_show, _addr)                         \
 	IIO_DEVICE_ATTR(angl_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ANGL_X(_show, _addr)                         \
+	IIO_DEVICE_ATTR(angl_x_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ANGL_Y(_show, _addr)                         \
+	IIO_DEVICE_ATTR(angl_y_raw, S_IRUGO, _show, NULL, _addr)
+
+#define IIO_DEV_ATTR_ANGL_Z(_show, _addr)                         \
+	IIO_DEVICE_ATTR(angl_z_raw, S_IRUGO, _show, NULL, _addr)
-- 
1.7.1

