Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43490 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab0IOGcw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2010 02:32:52 -0400
Date: Wed, 15 Sep 2010 15:32:33 +0900
From: Donggeun Kim <dg77.kim@samsung.com>
Subject: [PATCH V2] staging: iio: tmd2771x: Add tmd2771x proximity and ambient
 light sensor driver
To: linux-iio@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: kyungmin.park@samsung.com
Message-id: <4C906881.8010204@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from V1 to V2:
- I2C read and write wrapping functions are removed.
- The error handling routines are inserted.
- The similar functions are created by macro invocation.
- Some attribute names are changed.
- Some event attribute names are changed.
- The comments are added to the code to explain the non standard attributes
  and fields of the platform data.

This driver supports TAOS TMD27711 and TMD27713
proximity and ambient light sensor.
When threshold condition for proximity or ambient light sensor is satisfied,
an event is generated.
The proximity raw value is exported through the 'proximity_raw' attribute.
This driver uses 'illuminance0_input' attribute to export lux value by
calculating ch0 and ch1 ADC values.

Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/staging/iio/light/Kconfig    |   11 +
 drivers/staging/iio/light/Makefile   |    1 +
 drivers/staging/iio/light/tmd2771x.c |  706 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/light/tmd2771x.h |  169 ++++++++
 drivers/staging/iio/sysfs.h          |    3 +
 5 files changed, 890 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/iio/light/tmd2771x.c
 create mode 100644 drivers/staging/iio/light/tmd2771x.h

diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index 3ddc478..ecf8e09 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -12,3 +12,14 @@ config SENSORS_TSL2563
 
 	 This driver can also be built as a module.  If so, the module
 	 will be called tsl2563.
+
+config SENSORS_TMD2771X
+	tristate "TAOS TMD2771X proximity and ambient light sensor"
+	depends on I2C
+	help
+	 If you say yes here you get support for TAOS TMD27711, TMD27713
+	 proximity and ambient light sensor.
+
+	 This driver can also be built as a module. If so, the module
+	 will be called tmd2771x.
+
diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
index 30f3300..03b0d10 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -3,3 +3,4 @@
 #
 
 obj-$(CONFIG_SENSORS_TSL2563)	+= tsl2563.o
