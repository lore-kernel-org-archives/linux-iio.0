Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:55872 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965355AbdKGQ2o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 Nov 2017 11:28:44 -0500
Date: Tue, 7 Nov 2017 17:28:42 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Christoph Fritz <chf.fritz@googlemail.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: add support for Intersil isl76683
 sensor
In-Reply-To: <1510068983-25769-2-git-send-email-chf.fritz@googlemail.com>
Message-ID: <alpine.DEB.2.20.1711071645280.31533@vps.pmeerw.net>
References: <1510068983-25769-1-git-send-email-chf.fritz@googlemail.com> <1510068983-25769-2-git-send-email-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 7 Nov 2017, Christoph Fritz wrote:

> This patch adds support for Intersil isl76683 light sensor.

nitpicking in subject: maybe 'Add support...', start uppercase 
more comments below
 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/iio/light/Kconfig    |  12 +
>  drivers/iio/light/Makefile   |   1 +
>  drivers/iio/light/isl76683.c | 693 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 706 insertions(+)
>  create mode 100644 drivers/iio/light/isl76683.c
> 
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 2356ed9..4f0882c 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -194,6 +194,18 @@ config ISL29125
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called isl29125.
>  
> +config ISL76683
> +	tristate "Intersil ISL76683 light sensor"
> +	depends on I2C
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  Say Y here if you want to build a driver for the Intersil ISL76683
> +	  light sensor for I2C.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called isl76683.
> +
>  config HID_SENSOR_ALS
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index fa32fa4..886a51f 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
>  obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
>  obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
>  obj-$(CONFIG_ISL29125)		+= isl29125.o
> +obj-$(CONFIG_ISL76683)		+= isl76683.o
>  obj-$(CONFIG_JSA1212)		+= jsa1212.o
>  obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
>  obj-$(CONFIG_LTR501)		+= ltr501.o
> diff --git a/drivers/iio/light/isl76683.c b/drivers/iio/light/isl76683.c
> new file mode 100644
> index 0000000..b730276
> --- /dev/null
> +++ b/drivers/iio/light/isl76683.c
> @@ -0,0 +1,693 @@
> +/*
> + * IIO driver for the light sensor ISL76683.
> + *
> + * Copyright (c) 2017 Christoph Fritz <chf.fritz@googlemail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * Datasheet:
> + *  http://www.intersil.com/content/dam/Intersil/documents/isl7/isl76683.pdf
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/util_macros.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define ISL76683_REG_CMD		0x00
> +#define ISL76683_REG_CTRL		0x01
> +#define ISL76683_REG_THR_HI		0x02
> +#define ISL76683_REG_THR_LO		0x03
> +#define ISL76683_REG_SENSOR_L		0x04

maybe L -> LSB, M -> MSB to make it more clear
OTOH SENSOR_M is not really used, so could drop as well and maybe add a 
comment to denote that data is 16-bit little endian

> +#define ISL76683_REG_SENSOR_M		0x05
> +#define ISL76683_REG_CLEAR_INT		0x40
> +#define ISL76683_REGMAP_MAX		0x40
> +
> +#define ISL76683_CMD_ENABLE		BIT(7)
> +#define ISL76683_CMD_PWRDWN		BIT(6)
> +#define ISL76683_WIDTH_MASK		0x3
> +#define ISL76683_PHOTOD_SHFT		2
> +#define ISL76683_PHOTOD_MASK		(0x3 << ISL76683_PHOTOD_SHFT)

could use GENMASK()

> +#define ISL76683_INTPERS_MASK		0x3
> +#define ISL76683_LUXRANGE_SHFT		2
> +#define ISL76683_LUXRANGE_MASK		(0x3 << ISL76683_LUXRANGE_SHFT)
> +#define ISL76683_LUXRANGE_STR		"1000 4000 16000 64000"
> +
> +enum isl76683_dmode {
> +	ISL76683_DIODE_0 = 0,
> +	ISL76683_DIODE_IR,
> +	ISL76683_DIODE_DIFF,
> +};
> +
> +enum isl76683_lux_range {
> +	ISL76683_LUX_1000 = 0,
> +	ISL76683_LUX_4000,
> +	ISL76683_LUX_16000,
> +	ISL76683_LUX_64000,
> +};
> +
> +static const int isl76683_lux_ranges_available[] = {
> +	1000, 4000, 16000, 64000};
> +
> +#define ISL76683_LUX_RANGE_DEFAULT	ISL76683_LUX_1000
> +#define ISL76683_DIODE_MAX		ISL76683_DIODE_DIFF
> +#define ISL76683_DIODE_DEFAULT		ISL76683_DIODE_0
> +#define ISL76683_WIDTH_DEFAULT		0x0
> +#define ISL76683_RESOLUTION_DEFAULT	16
> +#define ISL76683_EXT_RESISTOR_DEFAULT	100
> +#define ISL76683_KOHM_MIN		1
> +#define ISL76683_KOHM_MAX		1000
> +#define ISL76683_INTPERS_DEFAULT	0x0
> +#define ISL76683_THR_DEFAULT		0x7f
> +
> +struct isl76683_chip {
> +	enum isl76683_lux_range	luxrange;
> +	int			external_resistor;
> +	enum isl76683_dmode	photodiode;
> +	struct i2c_client	*client;
> +	struct regmap		*rmp;
> +	struct completion	irq_complete;
> +	struct iio_trigger	*trig;
> +	bool			trig_enabled;
> +	struct mutex		lock;
> +	__le16			*buffer;

isl76683_trigger_handler() stores the already endianness-converted value 
into buffer, so type should be u16?

why do we need buffer at all?

> +	s64			time_ns;
> +	bool			buffer_running;
> +};
> +
> +static bool isl76683_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ISL76683_REG_CMD:
> +	case ISL76683_REG_CTRL:
> +	case ISL76683_REG_THR_HI:
> +	case ISL76683_REG_THR_LO:
> +	case ISL76683_REG_SENSOR_L:
> +	case ISL76683_REG_SENSOR_M:
> +	case ISL76683_REG_CLEAR_INT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool isl76683_writeable_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ISL76683_REG_CMD:
> +	case ISL76683_REG_CTRL:
> +	case ISL76683_REG_THR_HI:
> +	case ISL76683_REG_THR_LO:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool isl76683_is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case ISL76683_REG_SENSOR_L:
> +	case ISL76683_REG_SENSOR_M:
> +	case ISL76683_REG_CLEAR_INT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config isl76683_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = ISL76683_REGMAP_MAX,
> +	.readable_reg = isl76683_readable_reg,
> +	.writeable_reg = isl76683_writeable_reg,
> +	.volatile_reg = isl76683_is_volatile_reg,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
> +static int isl76683_set_config(struct isl76683_chip *chip)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(chip->rmp, ISL76683_REG_CTRL,
> +				ISL76683_LUXRANGE_MASK | ISL76683_INTPERS_MASK,
> +				(chip->luxrange << ISL76683_LUXRANGE_SHFT) |
> +				ISL76683_INTPERS_DEFAULT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(chip->rmp, ISL76683_REG_CMD,
> +				ISL76683_PHOTOD_MASK | ISL76683_WIDTH_MASK,
> +				(chip->photodiode << ISL76683_PHOTOD_SHFT) |
> +				ISL76683_WIDTH_DEFAULT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(chip->rmp, ISL76683_REG_THR_HI,
> +				ISL76683_THR_DEFAULT);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_write(chip->rmp, ISL76683_REG_THR_LO,
> +				ISL76683_THR_DEFAULT);

could just 
return regmap_write(...);

> +	if (ret < 0)
> +
> +	return 0;
> +}
> +
> +static int isl76683_power(struct isl76683_chip *chip, bool on)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(chip->rmp, ISL76683_REG_CMD,
> +				ISL76683_CMD_ENABLE | ISL76683_CMD_PWRDWN,
> +				0x0);
> +	if (ret < 0)
> +		return ret;

why are these bits first set to 0 and then bits are written with a 
separate command?
is this a requirement of the chip to clear and set?

> +
> +	ret = regmap_update_bits(chip->rmp, ISL76683_REG_CMD,
> +				ISL76683_CMD_ENABLE | ISL76683_CMD_PWRDWN,
> +				on ? ISL76683_CMD_ENABLE : ISL76683_CMD_PWRDWN);
> +	if (ret < 0)
> +		return ret;
> +
> +	return on ? isl76683_set_config(chip) : 0;
> +}
> +
> +static int isl76683_reset(struct isl76683_chip *chip)
> +{
> +	int ret;
> +
> +	ret = isl76683_power(chip, false);
> +	if (ret < 0)
> +		return ret;

is an explicit delay needed here? just curious...

> +
> +	return isl76683_power(chip, true);
> +}
> +
> +static int isl76683_read_lux(struct isl76683_chip *chip,
> +			     bool is_processed, int *val)
> +{
> +	unsigned int sensor_data, range, fsr;
> +	__le16 sensor_raw;
> +	int ret;
> +
> +	ret = regmap_bulk_read(chip->rmp, ISL76683_REG_SENSOR_L,
> +				&sensor_raw, sizeof(sensor_raw));
> +	if (ret)
> +		return ret;
> +
> +	sensor_data = le16_to_cpu(sensor_raw);
> +
> +	if (!is_processed) {

in this case sensor_data is probably NOT in lux?
function name read_lux() is misleading?

> +		*val = sensor_data;
> +		return 0;
> +	}
> +
> +	/* range values taken from datasheet (table 9) */
> +	if (chip->luxrange == ISL76683_LUX_1000)
> +		range = 973;
> +	else if (chip->luxrange == ISL76683_LUX_4000)
> +		range = 3892;
> +	else if (chip->luxrange == ISL76683_LUX_16000)
> +		range = 15568;
> +	else if (chip->luxrange == ISL76683_LUX_64000)
> +		range = 62272;
> +	else
> +		return -EINVAL;
> +
> +	/* equations from datasheet (EQ.3 and EQ.4) */
> +	fsr = (100 * range) / chip->external_resistor;
> +	*val = (fsr * sensor_data) / (1 << ISL76683_RESOLUTION_DEFAULT);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t isl76683_interrupt_handler(int irq, void *private)
> +{
> +	struct iio_dev *indio_dev = private;
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +
> +	chip->time_ns = iio_get_time_ns(indio_dev);
> +
> +	if (chip->trig_enabled)
> +		iio_trigger_poll(chip->trig);
> +
> +	if (!completion_done(&chip->irq_complete))
> +		complete(&chip->irq_complete);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static inline int isl76683_start_measurement(struct isl76683_chip *chip)
> +{
> +	int dummy;
> +
> +	/* dummy read is clearing irq and triggers new measurement */
> +	return regmap_read(chip->rmp, ISL76683_REG_CLEAR_INT, &dummy);
> +}
> +
> +static int isl76683_singleshot_conversion(struct isl76683_chip *chip,
> +					  const struct iio_chan_spec *chan,
> +					  bool is_processed, int *val)
> +{
> +	long timeout;
> +	int ret;
> +
> +	if (chip->buffer_running)
> +		return -EAGAIN;
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_LIGHT_BOTH:
> +		chip->photodiode = ISL76683_DIODE_DIFF;
> +		break;
> +	case IIO_MOD_LIGHT_IR:
> +		chip->photodiode = ISL76683_DIODE_IR;
> +		break;
> +	default:
> +		chip->photodiode = ISL76683_DIODE_0;
> +	}
> +
> +	ret = isl76683_set_config(chip);
> +	if (ret)
> +		return ret;
> +
> +	ret = isl76683_start_measurement(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* wait for measurement to complete */
> +	timeout = wait_for_completion_interruptible_timeout(
> +			&chip->irq_complete,
> +			msecs_to_jiffies(5000));
> +	if (timeout == 0) {
> +		dev_err(&chip->client->dev, "measurement timed out\n");
> +		return -ETIMEDOUT;
> +	} else if (timeout < 0) {
> +		dev_err(&chip->client->dev, "wait for measurement failed\n");
> +		return -EINTR;
> +	}
> +
> +	ret = isl76683_read_lux(chip, is_processed, val);
> +	if (ret) {
> +		dev_err(&chip->client->dev, "%s: Error %d reading lux\n",
> +				__func__, ret);
> +		return ret;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static irqreturn_t isl76683_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +	__le16 buf;
> +	int ret;
> +
> +	ret = regmap_bulk_read(chip->rmp, ISL76683_REG_SENSOR_L, &buf, 2);

sizeof(buf)

> +	if (ret)
> +		return ret;
> +
> +	chip->buffer[0] = le16_to_cpu(buf);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, chip->buffer,
> +					   chip->time_ns);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	ret = isl76683_start_measurement(chip);
> +	if (ret < 0)
> +		return ret;

I think even if this fails IRQ_HANDLED should be returned

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int isl76683_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +
> +	mutex_lock(&chip->lock);
> +	chip->buffer_running = true;
> +	mutex_unlock(&chip->lock);

should set_config() be also protected by the mutex?

> +	chip->photodiode = indio_dev->channels[0].channel2;
> +	return isl76683_set_config(chip);
> +}
> +
> +static int isl76683_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +
> +	chip->buffer_running = false;
> +	return 0;
> +}
> +
> +static const struct iio_buffer_setup_ops isl76683_buffer_setup_ops = {
> +	.preenable = &isl76683_buffer_preenable,
> +	.postdisable = &isl76683_buffer_postdisable,
> +	.predisable = iio_triggered_buffer_predisable,
> +	.postenable = iio_triggered_buffer_postenable,
> +	.validate_scan_mask = &iio_validate_scan_mask_onehot,
> +};
> +
> +static int isl76683_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&chip->lock);
> +		ret = isl76683_singleshot_conversion(chip, chan, false, val);
> +		mutex_unlock(&chip->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		mutex_lock(&chip->lock);
> +		ret = isl76683_singleshot_conversion(chip, chan, true, val);
> +		mutex_unlock(&chip->lock);
> +		return ret;
> +	case IIO_CHAN_INFO_HARDWAREGAIN:

use _SCALE?

> +		*val = isl76683_lux_ranges_available[chip->luxrange];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int isl76683_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		mutex_lock(&chip->lock);
> +		chip->luxrange = find_closest(val,
> +			isl76683_lux_ranges_available,
> +			ARRAY_SIZE(isl76683_lux_ranges_available));
> +		ret = isl76683_set_config(chip);
> +		mutex_unlock(&chip->lock);
> +		return ret;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static IIO_CONST_ATTR(in_illuminance_hardwaregain_available,
> +		ISL76683_LUXRANGE_STR);
> +
> +static struct attribute *isl76683_attributes[] = {
> +	&iio_const_attr_in_illuminance_hardwaregain_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group isl76683_attribute_group = {
> +	.attrs = isl76683_attributes,
> +};
> +
> +#define ISL76683_CHANNEL_2(_ch2, _si) { \

why _2?

> +	.type = IIO_LIGHT, \
> +	.modified = 1, \
> +	.channel2 = _ch2, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> +			BIT(IIO_CHAN_INFO_PROCESSED), \

for INFO_RAW the measurement is not in lux, hence IIO_INTENSITY should be 
used? why have _RAW and _PROCESSED?

the computation in the _PROCESSED path should ideally go into the _SCALE 
factor


> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN), \

I think this should be _SCALE rather

> +	.scan_index = _si, \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \

you can/should specify IIO_LE and save the endianness conversion in 
isl76683_trigger_handler()

> +	}, \
> +}
> +
> +static const struct iio_chan_spec isl76683_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_PROCESSED),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,
> +		},
> +	},
> +	ISL76683_CHANNEL_2(IIO_MOD_LIGHT_IR, 1),
> +	ISL76683_CHANNEL_2(IIO_MOD_LIGHT_BOTH, 2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static int isl76683_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *scan_mask)
> +{
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +
> +	kfree(chip->buffer);
> +	chip->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);

