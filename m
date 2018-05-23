Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bastet.se.axis.com ([195.60.68.11]:48137 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeEWNXh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 May 2018 09:23:37 -0400
From: Borys Movchan <borys.movchan@axis.com>
To: <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <ppmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, Borys Movchan <borysmn@axis.com>,
        Borys Movchan <borysmn@axis.com>
Subject: [PATCH v2] iio: add ISL29033 Ultra-Low Lux ambient-light-sensor
Date: Wed, 23 May 2018 15:23:18 +0200
Message-ID: <20180523132318.4501-1-borys.movchan@axis.com>
In-Reply-To: <20180523100033.26868-1-borys.movchan@axis.com>
References: <20180523100033.26868-1-borys.movchan@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Borys Movchan <borysmn@axis.com>

Add Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated
Digital Ambient Light Sensor driver.

The ISL29033 is an integrated ambient and infrared
light-to-digital converter. Its advanced, self-calibrated photodiode
array emulates human eye response with excellent IR rejection. The
on-chip 16-bit ADC is capable of rejecting 50Hz and 60Hz
flicker caused by artificial light sources. The lux range select
feature allows users to program the lux range for optimized
counts/lux.

datasheet: https://www.intersil.com/content/dam/intersil/documents/isl2/isl29033.pdf

Signed-off-by: Borys Movchan <borys.movchan@axis.com>
---
 .../devicetree/bindings/iio/light/isl29033.txt     |  17 +
 drivers/iio/light/Kconfig                          |   9 +
 drivers/iio/light/Makefile                         |   1 +
 drivers/iio/light/isl29033.c                       | 767 +++++++++++++++++++++
 4 files changed, 794 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29033.txt
 create mode 100644 drivers/iio/light/isl29033.c

diff --git a/Documentation/devicetree/bindings/iio/light/isl29033.txt b/Documentation/devicetree/bindings/iio/light/isl29033.txt
new file mode 100644
index 000000000000..41870aeacebf
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/isl29033.txt
@@ -0,0 +1,17 @@
+ISL29033 Ultra-Low Lux ambient light sensor
+
+Required properties:
+  - compatible : Must be "isil,isl29033".
+  - reg: the I2C address of the device
+
+Optional properties:
+  - rext: Rext resistor nominal (in kOhm)
+
+Example:
+
+        als_sensor@44 {
+            compatible = "isil,isl29033";
+            reg = <0x44>;
+            rext = <1000>;
+        };
+
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 074e50657366..2d845618e6b0 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -182,6 +182,15 @@ config SENSORS_ISL29028
 	 Proximity value via iio. The ISL29028 provides the concurrent sensing
 	 of ambient light and proximity.
 
+config SENSORS_ISL29033
+	tristate "Intersil ISL29033 Ultra-Low Lux, Low Power, Integrated Digital Ambient Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	 Provides driver for the Intersil's ISL29033 device.
+	 This driver supports the sysfs interface to get the ALS and IR intensity
+	 value via IIO.
+
 config ISL29125
 	tristate "Intersil ISL29125 digital color light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f1777036d4f8..98f5f1f0a45a 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_HID_SENSOR_ALS)	+= hid-sensor-als.o
 obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
+obj-$(CONFIG_SENSORS_ISL29033)	+= isl29033.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
diff --git a/drivers/iio/light/isl29033.c b/drivers/iio/light/isl29033.c
new file mode 100644
index 000000000000..713f75247b7d
--- /dev/null
+++ b/drivers/iio/light/isl29033.c
@@ -0,0 +1,767 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * isl29033.c: A iio driver for the light sensor ISL 29033.
+ *
+ * IIO driver for monitoring ambient light intensity in lux and infrared
+ * sensing.
+ *
+ * Copyright (c) 2018, Axis Communication AB
+ * Author: Borys Movchan <Borys.Movchan@axis.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <asm/div64.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/acpi.h>
+
+#define ISL29033_REG_ADD_COMMAND1	0x00
+#define ISL29033_CMD1_OPMODE_SHIFT	5
+#define ISL29033_CMD1_OPMODE_MASK	(7 << ISL29033_CMD1_OPMODE_SHIFT)
+#define ISL29033_CMD1_OPMODE_POWER_DOWN	0
+#define ISL29033_CMD1_OPMODE_ALS_CONT	5
+#define ISL29033_CMD1_OPMODE_IR_CONT	6
+
+#define ISL29033_REG_ADD_COMMAND2	0x01
+#define ISL29033_CMD2_RESOLUTION_SHIFT	2
+#define ISL29033_CMD2_RESOLUTION_MASK	(0x3 << ISL29033_CMD2_RESOLUTION_SHIFT)
+
+#define ISL29033_CMD2_RANGE_SHIFT	0
+#define ISL29033_CMD2_RANGE_MASK	(0x3 << ISL29033_CMD2_RANGE_SHIFT)
+
+#define ISL29033_CMD2_SCHEME_SHIFT	7
+#define ISL29033_CMD2_SCHEME_MASK	(0x1 << ISL29033_CMD2_SCHEME_SHIFT)
+
+#define ISL29033_REG_ADD_DATA_LSB	0x02
+#define ISL29033_REG_ADD_DATA_MSB	0x03
+
+#define ISL29033_REG_TEST		0x08
+#define ISL29033_TEST_SHIFT		0
+#define ISL29033_TEST_MASK		(0xFF << ISL29033_TEST_SHIFT)
+
+#define ISL29033_REF_REXT		499	/* In kOhm */
+
+#define ISL29033_MICRO			1000000
+
+enum isl29033_int_time {
+	ISL29033_INT_TIME_16,
+	ISL29033_INT_TIME_12,
+	ISL29033_INT_TIME_8,
+	ISL29033_INT_TIME_4,
+};
+
+#define isl29033_int_utime(adcmax) \
+	((unsigned int)(adcmax) * (ISL29033_MICRO / 1000) / 655)
+
+static const unsigned int isl29033_int_utimes[4] = {
+	isl29033_int_utime(65536),
+	isl29033_int_utime(4096),
+	isl29033_int_utime(256),
+	isl29033_int_utime(16)
+};
+
+#define isl29033_mkscale(range, adcmax)				\
+	 { (range) / (adcmax),					\
+	   ((unsigned int)(range) * (ISL29033_MICRO / 10)	\
+			/ (adcmax) * 10) % ISL29033_MICRO }
+
+static const struct isl29033_scale {
+	unsigned int scale;
+	unsigned int uscale;
+} isl29033_scales[4][4] = {
+	{
+	   isl29033_mkscale(125, 65536), isl29033_mkscale(500, 65536),
+	   isl29033_mkscale(2000, 65536), isl29033_mkscale(8000, 65536)
+	},
+	{
+	   isl29033_mkscale(125, 4096), isl29033_mkscale(500, 4096),
+	   isl29033_mkscale(2000, 4096), isl29033_mkscale(8000, 4096)
+	},
+	{
+	   isl29033_mkscale(125, 256), isl29033_mkscale(500, 256),
+	   isl29033_mkscale(2000, 256), isl29033_mkscale(8000, 256)
+	},
+	{
+	   isl29033_mkscale(125, 16), isl29033_mkscale(500, 16),
+	   isl29033_mkscale(2000, 16), isl29033_mkscale(8000, 16)
+	}
+};
+
+
+struct isl29033_chip {
+	struct regmap		*regmap;
+	struct mutex		lock;
+	unsigned int		int_time;
+	unsigned int		calibscale;
+	unsigned int		ucalibscale;
+	struct isl29033_scale	scale;
+	unsigned int		rext;
+	unsigned int		opmode;
+	bool			suspended;
+
+};
+
+#define isl29033_rext_normalize(chip, val) \
+	((val) * ISL29033_REF_REXT / (chip)->rext)
+
+static unsigned int isl29033_rext_normalize2(struct isl29033_chip *chip,
+				     unsigned int val, unsigned int val2)
+{
+	val = val - isl29033_rext_normalize(chip, val)
+			* chip->rext / ISL29033_REF_REXT;
+	val2 = (val2 + val * ISL29033_MICRO) * ISL29033_REF_REXT / chip->rext;
+	return val2;
+}
+
+static int isl29033_set_integration_time(struct isl29033_chip *chip,
+					 unsigned int utime)
+{
+	unsigned int i;
+	int ret;
+	unsigned int int_time, new_int_time;
+
+	for (i = 0; i < ARRAY_SIZE(isl29033_int_utimes); ++i) {
+		if (utime == isl29033_int_utimes[i]
+				* chip->rext / ISL29033_REF_REXT) {
+			new_int_time = i;
+			break;
+		}
+	}
+
+	if (i >= ARRAY_SIZE(isl29033_int_utimes))
+		return -EINVAL;
+
+	ret = regmap_update_bits(chip->regmap, ISL29033_REG_ADD_COMMAND2,
+				 ISL29033_CMD2_RESOLUTION_MASK,
+				 i << ISL29033_CMD2_RESOLUTION_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	/* Keep the same range when integration time changes */
+	int_time = chip->int_time;
+	for (i = 0; i < ARRAY_SIZE(isl29033_scales[int_time]); ++i) {
+		if (chip->scale.scale == isl29033_scales[int_time][i].scale &&
+		    chip->scale.uscale == isl29033_scales[int_time][i].uscale) {
+			chip->scale = isl29033_scales[new_int_time][i];
+			break;
+		}
+	}
+	chip->int_time = new_int_time;
+
+	return 0;
+}
+
+static int isl29033_set_scale(struct isl29033_chip *chip, int scale, int uscale)
+{
+	unsigned int i;
+	int ret;
+	struct isl29033_scale new_scale;
+
+	for (i = 0; i < ARRAY_SIZE(isl29033_scales[chip->int_time]); ++i) {
+		if (scale ==
+			isl29033_rext_normalize(chip,
+				isl29033_scales[chip->int_time][i].scale)
+		    && uscale ==
+			isl29033_rext_normalize2(chip,
+				isl29033_scales[chip->int_time][i].scale,
+				isl29033_scales[chip->int_time][i].uscale)) {
+			new_scale = isl29033_scales[chip->int_time][i];
+			break;
+		}
+	}
+
+	if (i >= ARRAY_SIZE(isl29033_scales[chip->int_time]))
+		return -EINVAL;
+
+	ret = regmap_update_bits(chip->regmap, ISL29033_REG_ADD_COMMAND2,
+				 ISL29033_CMD2_RANGE_MASK,
+				 i << ISL29033_CMD2_RANGE_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	chip->scale = new_scale;
+
+	return 0;
+}
+
+static int isl29033_set_mode(struct isl29033_chip *chip, int mode)
+{
+
+	int ret;
+
+	ret = regmap_update_bits(chip->regmap, ISL29033_REG_ADD_COMMAND1,
+				ISL29033_CMD1_OPMODE_MASK,
+				mode << ISL29033_CMD1_OPMODE_SHIFT);
+	if (ret < 0) {
+		struct device *dev = regmap_get_device(chip->regmap);
+
+		dev_err(dev,
+			"Error in setting operating mode with err %d\n", ret);
+		return ret;
+	}
+
+	if (chip->int_time < 20000)
+		usleep_range(chip->int_time, chip->int_time * 2);
+	else
+		msleep(chip->int_time / 1000);
+
+	return 0;
+}
+
+static int isl29033_read_sensor_input(struct isl29033_chip *chip)
+{
+	int ret;
+	unsigned int lsb;
+	unsigned int msb;
+	struct device *dev = regmap_get_device(chip->regmap);
+
+	if (chip->opmode == ISL29033_CMD1_OPMODE_POWER_DOWN)
+		return -EBUSY;
+
+	ret = regmap_read(chip->regmap, ISL29033_REG_ADD_DATA_LSB, &lsb);
+	if (ret < 0) {
+		dev_err(dev,
+			"Error in reading LSB DATA with err %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_read(chip->regmap, ISL29033_REG_ADD_DATA_MSB, &msb);
+	if (ret < 0) {
+		dev_err(dev,
+			"Error in reading MSB DATA with err %d\n", ret);
+		return ret;
+	}
+	dev_vdbg(dev, "MSB 0x%x and LSB 0x%x\n", msb, lsb);
+
+	return (msb << 8) | lsb;
+}
+
+static int isl29033_read_lux(struct isl29033_chip *chip, int *lux, int *ulux)
+{
+	int ret;
+	unsigned int tmpres;
+
+	ret = isl29033_read_sensor_input(chip);
+	if (ret < 0)
+		return ret;
+
+	ret++;
+
+	tmpres = ret * isl29033_rext_normalize2(chip, chip->scale.scale,
+					  chip->scale.uscale);
+	*lux = ret * isl29033_rext_normalize(chip, chip->scale.scale)
+				+ tmpres / ISL29033_MICRO;
+	*ulux = tmpres % ISL29033_MICRO;
+
+	*lux = *lux * chip->calibscale;
+	*ulux = *ulux * chip->calibscale + *lux * chip->ucalibscale
+				+ *ulux * chip->ucalibscale / ISL29033_MICRO;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int isl29033_read_ir(struct isl29033_chip *chip, int *ir)
+{
+	int ret;
+
+	ret = isl29033_read_sensor_input(chip);
+	if (ret < 0)
+		return ret;
+
+	*ir = ret;
+
+	return IIO_VAL_INT;
+}
+
+static ssize_t isl29033_in_illuminance_scale_available
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+	unsigned int i;
+	int len = 0;
+
+	mutex_lock(&chip->lock);
+	for (i = 0; i < ARRAY_SIZE(isl29033_scales[chip->int_time]); ++i)
+		len += sprintf(buf + len, "%d.%06d ",
+			isl29033_rext_normalize(chip,
+				isl29033_scales[chip->int_time][i].scale),
+			isl29033_rext_normalize2(chip,
+				isl29033_scales[chip->int_time][i].scale,
+				isl29033_scales[chip->int_time][i].uscale));
+	mutex_unlock(&chip->lock);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t isl29033_in_illuminance_integration_time_available
+			(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+	unsigned int i;
+	int len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(isl29033_int_utimes); ++i)
+		len += sprintf(buf + len, "0.%06d ",
+				   isl29033_int_utimes[i]
+				   * chip->rext / ISL29033_REF_REXT);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static int isl29033_write_raw(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  int val,
+				  int val2,
+				  long mask)
+{
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	mutex_lock(&chip->lock);
+	if (chip->suspended) {
+		ret = -EBUSY;
+		goto write_done;
+	}
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (chan->type == IIO_LIGHT) {
+			chip->calibscale = val;
+			chip->ucalibscale = val2;
+			ret = 0;
+		}
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type == IIO_LIGHT && !val)
+			ret = isl29033_set_integration_time(chip, val2);
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_LIGHT)
+			ret = isl29033_set_scale(chip, val, val2);
+		break;
+	case IIO_CHAN_INFO_ENABLE:
+		if (val)
+			switch (chan->type) {
+			case IIO_LIGHT:
+				chip->opmode = ISL29033_CMD1_OPMODE_ALS_CONT;
+				break;
+			case IIO_INTENSITY:
+				chip->opmode = ISL29033_CMD1_OPMODE_IR_CONT;
+				break;
+			default:
+				chip->opmode = ISL29033_CMD1_OPMODE_POWER_DOWN;
+			break;
+			}
+		else
+			chip->opmode = ISL29033_CMD1_OPMODE_POWER_DOWN;
+		ret = isl29033_set_mode(chip, chip->opmode);
+		if (ret != 0)
+			chip->opmode = ISL29033_CMD1_OPMODE_POWER_DOWN;
+		break;
+	default:
+		break;
+	}
+
+write_done:
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int isl29033_read_raw(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val,
+				 int *val2,
+				 long mask)
+{
+	int ret = -EINVAL;
+	struct isl29033_chip *chip = iio_priv(indio_dev);
+
+	mutex_lock(&chip->lock);
+	if (chip->suspended) {
+		ret = -EBUSY;
+		goto read_done;
+	}
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chip->opmode != ISL29033_CMD1_OPMODE_IR_CONT)
+			ret = -EBUSY;
+		else
+			ret = isl29033_read_ir(chip, val);
+		break;
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			if (chip->opmode != ISL29033_CMD1_OPMODE_ALS_CONT)
+				ret = -EBUSY;
+			else
+				ret = isl29033_read_lux(chip, val, val2);
+			break;
+		case IIO_INTENSITY:
+			if (chip->opmode != ISL29033_CMD1_OPMODE_IR_CONT)
+				ret = -EBUSY;
+			else
+				ret = isl29033_read_ir(chip, val);
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type == IIO_LIGHT) {
+			*val = 0;
+			*val2 = isl29033_int_utimes[chip->int_time]
+					* chip->rext / ISL29033_REF_REXT;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_LIGHT) {
+			*val = isl29033_rext_normalize(chip, chip->scale.scale);
+			*val2 = isl29033_rext_normalize2(chip,
+					chip->scale.scale, chip->scale.uscale);
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (chan->type == IIO_LIGHT) {
+			*val = chip->calibscale;
+			*val2 = chip->ucalibscale;
+			ret = IIO_VAL_INT_PLUS_MICRO;
+		}
+		break;
+	case IIO_CHAN_INFO_ENABLE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*val = chip->opmode == ISL29033_CMD1_OPMODE_ALS_CONT;
+			break;
+		case IIO_INTENSITY:
+			*val = chip->opmode == ISL29033_CMD1_OPMODE_IR_CONT;
+			break;
+		default:
+			break;
+		}
+		ret = IIO_VAL_INT;
+		break;
+
+	default:
+		break;
+	}
+
+read_done:
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+#define ISL29033_LIGHT_CHANNEL {					\
+	.type = IIO_LIGHT,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |		\
+	BIT(IIO_CHAN_INFO_CALIBSCALE) |					\
+	BIT(IIO_CHAN_INFO_SCALE) |					\
+	BIT(IIO_CHAN_INFO_INT_TIME) |					\
+	BIT(IIO_CHAN_INFO_ENABLE),					\
+}
+
+#define ISL29033_IR_CHANNEL {						\
+	.type = IIO_INTENSITY,						\
+	.modified = 1,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+	BIT(IIO_CHAN_INFO_ENABLE),					\
+	.channel2 = IIO_MOD_LIGHT_IR,					\
+}
+
+static const struct iio_chan_spec isl29033_channels[] = {
+	ISL29033_LIGHT_CHANNEL,
+	ISL29033_IR_CHANNEL,
+};
+
+static IIO_DEVICE_ATTR(in_illuminance_integration_time_available, 0444,
+		isl29033_in_illuminance_integration_time_available, NULL, 0);
+static IIO_DEVICE_ATTR(in_illuminance_scale_available, 0444,
+		isl29033_in_illuminance_scale_available, NULL, 0);
+
+#define ISL29033_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
+
+static struct attribute *isl29033_attributes[] = {
+	ISL29033_DEV_ATTR(in_illuminance_scale_available),
+	ISL29033_DEV_ATTR(in_illuminance_integration_time_available),
+	NULL
+};
+
+static const struct attribute_group isl29033_group = {
+	.attrs = isl29033_attributes,
+};
+
+static int isl29033_chip_init(struct isl29033_chip *chip)
+{
+	int ret;
+	struct device *dev = regmap_get_device(chip->regmap);
+
+
+	/*
+	 * Code added per Intersil Application Note 1534:
+	 *	 When VDD sinks to approximately 1.8V or below, some of
+	 * the part's registers may change their state. When VDD
+	 * recovers to 2.25V (or greater), the part may thus be in an
+	 * unknown mode of operation. The user can return the part to
+	 * a known mode of operation either by (a) setting VDD = 0V for
+	 * 1 second or more and then powering back up with a slew rate
+	 * of 0.5V/ms or greater, or (b) via I2C disable all ALS/PROX
+	 * conversions, clear the test registers, and then rewrite all
+	 * registers to the desired values.
+	 * ...
+	 * For ISL29033, etc.
+	 * 1. Write 0x00 to register 0x08 (TEST)
+	 * 2. Write 0x00 to register 0x00 (CMD1)
+	 * 3. Rewrite all registers to the desired values
+	 */
+	ret = regmap_write(chip->regmap, ISL29033_REG_TEST, 0x0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to clear isl29033 TEST reg with err %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * See Intersil AN1534 comments above.
+	 * "Operating Mode" (COMMAND1) register is reprogrammed when
+	 * data is read from the device.
+	 */
+	ret = regmap_write(chip->regmap, ISL29033_REG_ADD_COMMAND1, 0);
+	if (ret < 0) {
+		dev_err(dev, "Failed to clear isl29033 CMD1 reg with err %d\n",
+			ret);
+		return ret;
+	}
+
+	usleep_range(1000, 2000);	/* per data sheet, page 10 */
+
+	/* Set defaults */
+	ret = isl29033_set_scale(chip,
+			isl29033_rext_normalize(chip, chip->scale.scale),
+			isl29033_rext_normalize2(chip, chip->scale.scale,
+					chip->scale.uscale));
+	if (ret < 0) {
+		dev_err(dev,
+			"Init of isl29033 fails (scale) with err %d\n", ret);
+		return ret;
+	}
+
+	ret = isl29033_set_integration_time(chip,
+			isl29033_int_utimes[chip->int_time]
+			* chip->rext / ISL29033_REF_REXT);
+	if (ret < 0)
+		dev_err(dev,
+			"Init of isl29033 fails (integration) with err %d\n",
+			ret);
+
+	return ret;
+}
+
+static const struct iio_info isl29033_info = {
+	.attrs = &isl29033_group,
+	.read_raw = isl29033_read_raw,
+	.write_raw = isl29033_write_raw,
+};
+
+static bool isl29033_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL29033_REG_ADD_DATA_LSB:
+	case ISL29033_REG_ADD_DATA_MSB:
+	case ISL29033_REG_ADD_COMMAND1:
+	case ISL29033_REG_ADD_COMMAND2:
+	case ISL29033_REG_TEST:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config isl29033_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_reg = isl29033_is_volatile_reg,
+	.max_register = ISL29033_REG_TEST,
+	.num_reg_defaults_raw = ISL29033_REG_TEST + 1,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+struct isl29033_chip_info {
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	const struct iio_info *info;
+	const struct regmap_config *regmap_cfg;
+};
+
+static const char *isl29033_match_acpi_device(struct device *dev, int *data)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+
+	if (!id)
+		return NULL;
+
+	*data = (int)id->driver_data;
+
+	return dev_name(dev);
+}
+
+static int isl29033_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct isl29033_chip *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+	const char *name = NULL;
+	int dev_id = 0;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+
+	i2c_set_clientdata(client, indio_dev);
+
+	if (id) {
+		name = id->name;
+		dev_id = id->driver_data;
+	}
+
+	if (ACPI_HANDLE(&client->dev))
+		name = isl29033_match_acpi_device(&client->dev, &dev_id);
+
+	mutex_init(&chip->lock);
+
+	chip->calibscale = 1;
+	chip->ucalibscale = 0;
+	chip->int_time = ISL29033_INT_TIME_16;
+	chip->scale = isl29033_scales[chip->int_time][0];
+	chip->suspended = false;
+
+#ifdef CONFIG_OF
+	ret = device_property_read_u32(&client->dev, "rext", &chip->rext);
+	if (ret != 0)
+		chip->rext =  ISL29033_REF_REXT;
+#endif /* CONFIG_OF */
+
+	chip->regmap = devm_regmap_init_i2c(client, &isl29033_regmap_config);
+
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(&client->dev,
+			"regmap initialization fails with err %d\n", ret);
+		return ret;
+	}
+
+	ret = isl29033_chip_init(chip);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &isl29033_info;
+	indio_dev->channels = isl29033_channels;
+	indio_dev->num_channels = ARRAY_SIZE(isl29033_channels);
+	indio_dev->name = name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int isl29033_suspend(struct device *dev)
+{
+	struct isl29033_chip *chip = iio_priv(dev_get_drvdata(dev));
+
+	mutex_lock(&chip->lock);
+
+	isl29033_set_mode(chip, ISL29033_CMD1_OPMODE_POWER_DOWN);
+	chip->suspended = true;
+
+	mutex_unlock(&chip->lock);
+
+	return 0;
+}
+
+static int isl29033_resume(struct device *dev)
+{
+	struct isl29033_chip *chip = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	ret = isl29033_chip_init(chip);
+	if (!ret)
+		chip->suspended = false;
+
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static SIMPLE_DEV_PM_OPS(isl29033_pm_ops, isl29033_suspend, isl29033_resume);
+#define ISL29033_PM_OPS (&isl29033_pm_ops)
+#else
+#define ISL29033_PM_OPS NULL
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id isl29033_acpi_match[] = {
+	{"ISL29033", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, isl29033_acpi_match);
+#endif
+
+static const struct i2c_device_id isl29033_id[] = {
+	{"isl29033", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, isl29033_id);
+
+static const struct of_device_id isl29033_of_match[] = {
+	{ .compatible = "isil,isl29033", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, isl29033_of_match);
+
+static struct i2c_driver isl29033_driver = {
+	.driver	 = {
+		.name = "isl29033",
+		.acpi_match_table = ACPI_PTR(isl29033_acpi_match),
+		.pm = ISL29033_PM_OPS,
+		.of_match_table = isl29033_of_match,
+	},
+	.probe	 = isl29033_probe,
+	.id_table = isl29033_id,
+};
+module_i2c_driver(isl29033_driver);
+
+MODULE_DESCRIPTION("ISL29033 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0

