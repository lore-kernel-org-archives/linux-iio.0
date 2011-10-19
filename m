Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: adc: Relocate Capacitance to Digital Converters (CDC) into own subdir
Date: Wed, 19 Oct 2011 11:53:02 +0200
Message-ID: <1319017982-14002-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

No functional changes.
Fix Kconfig description.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Kconfig      |    1 +
 drivers/staging/iio/Makefile     |    1 +
 drivers/staging/iio/adc/Kconfig  |   24 --
 drivers/staging/iio/adc/Makefile |    3 -
 drivers/staging/iio/adc/ad7150.c |  676 -------------------------------
 drivers/staging/iio/adc/ad7152.c |  559 --------------------------
 drivers/staging/iio/adc/ad7746.c |  807 --------------------------------------
 drivers/staging/iio/adc/ad7746.h |   29 --
 drivers/staging/iio/cdc/Kconfig  |   36 ++
 drivers/staging/iio/cdc/Makefile |    7 +
 drivers/staging/iio/cdc/ad7150.c |  676 +++++++++++++++++++++++++++++++
 drivers/staging/iio/cdc/ad7152.c |  559 ++++++++++++++++++++++++++
 drivers/staging/iio/cdc/ad7746.c |  807 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/cdc/ad7746.h |   29 ++
 14 files changed, 2116 insertions(+), 2098 deletions(-)
 delete mode 100644 drivers/staging/iio/adc/ad7150.c
 delete mode 100644 drivers/staging/iio/adc/ad7152.c
 delete mode 100644 drivers/staging/iio/adc/ad7746.c
 delete mode 100644 drivers/staging/iio/adc/ad7746.h
 create mode 100644 drivers/staging/iio/cdc/Kconfig
 create mode 100644 drivers/staging/iio/cdc/Makefile
 create mode 100644 drivers/staging/iio/cdc/ad7150.c
 create mode 100644 drivers/staging/iio/cdc/ad7152.c
 create mode 100644 drivers/staging/iio/cdc/ad7746.c
 create mode 100644 drivers/staging/iio/cdc/ad7746.h

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 09cf580..4ec9118 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -59,6 +59,7 @@ config IIO_CONSUMERS_PER_TRIGGER
 source "drivers/staging/iio/accel/Kconfig"
 source "drivers/staging/iio/adc/Kconfig"
 source "drivers/staging/iio/addac/Kconfig"
+source "drivers/staging/iio/cdc/Kconfig"
 source "drivers/staging/iio/dac/Kconfig"
 source "drivers/staging/iio/dds/Kconfig"
 source "drivers/staging/iio/gyro/Kconfig"
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index eaa07b0..1340aea 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
 obj-y += accel/
 obj-y += adc/
 obj-y += addac/
+obj-y += cdc/
 obj-y += dac/
 obj-y += dds/
 obj-y += gyro/
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 13e93fb..d9decea 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -3,20 +3,6 @@
 #
 menu "Analog to digital converters"
 
-config AD7150
-	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (ad7150, ad7151, ad7156) Provides direct access via sysfs.
-
-config AD7152
-	tristate "Analog Devices ad7152/3 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (ad7152, ad7153) Provides direct access via sysfs.
-
 config AD7291
 	tristate "Analog Devices AD7291 ADC driver"
 	depends on I2C
@@ -137,16 +123,6 @@ config AD7793
 	  To compile this driver as a module, choose M here: the
 	  module will be called AD7793.
 
-config AD7746
-	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
-	depends on I2C
-	help
-	  Say yes here to build support for Analog Devices capacitive sensors.
-	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called ad7745.
-
 config AD7816
 	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
 	depends on SPI
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index be7faaa..ceee7f3 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -29,10 +29,7 @@ ad7298-y := ad7298_core.o
 ad7298-$(CONFIG_IIO_BUFFER) += ad7298_ring.o
 obj-$(CONFIG_AD7298) += ad7298.o
 
-obj-$(CONFIG_AD7150) += ad7150.o
-obj-$(CONFIG_AD7152) += ad7152.o
 obj-$(CONFIG_AD7291) += ad7291.o