most drivers do static allocation of the buffer, i.e. 2 bytes + 6 bytes 
padding + 8 bytes timestamp

> +	if (chip->buffer == NULL)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info isl76683_info = {
> +	.update_scan_mode = isl76683_update_scan_mode,
> +	.read_raw = isl76683_read_raw,
> +	.write_raw = isl76683_write_raw,
> +	.attrs = &isl76683_attribute_group,
> +	.driver_module = THIS_MODULE,

THIS_MODULE not needed anymore

> +};
> +
> +static int isl76683_set_trigger_state(struct iio_trigger *trig, bool enable)
> +{
> +	struct isl76683_chip *chip = iio_trigger_get_drvdata(trig);
> +	int ret;
> +
> +	if (enable) {
> +		chip->trig_enabled = true;
> +		ret = isl76683_start_measurement(chip);
> +		if (ret < 0)
> +			return ret;
> +	} else
> +		chip->trig_enabled = false;
> +
> +	return 0;
> +}
> +
> +static const struct iio_trigger_ops isl76683_trigger_ops = {
> +	.owner = THIS_MODULE,
> +	.set_trigger_state = isl76683_set_trigger_state,
> +	.validate_device = iio_trigger_validate_own_device,
> +};
> +
> +static int isl76683_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct isl76683_chip *chip;
> +	struct iio_dev *indio_dev;
> +	struct device_node *np = client->dev.of_node;
> +	int rs = ISL76683_EXT_RESISTOR_DEFAULT;
> +	int v, ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	i2c_set_clientdata(client, indio_dev);
> +	chip->client = client;
> +
> +	if (np) {
> +		ret = of_property_read_u32(np, "isil,external-resistor", &v);
> +		if (ret || v < ISL76683_KOHM_MIN || v > ISL76683_KOHM_MAX)
> +			dev_warn(&client->dev,
> +				 "assuming %i kOhm resistor\n", rs);

I'd rather fail if the value is incorrect (matter of taste)

> +		else
> +			rs = v;
> +	}
> +
> +	chip->luxrange = ISL76683_LUX_RANGE_DEFAULT;
> +	chip->external_resistor = rs;
> +	chip->photodiode = ISL76683_DIODE_DEFAULT;
> +	chip->buffer_running = false;
> +
> +	chip->rmp = devm_regmap_init_i2c(client, &isl76683_regmap_config);
> +	if (IS_ERR(chip->rmp)) {
> +		ret = PTR_ERR(chip->rmp);
> +		dev_err(&client->dev, "%s: Error %d initializing regmap\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	mutex_init(&chip->lock);
> +
> +	init_completion(&chip->irq_complete);
> +
> +	if (!client->irq) {
> +		dev_err(&client->dev, "no interrupt configured\n");
> +		return -EINVAL;
> +	}
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->info = &isl76683_info;
> +	indio_dev->channels = isl76683_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(isl76683_channels);
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	chip->trig_enabled = false;
> +	chip->trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
> +			indio_dev->name, indio_dev->id);
> +	if (!chip->trig)
> +		return -ENOMEM;
> +
> +	chip->trig->ops = &isl76683_trigger_ops;
> +	chip->trig->dev.parent = &client->dev;
> +	iio_trigger_set_drvdata(chip->trig, chip);
> +
> +	ret = devm_request_irq(&client->dev, client->irq,
> +			isl76683_interrupt_handler,
> +			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			"isl76683_event", indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "irq request error\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_trigger_register(&client->dev, chip->trig);
> +	if (ret) {
> +		dev_err(&client->dev, "iio_trigger register error\n");
> +		return ret;
> +	}
> +
> +	ret = isl76683_reset(chip);
> +	if (ret) {
> +		dev_err(&client->dev, "reset failed\n");
> +		return ret;
> +	}
> +
> +	ret = isl76683_read_lux(chip, false, &v);
> +	if (ret) {
> +		dev_err(&client->dev, "initial dummy readout failed\n");
> +		return ret;
> +	}
> +
> +	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
> +			&isl76683_trigger_handler, &isl76683_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev,
> +			"%s(): iio registration failed with error %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int isl76683_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct isl76683_chip *chip = iio_priv(indio_dev);
> +
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	isl76683_power(chip, false);
> +	kfree(chip->buffer);
> +
> +	return 0;
> +}
> +
> +#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
> +static int isl76683_runtime_suspend(struct device *dev)
> +{
> +	struct isl76683_chip *chip =
> +		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	ret = isl76683_power(chip, false);
> +	regcache_mark_dirty(chip->rmp);
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static int isl76683_runtime_resume(struct device *dev)
> +{
> +	struct isl76683_chip *chip =
> +		iio_priv(i2c_get_clientdata(to_i2c_client(dev)));
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	ret = isl76683_power(chip, true);
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +#endif
> +
> +static const struct dev_pm_ops isl76683_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(isl76683_runtime_suspend,
> +			   isl76683_runtime_resume, NULL)
> +};
> +
> +static const struct i2c_device_id isl76683_id[] = {
> +	{"isl76683", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, isl76683_id);
> +
> +static const struct of_device_id isl76683_of_match[] = {
> +	{ .compatible = "isil,isl76683", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, isl76683_of_match);
> +
> +static struct i2c_driver isl76683_driver = {
> +	.driver  = {
> +		.name = "isl76683",
> +		.of_match_table = isl76683_of_match,
> +		.pm = &isl76683_pm_ops,
> +	},
> +	.probe = isl76683_probe,
> +	.remove = isl76683_remove,
> +	.id_table = isl76683_id,
> +};
> +
> +module_i2c_driver(isl76683_driver);
> +
> +MODULE_DESCRIPTION("ISL76683 Ambient Light Sensor driver");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Christoph Fritz <chf.fritz@googlemail.com>");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
