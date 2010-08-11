Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Barry.Song@analog.com,
	m_brugger@web.de,
	mensch0815@googlemail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] staging:iio:adis16260 add support for adis16250 and adis16255
Date: Wed, 11 Aug 2010 15:12:19 +0100
Message-Id: <1281535939-7190-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1281535939-7190-1-git-send-email-jic23@cam.ac.uk>
References: <1281535939-7190-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This patch also adds platform data to mark direction of sensor needed
to provide equivalent functionality to the original adis16255 driver.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/Kconfig                   |    7 +-
 drivers/staging/iio/gyro/adis16260.h               |    4 +
 drivers/staging/iio/gyro/adis16260_core.c          |  152 +++++++++++++++-----
 drivers/staging/iio/gyro/adis16260_platform_data.h |   19 +++
 drivers/staging/iio/gyro/gyro.h                    |   18 +++
 5 files changed, 163 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index c404361..1aeba38 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -4,10 +4,11 @@
 comment "Digital gyroscope sensors"
 
 config ADIS16260
-	tristate "Analog Devices ADIS16260/5 Digital Gyroscope Sensor SPI driver"
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
index 812440a..1671bd8 100644
--- a/drivers/staging/iio/gyro/adis16260.h
+++ b/drivers/staging/iio/gyro/adis16260.h
@@ -1,6 +1,8 @@
 #ifndef SPI_ADIS16260_H_
 #define SPI_ADIS16260_H_
 
+#include "adis16260_platform_data.h"
+
 #define ADIS16260_STARTUP_DELAY	220 /* ms */
 
 #define ADIS16260_READ_REG(a)    a
@@ -92,6 +94,7 @@
  * @tx:			transmit buffer
  * @rx:			recieve buffer
  * @buf_lock:		mutex to protect tx and rx
