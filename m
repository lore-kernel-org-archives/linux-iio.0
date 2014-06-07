Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33322 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbaFGS7q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 14:59:46 -0400
Message-ID: <5393618F.10400@kernel.org>
Date: Sat, 07 Jun 2014 20:01:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1] iio: accel: kxcjk1013 3-axis accelerometer driver
References: <1401902764-4567-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1401902764-4567-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/06/14 18:26, Srinivas Pandruvada wrote:
> This patch adds IIO driver for KXCJK 1013 triaxis accelerometer sensor.
> The specifications for this driver is downloaded from:
> http://www.kionix.com/sites/default/files/KXCJK-1013%20Specifications%20Rev%202.pdf
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Mostly looks fine to me, though I have a few queries inline to do with various state
changes when the buffer / dataready trigger is running.
Also you probably want to provide the callback to prevent the buffer
associating with other triggers seeing as I don't think it will ever
work...  (almost always the case with data ready interrupts).

Nothing stops us running additional devices off the dataready trigger though
which is why we bother to have triggers for these devices.

I'd also slightly prefer some switching round of logic to make the flow
more standard. It's a matter of personal preference really so if you feel
strongly against it then push back!
> ---
Change list?

>   drivers/iio/accel/Kconfig      |  12 +
>   drivers/iio/accel/Makefile     |   1 +
>   drivers/iio/accel/kxcjk-1013.c | 729 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 742 insertions(+)
>   create mode 100644 drivers/iio/accel/kxcjk-1013.c
>
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 1e120fa..12addf2 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -77,4 +77,16 @@ config MMA8452
>   	  To compile this driver as a module, choose M here: the module
>   	  will be called mma8452.
>
> +config KXCJK1013
> +	tristate "Kionix 3-Axis Accelerometer Driver"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here if you want to build a driver for the Kionix KXCJK-1013
> +	  triaxial acceleration sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called kxcjk-1013.
> +
>   endmenu
> diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
> index dc0e379..6578ca1 100644
> --- a/drivers/iio/accel/Makefile
> +++ b/drivers/iio/accel/Makefile
> @@ -5,6 +5,7 @@
>   # When adding new entries keep the list in alphabetical order
>   obj-$(CONFIG_BMA180) += bma180.o
>   obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
> +obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
>   obj-$(CONFIG_KXSD9)	+= kxsd9.o
>   obj-$(CONFIG_MMA8452)	+= mma8452.o
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> new file mode 100644
> index 0000000..bbc3a57
> --- /dev/null
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -0,0 +1,729 @@
> +/*
> + * KXCJK-1013 3-axis accelerometer driver
> + * Copyright (c) 2014, Intel Corporation.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/of.h>
> +#include <linux/bitops.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/acpi.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define KXCJK1013_DRV_NAME "kxcjk1013"
> +#define KXCJK1013_IRQ_NAME "kxcjk1013_event"
> +
> +#define KXCJK1013_REG_XOUT_L		0x06
> +/*
> + * From low byte X axis register, all the other addresses of Y and Z can be
> + * obtained by just applying axis offset. The following axis defines are just
> + * provide clarity, but not used.
> + */
> +#define KXCJK1013_REG_XOUT_H		0x07
> +#define KXCJK1013_REG_YOUT_L		0x08
> +#define KXCJK1013_REG_YOUT_H		0x09
> +#define KXCJK1013_REG_ZOUT_L		0x0A
> +#define KXCJK1013_REG_ZOUT_H		0x0B
> +
> +#define KXCJK1013_REG_DCST_RESP		0x0C
> +#define KXCJK1013_REG_WHO_AM_I		0x0F
> +#define KXCJK1013_REG_INT_SRC1		0x16
> +#define KXCJK1013_REG_INT_SRC2		0x17
> +#define KXCJK1013_REG_STATUS_REG	0x18
> +#define KXCJK1013_REG_INT_REL		0x1A
> +#define KXCJK1013_REG_CTRL1		0x1B
> +#define KXCJK1013_REG_CTRL2		0x1D
> +#define KXCJK1013_REG_INT_CTRL1		0x1E
> +#define KXCJK1013_REG_INT_CTRL2		0x1F
> +#define KXCJK1013_REG_DATA_CTRL		0x21
> +#define KXCJK1013_REG_WAKE_TIMER	0x29
> +#define KXCJK1013_REG_SELF_TEST		0x3A
> +#define KXCJK1013_REG_WAKE_THRES	0x6A
> +
> +#define KXCJK1013_REG_CTRL1_BIT_PC1	BIT(7)
> +#define KXCJK1013_REG_CTRL1_BIT_RES	BIT(6)
> +#define KXCJK1013_REG_CTRL1_BIT_DRDY	BIT(5)
> +#define KXCJK1013_REG_CTRL1_BIT_GSEL1	BIT(4)
> +#define KXCJK1013_REG_CTRL1_BIT_GSEL0	BIT(3)
> +#define KXCJK1013_REG_CTRL1_BIT_WUFE	BIT(1)
> +#define KXCJK1013_REG_INT_REG1_BIT_IEA	BIT(4)
> +#define KXCJK1013_REG_INT_REG1_BIT_IEN	BIT(5)
> +
> +#define KXCJK1013_DATA_MASK_12_BIT	0x0FFF
> +#define KXCJK1013_MAX_STARTUP_TIME_US	100000
> +
> +struct kxcjk1013_data {
> +	struct i2c_client *client;
> +	struct iio_trigger *trig;
> +	bool	trig_mode;
Odd spacing?
> +	struct mutex mutex;
> +	s16 buffer[3];
> +	atomic_t power_state;
> +	int gpio_irq;
> +	u8 odr_bits;
> +};
> +
> +enum kxcjk1013_axis {
> +	AXIS_X,
> +	AXIS_Y,
> +	AXIS_Z,
> +};
> +
> +enum kxcjk1013_mode {
> +	STANDBY,
> +	OPERATION,
> +};
> +
> +static const struct {
> +	int val;
> +	int val2;
> +	int odr_bits;
> +} samp_freq_table[] = { {0, 781, 0x08}, {1, 563, 0x09},
> +			{3, 125, 0x0A}, {6, 25, 0x0B}, {12, 5, 0},
> +			{25, 0, 0x01}, {50, 0, 0x02}, {100, 0, 0x03},
> +			{200, 0, 0x04}, {400, 0, 0x05}, {800, 0, 0x06},
> +			{1600, 0, 0x07} };
> +
> +/* Refer to section 4 of the specification */
> +static const struct {
> +	int odr_bits;
> +	int usec;
> +} odr_start_up_times[] = { {0x08, 100000}, {0x09, 100000},
> +			{0x0A, 100000}, {0x0B, 100000}, { 0, 80000},
> +			{0x01, 41000}, {0x02, 21000}, {0x03, 11000},
> +			{0x04, 6400}, {0x05, 3900}, {0x06, 2700},
> +			{0x07, 2100} };
> +
> +static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
> +			      enum kxcjk1013_mode mode)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
> +		return ret;
> +	}
> +
> +	if (mode == STANDBY)
> +		ret &= ~KXCJK1013_REG_CTRL1_BIT_PC1;
> +	else
> +		ret |= KXCJK1013_REG_CTRL1_BIT_PC1;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					KXCJK1013_REG_CTRL1, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int kxcjk1013_chip_setup_polarity(struct kxcjk1013_data *data,
> +					  bool active_high)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
> +		return ret;
> +	}
> +
> +	if (active_high)
> +		ret |= KXCJK1013_REG_INT_REG1_BIT_IEA;
> +	else
> +		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEA;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
> +					ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
This is a wrapper that adds little. I'd get rid of it - particularly
as you never handle any errors it might return anyway! I can see
why you don't handle the errors (nothing much you can do if they
occur) but this function gives a somewhat false sense of security :)
> +static int kxcjk1013_chip_ack_intr(struct kxcjk1013_data *data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_rel\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_WHO_AM_I);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading who_am_i\n");
> +		return ret;
> +	}
> +
> +	dev_dbg(&data->client->dev, "KXCJK1013 Chip Id %x\n", ret);
> +
> +	ret = kxcjk1013_set_mode(data, STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
> +		return ret;
> +	}
> +
> +	/* Setting range to 4G */
> +	ret |= KXCJK1013_REG_CTRL1_BIT_GSEL0;
> +	ret &= ~KXCJK1013_REG_CTRL1_BIT_GSEL1;
> +
> +	/* Set 12 bit mode */
> +	ret |= KXCJK1013_REG_CTRL1_BIT_RES;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					KXCJK1013_REG_CTRL1, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_ctrl\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_DATA_CTRL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_data_ctrl\n");
> +		return ret;
> +	}
> +
> +	data->odr_bits = ret;
> +
> +	/* Active high interrupt */
I suppose starting with this is fine, but it should be ultimately coming
from some form of platform data...
> +	return kxcjk1013_chip_setup_polarity(data, true);
> +}
> +
> +static int kxcjk1013_chip_setup_interrupt(struct kxcjk1013_data *data,
> +					  bool status)
> +{
> +	int ret;
> +
> +	ret = kxcjk1013_set_mode(data, STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
> +		return ret;
> +	}
> +
> +	if (status)
> +		ret |= KXCJK1013_REG_INT_REG1_BIT_IEN;
> +	else
> +		ret &= ~KXCJK1013_REG_INT_REG1_BIT_IEN;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
> +					ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
> +		return ret;
> +	}
> +
> +	if (status)
> +		ret |= KXCJK1013_REG_CTRL1_BIT_DRDY;
> +	else
> +		ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					KXCJK1013_REG_CTRL1, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int kxcjk1013_convert_freq_to_bit(int val, int val2)
> +{
> +	int i;
> +
> +	for (i = 0; ARRAY_SIZE(samp_freq_table); ++i) {
> +		if (samp_freq_table[i].val == val &&
> +			samp_freq_table[i].val2 == val2) {
> +			return samp_freq_table[i].odr_bits;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
> +{
> +	int ret;
> +	int odr_bits;
> +
> +	odr_bits = kxcjk1013_convert_freq_to_bit(val, val2 / 1000);
> +	if (odr_bits < 0)
> +		return odr_bits;
> +
I don't immediately see anything stopping the sampling frequency from
being changed in buffered mode.  If we are in that mode, I think the
next bit of code will stall the data stream and it is never restarted?
It's late on a Saturday though after a nice dinner so I might be missing
the obvious!
> +	ret = kxcjk1013_set_mode(data, STANDBY);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_DATA_CTRL,
> +					odr_bits);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing data_ctrl\n");
> +		return ret;
> +	}
> +
> +	data->odr_bits = odr_bits;
> +
> +	return 0;
> +}
> +
> +static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(samp_freq_table); ++i) {
> +		if (samp_freq_table[i].odr_bits == data->odr_bits) {
> +			*val = samp_freq_table[i].val;
> +			*val2 = samp_freq_table[i].val2 * 1000;
Silly question of the day, why not just store val2 * 1000 in samp_freq_table?
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
This next one is a wrapper we could do without to my mind.  Doesn't
add anything significant.
> +static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
> +{
> +	u8 reg = KXCJK1013_REG_XOUT_L + axis * 2;
> +	int ret;
> +
> +	ret = i2c_smbus_read_word_data(data->client, reg);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev,
> +			"failed to read accel_%c registers\n", 'x' + axis);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(odr_start_up_times); ++i) {
> +		if (odr_start_up_times[i].odr_bits == data->odr_bits)
> +			return odr_start_up_times[i].usec;
> +
> +	}
> +
> +	return KXCJK1013_MAX_STARTUP_TIME_US;
> +}
> +
> +static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan, int *val, int *val2,
> +		long mask)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&data->mutex);
> +		if (iio_buffer_enabled(indio_dev))
> +			ret = -EBUSY;
> +		else {
> +			int sleep_val;
> +
> +			ret = kxcjk1013_set_mode(data, OPERATION);
> +			if (ret < 0)
> +				return ret;
> +			atomic_inc(&data->power_state);
> +			sleep_val = kxcjk1013_get_startup_times(data);
> +			if (sleep_val < 20000)
> +				usleep_range(sleep_val, 20000);
> +			else
> +				msleep_interruptible(sleep_val/1000);
> +			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
> +			if (atomic_dec_and_test(&data->power_state))
> +				kxcjk1013_set_mode(data, STANDBY);
> +		}
> +		mutex_unlock(&data->mutex);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = sign_extend32(le16_to_cpu(ret >> 4), 11);
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 19163; /* range +-4g (4/2047*9.806650) */
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = kxcjk1013_get_odr(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		return ret;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int kxcjk1013_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan, int val, int val2, long mask)
> +{
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->mutex);
> +		ret = kxcjk1013_set_odr(data, val, val2);
> +		mutex_unlock(&data->mutex);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> +		"0.781 1.563 3.125 6.25 12.5 25 50 100 200 400 800 1600");
> +
> +static struct attribute *kxcjk1013_attributes[] = {
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group kxcjk1013_attrs_group = {
> +	.attrs = kxcjk1013_attributes,
> +};
> +
> +#define KXCJK1013_CHANNEL(_axis) {					\
> +	.type = IIO_ACCEL,						\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##_axis,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
> +	.scan_index = AXIS_##_axis,					\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 12,						\
> +		.storagebits = 16,					\
> +		.shift = 4,						\
> +		.endianness = IIO_LE,					\
> +	},								\
> +}
> +
> +static const struct iio_chan_spec kxcjk1013_channels[] = {
> +	KXCJK1013_CHANNEL(X),
> +	KXCJK1013_CHANNEL(Y),
> +	KXCJK1013_CHANNEL(Z),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static const struct iio_info kxcjk1013_info = {
> +	.attrs			= &kxcjk1013_attrs_group,
> +	.read_raw		= kxcjk1013_read_raw,
> +	.write_raw		= kxcjk1013_write_raw,
> +	.driver_module		= THIS_MODULE,
> +};
> +
> +static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int64_t time_ns = iio_get_time_ns();
you could use the  iio_pollfunc_store_time top half interrupt handler
to push this a little closer to the actual interrupt (don't bother if
you would prefer not).
(curriously whilst checking what that does I've just noticed we still
had a time arguement to the iio_trigger_poll functions despite the fact
the do nothing with it any more. Oops. One to clear out :)
> +	int bit, ret, i = 0;
> +
> +	mutex_lock(&data->mutex);
> +
> +	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
> +			 indio_dev->masklength) {
> +		ret = kxcjk1013_get_acc_reg(data, bit);
> +		if (ret < 0) {
> +			kxcjk1013_chip_ack_intr(data);
> +			mutex_unlock(&data->mutex);
> +			goto err;
> +		}
> +		data->buffer[i++] = ret;
> +	}
> +
> +	kxcjk1013_chip_ack_intr(data);
> +
> +	mutex_unlock(&data->mutex);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer, time_ns);
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +		bool state)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	if (state) {
> +		kxcjk1013_chip_setup_interrupt(data, true);
> +		kxcjk1013_set_mode(data, OPERATION);
> +		atomic_inc(&data->power_state);
> +	} else {
> +		if (!atomic_dec_and_test(&data->power_state))
> +			return 0;
> +		kxcjk1013_chip_setup_interrupt(data, false);
> +		kxcjk1013_set_mode(data, STANDBY);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
> +	.set_trigger_state = kxcjk1013_data_rdy_trigger_set_state,
> +	.owner = THIS_MODULE,
> +};
> +
> +static int kxcjk1013_acpi_gpio_probe(struct i2c_client *client,
> +				struct kxcjk1013_data *data)
> +{
> +	const struct acpi_device_id *id;
> +	struct device *dev;
> +	struct gpio_desc *gpio;
> +	int ret;
> +
> +	if (!client)
> +		return -EINVAL;
> +
> +	dev = &client->dev;
> +	if (!ACPI_HANDLE(dev))
> +		return -ENODEV;
> +
Silly question, but does acpi not allow non gpio irqs?
I can't see anything in this driver that requires it to be a gpio?
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +	/* data ready gpio interrupt pin */
> +	gpio = devm_gpiod_get_index(dev, "kxcjk1013_int", 0);
> +	if (IS_ERR(gpio)) {
> +		dev_err(dev, "acpi gpio get index failed\n");
> +		return PTR_ERR(gpio);
> +	}
> +
> +	ret = gpiod_direction_input(gpio);
I'm happy to accept that this is necessary but its uggly that we need to
set the direction here.
> +	if (ret)
> +		return ret;
> +
> +	ret = gpiod_to_irq(gpio);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->gpio_irq = ret;
> +
> +	/* Update client irq if it is invalid */
> +	if (client->irq < 0)
> +		client->irq = data->gpio_irq;
As commented below, why not check this first and not bother with the rest
if client->irq >= 0
Also isn't an irq of 0 always defined as bad these days? (I think this
finally got unwound on ARM a while back).
> +
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio),
> +							data->gpio_irq);
> +
> +	return 0;
> +}
> +
> +static int kxcjk1013_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	struct kxcjk1013_data *data;
> +	struct iio_dev *indio_dev;
> +	struct iio_trigger *trig = NULL;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	ret = kxcjk1013_chip_init(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = kxcjk1013_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
> +	indio_dev->name = KXCJK1013_DRV_NAME;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &kxcjk1013_info;
> +
> +	kxcjk1013_acpi_gpio_probe(client, data);
No error handling for this?  Perhaps checking before this if the
irq is already defined rather than going through all the acpi calls
then ignoring it if already present.

> +
> +	if (client->irq < 0) {
> +		kxcjk1013_chip_setup_interrupt(data, false);
> +		goto skip_setup_trigger;
Personally I'd prefer the logic reversed and avoid the goto.
It'll add a level of indentation, but I think it'd still be a smigeon easier
to follow.
> +	}
> +
> +	trig = iio_trigger_alloc("%s-dev%d", indio_dev->name, indio_dev->id);
> +	if (!trig)
> +		return -ENOMEM;
> +
> +	data->trig_mode = true;
> +
> +	ret = devm_request_irq(&client->dev, client->irq,
> +			iio_trigger_generic_data_rdy_poll,
> +			IRQF_TRIGGER_RISING, KXCJK1013_IRQ_NAME, trig);
> +	if (ret) {
> +		dev_err(&client->dev, "unable to request IRQ\n");
> +		goto err_trigger_free;
> +	}
> +
> +	trig->dev.parent = &client->dev;
> +	trig->ops = &kxcjk1013_trigger_ops;
> +	iio_trigger_set_drvdata(trig, indio_dev);
> +	data->trig = trig;
> +	indio_dev->trig = trig;
> +
> +	ret = iio_trigger_register(trig);
> +	if (ret)
> +		goto err_trigger_free;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +			kxcjk1013_trigger_handler, NULL);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "iio triggered buffer setup failed\n");
> +		goto err_trigger_unregister;
> +	}
> +
> +skip_setup_trigger:
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "unable to register iio device\n");
> +		if (data->trig_mode)
> +			goto err_buffer_cleanup;
> +		else
> +			return ret;
This a slightly convoluted bit of flow. I'd be tempted to just have
all the trigger removal protected by if (data->trig_mode).
It'll give more code and a fair bit of repition but straight forward
flow.  Usual arguement that I'd like every driver to look the same
as it makes my life easier ;)
> +	}
> +
> +	return 0;
> +
> +err_buffer_cleanup:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +err_trigger_unregister:
> +	iio_trigger_unregister(trig);
> +err_trigger_free:
> +	iio_trigger_free(trig);
> +
> +	return ret;
> +}
> +
> +static int kxcjk1013_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	if (data->trig_mode) {
> +		iio_triggered_buffer_cleanup(indio_dev);
> +		iio_trigger_unregister(data->trig);
> +		iio_trigger_free(data->trig);
> +	}
> +
> +	mutex_lock(&data->mutex);
> +	kxcjk1013_set_mode(data, STANDBY);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int kxcjk1013_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +
> +	mutex_lock(&data->mutex);
> +	kxcjk1013_set_mode(data, STANDBY);
> +	mutex_unlock(&data->mutex);
> +
> +	return 0;
> +}
Is this absense of a resume putting the state back as it was going
to cause any unexpected behaviour?  My first thought is that
you might have a buffer associated with the trigger that seems to be
enabled, but will never receive any data after a suspend / resume cycle.

> +

> +static SIMPLE_DEV_PM_OPS(kxcjk1013_pm_ops, kxcjk1013_suspend, NULL);
> +#define KXCJK1013_PM_OPS (&kxcjk1013_pm_ops)
> +#else
> +#define KXCJK1013_PM_OPS NULL
> +#endif
> +
> +static const struct acpi_device_id kx_acpi_match[] = {
> +	{"KXCJ1013", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
> +
> +static const struct i2c_device_id kxcjk1013_id[] = {
> +	{"kxcjk1013", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
> +
> +static struct i2c_driver kxcjk1013_driver = {
> +	.driver = {
> +		.name	= KXCJK1013_DRV_NAME,
> +		.acpi_match_table = ACPI_PTR(kx_acpi_match),
> +		.pm	= KXCJK1013_PM_OPS,
> +	},
> +	.probe		= kxcjk1013_probe,
> +	.remove		= kxcjk1013_remove,
> +	.id_table	= kxcjk1013_id,
> +};
> +module_i2c_driver(kxcjk1013_driver);
> +
> +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("KXCJK1013 accelerometer driver");
>

