Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-090.synserver.de ([212.40.185.90]:1092 "EHLO
	smtp-out-088.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751124Ab3A3PVd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jan 2013 10:21:33 -0500
Message-ID: <51093AB8.2070809@metafoo.de>
Date: Wed, 30 Jan 2013 16:22:32 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
Subject: Re: [PATCH] iio: gyro: Add itg3200
References: <1345192038-5665-1-git-send-email-not@iis.fhg.de> <1359471547-32178-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1359471547-32178-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/2013 03:59 PM, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

Hi,

Looks mostly good. One usage of outdated API and otherwise mostly just minor
style issues.

[...]
> +obj-$(CONFIG_ITG3200)   += itg3200.o
> diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> new file mode 100644
> index 0000000..6242705
> --- /dev/null
> +++ b/drivers/iio/gyro/itg3200_buffer.c
> @@ -0,0 +1,83 @@
> +/*
> + * itg3200_ring.c -- support InvenSense ITG3200
> + *                   Digital 3-Axis Gyroscope driver
> + *
> + * Copyright (c) 2011 Christian Strobel <christian.strobel@iis.fraunhofer.de>
> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> + * Copyright (c) 2012 Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/gyro/itg3200.h>
> +
> +static irqreturn_t itg3200_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	__be16 buf[ITG3200_SCAN_ELEMENTS + sizeof(s64)/sizeof(u16)];
> +
> +	/* Clear IRQ */
> +	itg3200_read_irq_status(indio_dev);
> +
> +	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {
> +		int ret;
> +		unsigned i, j = 0;
> +
> +		ret = itg3200_read_all_channels(st->i2c, buf);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		/* Select only active scan elements */
> +		for (i = 0; i < ITG3200_SCAN_ELEMENTS; i++)
> +			if (iio_scan_mask_query(indio_dev, buffer, i))
> +				buf[j++] = buf[i];

The IIO core can take care of this kind of demuxing for you. If you set
available_scan_masks to { 0xffff..., 0x0 } it will know that the device will
only be able to sample all channels at once. A user will still be able to
select a subset of channels and the IIO core will take care of picking the
right samples.

> +	}
> +
> +	if (indio_dev->scan_timestamp)
> +		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
> +				&pf->timestamp, sizeof(pf->timestamp));
> +
> +	iio_push_to_buffer(buffer, (u8 *)buf, pf->timestamp);

This won't work in the latest version of IIO, use

iio_push_to_buffers(indio_dev, (u8 *)buf); instead

> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +error_ret:
> +	return IRQ_HANDLED;
> +}
> +
> +
> +int itg3200_buffer_configure(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +		itg3200_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	/* Set default scan mode */
> +	iio_scan_mask_set(indio_dev, indio_dev->buffer, ITG3200_SCAN_TEMP);
> +	iio_scan_mask_set(indio_dev, indio_dev->buffer, ITG3200_SCAN_GYRO_X);
> +	iio_scan_mask_set(indio_dev, indio_dev->buffer, ITG3200_SCAN_GYRO_Y);
> +	iio_scan_mask_set(indio_dev, indio_dev->buffer, ITG3200_SCAN_GYRO_Z);

I think it's better to be consistent with other IIO device driver and just
leave the default to all disabled.

> +
> +	return 0;
> +}
> +
> +void itg3200_buffer_unconfigure(struct iio_dev *indio_dev)
> +{
> +	iio_triggered_buffer_cleanup(indio_dev);
> +}
> diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
> new file mode 100644
> index 0000000..e1e835e
> --- /dev/null
> +++ b/drivers/iio/gyro/itg3200_core.c
[...]
> +
> +static int itg3200_read_raw(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long info)
> +{
> +	ssize_t ret = 0;

The return type of the function is ssize_t.

> +	u8 reg;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		reg = (u8)chan->address;
> +		ret = itg3200_read_reg_s16(indio_dev, reg, val);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		if (chan->type == IIO_TEMP)
> +			*val2 = 1000000000/280;
> +		else
> +			*val2 = 1214142; /* (1 / 14,375) * (PI / 180) */
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Only the temperature channel has an offset */
> +		*val = 23000;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t itg3200_read_frequency(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	int ret, len = 0;
> +	u8 val;
> +	int sps;
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_DLPF, &val);
> +	if (ret)
> +		return ret;
> +
> +	sps = (val & ITG3200_DLPF_CFG_MASK) ? 1000 : 8000;
> +
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_SAMPLE_RATE_DIV, &val);
> +	if (ret)
> +		return ret;
> +
> +	sps /= val + 1;
> +
> +	len = sprintf(buf, "%d\n", sps);
> +	return len;

A bit shorter:

return sprintf(buf, "%d\n", sps);

