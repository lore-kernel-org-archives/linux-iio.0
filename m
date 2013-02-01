Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx-relay03-haj2.antispameurope.com ([83.246.65.203]:43723 "EHLO
	mx-relay03-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753049Ab3BALqG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 1 Feb 2013 06:46:06 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	linux-iio@vger.kernel.org,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
Subject: [RFC] iio: accel: Add driver for lis331dlh
Date: Fri,  1 Feb 2013 12:45:47 +0100
Message-Id: <1359719147-30231-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1359719147-30231-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
References: <1359719147-30231-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
To: jic23@cam.ac.uk, Lars-Peter Clausen <lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for the ST microsystems lis331dlh.
The lis331dlh is a three-axis accelerometer with 16-bit ADC.
It has an I2C and SPI interface.

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/iio/Kconfig                  |    1 +
 drivers/iio/accel/Kconfig            |   16 ++
 drivers/iio/accel/Makefile           |    5 +
 drivers/iio/accel/lis331dlh_buffer.c |  132 +++++++++++
 drivers/iio/accel/lis331dlh_core.c   |  429 ++++++++++++++++++++++++++++++++++
 drivers/iio/accel/lis331dlh_i2c.c    |  150 ++++++++++++
 drivers/iio/accel/lis331dlh_spi.c    |  129 ++++++++++
 include/linux/iio/accel/lis331dlh.h  |  243 +++++++++++++++++++
 8 files changed, 1105 insertions(+), 0 deletions(-)
 create mode 100644 drivers/iio/accel/lis331dlh_buffer.c
 create mode 100644 drivers/iio/accel/lis331dlh_core.c
 create mode 100644 drivers/iio/accel/lis331dlh_i2c.c
 create mode 100644 drivers/iio/accel/lis331dlh_spi.c
 create mode 100644 include/linux/iio/accel/lis331dlh.h

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b2f963b..ac4b0b5 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -62,6 +62,7 @@ config IIO_CONSUMERS_PER_TRIGGER
 
 source "drivers/iio/accel/Kconfig"
 source "drivers/iio/adc/Kconfig"
+source "drivers/iio/accel/Kconfig"
 source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/common/Kconfig"
 source "drivers/iio/dac/Kconfig"
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index d600353..d27ea59 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -21,4 +21,20 @@ config KXSD9
 	  Say yes here to build support for the Kionix KXSD9 accelerometer.
 	  Currently this only supports the device via an SPI interface.
 
+config LIS331DLH_SPI
+	tristate "ST Microelectronics LIS331DLH Accelerometer Driver (SPI)"
+	depends on SPI
+	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
+	help
+	  Say yes here to build SPI support for the ST microelectronics
+	  LIS331DLH 3-axis accelerometer.
+
+config LIS331DLH_I2C
+	tristate "ST Microelectronics LIS331DLH Accelerometer Driver (I2C)"
+	depends on I2C
+	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
+	help
+	  Say yes here to build I2C support for the ST microelectronics
+	  LIS331DLH 3-axis accelerometer.
+
 endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 4e1c859..720ecda 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -4,3 +4,8 @@
 
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
+
+lis331dlh-y			:= lis331dlh_core.o
+lis331dlh-$(CONFIG_IIO_BUFFER)	+= lis331dlh_buffer.o
+obj-$(CONFIG_LIS331DLH_SPI)	+= lis331dlh.o lis331dlh_spi.o
+obj-$(CONFIG_LIS331DLH_I2C)	+= lis331dlh.o lis331dlh_i2c.o
diff --git a/drivers/iio/accel/lis331dlh_buffer.c b/drivers/iio/accel/lis331dlh_buffer.c
new file mode 100644
index 0000000..8e50f0c
--- /dev/null
+++ b/drivers/iio/accel/lis331dlh_buffer.c
@@ -0,0 +1,132 @@
+/*
+ * lis331dlh_buffer.c	support STMicroelectronics LIS331DLH
+ *			3d 2/4/8g Linear Accelerometers
+ *
+ * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
+ * Copyright (c) 2013 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/accel/lis331dlh.h>
+
+
+static irqreturn_t lis331dlh_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct lis331dlh *st = iio_priv(indio_dev);
+	s16 buf[LIS331DLH_SCAN_ELEMENTS + sizeof(s64)/sizeof(s16)];
+	int ret;
+
+	ret = st->read_all(st, buf);
+	if (ret < 0)
+		goto error_ret;
+
+	if (indio_dev->scan_timestamp)
+		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
+				&pf->timestamp, sizeof(pf->timestamp));
+
+	iio_push_to_buffers(indio_dev, (u8 *)buf);
+	iio_trigger_notify_done(indio_dev->trig);
+
+error_ret:
+	return IRQ_HANDLED;
+}
+
+static int lis331dlh_data_rdy_trigger_set_state(struct iio_trigger *trig,
+		bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct lis331dlh *st = iio_priv(indio_dev);
+	int ret;
+	u8 ctrl;
+
+	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_3_ADDR, &ctrl);
+	if (ret)
+		goto error_ret;
+
+	if (state)
+		ctrl |= LIS331DLH_REG_CTRL_3_I1_DRDY;
+	else
+		ctrl &= ~LIS331DLH_REG_CTRL_3_I1_DRDY;
+
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_3_ADDR, ctrl);
+
+error_ret:
+	return ret;
+}
+
+static const struct iio_trigger_ops lis331dlh_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &lis331dlh_data_rdy_trigger_set_state,
+};
+
+int lis331dlh_probe_trigger(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct lis331dlh *st = iio_priv(indio_dev);
+
+	st->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
+				     indio_dev->id);
+	if (!st->trig)
+		return -ENOMEM;
+
+	ret = request_irq(st->irq,
+			  &iio_trigger_generic_data_rdy_poll,
+			  IRQF_TRIGGER_RISING,
+			  "lis331dlh_data_rdy",
+			  st->trig);
+	if (ret)
+		goto error_free_trig;
+
+
+	st->trig->dev.parent = indio_dev->dev.parent;
+	st->trig->ops = &lis331dlh_trigger_ops;
+	st->trig->private_data = indio_dev;
+	ret = iio_trigger_register(st->trig);
+	if (ret)
+		goto error_free_irq;
+
+	/* select default trigger */
+	indio_dev->trig = st->trig;
+
+	return 0;
+
+error_free_irq:
+	free_irq(st->irq, st->trig);
+error_free_trig:
+	iio_trigger_free(st->trig);
+	return ret;
+}
+
+void lis331dlh_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct lis331dlh *st = iio_priv(indio_dev);
+
+	iio_trigger_unregister(st->trig);
+	free_irq(st->irq, st->trig);
+	iio_trigger_free(st->trig);
+}
+
+int lis331dlh_buffer_configure(struct iio_dev *indio_dev)
+{
+	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+		lis331dlh_trigger_handler, NULL);
+}
+
+void lis331dlh_buffer_unconfigure(struct iio_dev *indio_dev)
+{
+	iio_triggered_buffer_cleanup(indio_dev);
+}
diff --git a/drivers/iio/accel/lis331dlh_core.c b/drivers/iio/accel/lis331dlh_core.c
new file mode 100644
index 0000000..4555db0
--- /dev/null
+++ b/drivers/iio/accel/lis331dlh_core.c
@@ -0,0 +1,429 @@
+/*
+ * lis331dlh_core.c	support STMicroelectronics LIS331DLH
+ *			3d 2/4/8g Linear Accelerometers
+ *
+ * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
+ * Copyright (c) 2013 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/accel/lis331dlh.h>
+
+static int lis331dlh_read_raw(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan,
+		int *val, int *val2, long info)
+{
+	struct lis331dlh *st = iio_priv(indio_dev);
+	int ret = 0;
+	u8 reg;
+	s16 accel;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		reg = (u8)chan->address;
+		ret = st->read_reg_16(st, reg, &accel);
+		*val = accel;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, &reg);
+		if (ret)
+			return ret;
+
+		reg &= LIS331DLH_REG_CTRL_4_FS_MASK;
+		switch (reg) {
+		case LIS331DLH_REG_CTRL_4_FS_2G:
+			*val2 = 569;
+			break;
+		case LIS331DLH_REG_CTRL_4_FS_4G:
+			*val2 = 1135;
+			break;
+		case LIS331DLH_REG_CTRL_4_FS_8G:
+			*val2 = 2270;
+			break;
+		default:
+			return -EINVAL;
+		}
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t lis331dlh_read_frequency(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct lis331dlh *st = iio_priv(indio_dev);
+	int ret, len = 0;
+	u8 val;
+
+	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR, &val);
+	if (ret)
+		return ret;
+
+	val &= LIS331DLH_REG_CTRL_1_DR_MASK;
+	switch (val) {
+	case LIS331DLH_REG_CTRL_1_DR_50:
+		len = sprintf(buf, "50\n");
+		break;
+	case LIS331DLH_REG_CTRL_1_DR_100:
+		len = sprintf(buf, "100\n");
+		break;
+	case LIS331DLH_REG_CTRL_1_DR_400:
+		len = sprintf(buf, "400\n");
+		break;
+	case LIS331DLH_REG_CTRL_1_DR_1000:
+		len = sprintf(buf, "1000\n");
+		break;
+	}
+	return len;
+}
+
+static ssize_t lis331dlh_write_frequency(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct lis331dlh *st = iio_priv(indio_dev);
+	unsigned freq;
+	int ret;
+	u8 val;
+
+	ret = kstrtouint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	mutex_lock(&indio_dev->mlock);
+	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR, &val);
+	if (ret)
+		goto error_ret_mutex;
+
+	val &= ~LIS331DLH_REG_CTRL_1_DR_MASK;
+	switch (freq) {
+	case 50:
+		val |= LIS331DLH_REG_CTRL_1_DR_50;
+		break;
+	case 100:
+		val |= LIS331DLH_REG_CTRL_1_DR_100;
+		break;
+	case 400:
+		val |= LIS331DLH_REG_CTRL_1_DR_400;
+		break;
+	case 1000:
+		val |= LIS331DLH_REG_CTRL_1_DR_1000;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret_mutex;
+	};
+
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR, val);
+
+error_ret_mutex:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
+/*
+ * The range has to be provided in meter per second squared.
+ * 1G is can be roughly approximated by 10 m/s^2, so we just
+ * multiply by 10.
+ */
+static ssize_t lis331dlh_read_range(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct lis331dlh *st = iio_priv(indio_dev);
+	int ret, len = 0;
+	u8 val;
+
+	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, &val);
+	if (ret)
+		return ret;
+
+	val &= LIS331DLH_REG_CTRL_4_FS_MASK;
+	switch (val) {
+	case LIS331DLH_REG_CTRL_4_FS_2G:
+		len = sprintf(buf, "20\n");
+		break;
+	case LIS331DLH_REG_CTRL_4_FS_4G:
+		len = sprintf(buf, "40\n");
+		break;
+	case LIS331DLH_REG_CTRL_4_FS_8G:
+		len = sprintf(buf, "80\n");
+		break;
+	}
+	return len;
+}
+
+static ssize_t lis331dlh_write_range(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct lis331dlh *st = iio_priv(indio_dev);
+	unsigned long freq;
+	int ret;
+	u8 val;
+
+	ret = strict_strtoul(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	mutex_lock(&indio_dev->mlock);
+	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, &val);
+	if (ret)
+		goto error_ret_mutex;
+
+	val &= ~LIS331DLH_REG_CTRL_4_FS_MASK;
+	switch (freq) {
+	case 20:
+		val |= LIS331DLH_REG_CTRL_4_FS_2G;
+		break;
+	case 40:
+		val |= LIS331DLH_REG_CTRL_4_FS_4G;
+		break;
+	case 80:
+		val |= LIS331DLH_REG_CTRL_4_FS_8G;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret_mutex;
+	};
+
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR, val);
+
+error_ret_mutex:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret ? ret : len;
+}
+
+#define LIS331DLH_ACCEL_INFO_MASK	(IIO_CHAN_INFO_SCALE_SHARED_BIT | \
+					 IIO_CHAN_INFO_RAW_SEPARATE_BIT)
+
+#define LIS331DLH_ACCEL_CHAN(_mod) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_ ## _mod, \
+	.info_mask = LIS331DLH_ACCEL_INFO_MASK, \
+	.address = LIS331DLH_REG_OUT_ ## _mod ## _L_ADDR, \
+	.scan_index = LIS331DLH_SCAN_ACCEL_ ## _mod, \
+	.scan_type = IIO_ST('s', 16, 16, 0), \
+}
+
+static const struct iio_chan_spec lis331dlh_channels[] = {
+	LIS331DLH_ACCEL_CHAN(X),
+	LIS331DLH_ACCEL_CHAN(Y),
+	LIS331DLH_ACCEL_CHAN(Z),
+	IIO_CHAN_SOFT_TIMESTAMP(LIS331DLH_SCAN_ELEMENTS),
+};
+
+static IIO_DEVICE_ATTR(range, S_IWUSR | S_IRUGO,
+		       lis331dlh_read_range,
+		       lis331dlh_write_range, 0);
+
+static IIO_CONST_ATTR(range_available, "20 40 80");
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			      lis331dlh_read_frequency,
+			      lis331dlh_write_frequency);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("50 100 400 1000");
+
+static struct attribute *lis331dlh_attributes[] = {
+	&iio_dev_attr_range.dev_attr.attr,
+	&iio_const_attr_range_available.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group lis331dlh_attribute_group = {
+	.attrs = lis331dlh_attributes,
+};
+
+/* Power down the device */
+int lis331dlh_power_down(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct lis331dlh *st = iio_priv(indio_dev);
+
+	mutex_lock(&indio_dev->mlock);
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR,
+				  LIS331DLH_REG_CTRL_1_POWER_OFF);
+	if (ret) {
+		dev_err(&indio_dev->dev,
+				"problem with turning device off");
+		goto err_ret;
+	}
+
+err_ret:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
+int lis331dlh_set_irq_data_rdy(struct iio_dev *indio_dev, bool enable)
+{
+	struct lis331dlh *st = iio_priv(indio_dev);
+	int ret;
+	u8 ctrl;
+
+	ret = st->read_reg_8(st, LIS331DLH_REG_CTRL_3_ADDR, &ctrl);
+	if (ret)
+		goto error_ret;
+
+	if (enable)
+		ctrl |= LIS331DLH_REG_CTRL_3_I1_DRDY;
+	else
+		ctrl &= ~LIS331DLH_REG_CTRL_3_I1_DRDY;
+
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_3_ADDR, ctrl);
+
+error_ret:
+	return ret;
+}
+
+int lis331dlh_init(struct iio_dev *indio_dev)
+{
+	struct lis331dlh *st = iio_priv(indio_dev);
+	int ret;
+	u8 val;
+
+	ret = st->read_reg_8(st, LIS331DLH_REG_WHO_AM_I_ADDR, &val);
+	if (ret || (val != LIS331DLH_REG_WHO_AM_I_DEFAULT)) {
+		dev_err(&indio_dev->dev,
+			"reading WHO_AM_I register failed: 0x%02X", val);
+		goto err_ret;
+	}
+
+	/* Write suitable defaults to ctrl1 */
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_1_ADDR,
+				  LIS331DLH_DEFAULT_CTRL1);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+				"problem with setup control register 1");
+		goto err_ret;
+	}
+
+	/* Write suitable defaults to ctrl2 */
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_2_ADDR,
+				  LIS331DLH_DEFAULT_CTRL2);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+				"problem with setup control register 2");
+		goto err_ret;
+	}
+
+	/* Write suitable defaults to ctrl3 */
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_3_ADDR,
+				  LIS331DLH_DEFAULT_CTRL3);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+				"problem with setup control register 3");
+		goto err_ret;
+	}
+
+	/* Write suitable defaults to ctrl4 */
+	ret = st->write_reg_8(st, LIS331DLH_REG_CTRL_4_ADDR,
+				  LIS331DLH_DEFAULT_CTRL4);
+	if (ret) {
+		dev_err(indio_dev->dev.parent,
+				"problem with setup control register 4");
+		goto err_ret;
+	}
+err_ret:
+	return ret;
+}
+
+static const struct iio_info lis331dlh_info = {
+	.attrs = &lis331dlh_attribute_group,
+	.read_raw = &lis331dlh_read_raw,
+	.driver_module = THIS_MODULE,
+};
+
+static const unsigned long lis331dlh_avail_scan_masks[] = { 0xffffffff, 0x0 };
+
+int lis331dlh_probe(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct lis331dlh *st = iio_priv(indio_dev);
+
+	indio_dev->channels = lis331dlh_channels;
+	indio_dev->num_channels = ARRAY_SIZE(lis331dlh_channels);
+	indio_dev->available_scan_masks = lis331dlh_avail_scan_masks;
+	indio_dev->info = &lis331dlh_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = lis331dlh_buffer_configure(indio_dev);
+	if (ret)
+		goto error_ret;
+
+	if (st->irq) {
+		ret = lis331dlh_probe_trigger(indio_dev);
+		if (ret)
+			goto error_unconfigure_buffer;
+	}
+
+	/* Get the device into a sane initial state */
+	ret = lis331dlh_init(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_remove_trigger;
+
+	return 0;
+
+error_remove_trigger:
+	if (st->irq)
+		lis331dlh_remove_trigger(indio_dev);
+error_unconfigure_buffer:
+	lis331dlh_buffer_unconfigure(indio_dev);
+error_ret:
+	return ret;
+}
+EXPORT_SYMBOL_GPL(lis331dlh_probe);
+
+int lis331dlh_remove(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct lis331dlh *st = iio_priv(indio_dev);
+
+	ret = lis331dlh_power_down(indio_dev);
+	if (ret)
+		return ret;
+
+	iio_device_unregister(indio_dev);
+
+	if (st->irq)
+		lis331dlh_remove_trigger(indio_dev);
+
+	lis331dlh_buffer_unconfigure(indio_dev);
+
+	iio_device_free(indio_dev);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lis331dlh_remove);
+
+MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
+MODULE_DESCRIPTION("ST LIS331DLH Accelerometer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/lis331dlh_i2c.c b/drivers/iio/accel/lis331dlh_i2c.c
new file mode 100644
index 0000000..875d439
--- /dev/null
+++ b/drivers/iio/accel/lis331dlh_i2c.c
@@ -0,0 +1,150 @@
+/*
+ * lis331dlh_i2c.c	support STMicroelectronics LIS331DLH
+ *			3d 2/4/8g Linear Accelerometers
+ *
+ * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
+ * Copyright (c) 2013 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/accel/lis331dlh.h>
+
+
+static int lis331dlh_i2c_write_reg_8(struct lis331dlh *st,
+		u8 reg_address, u8 val)
+{
+	return i2c_smbus_write_byte_data(st->us, 0x80 | reg_address, val);
+}
+
+static int lis331dlh_i2c_read_reg_8(struct lis331dlh *st,
+		u8 reg_address, u8 *val)
+{
+	struct i2c_client *i2c = st->us;
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(i2c, reg_address);
+	if (ret < 0)
+		return ret;
+	*val = ret;
+	return 0;
+}
+
+static int lis331dlh_i2c_read_reg_16(struct lis331dlh *st,
+		u8 lower_reg_addr, u16 *val)
+{
+	struct i2c_client *client = st->us;
+	int ret;
+
+	lower_reg_addr = LIS331DLH_I2C_AUTO_INC(lower_reg_addr);
+	ret = i2c_smbus_read_word_data(client, lower_reg_addr);
+	/*
+	 * We have configured the device with CPU endianess, so no need
+	 * to swap bytes here
+	 */
+	*val = ret;
+
+	return (ret < 0) ? ret : 0;
+}
+
+static int lis331dlh_i2c_read_all(struct lis331dlh *st, s16 *buf)
+{
+	struct i2c_client *client = st->us;
+	u8 reg = LIS331DLH_I2C_AUTO_INC(LIS331DLH_REG_OUT_X_L_ADDR);
+
+	struct i2c_msg msg[2] = {
+		{
+			.addr = client->addr,
+			.flags = client->flags,
+			.len = 1,
+			.buf = &reg,
+		},
+		{
+			.addr = client->addr,
+			.flags = client->flags | I2C_M_RD,
+			.len = LIS331DLH_MAX_RX,
+			.buf = (u8 *)buf,
+		},
+	};
+
+	return i2c_transfer(client->adapter, msg, 2);
+}
+
+static int lis331dlh_i2c_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	int ret;
+	struct lis331dlh *st;
+	struct iio_dev *indio_dev;
+
+	dev_dbg(&client->dev, "probe I2C dev with IRQ %i", client->irq);
+
+	indio_dev = iio_device_alloc(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = client->dev.driver->name;
+
+	st = iio_priv(indio_dev);
+
+	i2c_set_clientdata(client, indio_dev);
+	st->us = client;
+	st->irq = client->irq;
+
+	st->read_reg_8  = lis331dlh_i2c_read_reg_8;
+	st->write_reg_8 = lis331dlh_i2c_write_reg_8;
+	st->read_reg_16 = lis331dlh_i2c_read_reg_16;
+	st->read_all	= lis331dlh_i2c_read_all;
+
+	ret = lis331dlh_probe(indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	return 0;
+
+error_free_dev:
+	iio_device_free(indio_dev);
+error_ret:
+	return ret;
+}
+
+static int lis331dlh_i2c_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	return lis331dlh_remove(indio_dev);
+}
+
+static const struct i2c_device_id lis331dlh_id[] = {
+	{"lis331dlh", 0 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, lis331dlh_id);
+
+static struct i2c_driver lis331dlh_i2c_driver = {
+	.driver	 = {
+		.owner  = THIS_MODULE,
+		.name   = "lis331dlh_i2c",
+	},
+	.id_table = lis331dlh_id,
+	.probe	= lis331dlh_i2c_probe,
+	.remove	= lis331dlh_i2c_remove,
+};
+
+module_i2c_driver(lis331dlh_i2c_driver);
+
+MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
+MODULE_DESCRIPTION("ST LIS331DLH Accelerometer I2C driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/lis331dlh_spi.c b/drivers/iio/accel/lis331dlh_spi.c
new file mode 100644
index 0000000..6bfd9e6
--- /dev/null
+++ b/drivers/iio/accel/lis331dlh_spi.c
@@ -0,0 +1,129 @@
+/*
+ * lis331dlh_spi.c	support STMicroelectronics LIS331DLH
+ *			3d 2/4/8g Linear Accelerometers
+ *
+ * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
+ * Copyright (c) 2013 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/accel/lis331dlh.h>
+
+static int lis331dlh_spi_write_reg_8(struct lis331dlh *st,
+		u8 reg_address, u8 val)
+{
+	struct spi_device *spi = st->us;
+	u8 tx[2] ____cacheline_aligned;
+
+	tx[0] = LIS331DLH_WRITE_REG(reg_address);
+	tx[1] = val;
+
+	return spi_write(spi, tx, 2);
+}
+
+static int lis331dlh_spi_read_reg_8(struct lis331dlh *st,
+			u8 reg_address, u8 *val)
+{
+	struct spi_device *spi = st->us;
+	int ret;
+
+	ret = spi_w8r8(spi, LIS331DLH_READ_REG(reg_address));
+	*val = ret;
+
+	return (ret < 0) ? ret : 0;
+}
+
+static int lis331dlh_spi_read_reg_16(struct lis331dlh *st,
+			u8 lower_reg_addr, u16 *val)
+{
+	struct spi_device *spi = st->us;
+	u8 tx = LIS331DLH_SPI_AUTO_INC(LIS331DLH_READ_REG(lower_reg_addr));
+
+	return spi_write_then_read(spi, &tx, 1, val, 2);
+	/*
+	 * We have configured the device with CPU endianess, so no need
+	 * to swap bytes here
+	 */
+}
+
+static int lis331dlh_spi_read_all(struct lis331dlh *st, s16 *buf)
+{
+	struct spi_device *spi = st->us;
+	u8 tx = LIS331DLH_SPI_AUTO_INC(LIS331DLH_READ_REG(LIS331DLH_REG_OUT_X_L_ADDR));
+
+	return spi_write_then_read(spi, &tx, 1, (u8 *)buf, 6);
+}
+
+static int lis331dlh_spi_probe(struct spi_device *spi)
+{
+	int ret;
+	struct lis331dlh *st;
+	struct iio_dev *indio_dev;
+
+	dev_dbg(&spi->dev, "probe I2C dev with IRQ %i", spi->irq);
+
+	indio_dev = iio_device_alloc(sizeof(*st));
+	if (indio_dev == NULL) {
+		ret =  -ENOMEM;
+		goto error_ret;
+	}
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi->dev.driver->name;
+
+	st = iio_priv(indio_dev);
+
+	spi_set_drvdata(spi, indio_dev);
+	st->us = spi;
+	st->irq = spi->irq;
+
+	st->read_reg_8  = lis331dlh_spi_read_reg_8;
+	st->write_reg_8 = lis331dlh_spi_write_reg_8;
+	st->read_reg_16 = lis331dlh_spi_read_reg_16;
+	st->read_all	= lis331dlh_spi_read_all;
+
+	spi->mode = SPI_MODE_3;
+	spi_setup(spi);
+
+	ret = lis331dlh_probe(indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	return 0;
+
+error_free_dev:
+	iio_device_free(indio_dev);
+error_ret:
+	return ret;
+}
+
+static int lis331dlh_spi_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	return lis331dlh_remove(indio_dev);
+}
+
+static struct spi_driver lis331dlh_spi_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "lis331dlh_spi",
+	},
+	.probe = lis331dlh_spi_probe,
+	.remove = lis331dlh_spi_remove,
+};
+
+module_spi_driver(lis331dlh_spi_driver);
+
+MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
+MODULE_DESCRIPTION("ST LIS331DLH Accelerometer SPI driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/accel/lis331dlh.h b/include/linux/iio/accel/lis331dlh.h
new file mode 100644
index 0000000..35606c0
--- /dev/null
+++ b/include/linux/iio/accel/lis331dlh.h
@@ -0,0 +1,243 @@
+/*
+ * lis331dlh.h		support STMicroelectronics LIS331DLH
+ *			3d 2/4/8g Linear Accelerometers
+ *
+ * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
+ * Copyright (c) 2013 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#ifndef SPI_LIS331DLH_H_
+#define SPI_LIS331DLH_H_
+
+#include <asm/byteorder.h>
+#include <linux/iio/iio.h>
+
+#define LIS331DLH "lis331dlh"
+
+#define LIS331DLH_READ_REG(a) ((a) | 0x80)
+#define LIS331DLH_WRITE_REG(a) a
+#define LIS331DLH_I2C_AUTO_INC(a) ((a) | 0x80)
+#define LIS331DLH_SPI_AUTO_INC(a) ((a) | 0x40)
+
+#define LIS331DLH_REG_WHO_AM_I_ADDR			0x0F
+#define LIS331DLH_REG_WHO_AM_I_DEFAULT			0x32
+
+/* Control Register (1 of 5) */
+#define LIS331DLH_REG_CTRL_1_ADDR			0x20
+/* Power ctrl - either bit set corresponds to on*/
+#define LIS331DLH_REG_CTRL_1_POWER_OFF			0x00
+#define LIS331DLH_REG_CTRL_1_POWER_ON			0x20
+#define LIS331DLH_REG_CTRL_1_LOW_POWER_05		0x40
+
+/* Data Rate */
+#define LIS331DLH_REG_CTRL_1_DR_50			0x00
+#define LIS331DLH_REG_CTRL_1_DR_100			0x08
+#define LIS331DLH_REG_CTRL_1_DR_400			0x10
+#define LIS331DLH_REG_CTRL_1_DR_1000			0x18
+#define LIS331DLH_REG_CTRL_1_DR_MASK			0x18
+
+/* Axes enable ctrls */
+#define LIS331DLH_REG_CTRL_1_AXES_Z_ENABLE		0x04
+#define LIS331DLH_REG_CTRL_1_AXES_Y_ENABLE		0x02
+#define LIS331DLH_REG_CTRL_1_AXES_X_ENABLE		0x01
+
+/* Control Register (2 of 5) */
+#define LIS331DLH_REG_CTRL_2_ADDR			0x21
+
+#define LIS331DLH_REG_CTRL_2_BOOT			0x80
+
+#define LIS331DLH_REG_CTRL_2_HP_NORM			0x00
+#define LIS331DLH_REG_CTRL_2_HP_REF			0x40
+
+#define LIS331DLH_REG_CTRL_2_FDS_INT			0x10
+#define LIS331DLH_REG_CTRL_2_HPEN2			0x08
+#define LIS331DLH_REG_CTRL_2_HPEN1			0x04
+#define LIS331DLH_REG_CTRL_2_HPCF1			0x02
+#define LIS331DLH_REG_CTRL_2_HPCF0			0x01
+
+/* Control Register (3 of 5) */
+#define LIS331DLH_REG_CTRL_3_ADDR			0x22
+
+#define LIS331DLH_REG_CTRL_3_IHL			0x80
+#define LIS331DLH_REG_CTRL_3_PP_OD			0x40
+#define LIS331DLH_REG_CTRL_3_LIR2			0x20
+#define LIS331DLH_REG_CTRL_3_I2_I			0x00
+#define LIS331DLH_REG_CTRL_3_I2_1OR2			0x08
+#define LIS331DLH_REG_CTRL_3_I2_DRDY			0x10
+#define LIS331DLH_REG_CTRL_3_I2_RUN			0x18
+#define LIS331DLH_REG_CTRL_3_I2_MASK			0x18
+#define LIS331DLH_REG_CTRL_3_LIR1			0x04
+#define LIS331DLH_REG_CTRL_3_I1_I			0x00
+#define LIS331DLH_REG_CTRL_3_I1_1OR2			0x01
+#define LIS331DLH_REG_CTRL_3_I1_DRDY			0x02
+#define LIS331DLH_REG_CTRL_3_I1_RUN			0x03
+#define LIS331DLH_REG_CTRL_3_I1_MASK			0x03
+
+/* Control Register (4 of 5) */
+#define LIS331DLH_REG_CTRL_4_ADDR			0x23
+
+/* Block Data Update only after MSB and LSB read */
+#define LIS331DLH_REG_CTRL_4_BLOCK_UPDATE		0x80
+
+/* Set to big endian output */
+#define LIS331DLH_REG_CTRL_4_BIG_ENDIAN			0x40
+
+/* Full scale selection */
+#define LIS331DLH_REG_CTRL_4_FS_2G			0x00
+#define LIS331DLH_REG_CTRL_4_FS_4G			0x10
+#define LIS331DLH_REG_CTRL_4_FS_8G			0x30
+#define LIS331DLH_REG_CTRL_4_FS_MASK			0x30
+
+/* Self Test Sign */
+#define LIS331DLH_REG_CTRL_4_ST_SIGN			0x08
+
+/* Self Test Enable */
+#define LIS331DLH_REG_CTRL_4_ST_ON			0x02
+
+/* SPI 3 wire mode */
+#define LIS331DLH_REG_CTRL_4_THREE_WIRE_SPI_MODE	0x01
+
+/* Control Register (5 of 5) */
+#define LIS331DLH_REG_CTRL_5_ADDR			0x24
+
+#define LIS331DLH_REG_CTRL_5_SLEEP_WAKE_OFF		0x00
+#define LIS331DLH_REG_CTRL_5_LOW_POWER			0x03
+
+/* Dummy register */
+#define LIS331DLH_REG_HP_FILTER_RESET			0x25
+
+/* Reference register */
+#define LIS331DLH_REG_REFERENCE				0x26
+
+/* Status register */
+#define LIS331DLH_REG_STATUS_ADDR			0x27
+/* XYZ axis data overrun - first is all overrun? */
+#define LIS331DLH_REG_STATUS_XYZ_OVERRUN		0x80
+#define LIS331DLH_REG_STATUS_Z_OVERRUN			0x40
+#define LIS331DLH_REG_STATUS_Y_OVERRUN			0x20
+#define LIS331DLH_REG_STATUS_X_OVERRUN			0x10
+/* XYZ new data available - first is all 3 available? */
+#define LIS331DLH_REG_STATUS_XYZ_NEW_DATA		0x08
+#define LIS331DLH_REG_STATUS_Z_NEW_DATA			0x04
+#define LIS331DLH_REG_STATUS_Y_NEW_DATA			0x02
+#define LIS331DLH_REG_STATUS_X_NEW_DATA			0x01
+
+/* The accelerometer readings - low and high bytes.
+Form of high byte dependant on justification set in ctrl reg */
+#define LIS331DLH_REG_OUT_X_L_ADDR			0x28
+#define LIS331DLH_REG_OUT_X_H_ADDR			0x29
+#define LIS331DLH_REG_OUT_Y_L_ADDR			0x2A
+#define LIS331DLH_REG_OUT_Y_H_ADDR			0x2B
+#define LIS331DLH_REG_OUT_Z_L_ADDR			0x2C
+#define LIS331DLH_REG_OUT_Z_H_ADDR			0x2D
+
+/* Interrupt 1 config register */
+#define LIS331DLH_REG_INT1_CFG_ADDR			0x30
+#define LIS331DLH_REG_INT1_SRC_ADDR			0x31
+#define LIS331DLH_REG_INT1_THS_ADDR			0x32
+#define LIS331DLH_REG_INT1_DURATION_ADDR		0x33
+
+/* Interrupt 2 config register */
+#define LIS331DLH_REG_INT2_CFG_ADDR			0x34
+#define LIS331DLH_REG_INT2_SRC_ADDR			0x35
+#define LIS331DLH_REG_INT2_THS_ADDR			0x36
+#define LIS331DLH_REG_INT2_DURATION_ADDR		0x37
+
+#define LIS331DLH_REG_INT_AOI				0x80
+#define LIS331DLH_REG_INT_6D				0x40
+#define LIS331DLH_REG_INT_Z_HIGH			0x20
+#define LIS331DLH_REG_INT_Z_LOW				0x10
+#define LIS331DLH_REG_INT_Y_HIGH			0x08
+#define LIS331DLH_REG_INT_Y_LOW				0x04
+#define LIS331DLH_REG_INT_X_HIGH			0x02
+#define LIS331DLH_REG_INT_X_LOW				0x01
+
+
+/* Default control settings */
+#define LIS331DLH_DEFAULT_CTRL1  (LIS331DLH_REG_CTRL_1_POWER_ON	     \
+				| LIS331DLH_REG_CTRL_1_DR_50         \
+				| LIS331DLH_REG_CTRL_1_AXES_Z_ENABLE \
+				| LIS331DLH_REG_CTRL_1_AXES_Y_ENABLE \
+				| LIS331DLH_REG_CTRL_1_AXES_X_ENABLE)
+
+#define LIS331DLH_DEFAULT_CTRL2	 LIS331DLH_REG_CTRL_2_HP_NORM
+
+#define LIS331DLH_DEFAULT_CTRL3  0
+
+#ifdef __BIG_ENDIAN
+#define LIS331DLH_REG_CTRL_4_CPU_ENDIAN LIS331DLH_REG_CTRL_4_BIG_ENDIAN
+#else
+#define LIS331DLH_REG_CTRL_4_CPU_ENDIAN 0
+#endif
+
+#define LIS331DLH_DEFAULT_CTRL4  (LIS331DLH_REG_CTRL_4_BLOCK_UPDATE \
+				| LIS331DLH_REG_CTRL_4_CPU_ENDIAN \
+				| LIS331DLH_REG_CTRL_4_FS_2G)
+
+#define LIS331DLH_MAX_RX 6
+
+/**
+ * struct lis331dlh - device instance specific data
+ * @us:			pointer to actual bus (spi/i2c)
+ * @trig:		data ready trigger registered with iio
+ * @irq:		irq line
+ * @read/write		bus specific functions to access registers
+ **/
+struct lis331dlh {
+	void			*us;
+	struct iio_trigger	*trig;
+	int			irq;
+
+	int (*read_reg_8)  (struct lis331dlh *st, u8 addr, u8 *val);
+	int (*write_reg_8) (struct lis331dlh *st, u8 addr, u8 val);
+	int (*read_reg_16) (struct lis331dlh *st, u8 low_addr, u16 *val);
+	int (*read_all)    (struct lis331dlh *st, s16 *buf);
+};
+
+enum LIS331DLH_SCAN_INDEX {
+	LIS331DLH_SCAN_ACCEL_X,
+	LIS331DLH_SCAN_ACCEL_Y,
+	LIS331DLH_SCAN_ACCEL_Z,
+	LIS331DLH_SCAN_ELEMENTS,
+};
+
+int lis331dlh_probe(struct iio_dev *indio_dev);
+int lis331dlh_remove(struct iio_dev *indio_dev);
+
+int lis331dlh_stop_device(struct iio_dev *indio_dev);
+int lis331dlh_set_irq_data_rdy(struct iio_dev *indio_dev, bool enable);
+
+#ifdef CONFIG_IIO_BUFFER
+
+void lis331dlh_remove_trigger(struct iio_dev *indio_dev);
+int lis331dlh_probe_trigger(struct iio_dev *indio_dev);
+
+int lis331dlh_buffer_configure(struct iio_dev *indio_dev);
+void lis331dlh_buffer_unconfigure(struct iio_dev *indio_dev);
+
+#else /* CONFIG_IIO_BUFFER */
+
+static inline void lis331dlh_remove_trigger(struct iio_dev *indio_dev)
+{
+}
+static inline int lis331dlh_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
+static inline int lis331dlh_buffer_configure(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void lis331dlh_buffer_unconfigure(struct iio_dev *indio_dev)
+{
+}
+
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* SPI_LIS331DLH_H_ */
-- 
1.7.2.3

