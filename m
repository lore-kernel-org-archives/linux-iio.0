Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60163 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753622AbcCINao (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Mar 2016 08:30:44 -0500
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/2] iio: temperature: Add threshold interrupt support for max31722
Date: Wed,  9 Mar 2016 15:30:52 +0200
Message-Id: <1457530252-4984-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1457530252-4984-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added interrupt support for high/low temperature threshold
events to the max31722 driver.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/temperature/max31722.c | 303 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 301 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/max31722.c b/drivers/iio/temperature/max31722.c
index fa833b6..a8bfe35 100644
--- a/drivers/iio/temperature/max31722.c
+++ b/drivers/iio/temperature/max31722.c
@@ -10,21 +10,32 @@
 
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
 #define MAX31722_REG_CFG				0x00
 #define MAX31722_REG_TEMP_LSB			0x01
 #define MAX31722_REG_TEMP_MSB			0x02
+#define MAX31722_REG_THIGH_LSB         0x03
+#define MAX31722_REG_TLOW_LSB          0x05
 #define MAX31722_MAX_REG				0x86
 
 #define MAX31722_MODE_CONTINUOUS		0x00
 #define MAX31722_MODE_STANDBY			0x01
+#define MAX31722_MODE_THERMOSTAT       0x80
+
+#define MAX31722_MIN_TEMP          -55
+#define MAX31722_MAX_TEMP          125
 
 #define MAX31722_REGMAP_NAME			"max31722_regmap"
+#define MAX31722_EVENT             "max31722_event"
+#define MAX31722_GPIO              "max31722_gpio"
 
 #define MAX31722_SCALE_AVAILABLE		"0.5 0.25 0.125 0.0625"
 
@@ -43,6 +54,8 @@ static const struct reg_field max31722_reg_field_state =
 				REG_FIELD(MAX31722_REG_CFG, 0, 0);
 static const struct reg_field max31722_reg_field_resolution =
 				REG_FIELD(MAX31722_REG_CFG, 1, 2);
+static const struct reg_field max31722_reg_field_thermostat =
+				REG_FIELD(MAX31722_REG_CFG, 3, 3);
 
 struct max31722_data {
 	struct spi_device *spi_device;
@@ -50,6 +63,8 @@ struct max31722_data {
 	struct regmap *regmap;
 	struct regmap_field *reg_state;
 	struct regmap_field *reg_resolution;
+	struct regmap_field *reg_thermostat;
+	u64 timestamp;
 };
 
 /*
@@ -71,11 +86,30 @@ static const struct attribute_group max31722_attribute_group = {
 	.attrs = max31722_attributes
 };
 
+static const struct iio_event_spec max31722_events[] = {
+	/* High temperature event */
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	/* Low temperature event */
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec max31722_channels[] = {
 	{
 		.type = IIO_TEMP,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = max31722_events,
+		.num_event_specs = ARRAY_SIZE(max31722_events),
 	},
 };
 
@@ -167,6 +201,172 @@ static void max31722_reg_to_float(u16 reg_val, int *val, int *val2)
 	}
 }
 