+ * @negate:		negate the scale parameter
  **/
 struct adis16260_state {
 	struct spi_device		*us;
@@ -102,6 +105,7 @@ struct adis16260_state {
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
+	unsigned			negate;
 };
 
 int adis16260_set_irq(struct device *dev, bool enable);
diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
index cf9d9c6..4d736c3 100644
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
@@ -222,6 +220,23 @@ static ssize_t adis16260_read_14bit_signed(struct device *dev,
 	return ret;
 }
 
+static ssize_t adis16260_read_gyro_scale(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16260_state *st = iio_dev_get_devdata(indio_dev);
+	ssize_t ret = 0;
+	if (st->negate)
+		ret = sprintf(buf, "-");
+	/* Take the iio_dev status lock */
+	mutex_lock(&indio_dev->mlock);
+	ret += adis16260_spi_read_signed(dev, attr, buf + ret, 14);
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
 static ssize_t adis16260_write_16bit(struct device *dev,
 		struct device_attribute *attr,
 		const char *buf,
@@ -240,6 +255,24 @@ error_ret:
 	return ret ? ret : len;
 }
 
+static ssize_t adis16260_write_gyro_scale(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int ret;
+	long val;
+
+	ret = strict_strtol(buf, 10, &val);
+	if (ret)
+		goto error_ret;
+	ret = adis16260_spi_write_reg_16(dev, this_attr->address, abs(val));
+
+error_ret:
+	return ret ? ret : len;
+}
+
 static ssize_t adis16260_read_frequency(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -447,17 +480,6 @@ static IIO_DEV_ATTR_IN_NAMED_RAW(supply,
 				ADIS16260_SUPPLY_OUT);
 static IIO_CONST_ATTR(in_supply_scale, "0.0018315");
 
-static IIO_DEV_ATTR_GYRO(adis16260_read_14bit_signed,
-		ADIS16260_GYRO_OUT);
-static IIO_DEV_ATTR_GYRO_SCALE(S_IWUSR | S_IRUGO,
-		adis16260_read_14bit_signed,
-		adis16260_write_16bit,
-		ADIS16260_GYRO_SCALE);
-static IIO_DEV_ATTR_GYRO_OFFSET(S_IWUSR | S_IRUGO,
-		adis16260_read_12bit_signed,
-		adis16260_write_16bit,
-		ADIS16260_GYRO_OFF);
-
 static IIO_DEV_ATTR_TEMP_RAW(adis16260_read_12bit_unsigned);
 static IIO_CONST_ATTR(temp_offset, "25");
 static IIO_CONST_ATTR(temp_scale, "0.1453");
@@ -469,8 +491,6 @@ static IIO_CONST_ATTR(in0_scale, "0.0006105");
 static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
 		adis16260_read_frequency,
 		adis16260_write_frequency);
-static IIO_DEV_ATTR_ANGL(adis16260_read_14bit_signed,
-		ADIS16260_ANGL_OUT);
 
 static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16260_write_reset, 0);
 
@@ -486,37 +506,77 @@ static struct attribute_group adis16260_event_attribute_group = {
 	.attrs = adis16260_event_attributes,
 };
 
-static struct attribute *adis16260_attributes[] = {
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_offset.dev_attr.attr,
-	&iio_dev_attr_angl_raw.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
-	NULL
-};
+
+#define ADIS16260_GYRO_ATTR_SET(axis)					\
+	IIO_DEV_ATTR_GYRO##axis(adis16260_read_14bit_signed,		\
+					 ADIS16260_GYRO_OUT);		\
+	static IIO_DEV_ATTR_GYRO##axis##_SCALE(S_IWUSR | S_IRUGO,	\
+					       adis16260_read_gyro_scale, \
+					       adis16260_write_gyro_scale, \
+					       ADIS16260_GYRO_SCALE);	\
+	static IIO_DEV_ATTR_GYRO##axis##_OFFSET(S_IWUSR | S_IRUGO,	\
+						adis16260_read_12bit_signed, \
+						adis16260_write_16bit,	\
+						ADIS16260_GYRO_OFF);	\
+	static IIO_DEV_ATTR_ANGL##axis(adis16260_read_14bit_signed,	\
+				 ADIS16260_ANGL_OUT);
+static ADIS16260_GYRO_ATTR_SET();
+static ADIS16260_GYRO_ATTR_SET(_X);
+static ADIS16260_GYRO_ATTR_SET(_Y);
+static ADIS16260_GYRO_ATTR_SET(_Z);
+
+#define ADIS16260_ATTRS(axis)						\
+	struct attribute *adis16260_attributes##axis[] = {		\
+		&iio_dev_attr_in_supply_raw.dev_attr.attr,		\
+		&iio_const_attr_in_supply_scale.dev_attr.attr,		\
+		&iio_dev_attr_gyro##axis##_raw.dev_attr.attr,		\
+		&iio_dev_attr_gyro##axis##_scale.dev_attr.attr,		\
+		&iio_dev_attr_gyro##axis##_offset.dev_attr.attr,	\
+		&iio_dev_attr_angl##axis##_raw.dev_attr.attr,		\
+		&iio_dev_attr_temp_raw.dev_attr.attr,			\
+		&iio_const_attr_temp_offset.dev_attr.attr,		\
+		&iio_const_attr_temp_scale.dev_attr.attr,		\
+		&iio_dev_attr_in0_raw.dev_attr.attr,			\
+		&iio_const_attr_in0_scale.dev_attr.attr,		\
+		&iio_dev_attr_sampling_frequency.dev_attr.attr,		\
+		&iio_const_attr_available_sampling_frequency.dev_attr.attr, \
+		&iio_dev_attr_reset.dev_attr.attr,			\
+		&iio_const_attr_name.dev_attr.attr,			\
+		NULL							\
+	};
+static ADIS16260_ATTRS();
+static ADIS16260_ATTRS(_x);
+static ADIS16260_ATTRS(_y);
+static ADIS16260_ATTRS(_z);
 
 static const struct attribute_group adis16260_attribute_group = {
 	.attrs = adis16260_attributes,
 };
 
+static const struct attribute_group adis16260_attribute_group_x = {
+	.attrs = adis16260_attributes_x,
+};
+
+static const struct attribute_group adis16260_attribute_group_y = {
+	.attrs = adis16260_attributes_y,
+};
+
+static const struct attribute_group adis16260_attribute_group_z = {
+	.attrs = adis16260_attributes_z,
+};
+
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
+
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, st);
 
@@ -543,7 +603,25 @@ static int __devinit adis16260_probe(struct spi_device *spi)
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
+
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
 	st->indio_dev->modes = INDIO_DIRECT_MODE;
@@ -633,9 +711,15 @@ err_ret:
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
index f68edab..98a355a 100644
--- a/drivers/staging/iio/gyro/gyro.h
+++ b/drivers/staging/iio/gyro/gyro.h
@@ -27,6 +27,15 @@
 #define IIO_DEV_ATTR_GYRO_SCALE(_mode, _show, _store, _addr)		\
 	IIO_DEVICE_ATTR(gyro_scale, S_IRUGO, _show, _store, _addr)
 
+#define IIO_DEV_ATTR_GYRO_X_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_x_scale, S_IRUGO, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Y_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_y_scale, S_IRUGO, _show, _store, _addr)
+
+#define IIO_DEV_ATTR_GYRO_Z_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(gyro_z_scale, S_IRUGO, _show, _store, _addr)
+
 #define IIO_DEV_ATTR_GYRO(_show, _addr)			\
 	IIO_DEVICE_ATTR(gyro_raw, S_IRUGO, _show, NULL, _addr)
 
@@ -41,3 +50,12 @@
 
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