> +}
> +
[...]
> +
> +/* Reset device and internal registers to the power-up-default settings
> + * Use the gyro clock as reference, as suggested by the datasheet */

Normally multi-line comments look like:

/*
 * ...
 * ...
 */

> +static int itg3200_reset(struct iio_dev *indio_dev)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	dev_dbg(&st->i2c->dev, "reset device");
> +
> +	ret = itg3200_write_reg_8(indio_dev,
> +			ITG3200_REG_POWER_MANAGEMENT,
> +			ITG3200_RESET);
> +	if (ret) {
> +		dev_err(&st->i2c->dev, "error resetting device");
> +		goto error_ret;
> +	}
> +
> +	/* Wait for PLL (1ms according to datasheet) */
> +	udelay(1500);
> +
> +	ret = itg3200_write_reg_8(indio_dev,
> +			ITG3200_REG_IRQ_CONFIG,
> +			ITG3200_IRQ_ACTIVE_HIGH |
> +			ITG3200_IRQ_PUSH_PULL |
> +			ITG3200_IRQ_LATCH_50US_PULSE |
> +			ITG3200_IRQ_LATCH_CLEAR_ANY);
> +
> +	if (ret)
> +		dev_err(&st->i2c->dev, "error init device");
> +
> +error_ret:
> +	return ret;
> +}
> +
> +/** itg3200_enable_full_scale() - Disables the digital low pass filter */

'/**' is used for kernel doc comments.

> +static int itg3200_enable_full_scale(struct iio_dev *indio_dev)
> +{
[...]
> +}
> +
> +static int itg3200_initial_setup(struct iio_dev *indio_dev)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	u8 val;
> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_ADDRESS, &val);
> +	if (ret)
> +		goto err_ret;
> +
> +	if (((val >> 1) & 0x3f) != 0x34) {
> +		dev_err(&st->i2c->dev, "invalid reg value 0x%02x", val);
> +		ret = -ENXIO;
> +		goto err_ret;
> +	}
> +
> +	ret = itg3200_reset(indio_dev);
> +	if (ret)
> +		goto err_ret;
> +
> +	ret = itg3200_enable_full_scale(indio_dev);
> +
> +	pr_info("%s initialized", indio_dev->name);

This line is just noise, please remove it.

> +err_ret:
> +	return ret;
> +}
> +
[...]
> +static struct i2c_driver itg3200_driver = {
> +	.driver = {
> +		.owner  = THIS_MODULE,
> +		.name	= "itg3200",
> +	},
> +	.id_table	= itg3200_id,
> +	.probe		= itg3200_probe,
> +	.remove		= itg3200_remove,
> +};
> +
> +static int __init itg3200_init(void)
> +{
> +	return i2c_add_driver(&itg3200_driver);
> +}
> +module_init(itg3200_init);
> +
> +static void __exit itg3200_exit(void)
> +{
> +	i2c_del_driver(&itg3200_driver);
> +}
> +module_exit(itg3200_exit);

module_i2c_driver(itg3200_driver);

> +
> +MODULE_AUTHOR("Christian Strobel <christian.strobel@iis.fraunhofer.de>");
> +MODULE_DESCRIPTION("ITG3200 Gyroscope I2C driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/gyro/itg3200_trigger.c b/drivers/iio/gyro/itg3200_trigger.c
> new file mode 100644
> index 0000000..bb72eab
> --- /dev/null
> +++ b/drivers/iio/gyro/itg3200_trigger.c
> @@ -0,0 +1,78 @@
> +/*
> + * itg3200_trigger.c -- support InvenSense ITG3200
> + *                      Digital 3-Axis Gyroscope driver
> + *
> + * Copyright (c) 2011 Christian Strobel <christian.strobel@iis.fraunhofer.de>
> + * Copyright (c) 2011 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> + * Copyright (c) 2012 Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/gyro/itg3200.h>
> +
> +
> +static int itg3200_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +		bool state)
> +{
> +	return itg3200_set_irq_data_rdy(trig->private_data, state);
> +}

Do we really need this wrapper? I think it might be better to move
itg3200_set_irq_data_rdy here, especially considering that it is unused in
case buffer support is not enabled.

Similar I think it makes sense to move itg3200_read_all_channels and
itg3200_read_irq_status to tg3200_buffer.c

[...]
> diff --git a/include/linux/iio/gyro/itg3200.h b/include/linux/iio/gyro/itg3200.h
> new file mode 100644
> index 0000000..8e79074
> --- /dev/null
> +++ b/include/linux/iio/gyro/itg3200.h
> @@ -0,0 +1,78 @@
[...]
> +#define itg3200_free_buf iio_sw_rb_free
> +#define itg3200_alloc_buf iio_sw_rb_allocate
> +#define itg3200_access_funcs ring_sw_access_funcs

These three don't seem to be used anywhere.

[...]