+/* Convert a floating point value to a register value. */
+static u16 max31722_float_to_reg(int val, int val2)
+{
+	int i;
+	bool negative_nr;
+	u8 lsb;
+	u16 reg_val;
+
+	negative_nr = (val & 0x80) || val2 < 0;
+	if (val2 < 0)
+		val2 *= -1;
+
+	/*
+	 * The LSB value will be an approximation of val2
+	 * due to its limited 4-bit range.
+	 */
+	lsb = 0;
+	for (i = 0 ; i < ARRAY_SIZE(max31722_scale_table) && val2 > 0; i++)
+		if (val2 - max31722_scale_table[i] >= 0) {
+			val2 -= max31722_scale_table[i];
+			lsb += 1 << (4 - i - 1);
+		}
+	lsb <<= 4;
+
+	if (negative_nr) {
+		/*
+		 * Negative value. Temporarily use the complement of val for
+		 * the MSB, then concatenate the LSB, reverse bits & add 1 for
+		 * the final value.
+		 */
+		u8 msb = (u8)(-1 * val);
+		u16 rev = 0;
+		int num_bits = sizeof(rev) * 8;
+
+		reg_val = (msb << 8) | lsb;
+
+		for (i = 0 ; i < num_bits ; i++) {
+			rev |= !(reg_val & 0x01) << i;
+			reg_val >>= 1;
+		}
+		rev += 1;
+		return rev;
+
+	} else {
+		reg_val = ((u8)val << 8) | lsb;
+	}
+
+	return reg_val;
+}
+
+static int max31722_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	unsigned int event_val;
+	int ret;
+	struct max31722_data *data = iio_priv(indio_dev);
+	struct spi_device *spi = data->spi_device;
+
+	mutex_lock(&data->lock);
+	ret = regmap_field_read(data->reg_thermostat, &event_val);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to read thermostat status\n");
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+	mutex_unlock(&data->lock);
+
+	return event_val;
+}
+
+static int max31722_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       int state)
+{
+	int ret;
+	struct max31722_data *data = iio_priv(indio_dev);
+	struct spi_device *spi = data->spi_device;
+
+	if (state != 0 && state != 1)
+		return -EINVAL;
+
+	/*
+	 * Set thermostat mode:
+	 * 0 : comparator mode (default)
+	 * 1 : interrupt mode
+	 */
+	mutex_lock(&data->lock);
+	ret = regmap_field_write(data->reg_thermostat, state);
+	if (ret < 0)
+		dev_err(&spi->dev, "failed to set thermostat mode\n");
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int max31722_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info,
+			       int *val, int *val2)
+{
+	int ret;
+	u8 reg;
+	u16 buf;
+	struct max31722_data *data = iio_priv(indio_dev);
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = MAX31722_REG_THIGH_LSB;
+	else if (dir == IIO_EV_DIR_FALLING)
+		reg = MAX31722_REG_TLOW_LSB;
+	else
+		return -EINVAL;
+
+	mutex_lock(&data->lock);
+	ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
+	mutex_unlock(&data->lock);
+	if (ret < 0) {
+		dev_err(&data->spi_device->dev,
+			"failed to read threshold register\n");
+		return ret;
+	}
+	max31722_reg_to_float(buf, val, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int max31722_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info,
+				int val, int val2)
+{
+	int ret;
+	u8 reg;
+	u16 buf;
+	struct max31722_data *data = iio_priv(indio_dev);
+
+	if (val < MAX31722_MIN_TEMP || val > MAX31722_MAX_TEMP)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = MAX31722_REG_THIGH_LSB;
+	else if (dir == IIO_EV_DIR_FALLING)
+		reg = MAX31722_REG_TLOW_LSB;
+	else
+		return -EINVAL;
+
+	buf = max31722_float_to_reg(val, val2);
+
+	ret = regmap_bulk_write(data->regmap, reg, &buf, 2);
+	if (ret < 0)
+		dev_err(&data->spi_device->dev,
+			"failed to write threshold register\n");
+
+	return ret;
+}
+
 static int max31722_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
@@ -241,8 +441,63 @@ static const struct iio_info max31722_info = {
 	.read_raw		= max31722_read_raw,
 	.write_raw		= max31722_write_raw,
 	.attrs			= &max31722_attribute_group,
+	.read_event_value	= max31722_read_event,
+	.write_event_value	= max31722_write_event,
+	.read_event_config	= max31722_read_event_config,
+	.write_event_config	= max31722_write_event_config,
 };
 
+static irqreturn_t max31722_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct max31722_data *data = iio_priv(indio_dev);
+
+	data->timestamp = iio_get_time_ns();
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t max31722_irq_event_handler(int irq, void *private)
+{
+	int ret;
+	u64 event;
+	u16 temp;
+	u16 tlow;
+	u16 thigh;
+	unsigned int dir;
+	struct iio_dev *indio_dev = private;
+	struct max31722_data *data = iio_priv(indio_dev);
+
+	/*
+	 * Do a quick temperature reading and compare it with TLOW/THIGH
+	 * so we can tell which threshold has been met.
+	 */
+	mutex_lock(&data->lock);
+	ret = regmap_bulk_read(data->regmap, MAX31722_REG_TEMP_LSB, &temp, 2);
+	if (ret < 0)
+		goto exit_err;
+	ret = regmap_bulk_read(data->regmap, MAX31722_REG_TLOW_LSB, &tlow, 2);
+	if (ret < 0)
+		goto exit_err;
+	ret = regmap_bulk_read(data->regmap, MAX31722_REG_THIGH_LSB, &thigh, 2);
+	if (ret < 0)
+		goto exit_err;
+	mutex_unlock(&data->lock);
+
+	dir = (temp > thigh ? 1 : 0);
+	event = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0, IIO_EV_TYPE_THRESH,
+				     (dir ? IIO_EV_DIR_RISING :
+					    IIO_EV_DIR_FALLING));
+	iio_push_event(indio_dev, event, data->timestamp);
+
+	return IRQ_HANDLED;
+
+exit_err:
+	dev_err(&data->spi_device->dev, "failed to read temperature register\n");
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 static int max31722_init(struct max31722_data *data)
 {
 	int ret = 0;
@@ -259,15 +514,40 @@ static int max31722_init(struct max31722_data *data)
 
 	MAX31722_REGFIELD(state);
 	MAX31722_REGFIELD(resolution);
+	MAX31722_REGFIELD(thermostat);
 
 	/* Set SD bit to 0 so we can have continuous measurements. */
 	ret = regmap_field_write(data->reg_state, MAX31722_MODE_CONTINUOUS);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to configure sensor.\n");
+		return ret;
+	}
+
+	/* Set thermostat interrupt mode */
+	ret = regmap_field_write(data->reg_thermostat, 1);
 	if (ret < 0)
 		dev_err(&spi->dev, "failed to configure sensor.\n");
 
 	return ret;
 }
 