+obj-$(CONFIG_SENSORS_TMD2771X)	+= tmd2771x.o
diff --git a/drivers/staging/iio/light/tmd2771x.c b/drivers/staging/iio/light/tmd2771x.c
new file mode 100644
index 0000000..7343d6c
--- /dev/null
+++ b/drivers/staging/iio/light/tmd2771x.c
@@ -0,0 +1,706 @@
+/*
+ *  tmd2771x.c - Texas Advanced Optoelectronic Solutions Inc.
+ *		 Proximity/Ambient light sensor
+ *
+ *  Copyright (C) 2010 Samsung Electronics
+ *  Donggeun Kim <dg77.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/mutex.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include "../iio.h"
+#include "light.h"
+#include "tmd2771x.h"
+
+struct tmd2771x_chip {
+	struct i2c_client		*client;
+	struct iio_dev			*indio_dev;
+	struct work_struct		work_thresh;
+	s64				last_timestamp;
+	struct mutex			lock;
+
+	struct tmd2771x_platform_data	*pdata;
+};
+
+#define TMD2771X_SET_GET_FUNC(name, field_name, shift, mask, reg)	\
+static int tmd2771x_set_##name(struct tmd2771x_chip *chip, u8 val)	\
+{									\
+	int ret = 0;							\
+	u8 value, temp;							\
+									\
+	mutex_lock(&chip->lock);					\
+	temp = (val << shift) & mask;					\
+	if (temp == chip->pdata->field_name)				\
+		goto out;						\
+									\
+	ret = value = i2c_smbus_read_byte_data(chip->client,		\
+			TMD2771X_DEFAULT_COMMAND | reg);		\
+	if (ret < 0)							\
+		goto out;						\
+									\
+	value &= ~mask;							\
+	value |= temp;							\
+	chip->pdata->field_name = temp;					\
+	ret = i2c_smbus_write_byte_data(chip->client,			\
+			TMD2771X_DEFAULT_COMMAND | reg, value);		\
+out:									\
+	mutex_unlock(&chip->lock);					\
+	return ret;							\
+}									\
+									\
+static int tmd2771x_get_##name(struct tmd2771x_chip *chip)		\
+{									\
+	return chip->pdata->field_name >> shift;			\
+}
+
+TMD2771X_SET_GET_FUNC(wait_en, wait_enable, TMD2771X_WEN_SHIFT,
+		      TMD2771X_WEN, TMD2771X_ENABLE);
+TMD2771X_SET_GET_FUNC(proximity_en, ps_enable, TMD2771X_PEN_SHIFT,
+		      TMD2771X_PEN, TMD2771X_ENABLE);
+TMD2771X_SET_GET_FUNC(light_en, als_enable, TMD2771X_AEN_SHIFT,
+		      TMD2771X_AEN, TMD2771X_ENABLE);
+TMD2771X_SET_GET_FUNC(power_on, power_on, TMD2771X_PON_SHIFT,
+		      TMD2771X_PON, TMD2771X_ENABLE);
+TMD2771X_SET_GET_FUNC(proximity_thresh_period, ps_interrupt_persistence,
+		      TMD2771X_PPERS_SHIFT, TMD2771X_PPERS_MASK,
+		      TMD2771X_PERS);
+TMD2771X_SET_GET_FUNC(intensity_both_thresh_period,
+		      als_interrupt_persistence, TMD2771X_APERS_SHIFT,
+		      TMD2771X_APERS_MASK, TMD2771X_PERS);
+
+#define TMD2771X_GET_RAW_FUNC(name, reg)				\
+static int tmd2771x_get_##name(struct tmd2771x_chip *chip)		\
+{									\
+	u8 values[2];							\
+	u16 raw_value;							\
+	int ret;							\
+									\
+	mutex_lock(&chip->lock);					\
+	ret = i2c_smbus_read_i2c_block_data(chip->client,		\
+		TMD2771X_AUTO_INCREMENT_COMMAND | reg,			\
+		2, values);						\
+	if (ret < 0) {							\
+		mutex_unlock(&chip->lock);				\
+		return ret;						\
+	}								\
+									\
+	raw_value = (values[1] << BITS_PER_BYTE) | values[0];		\
+	mutex_unlock(&chip->lock);					\
+									\
+	return raw_value;						\
+}
+
+TMD2771X_GET_RAW_FUNC(proximity_raw, TMD2771X_PDATAL);
+TMD2771X_GET_RAW_FUNC(intensity_both_raw, TMD2771X_CH0DATAL);
+TMD2771X_GET_RAW_FUNC(intensity_ir_raw, TMD2771X_CH1DATAL);
+
+#define TMD2771X_THRESH_VALUE_GET_SET_FUNC(name, field_name, reg)	\
+static int tmd2771x_set_##name(struct tmd2771x_chip *chip, u16 val)	\
+{									\
+	int ret = 0;							\
+	u8 temp_high, temp_low;						\
+									\
+	mutex_lock(&chip->lock);					\
+	if (val == chip->pdata->field_name)				\
+		goto out;						\
+									\
+	temp_high = (val >> BITS_PER_BYTE) & TMD2771X_8BIT_MASK;	\
+	temp_low = val & TMD2771X_8BIT_MASK;				\
+									\
+	chip->pdata->field_name = (temp_high << BITS_PER_BYTE) |	\
+				   temp_low;				\
+	ret = i2c_smbus_write_byte_data(chip->client,			\
+		TMD2771X_DEFAULT_COMMAND | reg, temp_low);		\
+	if (ret < 0)							\
+		goto out;						\
+									\
+	ret = i2c_smbus_write_byte_data(chip->client,			\
+		TMD2771X_DEFAULT_COMMAND | (reg + 1), temp_high);	\
+out:									\
+	mutex_unlock(&chip->lock);					\
+	return ret;							\
+}									\
+									\
+static int tmd2771x_get_##name(struct tmd2771x_chip *chip)		\
+{									\
+	return chip->pdata->field_name;					\
+}
+
+TMD2771X_THRESH_VALUE_GET_SET_FUNC(intensity_both_thresh_rising_value,
+			     als_interrupt_h_thres, TMD2771X_AIHTL);
+TMD2771X_THRESH_VALUE_GET_SET_FUNC(intensity_both_thresh_falling_value,
+			     als_interrupt_l_thres, TMD2771X_AILTL);
+TMD2771X_THRESH_VALUE_GET_SET_FUNC(proximity_thresh_rising_value,
+			     ps_interrupt_h_thres, TMD2771X_PIHTL);
+TMD2771X_THRESH_VALUE_GET_SET_FUNC(proximity_thresh_falling_value,
+			     ps_interrupt_l_thres, TMD2771X_PILTL);
+/*
+ * Conversions between lux and ADC values.
+ *
+ * The basic formulas for lux are as follows.
+ * lux1 = GA * 24 * (CH0DATA - 2 * CH1DATA) / (integration time * gain)
+ * lux2 = GA * 24 * (0.8 * CH0DATA - 1.4 * CH1DATA) / (integration time * gain)
+ * lux = MAX(lux1, lux2)
+ * GA is Glass Attenuation.
+ *
+ */
+static int tmd2771x_get_illuminance0_input(struct tmd2771x_chip *chip)
+{
+	long lux, lux1, lux2, als_int_time, als_gain,
+	     ch0, ch1, glass_attenuation = 1;
+
+	/* integration time = 2.7ms * (256 - als_time)
+	   The following equation removes floating point numbers
+	   Therefore, the result is 10 times greter than the original value */
+	als_int_time = 27 * (256 - chip->pdata->als_time);
+
+	ch0 = tmd2771x_get_intensity_both_raw(chip);
+	if (ch0 < 0)
+		return ch0;
+	ch1 = tmd2771x_get_intensity_ir_raw(chip);
+	if (ch1 < 0)
+		return ch1;
+
+	switch (chip->pdata->als_gain) {
+	case TMD2771X_AGAIN_1X:
+		als_gain = 1;
+		break;
+	case TMD2771X_AGAIN_8X:
+		als_gain = 8;
+		break;
+	case TMD2771X_AGAIN_16X:
+		als_gain = 16;
+		break;
+	case TMD2771X_AGAIN_120X:
+		als_gain = 120;
+		break;
+	default:
+		als_gain = 1;
+		break;
+	}
+
+	if (chip->pdata->glass_attenuation > 0)
+		glass_attenuation = chip->pdata->glass_attenuation;
+
+	/* Because the integration time is 10 times greater than
+	   the original value,
+	   numerator is mutiplied by 10 */
+	lux1 = (10 * glass_attenuation * 24 * (ch0 - 2 * ch1)) /
+	       (als_int_time * als_gain);
+	lux2 = (glass_attenuation * 24 * (8 * ch0 - 14 * ch1)) /
+	       (als_int_time * als_gain);
+	lux = lux1 > lux2 ? lux1 : lux2;
+
+	return lux;
+}
+
+static int tmd2771x_thresh_handler_th(struct iio_dev *dev_info,
+			       int index, s64 timestamp, int no_test)
+{
+	struct tmd2771x_chip *chip = dev_info->dev_data;
+
+	chip->last_timestamp = timestamp;
+	schedule_work(&chip->work_thresh);
+
+	return 0;
+}
+
+static void tmd2771x_thresh_handler_bh(struct work_struct *work_s)
+{
+	struct tmd2771x_chip *chip =
+		container_of(work_s, struct tmd2771x_chip, work_thresh);
+	int value;
+
+	value = i2c_smbus_read_byte_data(chip->client,
+			TMD2771X_DEFAULT_COMMAND | TMD2771X_STATUS);
+
+	if (value & TMD2771X_PINT) {
+		iio_push_event(chip->indio_dev, 0,
+			       IIO_EVENT_CODE_PROXIMITY_THRESH,
+			       chip->last_timestamp);
+	}
+
+	if (value & TMD2771X_AINT) {
+		iio_push_event(chip->indio_dev, 0,
+			       IIO_EVENT_CODE_LIGHT_THRESH,
+			       chip->last_timestamp);
+	}
+
+	/* Acknowledge proximity and ambient light sensor interrupt */
+	i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_PS_ALS_INT_CLEAR_COMMAND, 0);
+
+	enable_irq(chip->client->irq);
+}
+
+#define TMD2771X_OUTPUT(name)						\
+static ssize_t tmd2771x_show_##name(struct device *dev,			\
+		struct device_attribute *attr, char *buf)		\
+{									\
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);		\
+	struct tmd2771x_chip *chip = indio_dev->dev_data;		\
+	int value = tmd2771x_get_##name(chip);				\
+	return sprintf(buf, "%d\n", value);				\
+}									\
+static DEVICE_ATTR(name, S_IRUGO, tmd2771x_show_##name, NULL);
+
+#define TMD2771X_INPUT(name)						\
+static ssize_t tmd2771x_store_##name(struct device *dev,		\
+	struct device_attribute *attr, const char *buf, size_t count)	\
+{									\
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);		\
+	struct tmd2771x_chip *chip = indio_dev->dev_data;		\
+	int ret;							\
+	unsigned long val;						\
+									\
+	if (!count)							\
+		return -EINVAL;						\
+									\
+	ret = strict_strtoul(buf, 10, &val);				\
+	if (ret)							\
+		return -EINVAL;						\
+									\
+	ret = tmd2771x_set_##name(chip, val);				\
+	if (ret < 0)							\
+		return ret;						\
+									\
+	return count;							\
+}									\
+static ssize_t tmd2771x_show_##name(struct device *dev,			\
+		struct device_attribute *attr, char *buf)		\
+{									\
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);		\
+	struct tmd2771x_chip *chip = indio_dev->dev_data;		\
+	int value = tmd2771x_get_##name(chip);				\
+	return sprintf(buf, "%d\n", value);				\
+}									\
+static DEVICE_ATTR(name, S_IRUGO | S_IWUSR,				\
+		tmd2771x_show_##name, tmd2771x_store_##name);
+
+TMD2771X_OUTPUT(proximity_raw);
+TMD2771X_OUTPUT(intensity_both_raw);
+TMD2771X_OUTPUT(intensity_ir_raw);
+TMD2771X_OUTPUT(illuminance0_input);
+TMD2771X_INPUT(power_on);
+TMD2771X_INPUT(wait_en);
+TMD2771X_INPUT(proximity_en);
+TMD2771X_INPUT(light_en);
+
+static ssize_t tmd2771x_show_name(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tmd2771x_chip *chip = indio_dev->dev_data;
+	return sprintf(buf, "%s\n", chip->client->name);
+}
+
+static DEVICE_ATTR(name, S_IRUGO, tmd2771x_show_name, NULL);
+
+static struct attribute *tmd2771x_attributes[] = {
+	&dev_attr_proximity_raw.attr,
+	&dev_attr_intensity_both_raw.attr,
+	&dev_attr_intensity_ir_raw.attr,
+	&dev_attr_illuminance0_input.attr,
+	&dev_attr_power_on.attr,
+	/* wait_en can control the wait state.
+	   When wait state is enabled, waiting time is inserted
+	   between the proximity sensing state and the light sensing state. */
+	&dev_attr_wait_en.attr,
+	/* proximity_en can enable or disable the proximity sensor. */
+	&dev_attr_proximity_en.attr,
+	/* light_en can enable or disable the ambient light sensor. */
+	&dev_attr_light_en.attr,
+	&dev_attr_name.attr,
+	NULL
+};
+
+static const struct attribute_group tmd2771x_group = {
+	.attrs = tmd2771x_attributes,
+};
+
+static ssize_t tmd2771x_read_interrupt_config(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tmd2771x_chip *chip = indio_dev->dev_data;
+	u8 val;
+	int ret;
+
+	ret = val = i2c_smbus_read_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_ENABLE);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%d\n", !!(val & this_attr->mask));
+}
+
+static ssize_t tmd2771x_write_interrupt_config(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t len)
+{
+	struct iio_event_attr *this_attr = to_iio_event_attr(attr);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct tmd2771x_chip *chip = indio_dev->dev_data;
+	int ret, currentlyset, changed = 0;
+	u8 valold;
+	bool val;
+
+	val = !(buf[0] == '0');
+
+	mutex_lock(&indio_dev->mlock);
+
+	ret = valold = i2c_smbus_read_byte_data(chip->client,
+				TMD2771X_DEFAULT_COMMAND | TMD2771X_ENABLE);
+	if (ret < 0)
+		goto error_mutex_unlock;
+
+	currentlyset = !!(valold & this_attr->mask);
+	if (val == false && currentlyset) {
+		valold &= ~this_attr->mask;
+		changed = 1;
+	} else if (val == true && !currentlyset) {
+		changed = 1;
+		valold |= this_attr->mask;
+	}
+
+	if (changed)
+		ret = i2c_smbus_write_byte_data(chip->client,
+			TMD2771X_DEFAULT_COMMAND | TMD2771X_ENABLE, valold);
+
+error_mutex_unlock:
+	mutex_unlock(&indio_dev->mlock);
+
+	return (ret < 0) ? ret : len;
+}
+
+IIO_EVENT_SH(threshold, &tmd2771x_thresh_handler_th);
+
+IIO_EVENT_ATTR_SH(proximity_thresh_en,
+		  iio_event_threshold,
+		  tmd2771x_read_interrupt_config,
+		  tmd2771x_write_interrupt_config,
+		  TMD2771X_PIEN);
+TMD2771X_INPUT(proximity_thresh_rising_value);
+TMD2771X_INPUT(proximity_thresh_falling_value);
+TMD2771X_INPUT(proximity_thresh_period);
+
+IIO_EVENT_ATTR_SH(intensity_both_thresh_en,
+		  iio_event_threshold,
+		  tmd2771x_read_interrupt_config,
+		  tmd2771x_write_interrupt_config,
+		  TMD2771X_AIEN);
+TMD2771X_INPUT(intensity_both_thresh_rising_value);
+TMD2771X_INPUT(intensity_both_thresh_falling_value);
+TMD2771X_INPUT(intensity_both_thresh_period);
+
+static struct attribute *tmd2771x_event_attributes[] = {
+	&iio_event_attr_proximity_thresh_en.dev_attr.attr,
+	&dev_attr_proximity_thresh_rising_value.attr,
+	&dev_attr_proximity_thresh_falling_value.attr,
+	&dev_attr_proximity_thresh_period.attr,
+	&iio_event_attr_intensity_both_thresh_en.dev_attr.attr,
+	&dev_attr_intensity_both_thresh_rising_value.attr,
+	&dev_attr_intensity_both_thresh_falling_value.attr,
+	&dev_attr_intensity_both_thresh_period.attr,
+	NULL
+};
+
+static struct attribute_group tmd2771x_event_attribute_group = {
+	.attrs = tmd2771x_event_attributes,
+};
+
+static int tmd2771x_initialize_chip(struct tmd2771x_chip *chip)
+{
+	u8 value, temp_low, temp_high;
+	int ret;
+
+	/* Disable and powerdown */
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_ENABLE, 0);
+	if (ret < 0)
+		return ret;
+
+	/* ALS timing register */
+	value = chip->pdata->als_time;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_ATIME, value);
+	if (ret < 0)
+		return ret;
+
+	/* PS timing register */
+	value = chip->pdata->ps_time;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_PTIME, value);
+	if (ret < 0)
+		return ret;
+
+	/* Wait time register */
+	value = chip->pdata->wait_time;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_WTIME, value);
+	if (ret < 0)
+		return ret;
+
+	/* Proximity pulse count register */
+	value = chip->pdata->ps_pulse_count;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_PPCOUNT, value);
+	if (ret < 0)
+		return ret;
+
+	/* ALS interrupt threshold register */
+	temp_high = (chip->pdata->als_interrupt_l_thres >> BITS_PER_BYTE);
+	temp_low = chip->pdata->als_interrupt_l_thres & TMD2771X_8BIT_MASK;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_AILTL, temp_low);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_AILTH, temp_high);
+	if (ret < 0)
+		return ret;
+
+	temp_high = (chip->pdata->als_interrupt_h_thres >> BITS_PER_BYTE);
+	temp_low = chip->pdata->als_interrupt_h_thres & TMD2771X_8BIT_MASK;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_AIHTL, temp_low);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_AIHTH, temp_high);
+	if (ret < 0)
+		return ret;
+
+	/* PS interrupt threshold register */
+	temp_high = (chip->pdata->ps_interrupt_l_thres >> BITS_PER_BYTE);
+	temp_low = chip->pdata->ps_interrupt_l_thres & TMD2771X_8BIT_MASK;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_PILTL, temp_low);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_PILTH, temp_high);
+	if (ret < 0)
+		return ret;
+
+	temp_high = (chip->pdata->ps_interrupt_h_thres >> BITS_PER_BYTE);
+	temp_low = chip->pdata->ps_interrupt_h_thres & TMD2771X_8BIT_MASK;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_PIHTL, temp_low);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_PIHTH, temp_high);
+	if (ret < 0)
+		return ret;
+
+	/* Persistence register */
+	value = chip->pdata->ps_interrupt_persistence |
+		chip->pdata->als_interrupt_persistence;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_PERS, value);
+	if (ret < 0)
+		return ret;
+
+	/* Configuration register */
+	value = chip->pdata->wait_long;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_CONFIG, value);
+	if (ret < 0)
+		return ret;
+
+	/* Control register */
+	value = chip->pdata->ps_drive_strength | chip->pdata->ps_diode |
+		chip->pdata->als_gain;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_CONTROL, value);
+	if (ret < 0)
+		return ret;
+
+	/* Enable register */
+	value = chip->pdata->ps_interrupt_enable |
+		chip->pdata->als_interrupt_enable |
+		chip->pdata->wait_enable | chip->pdata->ps_enable |
+		chip->pdata->als_enable | chip->pdata->power_on;
+	ret = i2c_smbus_write_byte_data(chip->client,
+		TMD2771X_DEFAULT_COMMAND | TMD2771X_ENABLE, value);
+	if (ret < 0)
+		return ret;
+
+	msleep(TMD2771X_POWERUP_WAIT_TIME);
+
+	return 0;
+}
+
+static int __devinit tmd2771x_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct tmd2771x_chip *chip;
+	int ret = -1;
+
+	chip = kzalloc(sizeof(struct tmd2771x_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->pdata = client->dev.platform_data;
+	if (!(chip->pdata))
+		goto error_no_pdata;
+
+	chip->client = client;
+	i2c_set_clientdata(client, chip);
+	mutex_init(&chip->lock);
+	INIT_WORK(&chip->work_thresh, tmd2771x_thresh_handler_bh);
+
+	if (chip->pdata->control_power_source) {
+		chip->pdata->control_power_source(1);
+		msleep(TMD2771X_POWERUP_WAIT_TIME);
+	}
+
+	/* Detect device id */
+	ret = i2c_smbus_read_byte_data(client,
+			TMD2771X_DEFAULT_COMMAND | TMD2771X_ID);
+	if ((ret != TMD27711_DEV_ID) || (ret != TMD27713_DEV_ID)) {
+		dev_err(&client->dev, "failed to detect device id\n");
+		goto error_detect_id;
+	}
+
+	chip->indio_dev = iio_allocate_device();
+	if (!chip->indio_dev)
+		goto error_allocate_iio;
+
+	chip->indio_dev->attrs = &tmd2771x_group;
+	chip->indio_dev->dev.parent = &client->dev;
+	chip->indio_dev->dev_data = (void *)(chip);
+	chip->indio_dev->num_interrupt_lines = 1;
+	chip->indio_dev->event_attrs = &tmd2771x_event_attribute_group;
+	chip->indio_dev->driver_module = THIS_MODULE;
+	chip->indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(chip->indio_dev);
+	if (ret)
+		goto error_register_iio;
+
+	if (client->irq > 0) {
+		ret = iio_register_interrupt_line(client->irq,
+						  chip->indio_dev,
+						  0,
+						  IRQF_TRIGGER_FALLING,
+						  "TMD2771X");
+		if (ret)
+			goto error_register_interrupt;
+
+		iio_add_event_to_list(&iio_event_threshold,
+				    &chip->indio_dev->interrupts[0]->ev_list);
+
+	}
+
+	ret = tmd2771x_initialize_chip(chip);
+	if (ret)
+		goto error_initialize;
+
+	dev_info(&client->dev, "%s registered\n", id->name);
+
+	return 0;
+
+error_initialize:
+error_register_interrupt:
+	iio_device_unregister(chip->indio_dev);
+error_register_iio:
+	iio_free_device(chip->indio_dev);
+error_allocate_iio:
+error_no_pdata:
+error_detect_id:
+	kfree(chip);
+	return ret;
+}
+
+static int __devexit tmd2771x_remove(struct i2c_client *client)
+{
+	struct tmd2771x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip->client->irq > 0)
+		iio_unregister_interrupt_line(chip->indio_dev, 0);
+
+	iio_device_unregister(chip->indio_dev);
+	iio_free_device(chip->indio_dev);
+	kfree(chip);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tmd2771x_suspend(struct i2c_client *client, pm_message_t mesg)
+{
+	struct tmd2771x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip->pdata->control_power_source)
+		chip->pdata->control_power_source(0);
+
+	return 0;
+}
+
+static int tmd2771x_resume(struct i2c_client *client)
+{
+	struct tmd2771x_chip *chip = i2c_get_clientdata(client);
+
+	if (chip->pdata->control_power_source)
+		chip->pdata->control_power_source(1);
+	tmd2771x_initialize_chip(chip);
+
+	return 0;
+}
+#else
+#define tmd2771x_suspend NULL
+#define tmd2771x_resume NULL
+#endif
+
+static const struct i2c_device_id tmd2771x_id[] = {
+	{ "TMD27711", 0 },
+	{ "TMD27713", 1 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, tmd2771x_id);
+
+static struct i2c_driver tmd2771x_i2c_driver = {
+	.driver = {
+		.name	= "TMD2771X",
+	},
+	.probe		= tmd2771x_probe,
+	.remove		= __exit_p(tmd2771x_remove),
+	.suspend	= tmd2771x_suspend,
+	.resume		= tmd2771x_resume,
+	.id_table	= tmd2771x_id,
+};
+
+static int __init tmd2771x_init(void)
+{
+	return i2c_add_driver(&tmd2771x_i2c_driver);
+}
+module_init(tmd2771x_init);
+
+static void __exit tmd2771x_exit(void)
+{
+	i2c_del_driver(&tmd2771x_i2c_driver);
+}
+module_exit(tmd2771x_exit);
+
+MODULE_AUTHOR("Donggeun Kim <dg77.kim@samsung.com>");
+MODULE_DESCRIPTION("TMD2771X Proximity/Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/staging/iio/light/tmd2771x.h b/drivers/staging/iio/light/tmd2771x.h
new file mode 100644
index 0000000..fcb9abf
--- /dev/null
+++ b/drivers/staging/iio/light/tmd2771x.h
@@ -0,0 +1,169 @@
+/*
+ *  tmd2771x.h - Texas Advanced Optoelectronic Solutions Inc.
+ *		 Proximity/Ambient light sensor
+ *
+ *  Copyright (c) 2010 Samsung Eletronics
+ *  Donggeun Kim <dg77.kim@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _TMD2771X_H_
+#define _TMD2771X_H_
+
+#define TMD2771X_ENABLE				0x00
+#define TMD2771X_ATIME				0x01
+#define TMD2771X_PTIME				0x02
+#define TMD2771X_WTIME				0x03
+#define TMD2771X_AILTL				0x04
+#define TMD2771X_AILTH				0x05
+#define TMD2771X_AIHTL				0x06
+#define TMD2771X_AIHTH				0x07
+#define TMD2771X_PILTL				0x08
+#define TMD2771X_PILTH				0x09
+#define TMD2771X_PIHTL				0x0a
+#define TMD2771X_PIHTH				0x0b
+#define TMD2771X_PERS				0x0c
+#define TMD2771X_CONFIG				0x0d
+#define TMD2771X_PPCOUNT			0x0e
+#define TMD2771X_CONTROL			0x0f
+#define TMD2771X_ID				0x12
+#define TMD2771X_STATUS				0x13
+#define TMD2771X_CH0DATAL			0x14
+#define TMD2771X_CH0DATAH			0x15
+#define TMD2771X_CH1DATAL			0x16
+#define TMD2771X_CH1DATAH			0x17
+#define TMD2771X_PDATAL				0x18
+#define TMD2771X_PDATAH				0x19
+
+#define TMD2771X_PIEN_SHIFT			(5)
+#define TMD2771X_PIEN				(0x1 << TMD2771X_PIEN_SHIFT)
+#define TMD2771X_AIEN_SHIFT			(4)
+#define TMD2771X_AIEN				(0x1 << TMD2771X_AIEN_SHIFT)
+#define TMD2771X_WEN_SHIFT			(3)
+#define TMD2771X_WEN				(0x1 << TMD2771X_WEN_SHIFT)
+#define TMD2771X_PEN_SHIFT			(2)
+#define TMD2771X_PEN				(0x1 << TMD2771X_PEN_SHIFT)
+#define TMD2771X_AEN_SHIFT			(1)
+#define TMD2771X_AEN				(0x1 << TMD2771X_AEN_SHIFT)
+#define TMD2771X_PON_SHIFT			(0)
+#define TMD2771X_PON				(0x1 << TMD2771X_PON_SHIFT)
+
+#define TMD2771X_PPERS_SHIFT			(4)
+#define TMD2771X_PPERS_MASK			(0xf << TMD2771X_PPERS_SHIFT)
+#define TMD2771X_APERS_SHIFT			(0)
+#define TMD2771X_APERS_MASK			(0xf << TMD2771X_APERS_SHIFT)
+
+#define TMD2771X_WLONG_SHIFT			(1)
+#define TMD2771X_WLONG				(0x1 << TMD2771X_WLONG_SHIFT)
+
+#define TMD2771X_PDRIVE_SHIFT			(6)
+#define TMD2771X_PDRIVE_100MA			(0x0 << TMD2771X_PDRIVE_SHIFT)
+#define TMD2771X_PDRIVE_50MA			(0x1 << TMD2771X_PDRIVE_SHIFT)
+#define TMD2771X_PDRIVE_25MA			(0x2 << TMD2771X_PDRIVE_SHIFT)
+#define TMD2771X_PDRIVE_12MA			(0x3 << TMD2771X_PDRIVE_SHIFT)
+#define TMD2771X_PDIODE_SHIFT			(4)
+#define TMD2771X_PDIODE_CH0_DIODE		(0x1 << TMD2771X_PDIODE_SHIFT)
+#define TMD2771X_PDIODE_CH1_DIODE		(0x2 << TMD2771X_PDIODE_SHIFT)
+#define TMD2771X_PDIODE_BOTH_DIODE		(0x3 << TMD2771X_PDIODE_SHIFT)
+#define TMD2771X_AGAIN_SHIFT			(0)
+#define TMD2771X_AGAIN_1X			(0x0 << TMD2771X_AGAIN_SHIFT)
+#define TMD2771X_AGAIN_8X			(0x1 << TMD2771X_AGAIN_SHIFT)
+#define TMD2771X_AGAIN_16X			(0x2 << TMD2771X_AGAIN_SHIFT)
+#define TMD2771X_AGAIN_120X			(0x3 << TMD2771X_AGAIN_SHIFT)
+
+#define TMD2771X_PINT_SHIFT			(5)
+#define TMD2771X_PINT				(0x1 << TMD2771X_PINT_SHIFT)
+#define TMD2771X_AINT_SHIFT			(4)
+#define TMD2771X_AINT				(0x1 << TMD2771X_AINT_SHIFT)
+#define TMD2771X_AVALID_SHIFT			(0)
+#define TMD2771X_AVALID				(0x1 << TMD2771X_AVALID_SHIFT)
+
+#define TMD2771X_8BIT_MASK			(0xff)
+
+#define TMD2771X_DEFAULT_COMMAND		0x80
+#define TMD2771X_AUTO_INCREMENT_COMMAND		0xa0
+#define TMD2771X_PS_INT_CLEAR_COMMAND		0xe5
+#define TMD2771X_ALS_INT_CLEAR_COMMAND		0xe6
+#define TMD2771X_PS_ALS_INT_CLEAR_COMMAND	0xe7
+
+#define TMD2771X_POWERUP_WAIT_TIME		12
+
+#define TMD27711_DEV_ID				0x20
+#define TMD27713_DEV_ID				0x29
+
+/**
+ * struct tmd2771x_platform_data - device instance specific data
+ * @control_power_source:	function that controls power source
+ *				of the device
+ *				typically used for controlling regulator
+ * @wait_enable:		writing TMD2771X_WEN activates the wait timer
+ * @wait_long:			when asserted, the wait cycles are increased by
+ *				a factor 12x from that programmed in
+ *				TMD2771X_WTIME register
+ * @wait_time:			waiting time for wait timer
+ * @ps_enable:			writing TMD2771X_PEN enables proximity sensor
+ * @ps_interrupt_h_thres:	value to be used as the high trigger points for
+ *				proximity interrupt generation
+ * @ps_interrupt_l_thres:	value to be used as the low trigger points for
+ *				proximity interrupt generation
+ * @ps_interrupt_enable:	writing TMD2771X_PIEN enables
+ *				proximity interrupt
+ * @ps_time:			the value controls the integration time of
+ *				the proximity ADC in 2.72 ms increments
+ *				it is recommended that
+ *				this value is set to 0xff (2.72ms)
+ * @ps_interrupt_persistence:	the value controls rate of proximity interrupt
+ * @ps_pulse_count:		the number of proximity pulses
+ *				that will be transmitted
+ * @ps_drive_strength:		LED drive strength
+ * @ps_diode:			select proximity diode
+ * @als_enable:			writing TMD2771X_AEN enables
+ *				ambient light sensor
+ * @als_interrupt_h_thres:	value to be used as the high trigger points for
+ *				light interrupt generation
+ * @als_interrupt_l_thres:	value to be used as the low trigger points for
+ *				light interrupt generation
+ * @als_interrupt_enable:	writing TMD2771X_AIEN enables light interrupt
+ * @als_time:			the value controls the integration time of
+ *				light sensor channel ADCs in 2.72 ms increments
+ * @als_interrupt_persistence:	the value controls rate of light interrupt
+ * @als_gain:			ambient light sensor gain control
+ * @glass_attenuation:		glass attenuation factor **/
+
+struct tmd2771x_platform_data {
+	void (*control_power_source)(int);
+
+	u8 power_on;			/* TMD2771X_PON   */
+	u8 wait_enable;			/* TMD2771X_WEN  */
+	u8 wait_long;			/* TMD2771X_WLONG */
+	u8 wait_time;			/* 0x00 ~ 0xff	*/
+
+	/* Proximity */
+	u8 ps_enable;			/* TMD2771X_PEN	*/
+	u16 ps_interrupt_h_thres;	/* 0x0000 ~ 0xffff */
+	u16 ps_interrupt_l_thres;	/* 0x0000 ~ 0xffff */
+	u8 ps_interrupt_enable;		/* TMD2771X_PIEN */
+	u8 ps_time;			/* 0x00 ~ 0xff	*/
+	u8 ps_interrupt_persistence;	/* 0x00 ~ 0xf0 (top four bits) */
+	u8 ps_pulse_count;		/* 0x00 ~ 0xff	*/
+	u8 ps_drive_strength;		/* TMD2771X_PDRIVE_12MA ~
+					   TMD2771X_PDRIVE_100MA */
+	u8 ps_diode;			/* TMD2771X_PDIODE_CH0_DIODE ~
+					   TMD2771X_PDIODE_BOTH_DIODE */
+
+	/* Ambient Light */
+	u8 als_enable;			/* TMD2771X_AEN */
+	u16 als_interrupt_h_thres;	/* 0x0000 ~ 0xffff */
+	u16 als_interrupt_l_thres;	/* 0x0000 ~ 0xffff */
+	u8 als_interrupt_enable;	/* TMD2771X_AIEN */
+	u8 als_time;			/* 0x00 ~ 0xff */
+	u8 als_interrupt_persistence;	/* 0x00 ~ 0x0f (bottom four bits) */
+	u8 als_gain;			/* TMD2771X_AGAIN_1X ~
+					   TMD2771X_AGAIN_120X */
+	u8 glass_attenuation;
+};
+
+#endif
diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 6083416..c74eb83 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -330,6 +330,7 @@ struct iio_const_attr {
 #define IIO_EVENT_CODE_ADC_BASE		500
 #define IIO_EVENT_CODE_MISC_BASE	600
 #define IIO_EVENT_CODE_LIGHT_BASE	700
+#define IIO_EVENT_CODE_PROXIMITY_BASE	800
 
 #define IIO_EVENT_CODE_DEVICE_SPECIFIC	1000
 
@@ -367,4 +368,6 @@ struct iio_const_attr {
 #define IIO_EVENT_CODE_RING_75_FULL	(IIO_EVENT_CODE_RING_BASE + 1)
 #define IIO_EVENT_CODE_RING_100_FULL	(IIO_EVENT_CODE_RING_BASE + 2)
 
+#define IIO_EVENT_CODE_PROXIMITY_THRESH	IIO_EVENT_CODE_PROXIMITY_BASE
+
 #endif /* _INDUSTRIAL_IO_SYSFS_H_ */
-- 
1.6.3.3