-obj-$(CONFIG_AD7746) += ad7746.o
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7816) += ad7816.o
diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
deleted file mode 100644
index e185f0e..0000000
--- a/drivers/staging/iio/adc/ad7150.c
+++ /dev/null
@@ -1,676 +0,0 @@
-/*
- * AD7150 capacitive sensor driver supporting AD7150/1/6
- *
- * Copyright 2010-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/module.h>
-
-#include "../iio.h"
-#include "../sysfs.h"
-
-/*
- * AD7150 registers definition
- */
-
-#define AD7150_STATUS              0
-#define AD7150_STATUS_OUT1         (1 << 3)
-#define AD7150_STATUS_OUT2         (1 << 5)
-#define AD7150_CH1_DATA_HIGH       1
-#define AD7150_CH2_DATA_HIGH       3
-#define AD7150_CH1_AVG_HIGH        5
-#define AD7150_CH2_AVG_HIGH        7
-#define AD7150_CH1_SENSITIVITY     9
-#define AD7150_CH1_THR_HOLD_H      9
-#define AD7150_CH1_TIMEOUT         10
-#define AD7150_CH1_SETUP           11
-#define AD7150_CH2_SENSITIVITY     12
-#define AD7150_CH2_THR_HOLD_H      12
-#define AD7150_CH2_TIMEOUT         13
-#define AD7150_CH2_SETUP           14
-#define AD7150_CFG                 15
-#define AD7150_CFG_FIX             (1 << 7)
-#define AD7150_PD_TIMER            16
-#define AD7150_CH1_CAPDAC          17
-#define AD7150_CH2_CAPDAC          18
-#define AD7150_SN3                 19
-#define AD7150_SN2                 20
-#define AD7150_SN1                 21
-#define AD7150_SN0                 22
-#define AD7150_ID                  23
-
-/**
- * struct ad7150_chip_info - instance specific chip data
- * @client: i2c client for this device
- * @current_event: device always has one type of event enabled.
- *	This element stores the event code of the current one.
- * @threshold: thresholds for simple capacitance value events
- * @thresh_sensitivity: threshold for simple capacitance offset
- *	from 'average' value.
- * @mag_sensitity: threshold for magnitude of capacitance offset from
- *	from 'average' value.
- * @thresh_timeout: a timeout, in samples from the moment an
- *	adaptive threshold event occurs to when the average
- *	value jumps to current value.
- * @mag_timeout: a timeout, in sample from the moment an
- *	adaptive magnitude event occurs to when the average
- *	value jumps to the current value.
- * @old_state: store state from previous event, allowing confirmation
- *	of new condition.
- * @conversion_mode: the current conversion mode.
- * @state_lock: ensure consistent state of this structure wrt the
- *	hardware.
- */
-struct ad7150_chip_info {
-	struct i2c_client *client;
-	u64 current_event;
-	u16 threshold[2][2];
-	u8 thresh_sensitivity[2][2];
-	u8 mag_sensitivity[2][2];
-	u8 thresh_timeout[2][2];
-	u8 mag_timeout[2][2];
-	int old_state;
-	char *conversion_mode;
-	struct mutex state_lock;
-};
-
-/*
- * sysfs nodes
- */
-
-static const u8 ad7150_addresses[][6] = {
-	{ AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
-	  AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
-	  AD7150_CH1_SENSITIVITY, AD7150_CH1_TIMEOUT },
-	{ AD7150_CH2_DATA_HIGH, AD7150_CH2_AVG_HIGH,
-	  AD7150_CH2_SETUP, AD7150_CH2_THR_HOLD_H,
-	  AD7150_CH2_SENSITIVITY, AD7150_CH2_TIMEOUT },
-};
-
-static int ad7150_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val,
-			   int *val2,
-			   long mask)
-{
-	int ret;
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-
-	switch (mask) {
-	case 0:
-		ret = i2c_smbus_read_word_data(chip->client,
-					ad7150_addresses[chan->channel][0]);
-		if (ret < 0)
-			return ret;
-		*val = swab16(ret);
-		return IIO_VAL_INT;
-	case (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE):
-		ret = i2c_smbus_read_word_data(chip->client,
-					ad7150_addresses[chan->channel][1]);
-		if (ret < 0)
-			return ret;
-		*val = swab16(ret);
-		return IIO_VAL_INT;
-	default:
-		return -EINVAL;
-	}
-}
-
-static int ad7150_read_event_config(struct iio_dev *indio_dev, u64 event_code)
-{
-	int ret;
-	u8 threshtype;
-	bool adaptive;
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
-
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
-	if (ret < 0)
-		return ret;
-
-	threshtype = (ret >> 5) & 0x03;
-	adaptive = !!(ret & 0x80);
-
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		if (rising)
-			return adaptive && (threshtype == 0x1);
-		else
-			return adaptive && (threshtype == 0x0);
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		if (rising)
-			return adaptive && (threshtype == 0x3);
-		else
-			return adaptive && (threshtype == 0x2);
-
-	case IIO_EV_TYPE_THRESH:
-		if (rising)
-			return !adaptive && (threshtype == 0x1);
-		else
-			return !adaptive && (threshtype == 0x0);
-	};
-	return -EINVAL;
-}
-
-/* lock should be held */
-static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
-{
-	int ret;
-	u16 value;
-	u8 sens, timeout;
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
-
-	if (event_code != chip->current_event)
-		return 0;
-
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
-		/* Note completely different from the adaptive versions */
-	case IIO_EV_TYPE_THRESH:
-		value = chip->threshold[rising][chan];
-		ret = i2c_smbus_write_word_data(chip->client,
-						ad7150_addresses[chan][3],
-						swab16(value));
-		if (ret < 0)
-			return ret;
-		return 0;
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		sens = chip->mag_sensitivity[rising][chan];
-		timeout = chip->mag_timeout[rising][chan];
-		break;
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		sens = chip->thresh_sensitivity[rising][chan];
-		timeout = chip->thresh_timeout[rising][chan];
-		break;
-	default:
-		return -EINVAL;
-	};
-	ret = i2c_smbus_write_byte_data(chip->client,
-					ad7150_addresses[chan][4],
-					sens);
-	if (ret < 0)
-		return ret;
-
-	ret = i2c_smbus_write_byte_data(chip->client,
-					ad7150_addresses[chan][5],
-					timeout);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
-static int ad7150_write_event_config(struct iio_dev *indio_dev,
-				     u64 event_code, int state)
-{
-	u8 thresh_type, cfg, adaptive;
-	int ret;
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
-
-	/* Something must always be turned on */
-	if (state == 0)
-		return -EINVAL;
-
-	if (event_code == chip->current_event)
-		return 0;
-	mutex_lock(&chip->state_lock);
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
-	if (ret < 0)
-		goto error_ret;
-
-	cfg = ret & ~((0x03 << 5) | (0x1 << 7));
-
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		adaptive = 1;
-		if (rising)
-			thresh_type = 0x1;
-		else
-			thresh_type = 0x0;
-		break;
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		adaptive = 1;
-		if (rising)
-			thresh_type = 0x3;
-		else
-			thresh_type = 0x2;
-		break;
-	case IIO_EV_TYPE_THRESH:
-		adaptive = 0;
-		if (rising)
-			thresh_type = 0x1;
-		else
-			thresh_type = 0x0;
-		break;
-	default:
-		ret = -EINVAL;
-		goto error_ret;
-	};
-
-	cfg |= (!adaptive << 7) | (thresh_type << 5);
-
-	ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
-	if (ret < 0)
-		goto error_ret;
-
-	chip->current_event = event_code;
-
-	/* update control attributes */
-	ret = ad7150_write_event_params(indio_dev, event_code);
-error_ret:
-	mutex_unlock(&chip->state_lock);
-
-	return 0;
-}
-
-static int ad7150_read_event_value(struct iio_dev *indio_dev,
-				   u64 event_code,
-				   int *val)
-{
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
-
-	/* Complex register sharing going on here */
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		*val = chip->mag_sensitivity[rising][chan];
-		return 0;
-
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		*val = chip->thresh_sensitivity[rising][chan];
-		return 0;
-
-	case IIO_EV_TYPE_THRESH:
-		*val = chip->threshold[rising][chan];
-		return 0;
-
-	default:
-		return -EINVAL;
-	};
-}
-
-static int ad7150_write_event_value(struct iio_dev *indio_dev,
-				   u64 event_code,
-				   int val)
-{
-	int ret;
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			IIO_EV_DIR_RISING);
-
-	mutex_lock(&chip->state_lock);
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		chip->mag_sensitivity[rising][chan] = val;
-		break;
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		chip->thresh_sensitivity[rising][chan] = val;
-		break;
-	case IIO_EV_TYPE_THRESH:
-		chip->threshold[rising][chan] = val;
-		break;
-	default:
-		ret = -EINVAL;
-		goto error_ret;
-	};
-
-	/* write back if active */
-	ret = ad7150_write_event_params(indio_dev, event_code);
-
-error_ret:
-	mutex_unlock(&chip->state_lock);
-	return ret;
-}
-
-static ssize_t ad7150_show_timeout(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	u8 value;
-
-	/* use the event code for consistency reasons */
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
-			== IIO_EV_DIR_RISING);
-
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		value = chip->mag_timeout[rising][chan];
-		break;
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		value = chip->thresh_timeout[rising][chan];
-		break;
-	default:
-		return -EINVAL;
-	};
-
-	return sprintf(buf, "%d\n", value);
-}
-
-static ssize_t ad7150_store_timeout(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
-	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address) ==
-			IIO_EV_DIR_RISING);
-	u8 data;
-	int ret;
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
-
-	mutex_lock(&chip->state_lock);
-	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
-	case IIO_EV_TYPE_MAG_ADAPTIVE:
-		chip->mag_timeout[rising][chan] = data;
-		break;
-	case IIO_EV_TYPE_THRESH_ADAPTIVE:
-		chip->thresh_timeout[rising][chan] = data;
-		break;
-	default:
-		ret = -EINVAL;
-		goto error_ret;
-	};
-
-	ret = ad7150_write_event_params(indio_dev, this_attr->address);
-error_ret:
-	mutex_unlock(&chip->state_lock);
-
-	if (ret < 0)
-		return ret;
-
-	return len;
-}
-
-#define AD7150_TIMEOUT(chan, type, dir, ev_type, ev_dir)		\
-	IIO_DEVICE_ATTR(in_capacitance##chan##_##type##_##dir##_timeout, \
-		S_IRUGO | S_IWUSR,					\
-		&ad7150_show_timeout,					\
-		&ad7150_store_timeout,					\
-		IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,			\
-				     chan,				\
-				     IIO_EV_TYPE_##ev_type,		\
-				     IIO_EV_DIR_##ev_dir))
-static AD7150_TIMEOUT(0, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(0, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
-static AD7150_TIMEOUT(1, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(1, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
-static AD7150_TIMEOUT(0, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(0, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
-static AD7150_TIMEOUT(1, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
-static AD7150_TIMEOUT(1, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
-
-static const struct iio_chan_spec ad7150_channels[] = {
-	{
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
-		.event_mask =
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
-	}, {
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
-		.event_mask =
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
-		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
-	},
-};
-
-/*
- * threshold events
- */
-
-static irqreturn_t ad7150_event_handler(int irq, void *private)
-{
-	struct iio_dev *indio_dev = private;
-	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	u8 int_status;
-	s64 timestamp = iio_get_time_ns();
-	int ret;
-
-	ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
-	if (ret < 0)
-		return IRQ_HANDLED;
-
-	int_status = ret;
-
-	if ((int_status & AD7150_STATUS_OUT1) &&
-	    !(chip->old_state & AD7150_STATUS_OUT1))
-		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-						    0,
-						    IIO_EV_TYPE_THRESH,
-						    IIO_EV_DIR_RISING),
-				timestamp);
-	else if ((!(int_status & AD7150_STATUS_OUT1)) &&
-		 (chip->old_state & AD7150_STATUS_OUT1))
-		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-						    0,
-						    IIO_EV_TYPE_THRESH,
-						    IIO_EV_DIR_FALLING),
-			       timestamp);
-
-	if ((int_status & AD7150_STATUS_OUT2) &&
-	    !(chip->old_state & AD7150_STATUS_OUT2))
-		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-						    1,
-						    IIO_EV_TYPE_THRESH,
-						    IIO_EV_DIR_RISING),
-			       timestamp);
-	else if ((!(int_status & AD7150_STATUS_OUT2)) &&
-		 (chip->old_state & AD7150_STATUS_OUT2))
-		iio_push_event(indio_dev,
-			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
-						    1,
-						    IIO_EV_TYPE_THRESH,
-						    IIO_EV_DIR_FALLING),
-			       timestamp);
-	/* store the status to avoid repushing same events */
-	chip->old_state = int_status;
-
-	return IRQ_HANDLED;
-}
-
-/* Timeouts not currently handled by core */
-static struct attribute *ad7150_event_attributes[] = {
-	&iio_dev_attr_in_capacitance0_mag_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_mag_adaptive_falling_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_mag_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_mag_adaptive_falling_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_thresh_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_thresh_adaptive_falling_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_thresh_adaptive_rising_timeout
-	.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_thresh_adaptive_falling_timeout
-	.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group ad7150_event_attribute_group = {
-	.attrs = ad7150_event_attributes,
-	.name = "events",
-};
-
-static const struct iio_info ad7150_info = {
-	.event_attrs = &ad7150_event_attribute_group,
-	.driver_module = THIS_MODULE,
-	.read_raw = &ad7150_read_raw,
-	.read_event_config = &ad7150_read_event_config,
-	.write_event_config = &ad7150_write_event_config,
-	.read_event_value = &ad7150_read_event_value,
-	.write_event_value = &ad7150_write_event_value,
-};
-
-/*
- * device probe and remove
- */
-
-static int __devinit ad7150_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
-{
-	int ret;
-	struct ad7150_chip_info *chip;
-	struct iio_dev *indio_dev;
-
-	indio_dev = iio_allocate_device(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	chip = iio_priv(indio_dev);
-	mutex_init(&chip->state_lock);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
-
-	chip->client = client;
-
-	indio_dev->name = id->name;
-	indio_dev->channels = ad7150_channels;
-	indio_dev->num_channels = ARRAY_SIZE(ad7150_channels);
-	/* Establish that the iio_dev is a child of the i2c device */
-	indio_dev->dev.parent = &client->dev;
-
-	indio_dev->info = &ad7150_info;
-
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	if (client->irq) {
-		ret = request_threaded_irq(client->irq,
-					   NULL,
-					   &ad7150_event_handler,
-					   IRQF_TRIGGER_RISING |
-					   IRQF_TRIGGER_FALLING,
-					   "ad7150_irq1",
-					   indio_dev);
-		if (ret)
-			goto error_free_dev;
-	}
-
-	if (client->dev.platform_data) {
-		ret = request_threaded_irq(*(unsigned int *)
-					   client->dev.platform_data,
-					   NULL,
-					   &ad7150_event_handler,
-					   IRQF_TRIGGER_RISING |
-					   IRQF_TRIGGER_FALLING,
-					   "ad7150_irq2",
-					   indio_dev);
-		if (ret)
-			goto error_free_irq;
-	}
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_irq2;
-
-	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
-		 id->name, client->irq);
-
-	return 0;
-error_free_irq2:
-	if (client->dev.platform_data)
-		free_irq(*(unsigned int *)client->dev.platform_data,
-			 indio_dev);
-error_free_irq:
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-error_free_dev:
-	iio_free_device(indio_dev);
-error_ret:
-	return ret;
-}
-
-static int __devexit ad7150_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	if (client->irq)
-		free_irq(client->irq, indio_dev);
-
-	if (client->dev.platform_data)
-		free_irq(*(unsigned int *)client->dev.platform_data, indio_dev);
-
-	iio_free_device(indio_dev);
-
-	return 0;
-}
-
-static const struct i2c_device_id ad7150_id[] = {
-	{ "ad7150", 0 },
-	{ "ad7151", 0 },
-	{ "ad7156", 0 },
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, ad7150_id);
-
-static struct i2c_driver ad7150_driver = {
-	.driver = {
-		.name = "ad7150",
-	},
-	.probe = ad7150_probe,
-	.remove = __devexit_p(ad7150_remove),
-	.id_table = ad7150_id,
-};
-
-static __init int ad7150_init(void)
-{
-	return i2c_add_driver(&ad7150_driver);
-}
-
-static __exit void ad7150_exit(void)
-{
-	i2c_del_driver(&ad7150_driver);
-}
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices AD7150/1/6 capacitive sensor driver");
-MODULE_LICENSE("GPL v2");
-
-module_init(ad7150_init);
-module_exit(ad7150_exit);
diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
deleted file mode 100644
index 662584d..0000000
--- a/drivers/staging/iio/adc/ad7152.c
+++ /dev/null
@@ -1,559 +0,0 @@
-/*
- * AD7152 capacitive sensor driver supporting AD7152/3
- *
- * Copyright 2010-2011a Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/i2c.h>
-#include <linux/module.h>
-#include <linux/delay.h>
-
-#include "../iio.h"
-#include "../sysfs.h"
-
-/*
- * TODO: Check compliance of calibbias with abi (units)
- */
-/*
- * AD7152 registers definition
- */
-
-#define AD7152_REG_STATUS		0
-#define AD7152_REG_CH1_DATA_HIGH	1
-#define AD7152_REG_CH2_DATA_HIGH	3
-#define AD7152_REG_CH1_OFFS_HIGH	5
-#define AD7152_REG_CH2_OFFS_HIGH	7
-#define AD7152_REG_CH1_GAIN_HIGH	9
-#define AD7152_REG_CH1_SETUP		11
-#define AD7152_REG_CH2_GAIN_HIGH	12
-#define AD7152_REG_CH2_SETUP		14
-#define AD7152_REG_CFG			15
-#define AD7152_REG_RESEVERD		16
-#define AD7152_REG_CAPDAC_POS		17
-#define AD7152_REG_CAPDAC_NEG		18
-#define AD7152_REG_CFG2			26
-
-/* Status Register Bit Designations (AD7152_REG_STATUS) */
-#define AD7152_STATUS_RDY1		(1 << 0)
-#define AD7152_STATUS_RDY2		(1 << 1)
-#define AD7152_STATUS_C1C2		(1 << 2)
-#define AD7152_STATUS_PWDN		(1 << 7)
-
-/* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
-#define AD7152_SETUP_CAPDIFF		(1 << 5)
-#define AD7152_SETUP_RANGE_2pF		(0 << 6)
-#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
-#define AD7152_SETUP_RANGE_1pF		(2 << 6)
-#define AD7152_SETUP_RANGE_4pF		(3 << 6)
-#define AD7152_SETUP_RANGE(x)		((x) << 6)
-
-/* Config Register Bit Designations (AD7152_REG_CFG) */
-#define AD7152_CONF_CH2EN		(1 << 3)
-#define AD7152_CONF_CH1EN		(1 << 4)
-#define AD7152_CONF_MODE_IDLE		(0 << 0)
-#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
-#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
-#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
-#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
-
-/* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
-#define AD7152_CAPDAC_DACEN		(1 << 7)
-#define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
-
-/* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
-#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
-
-enum {
-	AD7152_DATA,
-	AD7152_OFFS,
-	AD7152_GAIN,
-	AD7152_SETUP
-};
-
-/*
- * struct ad7152_chip_info - chip specifc information
- */
-
-struct ad7152_chip_info {
-	struct i2c_client *client;
-	/*
-	 * Capacitive channel digital filter setup;
-	 * conversion time/update rate setup per channel
-	 */
-	u8	filter_rate_setup;
-	u8	setup[2];
-};
-
-static inline ssize_t ad7152_start_calib(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len,
-					 u8 regval)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	bool doit;
-	int ret, timeout = 10;
-
-	ret = strtobool(buf, &doit);
-	if (ret < 0)
-		return ret;
-
-	if (!doit)
-		return 0;
-
-	if (this_attr->address == 0)
-		regval |= AD7152_CONF_CH1EN;
-	else
-		regval |= AD7152_CONF_CH2EN;
-
-	mutex_lock(&indio_dev->mlock);
-	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
-	if (ret < 0) {
-		mutex_unlock(&indio_dev->mlock);
-		return ret;
-	}
-
-	do {
-		mdelay(20);
-		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
-		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
-			return ret;
-		}
-	} while ((ret == regval) && timeout--);
-
-	mutex_unlock(&indio_dev->mlock);
-	return len;
-}
-static ssize_t ad7152_start_offset_calib(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len)
-{
-	return ad7152_start_calib(dev, attr, buf, len,
-				  AD7152_CONF_MODE_OFFS_CAL);
-}
-static ssize_t ad7152_start_gain_calib(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t len)
-{
-	return ad7152_start_calib(dev, attr, buf, len,
-				  AD7152_CONF_MODE_GAIN_CAL);
-}
-
-static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
-		       S_IWUSR, NULL, ad7152_start_offset_calib, 0);
-static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
-		       S_IWUSR, NULL, ad7152_start_offset_calib, 1);
-static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
-		       S_IWUSR, NULL, ad7152_start_gain_calib, 0);
-static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
-		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
-
-/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
-static const unsigned char ad7152_filter_rate_table[][2] = {
-	{200, 5 + 1}, {50, 20 + 1}, {20, 50 + 1}, {17, 60 + 1},
-};
-
-static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n",
-		       ad7152_filter_rate_table[chip->filter_rate_setup][0]);
-}
-
-static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	u8 data;
-	int ret, i;
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
-
-	for (i = 0; i < ARRAY_SIZE(ad7152_filter_rate_table); i++)
-		if (data >= ad7152_filter_rate_table[i][0])
-			break;
-
-	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
-		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
-
-	mutex_lock(&indio_dev->mlock);
-	ret = i2c_smbus_write_byte_data(chip->client,
-			AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
-	if (ret < 0) {
-		mutex_unlock(&indio_dev->mlock);
-		return ret;
-	}
-
-	chip->filter_rate_setup = i;
-	mutex_unlock(&indio_dev->mlock);
-
-	return len;
-}
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
-		ad7152_show_filter_rate_setup,
-		ad7152_store_filter_rate_setup);
-
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("200 50 20 17");
-
-static IIO_CONST_ATTR(in_capacitance_scale_available,
-		      "0.000061050 0.000030525 0.000015263 0.000007631");
-
-static struct attribute *ad7152_attributes[] = {
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
-	&iio_const_attr_in_capacitance_scale_available.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7152_attribute_group = {
-	.attrs = ad7152_attributes,
-};
-
-static const u8 ad7152_addresses[][4] = {
-	{ AD7152_REG_CH1_DATA_HIGH, AD7152_REG_CH1_OFFS_HIGH,
-	  AD7152_REG_CH1_GAIN_HIGH, AD7152_REG_CH1_SETUP },
-	{ AD7152_REG_CH2_DATA_HIGH, AD7152_REG_CH2_OFFS_HIGH,
-	  AD7152_REG_CH2_GAIN_HIGH, AD7152_REG_CH2_SETUP },
-};
-
-/* Values are nano relative to pf base. */
-static const int ad7152_scale_table[] = {
-	30525, 7631, 15263, 61050
-};
-
-static int ad7152_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long mask)
-{
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	int ret, i;
-
-	mutex_lock(&indio_dev->mlock);
-
-	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
-		if (val != 1) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		val = (val2 * 1024) / 15625;
-
-		ret = i2c_smbus_write_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_GAIN],
-				swab16(val));
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
-		if ((val < 0) | (val > 0xFFFF)) {
-			ret = -EINVAL;
-			goto out;
-		}
-		ret = i2c_smbus_write_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_OFFS],
-				swab16(val));
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-		if (val != 0) {
-			ret = -EINVAL;
-			goto out;
-		}
-		for (i = 0; i < ARRAY_SIZE(ad7152_scale_table); i++)
-			if (val2 == ad7152_scale_table[i])
-				break;
-
-		chip->setup[chan->channel] &= ~AD7152_SETUP_RANGE_4pF;
-		chip->setup[chan->channel] |= AD7152_SETUP_RANGE(i);
-
-		ret = i2c_smbus_write_byte_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_SETUP],
-				chip->setup[chan->channel]);
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-out:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-static int ad7152_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2,
-			   long mask)
-{
-	struct ad7152_chip_info *chip = iio_priv(indio_dev);
-	int ret;
-	u8 regval = 0;
-
-	mutex_lock(&indio_dev->mlock);
-
-	switch (mask) {
-	case 0:
-		/* First set whether in differential mode */
-
-		regval = chip->setup[chan->channel];
-
-		if (chan->differential)
-			chip->setup[chan->channel] |= AD7152_SETUP_CAPDIFF;
-		else
-			chip->setup[chan->channel] &= ~AD7152_SETUP_CAPDIFF;
-
-		if (regval != chip->setup[chan->channel]) {
-			ret = i2c_smbus_write_byte_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_SETUP],
-				chip->setup[chan->channel]);
-			if (ret < 0)
-				goto out;
-		}
-		/* Make sure the channel is enabled */
-		if (chan->channel == 0)
-			regval = AD7152_CONF_CH1EN;
-		else
-			regval = AD7152_CONF_CH2EN;
-
-		/* Trigger a single read */
-		regval |= AD7152_CONF_MODE_SINGLE_CONV;
-		ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG,
-				regval);
-		if (ret < 0)
-			goto out;
-
-		msleep(ad7152_filter_rate_table[chip->filter_rate_setup][1]);
-		/* Now read the actual register */
-		ret = i2c_smbus_read_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_DATA]);
-		if (ret < 0)
-			goto out;
-		*val = swab16(ret);
-
-		if (chan->differential)
-			*val -= 0x8000;
-
-		ret = IIO_VAL_INT;
-		break;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
-
-		ret = i2c_smbus_read_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_GAIN]);
-		if (ret < 0)
-			goto out;
-		/* 1 + gain_val / 2^16 */
-		*val = 1;
-		*val2 = (15625 * swab16(ret)) / 1024;
-
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
-		ret = i2c_smbus_read_word_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_OFFS]);
-		if (ret < 0)
-			goto out;
-		*val = swab16(ret);
-
-		ret = IIO_VAL_INT;
-		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-		ret = i2c_smbus_read_byte_data(chip->client,
-				ad7152_addresses[chan->channel][AD7152_SETUP]);
-		if (ret < 0)
-			goto out;
-		*val = 0;
-		*val2 = ad7152_scale_table[ret >> 6];
-
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
-	default:
-		ret = -EINVAL;
-	};
-out:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       long mask)
-{
-	switch (mask) {
-	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
-		return IIO_VAL_INT_PLUS_NANO;
-	default:
-		return IIO_VAL_INT_PLUS_MICRO;
-	}
-}
-
-static const struct iio_info ad7152_info = {
-	.attrs = &ad7152_attribute_group,
-	.read_raw = &ad7152_read_raw,
-	.write_raw = &ad7152_write_raw,
-	.write_raw_get_fmt = &ad7152_write_raw_get_fmt,
-	.driver_module = THIS_MODULE,
-};
-
-static const struct iio_chan_spec ad7152_channels[] = {
-	{
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.differential = 1,
-		.indexed = 1,
-		.channel = 0,
-		.channel2 = 2,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.differential = 1,
-		.indexed = 1,
-		.channel = 1,
-		.channel2 = 3,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
-	}
-};
-/*
- * device probe and remove
- */
-
-static int __devinit ad7152_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
-{
-	int ret = 0;
-	struct ad7152_chip_info *chip;
-	struct iio_dev *indio_dev;
-
-	indio_dev = iio_allocate_device(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	chip = iio_priv(indio_dev);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
-
-	chip->client = client;
-
-	/* Establish that the iio_dev is a child of the i2c device */
-	indio_dev->name = id->name;
-	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ad7152_info;
-	indio_dev->channels = ad7152_channels;
-	if (id->driver_data == 0)
-		indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
-	else
-		indio_dev->num_channels = 2;
-	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
-	dev_err(&client->dev, "%s capacitive sensor registered\n", id->name);
-
-	return 0;
-
-error_free_dev:
-	iio_free_device(indio_dev);
-error_ret:
-	return ret;
-}
-
-static int __devexit ad7152_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
-
-	return 0;
-}
-
-static const struct i2c_device_id ad7152_id[] = {
-	{ "ad7152", 0 },
-	{ "ad7153", 1 },
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, ad7152_id);
-
-static struct i2c_driver ad7152_driver = {
-	.driver = {
-		.name = KBUILD_MODNAME,
-	},
-	.probe = ad7152_probe,
-	.remove = __devexit_p(ad7152_remove),
-	.id_table = ad7152_id,
-};
-
-static __init int ad7152_init(void)
-{
-	return i2c_add_driver(&ad7152_driver);
-}
-
-static __exit void ad7152_exit(void)
-{
-	i2c_del_driver(&ad7152_driver);
-}
-
-MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
-MODULE_DESCRIPTION("Analog Devices AD7152/3 capacitive sensor driver");
-MODULE_LICENSE("GPL v2");
-
-module_init(ad7152_init);
-module_exit(ad7152_exit);
diff --git a/drivers/staging/iio/adc/ad7746.c b/drivers/staging/iio/adc/ad7746.c
deleted file mode 100644
index 2867943..0000000
--- a/drivers/staging/iio/adc/ad7746.c
+++ /dev/null
@@ -1,807 +0,0 @@
-/*
- * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#include <linux/interrupt.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/i2c.h>
-#include <linux/delay.h>
-#include <linux/module.h>
-#include <linux/stat.h>
-
-#include "../iio.h"
-#include "../sysfs.h"
-
-#include "ad7746.h"
-
-/*
- * AD7746 Register Definition
- */
-
-#define AD7746_REG_STATUS		0
-#define AD7746_REG_CAP_DATA_HIGH	1
-#define AD7746_REG_CAP_DATA_MID		2
-#define AD7746_REG_CAP_DATA_LOW		3
-#define AD7746_REG_VT_DATA_HIGH		4
-#define AD7746_REG_VT_DATA_MID		5
-#define AD7746_REG_VT_DATA_LOW		6
-#define AD7746_REG_CAP_SETUP		7
-#define AD7746_REG_VT_SETUP		8
-#define AD7746_REG_EXC_SETUP		9
-#define AD7746_REG_CFG			10
-#define AD7746_REG_CAPDACA		11
-#define AD7746_REG_CAPDACB		12
-#define AD7746_REG_CAP_OFFH		13
-#define AD7746_REG_CAP_OFFL		14
-#define AD7746_REG_CAP_GAINH		15
-#define AD7746_REG_CAP_GAINL		16
-#define AD7746_REG_VOLT_GAINH		17
-#define AD7746_REG_VOLT_GAINL		18
-
-/* Status Register Bit Designations (AD7746_REG_STATUS) */
-#define AD7746_STATUS_EXCERR		(1 << 3)
-#define AD7746_STATUS_RDY		(1 << 2)
-#define AD7746_STATUS_RDYVT		(1 << 1)
-#define AD7746_STATUS_RDYCAP		(1 << 0)
-
-/* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
-#define AD7746_CAPSETUP_CAPEN		(1 << 7)
-#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
-#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
-#define AD7746_CAPSETUP_CACHOP		(1 << 0)
-
-/* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
-#define AD7746_VTSETUP_VTEN		(1 << 7)
-#define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
-#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
-#define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
-#define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
-#define AD7746_VTSETUP_EXTREF		(1 << 4)
-#define AD7746_VTSETUP_VTSHORT		(1 << 1)
-#define AD7746_VTSETUP_VTCHOP		(1 << 0)
-
-/* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
-#define AD7746_EXCSETUP_CLKCTRL		(1 << 7)
-#define AD7746_EXCSETUP_EXCON		(1 << 6)
-#define AD7746_EXCSETUP_EXCB		(1 << 5)
-#define AD7746_EXCSETUP_NEXCB		(1 << 4)
-#define AD7746_EXCSETUP_EXCA		(1 << 3)
-#define AD7746_EXCSETUP_NEXCA		(1 << 2)
-#define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
-
-/* Config Register Bit Designations (AD7746_REG_CFG) */
-#define AD7746_CONF_VTFS(x)		((x) << 6)
-#define AD7746_CONF_CAPFS(x)		((x) << 3)
-#define AD7746_CONF_MODE_IDLE		(0 << 0)
-#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
-#define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
-#define AD7746_CONF_MODE_PWRDN		(3 << 0)
-#define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
-#define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
-
-/* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
-#define AD7746_CAPDAC_DACEN		(1 << 7)
-#define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
-
-/*
- * struct ad7746_chip_info - chip specifc information
- */
-
-struct ad7746_chip_info {
-	struct i2c_client *client;
-	/*
-	 * Capacitive channel digital filter setup;
-	 * conversion time/update rate setup per channel
-	 */
-	u8	config;
-	u8	cap_setup;
-	u8	vt_setup;
-	u8	capdac[2][2];
-	s8	capdac_set;
-};
-
-enum ad7746_chan {
-	VIN,
-	VIN_VDD,
-	TEMP_INT,
-	TEMP_EXT,
-	CIN1,
-	CIN1_DIFF,
-	CIN2,
-	CIN2_DIFF,
-};
-
-static const struct iio_chan_spec ad7746_channels[] = {
-	[VIN] = {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_EXT_VIN,
-	},
-	[VIN_VDD] = {
-		.type = IIO_VOLTAGE,
-		.indexed = 1,
-		.channel = 1,
-		.extend_name = "supply",
-		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_VDD_MON,
-	},
-	[TEMP_INT] = {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 0,
-		.processed_val = IIO_PROCESSED,
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_INT_TEMP,
-	},
-	[TEMP_EXT] = {
-		.type = IIO_TEMP,
-		.indexed = 1,
-		.channel = 1,
-		.processed_val = IIO_PROCESSED,
-		.address = AD7746_REG_VT_DATA_HIGH << 8 |
-			AD7746_VTSETUP_VTMD_EXT_TEMP,
-	},
-	[CIN1] = {
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8,
-	},
-	[CIN1_DIFF] = {
-		.type = IIO_CAPACITANCE,
-		.differential = 1,
-		.indexed = 1,
-		.channel = 0,
-		.channel2 = 2,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
-			AD7746_CAPSETUP_CAPDIFF
-	},
-	[CIN2] = {
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
-			AD7746_CAPSETUP_CIN2,
-	},
-	[CIN2_DIFF] = {
-		.type = IIO_CAPACITANCE,
-		.differential = 1,
-		.indexed = 1,
-		.channel = 1,
-		.channel2 = 3,
-		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
-		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
-		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
-		(1 << IIO_CHAN_INFO_SCALE_SHARED),
-		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
-			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
-	}
-};
-
-/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
-static const unsigned char ad7746_vt_filter_rate_table[][2] = {
-	{50, 20 + 1}, {31, 32 + 1}, {16, 62 + 1}, {8, 122 + 1},
-};
-
-static const unsigned char ad7746_cap_filter_rate_table[][2] = {
-	{91, 11 + 1}, {84, 12 + 1}, {50, 20 + 1}, {26, 38 + 1},
-	{16, 62 + 1}, {13, 77 + 1}, {11, 92 + 1}, {9, 110 + 1},
-};
-
-static int ad7746_select_channel(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan)
-{
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	int ret, delay;
-	u8 vt_setup, cap_setup;
-
-	switch (chan->type) {
-	case IIO_CAPACITANCE:
-		cap_setup = (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
-		vt_setup = chip->vt_setup & ~AD7746_VTSETUP_VTEN;
-		delay = ad7746_cap_filter_rate_table[(chip->config >> 3) &
-			0x7][1];
-
-		if (chip->capdac_set != chan->channel) {
-			ret = i2c_smbus_write_byte_data(chip->client,
-				AD7746_REG_CAPDACA,
-				chip->capdac[chan->channel][0]);
-			if (ret < 0)
-				return ret;
-			ret = i2c_smbus_write_byte_data(chip->client,
-				AD7746_REG_CAPDACB,
-				chip->capdac[chan->channel][1]);
-			if (ret < 0)
-				return ret;
-
-			chip->capdac_set = chan->channel;
-		}
-		break;
-	case IIO_VOLTAGE:
-	case IIO_TEMP:
-		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
-		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
-		delay = ad7746_cap_filter_rate_table[(chip->config >> 6) &
-			0x3][1];
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (chip->cap_setup != cap_setup) {
-		ret = i2c_smbus_write_byte_data(chip->client,
-						AD7746_REG_CAP_SETUP,
-						cap_setup);
-		if (ret < 0)
-			return ret;
-
-		chip->cap_setup = cap_setup;
-	}
-
-	if (chip->vt_setup != vt_setup) {
-		ret = i2c_smbus_write_byte_data(chip->client,
-						AD7746_REG_VT_SETUP,
-						vt_setup);
-		if (ret < 0)
-			return ret;
-
-		chip->vt_setup = vt_setup;
-	}
-
-	return delay;
-}
-
-static inline ssize_t ad7746_start_calib(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len,
-					 u8 regval)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	bool doit;
-	int ret, timeout = 10;
-
-	ret = strtobool(buf, &doit);
-	if (ret < 0)
-		return ret;
-
-	if (!doit)
-		return 0;
-
-	mutex_lock(&indio_dev->mlock);
-	regval |= chip->config;
-	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
-	if (ret < 0) {
-		mutex_unlock(&indio_dev->mlock);
-		return ret;
-	}
-
-	do {
-		msleep(20);
-		ret = i2c_smbus_read_byte_data(chip->client, AD7746_REG_CFG);
-		if (ret < 0) {
-			mutex_unlock(&indio_dev->mlock);
-			return ret;
-		}
-	} while ((ret == regval) && timeout--);
-
-	mutex_unlock(&indio_dev->mlock);
-
-	return len;
-}
-
-static ssize_t ad7746_start_offset_calib(struct device *dev,
-					 struct device_attribute *attr,
-					 const char *buf,
-					 size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	int ret = ad7746_select_channel(indio_dev,
-			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
-	if (ret < 0)
-		return ret;
-
-	return ad7746_start_calib(dev, attr, buf, len,
-				  AD7746_CONF_MODE_OFFS_CAL);
-}
-
-static ssize_t ad7746_start_gain_calib(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf,
-				       size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	int ret = ad7746_select_channel(indio_dev,
-			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
-	if (ret < 0)
-		return ret;
-
-	return ad7746_start_calib(dev, attr, buf, len,
-				  AD7746_CONF_MODE_GAIN_CAL);
-}
-
-static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
-		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN1);
-static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
-		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN2);
-static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
-		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN1);
-static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
-		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN2);
-static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
-		       S_IWUSR, NULL, ad7746_start_gain_calib, VIN);
-
-static ssize_t ad7746_show_cap_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", ad7746_cap_filter_rate_table[
-			(chip->config >> 3) & 0x7][0]);
-}
-
-static ssize_t ad7746_store_cap_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	u8 data;
-	int ret, i;
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
-
-	for (i = 0; i < ARRAY_SIZE(ad7746_cap_filter_rate_table); i++)
-		if (data >= ad7746_cap_filter_rate_table[i][0])
-			break;
-
-	if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
-		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
-
-	mutex_lock(&indio_dev->mlock);
-	chip->config &= ~AD7746_CONF_CAPFS(0x7);
-	chip->config |= AD7746_CONF_CAPFS(i);
-	mutex_unlock(&indio_dev->mlock);
-
-	return len;
-}
-
-static ssize_t ad7746_show_vt_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-
-	return sprintf(buf, "%d\n", ad7746_vt_filter_rate_table[
-			(chip->config >> 6) & 0x3][0]);
-}
-
-static ssize_t ad7746_store_vt_filter_rate_setup(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	u8 data;
-	int ret, i;
-
-	ret = kstrtou8(buf, 10, &data);
-	if (ret < 0)
-		return ret;
-
-	for (i = 0; i < ARRAY_SIZE(ad7746_vt_filter_rate_table); i++)
-		if (data >= ad7746_vt_filter_rate_table[i][0])
-			break;
-
-	if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
-		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
-
-	mutex_lock(&indio_dev->mlock);
-	chip->config &= ~AD7746_CONF_VTFS(0x3);
-	chip->config |= AD7746_CONF_VTFS(i);
-	mutex_unlock(&indio_dev->mlock);
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(in_capacitance_sampling_frequency,
-		       S_IRUGO | S_IWUSR, ad7746_show_cap_filter_rate_setup,
-			ad7746_store_cap_filter_rate_setup, 0);
-
-static IIO_DEVICE_ATTR(in_voltage_sampling_frequency,
-		       S_IRUGO | S_IWUSR, ad7746_show_vt_filter_rate_setup,
-		       ad7746_store_vt_filter_rate_setup, 0);
-
-static IIO_CONST_ATTR(in_voltage_sampling_frequency_available, "50 31 16 8");
-static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
-		       "91 84 50 26 16 13 11 9");
-
-static struct attribute *ad7746_attributes[] = {
-	&iio_dev_attr_in_capacitance_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_in_voltage_sampling_frequency.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
-	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
-	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
-	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
-	&iio_const_attr_in_capacitance_sampling_frequency_available.
-	dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7746_attribute_group = {
-	.attrs = ad7746_attributes,
-};
-
-static int ad7746_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val,
-			    int val2,
-			    long mask)
-{
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	int ret, reg;
-
-	mutex_lock(&indio_dev->mlock);
-
-	switch (mask) {
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
-		if (val != 1) {
-			ret = -EINVAL;
-			goto out;
-		}
-
-		val = (val2 * 1024) / 15625;
-
-		switch (chan->type) {
-		case IIO_CAPACITANCE:
-			reg = AD7746_REG_CAP_GAINH;
-			break;
-		case IIO_VOLTAGE:
-			reg = AD7746_REG_VOLT_GAINH;
-			break;
-		default:
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ret = i2c_smbus_write_word_data(chip->client, reg, swab16(val));
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SHARED):
-		if ((val < 0) | (val > 0xFFFF)) {
-			ret = -EINVAL;
-			goto out;
-		}
-		ret = i2c_smbus_write_word_data(chip->client,
-				AD7746_REG_CAP_OFFH, swab16(val));
-		if (ret < 0)
-			goto out;
-
-		ret = 0;
-		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
-		if ((val < 0) | (val > 43008000)) { /* 21pF */
-			ret = -EINVAL;
-			goto out;
-		}
-
-		/* CAPDAC Scale = 21pF_typ / 127
-		 * CIN Scale = 8.192pF / 2^24
-		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
-		 * */
-
-		val /= 338646;
-
-		chip->capdac[chan->channel][chan->differential] = (val > 0 ?
-			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0);
-
-		ret = i2c_smbus_write_byte_data(chip->client,
-			AD7746_REG_CAPDACA,
-			chip->capdac[chan->channel][0]);
-		if (ret < 0)
-			goto out;
-		ret = i2c_smbus_write_byte_data(chip->client,
-			AD7746_REG_CAPDACB,
-			chip->capdac[chan->channel][1]);
-		if (ret < 0)
-			goto out;
-
-		chip->capdac_set = chan->channel;
-
-		ret = 0;
-		break;
-	default:
-		ret = -EINVAL;
-	}
-
-out:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-static int ad7746_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2,
-			   long mask)
-{
-	struct ad7746_chip_info *chip = iio_priv(indio_dev);
-	int ret, delay;
-	u8 regval, reg;
-
-	union {
-		u32 d32;
-		u8 d8[4];
-	} data;
-
-	mutex_lock(&indio_dev->mlock);
-
-	switch (mask) {
-	case 0:
-		ret = ad7746_select_channel(indio_dev, chan);
-		if (ret < 0)
-			goto out;
-		delay = ret;
-
-		regval = chip->config | AD7746_CONF_MODE_SINGLE_CONV;
-		ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG,
-				regval);
-		if (ret < 0)
-			goto out;
-
-		msleep(delay);
-		/* Now read the actual register */
-
-		ret = i2c_smbus_read_i2c_block_data(chip->client,
-			chan->address >> 8, 3, &data.d8[1]);
-
-		if (ret < 0)
-			goto out;
-
-		*val = (be32_to_cpu(data.d32) & 0xFFFFFF) - 0x800000;
-
-		switch (chan->type) {
-		case IIO_TEMP:
-		/* temperature in milli degrees Celsius
-		 * T = ((*val / 2048) - 4096) * 1000
-		 */
-			*val = (*val * 125) / 256;
-			break;
-		case IIO_VOLTAGE:
-			if (chan->channel == 1) /* supply_raw*/
-				*val = *val * 6;
-			break;
-		default:
-			break;
-		}
-
-		ret = IIO_VAL_INT;
-		break;
-	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
-		switch (chan->type) {
-		case IIO_CAPACITANCE:
-			reg = AD7746_REG_CAP_GAINH;
-			break;
-		case IIO_VOLTAGE:
-			reg = AD7746_REG_VOLT_GAINH;
-			break;
-		default:
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ret = i2c_smbus_read_word_data(chip->client, reg);
-		if (ret < 0)
-			goto out;
-		/* 1 + gain_val / 2^16 */
-		*val = 1;
-		*val2 = (15625 * swab16(ret)) / 1024;
-
-		ret = IIO_VAL_INT_PLUS_MICRO;
-		break;
-	case (1 << IIO_CHAN_INFO_CALIBBIAS_SHARED):
-		ret = i2c_smbus_read_word_data(chip->client,
-					       AD7746_REG_CAP_OFFH);
-		if (ret < 0)
-			goto out;
-		*val = swab16(ret);
-
-		ret = IIO_VAL_INT;
-		break;
-	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
-		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
-			[chan->differential]) * 338646;
-
-		ret = IIO_VAL_INT;
-		break;
-	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
-		switch (chan->type) {
-		case IIO_CAPACITANCE:
-			/* 8.192pf / 2^24 */
-			*val2 = 488;
-			*val =  0;
-			break;
-		case IIO_VOLTAGE:
-			/* 1170mV / 2^23 */
-			*val2 = 139475;
-			*val =  0;
-			break;
-		default:
-			ret =  -EINVAL;
-			goto out;
-		}
-
-		ret = IIO_VAL_INT_PLUS_NANO;
-		break;
-	default:
-		ret = -EINVAL;
-	};
-out:
-	mutex_unlock(&indio_dev->mlock);
-	return ret;
-}
-
-static const struct iio_info ad7746_info = {
-	.attrs = &ad7746_attribute_group,
-	.read_raw = &ad7746_read_raw,
-	.write_raw = &ad7746_write_raw,
-	.driver_module = THIS_MODULE,
-};
-
-/*
- * device probe and remove
- */
-
-static int __devinit ad7746_probe(struct i2c_client *client,
-		const struct i2c_device_id *id)
-{
-	struct ad7746_platform_data *pdata = client->dev.platform_data;
-	struct ad7746_chip_info *chip;
-	struct iio_dev *indio_dev;
-	int ret = 0;
-	unsigned char regval = 0;
-
-	indio_dev = iio_allocate_device(sizeof(*chip));
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	chip = iio_priv(indio_dev);
-	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, indio_dev);
-
-	chip->client = client;
-	chip->capdac_set = -1;
-
-	/* Establish that the iio_dev is a child of the i2c device */
-	indio_dev->name = id->name;
-	indio_dev->dev.parent = &client->dev;
-	indio_dev->info = &ad7746_info;
-	indio_dev->channels = ad7746_channels;
-	if (id->driver_data == 7746)
-		indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
-	else
-		indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
-	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
-	indio_dev->modes = INDIO_DIRECT_MODE;
-
-	if (pdata) {
-		if (pdata->exca_en) {
-			if (pdata->exca_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCA;
-			else
-				regval |= AD7746_EXCSETUP_EXCA;
-		}
-
-		if (pdata->excb_en) {
-			if (pdata->excb_inv_en)
-				regval |= AD7746_EXCSETUP_NEXCB;
-			else
-				regval |= AD7746_EXCSETUP_EXCB;
-		}
-
-		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
-	} else {
-		dev_warn(&client->dev, "No platform data? using default\n");
-		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
-			AD7746_EXCSETUP_EXCLVL(3);
-	}
-
-	ret = i2c_smbus_write_byte_data(chip->client,
-					AD7746_REG_EXC_SETUP, regval);
-	if (ret < 0)
-		goto error_free_dev;
-
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_free_dev;
-
-	dev_info(&client->dev, "%s capacitive sensor registered\n", id->name);
-
-	return 0;
-
-error_free_dev:
-	iio_free_device(indio_dev);
-error_ret:
-	return ret;
-}
-
-static int __devexit ad7746_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-
-	iio_device_unregister(indio_dev);
-	iio_free_device(indio_dev);
-
-	return 0;
-}
-
-static const struct i2c_device_id ad7746_id[] = {
-	{ "ad7745", 7745 },
-	{ "ad7746", 7746 },
-	{ "ad7747", 7747 },
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, ad7746_id);
-
-static struct i2c_driver ad7746_driver = {
-	.driver = {
-		.name = KBUILD_MODNAME,
-	},
-	.probe = ad7746_probe,
-	.remove = __devexit_p(ad7746_remove),
-	.id_table = ad7746_id,
-};
-
-static __init int ad7746_init(void)
-{
-	return i2c_add_driver(&ad7746_driver);
-}
-
-static __exit void ad7746_exit(void)
-{
-	i2c_del_driver(&ad7746_driver);
-}
-
-MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
-MODULE_DESCRIPTION("Analog Devices AD7746/5/7 capacitive sensor driver");
-MODULE_LICENSE("GPL v2");
-
-module_init(ad7746_init);
-module_exit(ad7746_exit);
diff --git a/drivers/staging/iio/adc/ad7746.h b/drivers/staging/iio/adc/ad7746.h
deleted file mode 100644
index ea8572d..0000000
--- a/drivers/staging/iio/adc/ad7746.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
- *
- * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-
-#ifndef IIO_CDC_AD7746_H_
-#define IIO_CDC_AD7746_H_
-
-/*
- * TODO: struct ad7746_platform_data needs to go into include/linux/iio
- */
-
-#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
-#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
-#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
-#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
-
-struct ad7746_platform_data {
-	unsigned char exclvl;	/*Excitation Voltage Level */
-	bool exca_en;		/* enables EXCA pin as the excitation output */
-	bool exca_inv_en;	/* enables /EXCA pin as the excitation output */
-	bool excb_en;		/* enables EXCB pin as the excitation output */
-	bool excb_inv_en;	/* enables /EXCB pin as the excitation output */
-};
-
-#endif /* IIO_CDC_AD7746_H_ */
diff --git a/drivers/staging/iio/cdc/Kconfig b/drivers/staging/iio/cdc/Kconfig
new file mode 100644
index 0000000..80211df
--- /dev/null
+++ b/drivers/staging/iio/cdc/Kconfig
@@ -0,0 +1,36 @@
+#
+# CDC drivers
+#
+menu "Capacitance to digital converters"
+
+config AD7150
+	tristate "Analog Devices ad7150/1/6 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (ad7150, ad7151, ad7156) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7150.
+
+config AD7152
+	tristate "Analog Devices ad7152/3 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (ad7152, ad7153) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7152.
+
+config AD7746
+	tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Analog Devices capacitive sensors.
+	  (AD7745, AD7746, AD7747) Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad7746.
+
+endmenu
diff --git a/drivers/staging/iio/cdc/Makefile b/drivers/staging/iio/cdc/Makefile
new file mode 100644
index 0000000..a5fbabf
--- /dev/null
+++ b/drivers/staging/iio/cdc/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for industrial I/O DAC drivers
+#
+
+obj-$(CONFIG_AD7150) += ad7150.o
+obj-$(CONFIG_AD7152) += ad7152.o
+obj-$(CONFIG_AD7746) += ad7746.o
diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
new file mode 100644
index 0000000..e185f0e
--- /dev/null
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -0,0 +1,676 @@
+/*
+ * AD7150 capacitive sensor driver supporting AD7150/1/6
+ *
+ * Copyright 2010-2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+
+/*
+ * AD7150 registers definition
+ */
+
+#define AD7150_STATUS              0
+#define AD7150_STATUS_OUT1         (1 << 3)
+#define AD7150_STATUS_OUT2         (1 << 5)
+#define AD7150_CH1_DATA_HIGH       1
+#define AD7150_CH2_DATA_HIGH       3
+#define AD7150_CH1_AVG_HIGH        5
+#define AD7150_CH2_AVG_HIGH        7
+#define AD7150_CH1_SENSITIVITY     9
+#define AD7150_CH1_THR_HOLD_H      9
+#define AD7150_CH1_TIMEOUT         10
+#define AD7150_CH1_SETUP           11
+#define AD7150_CH2_SENSITIVITY     12
+#define AD7150_CH2_THR_HOLD_H      12
+#define AD7150_CH2_TIMEOUT         13
+#define AD7150_CH2_SETUP           14
+#define AD7150_CFG                 15
+#define AD7150_CFG_FIX             (1 << 7)
+#define AD7150_PD_TIMER            16
+#define AD7150_CH1_CAPDAC          17
+#define AD7150_CH2_CAPDAC          18
+#define AD7150_SN3                 19
+#define AD7150_SN2                 20
+#define AD7150_SN1                 21
+#define AD7150_SN0                 22
+#define AD7150_ID                  23
+
+/**
+ * struct ad7150_chip_info - instance specific chip data
+ * @client: i2c client for this device
+ * @current_event: device always has one type of event enabled.
+ *	This element stores the event code of the current one.
+ * @threshold: thresholds for simple capacitance value events
+ * @thresh_sensitivity: threshold for simple capacitance offset
+ *	from 'average' value.
+ * @mag_sensitity: threshold for magnitude of capacitance offset from
+ *	from 'average' value.
+ * @thresh_timeout: a timeout, in samples from the moment an
+ *	adaptive threshold event occurs to when the average
+ *	value jumps to current value.
+ * @mag_timeout: a timeout, in sample from the moment an
+ *	adaptive magnitude event occurs to when the average
+ *	value jumps to the current value.
+ * @old_state: store state from previous event, allowing confirmation
+ *	of new condition.
+ * @conversion_mode: the current conversion mode.
+ * @state_lock: ensure consistent state of this structure wrt the
+ *	hardware.
+ */
+struct ad7150_chip_info {
+	struct i2c_client *client;
+	u64 current_event;
+	u16 threshold[2][2];
+	u8 thresh_sensitivity[2][2];
+	u8 mag_sensitivity[2][2];
+	u8 thresh_timeout[2][2];
+	u8 mag_timeout[2][2];
+	int old_state;
+	char *conversion_mode;
+	struct mutex state_lock;
+};
+
+/*
+ * sysfs nodes
+ */
+
+static const u8 ad7150_addresses[][6] = {
+	{ AD7150_CH1_DATA_HIGH, AD7150_CH1_AVG_HIGH,
+	  AD7150_CH1_SETUP, AD7150_CH1_THR_HOLD_H,
+	  AD7150_CH1_SENSITIVITY, AD7150_CH1_TIMEOUT },
+	{ AD7150_CH2_DATA_HIGH, AD7150_CH2_AVG_HIGH,
+	  AD7150_CH2_SETUP, AD7150_CH2_THR_HOLD_H,
+	  AD7150_CH2_SENSITIVITY, AD7150_CH2_TIMEOUT },
+};
+
+static int ad7150_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long mask)
+{
+	int ret;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+
+	switch (mask) {
+	case 0:
+		ret = i2c_smbus_read_word_data(chip->client,
+					ad7150_addresses[chan->channel][0]);
+		if (ret < 0)
+			return ret;
+		*val = swab16(ret);
+		return IIO_VAL_INT;
+	case (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE):
+		ret = i2c_smbus_read_word_data(chip->client,
+					ad7150_addresses[chan->channel][1]);
+		if (ret < 0)
+			return ret;
+		*val = swab16(ret);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7150_read_event_config(struct iio_dev *indio_dev, u64 event_code)
+{
+	int ret;
+	u8 threshtype;
+	bool adaptive;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
+
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	if (ret < 0)
+		return ret;
+
+	threshtype = (ret >> 5) & 0x03;
+	adaptive = !!(ret & 0x80);
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		if (rising)
+			return adaptive && (threshtype == 0x1);
+		else
+			return adaptive && (threshtype == 0x0);
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		if (rising)
+			return adaptive && (threshtype == 0x3);
+		else
+			return adaptive && (threshtype == 0x2);
+
+	case IIO_EV_TYPE_THRESH:
+		if (rising)
+			return !adaptive && (threshtype == 0x1);
+		else
+			return !adaptive && (threshtype == 0x0);
+	};
+	return -EINVAL;
+}
+
+/* lock should be held */
+static int ad7150_write_event_params(struct iio_dev *indio_dev, u64 event_code)
+{
+	int ret;
+	u16 value;
+	u8 sens, timeout;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
+
+	if (event_code != chip->current_event)
+		return 0;
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+		/* Note completely different from the adaptive versions */
+	case IIO_EV_TYPE_THRESH:
+		value = chip->threshold[rising][chan];
+		ret = i2c_smbus_write_word_data(chip->client,
+						ad7150_addresses[chan][3],
+						swab16(value));
+		if (ret < 0)
+			return ret;
+		return 0;
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		sens = chip->mag_sensitivity[rising][chan];
+		timeout = chip->mag_timeout[rising][chan];
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		sens = chip->thresh_sensitivity[rising][chan];
+		timeout = chip->thresh_timeout[rising][chan];
+		break;
+	default:
+		return -EINVAL;
+	};
+	ret = i2c_smbus_write_byte_data(chip->client,
+					ad7150_addresses[chan][4],
+					sens);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(chip->client,
+					ad7150_addresses[chan][5],
+					timeout);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int ad7150_write_event_config(struct iio_dev *indio_dev,
+				     u64 event_code, int state)
+{
+	u8 thresh_type, cfg, adaptive;
+	int ret;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
+
+	/* Something must always be turned on */
+	if (state == 0)
+		return -EINVAL;
+
+	if (event_code == chip->current_event)
+		return 0;
+	mutex_lock(&chip->state_lock);
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
+	if (ret < 0)
+		goto error_ret;
+
+	cfg = ret & ~((0x03 << 5) | (0x1 << 7));
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		adaptive = 1;
+		if (rising)
+			thresh_type = 0x1;
+		else
+			thresh_type = 0x0;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		adaptive = 1;
+		if (rising)
+			thresh_type = 0x3;
+		else
+			thresh_type = 0x2;
+		break;
+	case IIO_EV_TYPE_THRESH:
+		adaptive = 0;
+		if (rising)
+			thresh_type = 0x1;
+		else
+			thresh_type = 0x0;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret;
+	};
+
+	cfg |= (!adaptive << 7) | (thresh_type << 5);
+
+	ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
+	if (ret < 0)
+		goto error_ret;
+
+	chip->current_event = event_code;
+
+	/* update control attributes */
+	ret = ad7150_write_event_params(indio_dev, event_code);
+error_ret:
+	mutex_unlock(&chip->state_lock);
+
+	return 0;
+}
+
+static int ad7150_read_event_value(struct iio_dev *indio_dev,
+				   u64 event_code,
+				   int *val)
+{
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
+
+	/* Complex register sharing going on here */
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		*val = chip->mag_sensitivity[rising][chan];
+		return 0;
+
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		*val = chip->thresh_sensitivity[rising][chan];
+		return 0;
+
+	case IIO_EV_TYPE_THRESH:
+		*val = chip->threshold[rising][chan];
+		return 0;
+
+	default:
+		return -EINVAL;
+	};
+}
+
+static int ad7150_write_event_value(struct iio_dev *indio_dev,
+				   u64 event_code,
+				   int val)
+{
+	int ret;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(event_code);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
+			IIO_EV_DIR_RISING);
+
+	mutex_lock(&chip->state_lock);
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(event_code)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		chip->mag_sensitivity[rising][chan] = val;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		chip->thresh_sensitivity[rising][chan] = val;
+		break;
+	case IIO_EV_TYPE_THRESH:
+		chip->threshold[rising][chan] = val;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret;
+	};
+
+	/* write back if active */
+	ret = ad7150_write_event_params(indio_dev, event_code);
+
+error_ret:
+	mutex_unlock(&chip->state_lock);
+	return ret;
+}
+
+static ssize_t ad7150_show_timeout(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	u8 value;
+
+	/* use the event code for consistency reasons */
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address)
+			== IIO_EV_DIR_RISING);
+
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		value = chip->mag_timeout[rising][chan];
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		value = chip->thresh_timeout[rising][chan];
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return sprintf(buf, "%d\n", value);
+}
+
+static ssize_t ad7150_store_timeout(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	int chan = IIO_EVENT_CODE_EXTRACT_NUM(this_attr->address);
+	int rising = !!(IIO_EVENT_CODE_EXTRACT_DIR(this_attr->address) ==
+			IIO_EV_DIR_RISING);
+	u8 data;
+	int ret;
+
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&chip->state_lock);
+	switch (IIO_EVENT_CODE_EXTRACT_TYPE(this_attr->address)) {
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		chip->mag_timeout[rising][chan] = data;
+		break;
+	case IIO_EV_TYPE_THRESH_ADAPTIVE:
+		chip->thresh_timeout[rising][chan] = data;
+		break;
+	default:
+		ret = -EINVAL;
+		goto error_ret;
+	};
+
+	ret = ad7150_write_event_params(indio_dev, this_attr->address);
+error_ret:
+	mutex_unlock(&chip->state_lock);
+
+	if (ret < 0)
+		return ret;
+
+	return len;
+}
+
+#define AD7150_TIMEOUT(chan, type, dir, ev_type, ev_dir)		\
+	IIO_DEVICE_ATTR(in_capacitance##chan##_##type##_##dir##_timeout, \
+		S_IRUGO | S_IWUSR,					\
+		&ad7150_show_timeout,					\
+		&ad7150_store_timeout,					\
+		IIO_UNMOD_EVENT_CODE(IIO_CAPACITANCE,			\
+				     chan,				\
+				     IIO_EV_TYPE_##ev_type,		\
+				     IIO_EV_DIR_##ev_dir))
+static AD7150_TIMEOUT(0, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(0, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
+static AD7150_TIMEOUT(1, mag_adaptive, rising, MAG_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(1, mag_adaptive, falling, MAG_ADAPTIVE, FALLING);
+static AD7150_TIMEOUT(0, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(0, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
+static AD7150_TIMEOUT(1, thresh_adaptive, rising, THRESH_ADAPTIVE, RISING);
+static AD7150_TIMEOUT(1, thresh_adaptive, falling, THRESH_ADAPTIVE, FALLING);
+
+static const struct iio_chan_spec ad7150_channels[] = {
+	{
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.event_mask =
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
+	}, {
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
+		.event_mask =
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_THRESH_ADAPTIVE, IIO_EV_DIR_FALLING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_RISING) |
+		IIO_EV_BIT(IIO_EV_TYPE_MAG_ADAPTIVE, IIO_EV_DIR_FALLING)
+	},
+};
+
+/*
+ * threshold events
+ */
+
+static irqreturn_t ad7150_event_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ad7150_chip_info *chip = iio_priv(indio_dev);
+	u8 int_status;
+	s64 timestamp = iio_get_time_ns();
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(chip->client, AD7150_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	int_status = ret;
+
+	if ((int_status & AD7150_STATUS_OUT1) &&
+	    !(chip->old_state & AD7150_STATUS_OUT1))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+				timestamp);
+	else if ((!(int_status & AD7150_STATUS_OUT1)) &&
+		 (chip->old_state & AD7150_STATUS_OUT1))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+
+	if ((int_status & AD7150_STATUS_OUT2) &&
+	    !(chip->old_state & AD7150_STATUS_OUT2))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+						    1,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+	else if ((!(int_status & AD7150_STATUS_OUT2)) &&
+		 (chip->old_state & AD7150_STATUS_OUT2))
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
+						    1,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+	/* store the status to avoid repushing same events */
+	chip->old_state = int_status;
+
+	return IRQ_HANDLED;
+}
+
+/* Timeouts not currently handled by core */
+static struct attribute *ad7150_event_attributes[] = {
+	&iio_dev_attr_in_capacitance0_mag_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_mag_adaptive_falling_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_mag_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_mag_adaptive_falling_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_thresh_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_thresh_adaptive_falling_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_thresh_adaptive_rising_timeout
+	.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_thresh_adaptive_falling_timeout
+	.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ad7150_event_attribute_group = {
+	.attrs = ad7150_event_attributes,
+	.name = "events",
+};
+
+static const struct iio_info ad7150_info = {
+	.event_attrs = &ad7150_event_attribute_group,
+	.driver_module = THIS_MODULE,
+	.read_raw = &ad7150_read_raw,
+	.read_event_config = &ad7150_read_event_config,
+	.write_event_config = &ad7150_write_event_config,
+	.read_event_value = &ad7150_read_event_value,
+	.write_event_value = &ad7150_write_event_value,
+};
+
+/*
+ * device probe and remove
+ */
+
+static int __devinit ad7150_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	int ret;
+	struct ad7150_chip_info *chip;
+	struct iio_dev *indio_dev;
+
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	chip = iio_priv(indio_dev);
+	mutex_init(&chip->state_lock);
+	/* this is only used for device removal purposes */
+	i2c_set_clientdata(client, indio_dev);
+
+	chip->client = client;
+
+	indio_dev->name = id->name;
+	indio_dev->channels = ad7150_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7150_channels);
+	/* Establish that the iio_dev is a child of the i2c device */
+	indio_dev->dev.parent = &client->dev;
+
+	indio_dev->info = &ad7150_info;
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (client->irq) {
+		ret = request_threaded_irq(client->irq,
+					   NULL,
+					   &ad7150_event_handler,
+					   IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING,
+					   "ad7150_irq1",
+					   indio_dev);
+		if (ret)
+			goto error_free_dev;
+	}
+
+	if (client->dev.platform_data) {
+		ret = request_threaded_irq(*(unsigned int *)
+					   client->dev.platform_data,
+					   NULL,
+					   &ad7150_event_handler,
+					   IRQF_TRIGGER_RISING |
+					   IRQF_TRIGGER_FALLING,
+					   "ad7150_irq2",
+					   indio_dev);
+		if (ret)
+			goto error_free_irq;
+	}
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_irq2;
+
+	dev_info(&client->dev, "%s capacitive sensor registered,irq: %d\n",
+		 id->name, client->irq);
+
+	return 0;
+error_free_irq2:
+	if (client->dev.platform_data)
+		free_irq(*(unsigned int *)client->dev.platform_data,
+			 indio_dev);
+error_free_irq:
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+error_free_dev:
+	iio_free_device(indio_dev);
+error_ret:
+	return ret;
+}
+
+static int __devexit ad7150_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+
+	if (client->dev.platform_data)
+		free_irq(*(unsigned int *)client->dev.platform_data, indio_dev);
+
+	iio_free_device(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id ad7150_id[] = {
+	{ "ad7150", 0 },
+	{ "ad7151", 0 },
+	{ "ad7156", 0 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, ad7150_id);
+
+static struct i2c_driver ad7150_driver = {
+	.driver = {
+		.name = "ad7150",
+	},
+	.probe = ad7150_probe,
+	.remove = __devexit_p(ad7150_remove),
+	.id_table = ad7150_id,
+};
+
+static __init int ad7150_init(void)
+{
+	return i2c_add_driver(&ad7150_driver);
+}
+
+static __exit void ad7150_exit(void)
+{
+	i2c_del_driver(&ad7150_driver);
+}
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices AD7150/1/6 capacitive sensor driver");
+MODULE_LICENSE("GPL v2");
+
+module_init(ad7150_init);
+module_exit(ad7150_exit);
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
new file mode 100644
index 0000000..662584d
--- /dev/null
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -0,0 +1,559 @@
+/*
+ * AD7152 capacitive sensor driver supporting AD7152/3
+ *
+ * Copyright 2010-2011a Analog Devices Inc.
+ *
+ * Licensed under the GPL-2 or later.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+
+/*
+ * TODO: Check compliance of calibbias with abi (units)
+ */
+/*
+ * AD7152 registers definition
+ */
+
+#define AD7152_REG_STATUS		0
+#define AD7152_REG_CH1_DATA_HIGH	1
+#define AD7152_REG_CH2_DATA_HIGH	3
+#define AD7152_REG_CH1_OFFS_HIGH	5
+#define AD7152_REG_CH2_OFFS_HIGH	7
+#define AD7152_REG_CH1_GAIN_HIGH	9
+#define AD7152_REG_CH1_SETUP		11
+#define AD7152_REG_CH2_GAIN_HIGH	12
+#define AD7152_REG_CH2_SETUP		14
+#define AD7152_REG_CFG			15
+#define AD7152_REG_RESEVERD		16
+#define AD7152_REG_CAPDAC_POS		17
+#define AD7152_REG_CAPDAC_NEG		18
+#define AD7152_REG_CFG2			26
+
+/* Status Register Bit Designations (AD7152_REG_STATUS) */
+#define AD7152_STATUS_RDY1		(1 << 0)
+#define AD7152_STATUS_RDY2		(1 << 1)
+#define AD7152_STATUS_C1C2		(1 << 2)
+#define AD7152_STATUS_PWDN		(1 << 7)
+
+/* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
+#define AD7152_SETUP_CAPDIFF		(1 << 5)
+#define AD7152_SETUP_RANGE_2pF		(0 << 6)
+#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
+#define AD7152_SETUP_RANGE_1pF		(2 << 6)
+#define AD7152_SETUP_RANGE_4pF		(3 << 6)
+#define AD7152_SETUP_RANGE(x)		((x) << 6)
+
+/* Config Register Bit Designations (AD7152_REG_CFG) */
+#define AD7152_CONF_CH2EN		(1 << 3)
+#define AD7152_CONF_CH1EN		(1 << 4)
+#define AD7152_CONF_MODE_IDLE		(0 << 0)
+#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
+#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
+#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
+
+/* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
+#define AD7152_CAPDAC_DACEN		(1 << 7)
+#define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
+
+/* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
+#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
+
+enum {
+	AD7152_DATA,
+	AD7152_OFFS,
+	AD7152_GAIN,
+	AD7152_SETUP
+};
+
+/*
+ * struct ad7152_chip_info - chip specifc information
+ */
+
+struct ad7152_chip_info {
+	struct i2c_client *client;
+	/*
+	 * Capacitive channel digital filter setup;
+	 * conversion time/update rate setup per channel
+	 */
+	u8	filter_rate_setup;
+	u8	setup[2];
+};
+
+static inline ssize_t ad7152_start_calib(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t len,
+					 u8 regval)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	bool doit;
+	int ret, timeout = 10;
+
+	ret = strtobool(buf, &doit);
+	if (ret < 0)
+		return ret;
+
+	if (!doit)
+		return 0;
+
+	if (this_attr->address == 0)
+		regval |= AD7152_CONF_CH1EN;
+	else
+		regval |= AD7152_CONF_CH2EN;
+
+	mutex_lock(&indio_dev->mlock);
+	ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG, regval);
+	if (ret < 0) {
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
+	}
+
+	do {
+		mdelay(20);
+		ret = i2c_smbus_read_byte_data(chip->client, AD7152_REG_CFG);
+		if (ret < 0) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+	} while ((ret == regval) && timeout--);
+
+	mutex_unlock(&indio_dev->mlock);
+	return len;
+}
+static ssize_t ad7152_start_offset_calib(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t len)
+{
+	return ad7152_start_calib(dev, attr, buf, len,
+				  AD7152_CONF_MODE_OFFS_CAL);
+}
+static ssize_t ad7152_start_gain_calib(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t len)
+{
+	return ad7152_start_calib(dev, attr, buf, len,
+				  AD7152_CONF_MODE_GAIN_CAL);
+}
+
+static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
+		       S_IWUSR, NULL, ad7152_start_offset_calib, 0);
+static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
+		       S_IWUSR, NULL, ad7152_start_offset_calib, 1);
+static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
+		       S_IWUSR, NULL, ad7152_start_gain_calib, 0);
+static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
+		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
+
+/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
+static const unsigned char ad7152_filter_rate_table[][2] = {
+	{200, 5 + 1}, {50, 20 + 1}, {20, 50 + 1}, {17, 60 + 1},
+};
+
+static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n",
+		       ad7152_filter_rate_table[chip->filter_rate_setup][0]);
+}
+
+static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
+	u8 data;
+	int ret, i;
+
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(ad7152_filter_rate_table); i++)
+		if (data >= ad7152_filter_rate_table[i][0])
+			break;
+
+	if (i >= ARRAY_SIZE(ad7152_filter_rate_table))
+		i = ARRAY_SIZE(ad7152_filter_rate_table) - 1;
+
+	mutex_lock(&indio_dev->mlock);
+	ret = i2c_smbus_write_byte_data(chip->client,
+			AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
+	if (ret < 0) {
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
+	}
+
+	chip->filter_rate_setup = i;
+	mutex_unlock(&indio_dev->mlock);
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR,
+		ad7152_show_filter_rate_setup,
+		ad7152_store_filter_rate_setup);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("200 50 20 17");
+
+static IIO_CONST_ATTR(in_capacitance_scale_available,
+		      "0.000061050 0.000030525 0.000015263 0.000007631");
+
+static struct attribute *ad7152_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
+	&iio_const_attr_in_capacitance_scale_available.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7152_attribute_group = {
+	.attrs = ad7152_attributes,
+};
+
+static const u8 ad7152_addresses[][4] = {
+	{ AD7152_REG_CH1_DATA_HIGH, AD7152_REG_CH1_OFFS_HIGH,
+	  AD7152_REG_CH1_GAIN_HIGH, AD7152_REG_CH1_SETUP },
+	{ AD7152_REG_CH2_DATA_HIGH, AD7152_REG_CH2_OFFS_HIGH,
+	  AD7152_REG_CH2_GAIN_HIGH, AD7152_REG_CH2_SETUP },
+};
+
+/* Values are nano relative to pf base. */
+static const int ad7152_scale_table[] = {
+	30525, 7631, 15263, 61050
+};
+
+static int ad7152_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
+	int ret, i;
+
+	mutex_lock(&indio_dev->mlock);
+
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		if (val != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		val = (val2 * 1024) / 15625;
+
+		ret = i2c_smbus_write_word_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_GAIN],
+				swab16(val));
+		if (ret < 0)
+			goto out;
+
+		ret = 0;
+		break;
+
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		if ((val < 0) | (val > 0xFFFF)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = i2c_smbus_write_word_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_OFFS],
+				swab16(val));
+		if (ret < 0)
+			goto out;
+
+		ret = 0;
+		break;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		if (val != 0) {
+			ret = -EINVAL;
+			goto out;
+		}
+		for (i = 0; i < ARRAY_SIZE(ad7152_scale_table); i++)
+			if (val2 == ad7152_scale_table[i])
+				break;
+
+		chip->setup[chan->channel] &= ~AD7152_SETUP_RANGE_4pF;
+		chip->setup[chan->channel] |= AD7152_SETUP_RANGE(i);
+
+		ret = i2c_smbus_write_byte_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_SETUP],
+				chip->setup[chan->channel]);
+		if (ret < 0)
+			goto out;
+
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+static int ad7152_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2,
+			   long mask)
+{
+	struct ad7152_chip_info *chip = iio_priv(indio_dev);
+	int ret;
+	u8 regval = 0;
+
+	mutex_lock(&indio_dev->mlock);
+
+	switch (mask) {
+	case 0:
+		/* First set whether in differential mode */
+
+		regval = chip->setup[chan->channel];
+
+		if (chan->differential)
+			chip->setup[chan->channel] |= AD7152_SETUP_CAPDIFF;
+		else
+			chip->setup[chan->channel] &= ~AD7152_SETUP_CAPDIFF;
+
+		if (regval != chip->setup[chan->channel]) {
+			ret = i2c_smbus_write_byte_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_SETUP],
+				chip->setup[chan->channel]);
+			if (ret < 0)
+				goto out;
+		}
+		/* Make sure the channel is enabled */
+		if (chan->channel == 0)
+			regval = AD7152_CONF_CH1EN;
+		else
+			regval = AD7152_CONF_CH2EN;
+
+		/* Trigger a single read */
+		regval |= AD7152_CONF_MODE_SINGLE_CONV;
+		ret = i2c_smbus_write_byte_data(chip->client, AD7152_REG_CFG,
+				regval);
+		if (ret < 0)
+			goto out;
+
+		msleep(ad7152_filter_rate_table[chip->filter_rate_setup][1]);
+		/* Now read the actual register */
+		ret = i2c_smbus_read_word_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_DATA]);
+		if (ret < 0)
+			goto out;
+		*val = swab16(ret);
+
+		if (chan->differential)
+			*val -= 0x8000;
+
+		ret = IIO_VAL_INT;
+		break;
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+
+		ret = i2c_smbus_read_word_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_GAIN]);
+		if (ret < 0)
+			goto out;
+		/* 1 + gain_val / 2^16 */
+		*val = 1;
+		*val2 = (15625 * swab16(ret)) / 1024;
+
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE):
+		ret = i2c_smbus_read_word_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_OFFS]);
+		if (ret < 0)
+			goto out;
+		*val = swab16(ret);
+
+		ret = IIO_VAL_INT;
+		break;
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		ret = i2c_smbus_read_byte_data(chip->client,
+				ad7152_addresses[chan->channel][AD7152_SETUP]);
+		if (ret < 0)
+			goto out;
+		*val = 0;
+		*val2 = ad7152_scale_table[ret >> 6];
+
+		ret = IIO_VAL_INT_PLUS_NANO;
+		break;
+	default:
+		ret = -EINVAL;
+	};
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
+static int ad7152_write_raw_get_fmt(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       long mask)
+{
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static const struct iio_info ad7152_info = {
+	.attrs = &ad7152_attribute_group,
+	.read_raw = &ad7152_read_raw,
+	.write_raw = &ad7152_write_raw,
+	.write_raw_get_fmt = &ad7152_write_raw_get_fmt,
+	.driver_module = THIS_MODULE,
+};
+
+static const struct iio_chan_spec ad7152_channels[] = {
+	{
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+	}, {
+		.type = IIO_CAPACITANCE,
+		.differential = 1,
+		.indexed = 1,
+		.channel = 0,
+		.channel2 = 2,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+	}, {
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+	}, {
+		.type = IIO_CAPACITANCE,
+		.differential = 1,
+		.indexed = 1,
+		.channel = 1,
+		.channel2 = 3,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+	}
+};
+/*
+ * device probe and remove
+ */
+
+static int __devinit ad7152_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	int ret = 0;
+	struct ad7152_chip_info *chip;
+	struct iio_dev *indio_dev;
+
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	chip = iio_priv(indio_dev);
+	/* this is only used for device removal purposes */
+	i2c_set_clientdata(client, indio_dev);
+
+	chip->client = client;
+
+	/* Establish that the iio_dev is a child of the i2c device */
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ad7152_info;
+	indio_dev->channels = ad7152_channels;
+	if (id->driver_data == 0)
+		indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
+	else
+		indio_dev->num_channels = 2;
+	indio_dev->num_channels = ARRAY_SIZE(ad7152_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	dev_err(&client->dev, "%s capacitive sensor registered\n", id->name);
+
+	return 0;
+
+error_free_dev:
+	iio_free_device(indio_dev);
+error_ret:
+	return ret;
+}
+
+static int __devexit ad7152_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id ad7152_id[] = {
+	{ "ad7152", 0 },
+	{ "ad7153", 1 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, ad7152_id);
+
+static struct i2c_driver ad7152_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = ad7152_probe,
+	.remove = __devexit_p(ad7152_remove),
+	.id_table = ad7152_id,
+};
+
+static __init int ad7152_init(void)
+{
+	return i2c_add_driver(&ad7152_driver);
+}
+
+static __exit void ad7152_exit(void)
+{
+	i2c_del_driver(&ad7152_driver);
+}
+
+MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices AD7152/3 capacitive sensor driver");
+MODULE_LICENSE("GPL v2");
+
+module_init(ad7152_init);
+module_exit(ad7152_exit);
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
new file mode 100644
index 0000000..2867943
--- /dev/null
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -0,0 +1,807 @@
+/*
+ * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/stat.h>
+
+#include "../iio.h"
+#include "../sysfs.h"
+
+#include "ad7746.h"
+
+/*
+ * AD7746 Register Definition
+ */
+
+#define AD7746_REG_STATUS		0
+#define AD7746_REG_CAP_DATA_HIGH	1
+#define AD7746_REG_CAP_DATA_MID		2
+#define AD7746_REG_CAP_DATA_LOW		3
+#define AD7746_REG_VT_DATA_HIGH		4
+#define AD7746_REG_VT_DATA_MID		5
+#define AD7746_REG_VT_DATA_LOW		6
+#define AD7746_REG_CAP_SETUP		7
+#define AD7746_REG_VT_SETUP		8
+#define AD7746_REG_EXC_SETUP		9
+#define AD7746_REG_CFG			10
+#define AD7746_REG_CAPDACA		11
+#define AD7746_REG_CAPDACB		12
+#define AD7746_REG_CAP_OFFH		13
+#define AD7746_REG_CAP_OFFL		14
+#define AD7746_REG_CAP_GAINH		15
+#define AD7746_REG_CAP_GAINL		16
+#define AD7746_REG_VOLT_GAINH		17
+#define AD7746_REG_VOLT_GAINL		18
+
+/* Status Register Bit Designations (AD7746_REG_STATUS) */
+#define AD7746_STATUS_EXCERR		(1 << 3)
+#define AD7746_STATUS_RDY		(1 << 2)
+#define AD7746_STATUS_RDYVT		(1 << 1)
+#define AD7746_STATUS_RDYCAP		(1 << 0)
+
+/* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
+#define AD7746_CAPSETUP_CAPEN		(1 << 7)
+#define AD7746_CAPSETUP_CIN2		(1 << 6) /* AD7746 only */
+#define AD7746_CAPSETUP_CAPDIFF		(1 << 5)
+#define AD7746_CAPSETUP_CACHOP		(1 << 0)
+
+/* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
+#define AD7746_VTSETUP_VTEN		(1 << 7)
+#define AD7746_VTSETUP_VTMD_INT_TEMP	(0 << 5)
+#define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
+#define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
+#define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
+#define AD7746_VTSETUP_EXTREF		(1 << 4)
+#define AD7746_VTSETUP_VTSHORT		(1 << 1)
+#define AD7746_VTSETUP_VTCHOP		(1 << 0)
+
+/* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
+#define AD7746_EXCSETUP_CLKCTRL		(1 << 7)
+#define AD7746_EXCSETUP_EXCON		(1 << 6)
+#define AD7746_EXCSETUP_EXCB		(1 << 5)
+#define AD7746_EXCSETUP_NEXCB		(1 << 4)
+#define AD7746_EXCSETUP_EXCA		(1 << 3)
+#define AD7746_EXCSETUP_NEXCA		(1 << 2)
+#define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
+
+/* Config Register Bit Designations (AD7746_REG_CFG) */
+#define AD7746_CONF_VTFS(x)		((x) << 6)
+#define AD7746_CONF_CAPFS(x)		((x) << 3)
+#define AD7746_CONF_MODE_IDLE		(0 << 0)
+#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
+#define AD7746_CONF_MODE_PWRDN		(3 << 0)
+#define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
+#define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
+
+/* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
+#define AD7746_CAPDAC_DACEN		(1 << 7)
+#define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
+
+/*
+ * struct ad7746_chip_info - chip specifc information
+ */
+
+struct ad7746_chip_info {
+	struct i2c_client *client;
+	/*
+	 * Capacitive channel digital filter setup;
+	 * conversion time/update rate setup per channel
+	 */
+	u8	config;
+	u8	cap_setup;
+	u8	vt_setup;
+	u8	capdac[2][2];
+	s8	capdac_set;
+};
+
+enum ad7746_chan {
+	VIN,
+	VIN_VDD,
+	TEMP_INT,
+	TEMP_EXT,
+	CIN1,
+	CIN1_DIFF,
+	CIN2,
+	CIN2_DIFF,
+};
+
+static const struct iio_chan_spec ad7746_channels[] = {
+	[VIN] = {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = AD7746_REG_VT_DATA_HIGH << 8 |
+			AD7746_VTSETUP_VTMD_EXT_VIN,
+	},
+	[VIN_VDD] = {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.channel = 1,
+		.extend_name = "supply",
+		.info_mask = (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = AD7746_REG_VT_DATA_HIGH << 8 |
+			AD7746_VTSETUP_VTMD_VDD_MON,
+	},
+	[TEMP_INT] = {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 0,
+		.processed_val = IIO_PROCESSED,
+		.address = AD7746_REG_VT_DATA_HIGH << 8 |
+			AD7746_VTSETUP_VTMD_INT_TEMP,
+	},
+	[TEMP_EXT] = {
+		.type = IIO_TEMP,
+		.indexed = 1,
+		.channel = 1,
+		.processed_val = IIO_PROCESSED,
+		.address = AD7746_REG_VT_DATA_HIGH << 8 |
+			AD7746_VTSETUP_VTMD_EXT_TEMP,
+	},
+	[CIN1] = {
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 0,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
+		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = AD7746_REG_CAP_DATA_HIGH << 8,
+	},
+	[CIN1_DIFF] = {
+		.type = IIO_CAPACITANCE,
+		.differential = 1,
+		.indexed = 1,
+		.channel = 0,
+		.channel2 = 2,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
+		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
+			AD7746_CAPSETUP_CAPDIFF
+	},
+	[CIN2] = {
+		.type = IIO_CAPACITANCE,
+		.indexed = 1,
+		.channel = 1,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
+		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
+			AD7746_CAPSETUP_CIN2,
+	},
+	[CIN2_DIFF] = {
+		.type = IIO_CAPACITANCE,
+		.differential = 1,
+		.indexed = 1,
+		.channel = 1,
+		.channel2 = 3,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
+		(1 << IIO_CHAN_INFO_CALIBBIAS_SHARED) |
+		(1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		(1 << IIO_CHAN_INFO_SCALE_SHARED),
+		.address = AD7746_REG_CAP_DATA_HIGH << 8 |
+			AD7746_CAPSETUP_CAPDIFF | AD7746_CAPSETUP_CIN2,
+	}
+};
+
+/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
+static const unsigned char ad7746_vt_filter_rate_table[][2] = {
+	{50, 20 + 1}, {31, 32 + 1}, {16, 62 + 1}, {8, 122 + 1},
+};
+
+static const unsigned char ad7746_cap_filter_rate_table[][2] = {
+	{91, 11 + 1}, {84, 12 + 1}, {50, 20 + 1}, {26, 38 + 1},
+	{16, 62 + 1}, {13, 77 + 1}, {11, 92 + 1}, {9, 110 + 1},
+};
+
+static int ad7746_select_channel(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan)
+{
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	int ret, delay;
+	u8 vt_setup, cap_setup;
+
+	switch (chan->type) {
+	case IIO_CAPACITANCE:
+		cap_setup = (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
+		vt_setup = chip->vt_setup & ~AD7746_VTSETUP_VTEN;
+		delay = ad7746_cap_filter_rate_table[(chip->config >> 3) &
+			0x7][1];
+
+		if (chip->capdac_set != chan->channel) {
+			ret = i2c_smbus_write_byte_data(chip->client,
+				AD7746_REG_CAPDACA,
+				chip->capdac[chan->channel][0]);
+			if (ret < 0)
+				return ret;
+			ret = i2c_smbus_write_byte_data(chip->client,
+				AD7746_REG_CAPDACB,
+				chip->capdac[chan->channel][1]);
+			if (ret < 0)
+				return ret;
+
+			chip->capdac_set = chan->channel;
+		}
+		break;
+	case IIO_VOLTAGE:
+	case IIO_TEMP:
+		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
+		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
+		delay = ad7746_cap_filter_rate_table[(chip->config >> 6) &
+			0x3][1];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (chip->cap_setup != cap_setup) {
+		ret = i2c_smbus_write_byte_data(chip->client,
+						AD7746_REG_CAP_SETUP,
+						cap_setup);
+		if (ret < 0)
+			return ret;
+
+		chip->cap_setup = cap_setup;
+	}
+
+	if (chip->vt_setup != vt_setup) {
+		ret = i2c_smbus_write_byte_data(chip->client,
+						AD7746_REG_VT_SETUP,
+						vt_setup);
+		if (ret < 0)
+			return ret;
+
+		chip->vt_setup = vt_setup;
+	}
+
+	return delay;
+}
+
+static inline ssize_t ad7746_start_calib(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t len,
+					 u8 regval)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	bool doit;
+	int ret, timeout = 10;
+
+	ret = strtobool(buf, &doit);
+	if (ret < 0)
+		return ret;
+
+	if (!doit)
+		return 0;
+
+	mutex_lock(&indio_dev->mlock);
+	regval |= chip->config;
+	ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG, regval);
+	if (ret < 0) {
+		mutex_unlock(&indio_dev->mlock);
+		return ret;
+	}
+
+	do {
+		msleep(20);
+		ret = i2c_smbus_read_byte_data(chip->client, AD7746_REG_CFG);
+		if (ret < 0) {
+			mutex_unlock(&indio_dev->mlock);
+			return ret;
+		}
+	} while ((ret == regval) && timeout--);
+
+	mutex_unlock(&indio_dev->mlock);
+
+	return len;
+}
+
+static ssize_t ad7746_start_offset_calib(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf,
+					 size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	int ret = ad7746_select_channel(indio_dev,
+			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
+	if (ret < 0)
+		return ret;
+
+	return ad7746_start_calib(dev, attr, buf, len,
+				  AD7746_CONF_MODE_OFFS_CAL);
+}
+
+static ssize_t ad7746_start_gain_calib(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf,
+				       size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	int ret = ad7746_select_channel(indio_dev,
+			      &ad7746_channels[to_iio_dev_attr(attr)->address]);
+	if (ret < 0)
+		return ret;
+
+	return ad7746_start_calib(dev, attr, buf, len,
+				  AD7746_CONF_MODE_GAIN_CAL);
+}
+
+static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
+		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN1);
+static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
+		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN2);
+static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
+		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN1);
+static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
+		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN2);
+static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
+		       S_IWUSR, NULL, ad7746_start_gain_calib, VIN);
+
+static ssize_t ad7746_show_cap_filter_rate_setup(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", ad7746_cap_filter_rate_table[
+			(chip->config >> 3) & 0x7][0]);
+}
+
+static ssize_t ad7746_store_cap_filter_rate_setup(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	u8 data;
+	int ret, i;
+
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(ad7746_cap_filter_rate_table); i++)
+		if (data >= ad7746_cap_filter_rate_table[i][0])
+			break;
+
+	if (i >= ARRAY_SIZE(ad7746_cap_filter_rate_table))
+		i = ARRAY_SIZE(ad7746_cap_filter_rate_table) - 1;
+
+	mutex_lock(&indio_dev->mlock);
+	chip->config &= ~AD7746_CONF_CAPFS(0x7);
+	chip->config |= AD7746_CONF_CAPFS(i);
+	mutex_unlock(&indio_dev->mlock);
+
+	return len;
+}
+
+static ssize_t ad7746_show_vt_filter_rate_setup(struct device *dev,
+		struct device_attribute *attr,
+		char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", ad7746_vt_filter_rate_table[
+			(chip->config >> 6) & 0x3][0]);
+}
+
+static ssize_t ad7746_store_vt_filter_rate_setup(struct device *dev,
+		struct device_attribute *attr,
+		const char *buf,
+		size_t len)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	u8 data;
+	int ret, i;
+
+	ret = kstrtou8(buf, 10, &data);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(ad7746_vt_filter_rate_table); i++)
+		if (data >= ad7746_vt_filter_rate_table[i][0])
+			break;
+
+	if (i >= ARRAY_SIZE(ad7746_vt_filter_rate_table))
+		i = ARRAY_SIZE(ad7746_vt_filter_rate_table) - 1;
+
+	mutex_lock(&indio_dev->mlock);
+	chip->config &= ~AD7746_CONF_VTFS(0x3);
+	chip->config |= AD7746_CONF_VTFS(i);
+	mutex_unlock(&indio_dev->mlock);
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(in_capacitance_sampling_frequency,
+		       S_IRUGO | S_IWUSR, ad7746_show_cap_filter_rate_setup,
+			ad7746_store_cap_filter_rate_setup, 0);
+
+static IIO_DEVICE_ATTR(in_voltage_sampling_frequency,
+		       S_IRUGO | S_IWUSR, ad7746_show_vt_filter_rate_setup,
+		       ad7746_store_vt_filter_rate_setup, 0);
+
+static IIO_CONST_ATTR(in_voltage_sampling_frequency_available, "50 31 16 8");
+static IIO_CONST_ATTR(in_capacitance_sampling_frequency_available,
+		       "91 84 50 26 16 13 11 9");
+
+static struct attribute *ad7746_attributes[] = {
+	&iio_dev_attr_in_capacitance_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_in_voltage_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibbias_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance0_calibscale_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibscale_calibration.dev_attr.attr,
+	&iio_dev_attr_in_capacitance1_calibbias_calibration.dev_attr.attr,
+	&iio_dev_attr_in_voltage0_calibscale_calibration.dev_attr.attr,
+	&iio_const_attr_in_voltage_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_capacitance_sampling_frequency_available.
+	dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad7746_attribute_group = {
+	.attrs = ad7746_attributes,
+};
+
+static int ad7746_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	int ret, reg;
+
+	mutex_lock(&indio_dev->mlock);
+
+	switch (mask) {
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		if (val != 1) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		val = (val2 * 1024) / 15625;
+
+		switch (chan->type) {
+		case IIO_CAPACITANCE:
+			reg = AD7746_REG_CAP_GAINH;
+			break;
+		case IIO_VOLTAGE:
+			reg = AD7746_REG_VOLT_GAINH;
+			break;
+		default:
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = i2c_smbus_write_word_data(chip->client, reg, swab16(val));
+		if (ret < 0)
+			goto out;
+
+		ret = 0;
+		break;
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SHARED):
+		if ((val < 0) | (val > 0xFFFF)) {
+			ret = -EINVAL;
+			goto out;
+		}
+		ret = i2c_smbus_write_word_data(chip->client,
+				AD7746_REG_CAP_OFFH, swab16(val));
+		if (ret < 0)
+			goto out;
+
+		ret = 0;
+		break;
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		if ((val < 0) | (val > 43008000)) { /* 21pF */
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* CAPDAC Scale = 21pF_typ / 127
+		 * CIN Scale = 8.192pF / 2^24
+		 * Offset Scale = CAPDAC Scale / CIN Scale = 338646
+		 * */
+
+		val /= 338646;
+
+		chip->capdac[chan->channel][chan->differential] = (val > 0 ?
+			AD7746_CAPDAC_DACP(val) | AD7746_CAPDAC_DACEN : 0);
+
+		ret = i2c_smbus_write_byte_data(chip->client,
+			AD7746_REG_CAPDACA,
+			chip->capdac[chan->channel][0]);
+		if (ret < 0)
+			goto out;
+		ret = i2c_smbus_write_byte_data(chip->client,
+			AD7746_REG_CAPDACB,
+			chip->capdac[chan->channel][1]);
+		if (ret < 0)
+			goto out;
+
+		chip->capdac_set = chan->channel;
+
+		ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
+static int ad7746_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2,
+			   long mask)
+{
+	struct ad7746_chip_info *chip = iio_priv(indio_dev);
+	int ret, delay;
+	u8 regval, reg;
+
+	union {
+		u32 d32;
+		u8 d8[4];
+	} data;
+
+	mutex_lock(&indio_dev->mlock);
+
+	switch (mask) {
+	case 0:
+		ret = ad7746_select_channel(indio_dev, chan);
+		if (ret < 0)
+			goto out;
+		delay = ret;
+
+		regval = chip->config | AD7746_CONF_MODE_SINGLE_CONV;
+		ret = i2c_smbus_write_byte_data(chip->client, AD7746_REG_CFG,
+				regval);
+		if (ret < 0)
+			goto out;
+
+		msleep(delay);
+		/* Now read the actual register */
+
+		ret = i2c_smbus_read_i2c_block_data(chip->client,
+			chan->address >> 8, 3, &data.d8[1]);
+
+		if (ret < 0)
+			goto out;
+
+		*val = (be32_to_cpu(data.d32) & 0xFFFFFF) - 0x800000;
+
+		switch (chan->type) {
+		case IIO_TEMP:
+		/* temperature in milli degrees Celsius
+		 * T = ((*val / 2048) - 4096) * 1000
+		 */
+			*val = (*val * 125) / 256;
+			break;
+		case IIO_VOLTAGE:
+			if (chan->channel == 1) /* supply_raw*/
+				*val = *val * 6;
+			break;
+		default:
+			break;
+		}
+
+		ret = IIO_VAL_INT;
+		break;
+	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
+		switch (chan->type) {
+		case IIO_CAPACITANCE:
+			reg = AD7746_REG_CAP_GAINH;
+			break;
+		case IIO_VOLTAGE:
+			reg = AD7746_REG_VOLT_GAINH;
+			break;
+		default:
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = i2c_smbus_read_word_data(chip->client, reg);
+		if (ret < 0)
+			goto out;
+		/* 1 + gain_val / 2^16 */
+		*val = 1;
+		*val2 = (15625 * swab16(ret)) / 1024;
+
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	case (1 << IIO_CHAN_INFO_CALIBBIAS_SHARED):
+		ret = i2c_smbus_read_word_data(chip->client,
+					       AD7746_REG_CAP_OFFH);
+		if (ret < 0)
+			goto out;
+		*val = swab16(ret);
+
+		ret = IIO_VAL_INT;
+		break;
+	case (1 << IIO_CHAN_INFO_OFFSET_SEPARATE):
+		*val = AD7746_CAPDAC_DACP(chip->capdac[chan->channel]
+			[chan->differential]) * 338646;
+
+		ret = IIO_VAL_INT;
+		break;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		switch (chan->type) {
+		case IIO_CAPACITANCE:
+			/* 8.192pf / 2^24 */
+			*val2 = 488;
+			*val =  0;
+			break;
+		case IIO_VOLTAGE:
+			/* 1170mV / 2^23 */
+			*val2 = 139475;
+			*val =  0;
+			break;
+		default:
+			ret =  -EINVAL;
+			goto out;
+		}
+
+		ret = IIO_VAL_INT_PLUS_NANO;
+		break;
+	default:
+		ret = -EINVAL;
+	};
+out:
+	mutex_unlock(&indio_dev->mlock);
+	return ret;
+}
+
+static const struct iio_info ad7746_info = {
+	.attrs = &ad7746_attribute_group,
+	.read_raw = &ad7746_read_raw,
+	.write_raw = &ad7746_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
+/*
+ * device probe and remove
+ */
+
+static int __devinit ad7746_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct ad7746_platform_data *pdata = client->dev.platform_data;
+	struct ad7746_chip_info *chip;
+	struct iio_dev *indio_dev;
+	int ret = 0;
+	unsigned char regval = 0;
+
+	indio_dev = iio_allocate_device(sizeof(*chip));
+	if (indio_dev == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	chip = iio_priv(indio_dev);
+	/* this is only used for device removal purposes */
+	i2c_set_clientdata(client, indio_dev);
+
+	chip->client = client;
+	chip->capdac_set = -1;
+
+	/* Establish that the iio_dev is a child of the i2c device */
+	indio_dev->name = id->name;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &ad7746_info;
+	indio_dev->channels = ad7746_channels;
+	if (id->driver_data == 7746)
+		indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
+	else
+		indio_dev->num_channels =  ARRAY_SIZE(ad7746_channels) - 2;
+	indio_dev->num_channels = ARRAY_SIZE(ad7746_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (pdata) {
+		if (pdata->exca_en) {
+			if (pdata->exca_inv_en)
+				regval |= AD7746_EXCSETUP_NEXCA;
+			else
+				regval |= AD7746_EXCSETUP_EXCA;
+		}
+
+		if (pdata->excb_en) {
+			if (pdata->excb_inv_en)
+				regval |= AD7746_EXCSETUP_NEXCB;
+			else
+				regval |= AD7746_EXCSETUP_EXCB;
+		}
+
+		regval |= AD7746_EXCSETUP_EXCLVL(pdata->exclvl);
+	} else {
+		dev_warn(&client->dev, "No platform data? using default\n");
+		regval = AD7746_EXCSETUP_EXCA | AD7746_EXCSETUP_EXCB |
+			AD7746_EXCSETUP_EXCLVL(3);
+	}
+
+	ret = i2c_smbus_write_byte_data(chip->client,
+					AD7746_REG_EXC_SETUP, regval);
+	if (ret < 0)
+		goto error_free_dev;
+
+	ret = iio_device_register(indio_dev);
+	if (ret)
+		goto error_free_dev;
+
+	dev_info(&client->dev, "%s capacitive sensor registered\n", id->name);
+
+	return 0;
+
+error_free_dev:
+	iio_free_device(indio_dev);
+error_ret:
+	return ret;
+}
+
+static int __devexit ad7746_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+	iio_free_device(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id ad7746_id[] = {
+	{ "ad7745", 7745 },
+	{ "ad7746", 7746 },
+	{ "ad7747", 7747 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, ad7746_id);
+
+static struct i2c_driver ad7746_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = ad7746_probe,
+	.remove = __devexit_p(ad7746_remove),
+	.id_table = ad7746_id,
+};
+
+static __init int ad7746_init(void)
+{
+	return i2c_add_driver(&ad7746_driver);
+}
+
+static __exit void ad7746_exit(void)
+{
+	i2c_del_driver(&ad7746_driver);
+}
+
+MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
+MODULE_DESCRIPTION("Analog Devices AD7746/5/7 capacitive sensor driver");
+MODULE_LICENSE("GPL v2");
+
+module_init(ad7746_init);
+module_exit(ad7746_exit);
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
new file mode 100644
index 0000000..ea8572d
--- /dev/null
+++ b/drivers/staging/iio/cdc/ad7746.h
@@ -0,0 +1,29 @@
+/*
+ * AD7746 capacitive sensor driver supporting AD7745, AD7746 and AD7747
+ *
+ * Copyright 2011 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef IIO_CDC_AD7746_H_
+#define IIO_CDC_AD7746_H_
+
+/*
+ * TODO: struct ad7746_platform_data needs to go into include/linux/iio
+ */
+
+#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
+#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
+#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
+#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
+
+struct ad7746_platform_data {
+	unsigned char exclvl;	/*Excitation Voltage Level */
+	bool exca_en;		/* enables EXCA pin as the excitation output */
+	bool exca_inv_en;	/* enables /EXCA pin as the excitation output */
+	bool excb_en;		/* enables EXCB pin as the excitation output */
+	bool excb_inv_en;	/* enables /EXCB pin as the excitation output */
+};
+
+#endif /* IIO_CDC_AD7746_H_ */
-- 
1.7.0.4