+static int max31722_gpio_probe(struct spi_device *spi)
+{
+	struct gpio_desc *gpio;
+
+	if (!spi)
+		return -EINVAL;
+
+	/* gpio interrupt pin */
+	gpio = devm_gpiod_get_index(&spi->dev, MAX31722_GPIO, 0, GPIOD_IN);
+	if (IS_ERR(gpio)) {
+		dev_err(&spi->dev, "gpio request failed.\n");
+		return PTR_ERR(gpio);
+	}
+
+	return gpiod_to_irq(gpio);
+}
+
 static int max31722_probe(struct spi_device *spi)
 {
 	int ret;
@@ -294,15 +574,34 @@ static int max31722_probe(struct spi_device *spi)
 
 	ret = max31722_init(data);
 	if (ret < 0)
-		return ret;
+		goto err_standby;
+
+	ret = max31722_gpio_probe(data->spi_device);
+	if (ret < 0)
+		goto err_standby;
+
+	spi->irq = ret;
+	ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+					max31722_irq_handler,
+					max31722_irq_event_handler,
+					IRQF_TRIGGER_LOW,
+					MAX31722_EVENT, indio_dev);
+	if (ret < 0) {
+		dev_err(&spi->dev, "request irq %d failed\n", spi->irq);
+		goto err_standby;
+	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio_device_register failed\n");
-		regmap_field_write(data->reg_state, MAX31722_MODE_STANDBY);
+		goto err_standby;
 	}
 
 	return ret;
+
+err_standby:
+	regmap_field_write(data->reg_state, MAX31722_MODE_STANDBY);
+	return ret;
 }
 
 static int max31722_remove(struct spi_device *spi)
-- 
1.9.1

