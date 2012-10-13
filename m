Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45805 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901Ab2JMJ5r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 05:57:47 -0400
Message-ID: <50793B19.4010100@kernel.org>
Date: Sat, 13 Oct 2012 10:57:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Michael.Hennerich@analog.com,
	lars@metafoo.de, srinivas.pandruvada@intel.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/4] staging:iio: Proof of concept input driver.
References: <1350120278-26929-1-git-send-email-jic23@kernel.org> <1350120278-26929-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1350120278-26929-5-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/2012 10:24 AM, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> This is no where near ready to merge.  Lots of stuff missing.
It also contains an issue with using the input dev after freeing that
has already been reported. Naughty me - I forgot about that one.

Doesn't effect the usefulness of this as a test tool though!

> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Kconfig     |  11 ++
>  drivers/staging/iio/Makefile    |   1 +
>  drivers/staging/iio/iio_input.c | 225 ++++++++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/iio_input.h |  23 ++++
>  4 files changed, 260 insertions(+)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index ca56c75..3d21f6d 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -4,6 +4,17 @@
>  menu "IIO staging drivers"
>  	depends on IIO
>  
> +config IIO_ST_INPUT
> +	tristate "Input driver that uses channels specified via iio maps"
> +	depends on INPUT
> +	depends on IIO_BUFFER
> +	select IIO_BUFFER_CB
> +	help
> +	  Client driver for IIO via the push interfaces.  Used to provide
> +	  and input interface for IIO devices that can feed a buffer on
> +	  a trigger interrupt.  Note that all channels must come from a
> +	  single IIO supported device.
> +
>  config IIO_ST_HWMON
>  	tristate "Hwmon driver that uses channels specified via iio maps"
>  	depends on HWMON
> diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> index fa6937d..9e71498 100644
> --- a/drivers/staging/iio/Makefile
> +++ b/drivers/staging/iio/Makefile
> @@ -12,6 +12,7 @@ iio_dummy-$(CONFIG_IIO_SIMPLE_DUMMY_BUFFER) += iio_simple_dummy_buffer.o
>  obj-$(CONFIG_IIO_DUMMY_EVGEN) += iio_dummy_evgen.o
>  
>  obj-$(CONFIG_IIO_ST_HWMON) += iio_hwmon.o
> +obj-$(CONFIG_IIO_ST_INPUT) += iio_input.o
>  
>  obj-y += accel/
>  obj-y += adc/
> diff --git a/drivers/staging/iio/iio_input.c b/drivers/staging/iio/iio_input.c
> new file mode 100644
> index 0000000..c34b325
> --- /dev/null
> +++ b/drivers/staging/iio/iio_input.c
> @@ -0,0 +1,225 @@
> +/*
> + * The industrial I/O input client driver
> + *
> + * Copyright (c) 2011 Jonathan Cameron
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/consumer.h>
> +#include "iio_input.h"
> +
> +struct iio_input_state {
> +	struct iio_cb_buffer *buff;
> +	struct input_dev *idev;
> +};
> +
> +static int iio_channel_value(u8 *data,
> +			     const struct iio_chan_spec *chan,
> +			     s32 *val)
> +{
> +	u32 value = 0;
> +
> +	if (chan->scan_type.sign == 's') {
> +		switch (chan->scan_type.storagebits) {
> +		case 8:
> +			value = *(s8 *)(data);
> +			break;
> +		case 16:
> +			switch (chan->scan_type.endianness) {
> +			case IIO_CPU:
> +				value = *(s16 *)(data);
> +				break;
> +			case IIO_BE:
> +				value = be16_to_cpu(*(__be16 *)data);
> +				break;
> +			case IIO_LE:
> +				value = le16_to_cpu(*(__le16 *)data);
> +				break;
> +			}
> +			break;
> +		case 32:
> +			switch (chan->scan_type.endianness) {
> +			case IIO_CPU:
> +				value = *(s32 *)(data);
> +				break;
> +			case IIO_BE:
> +				value = be32_to_cpu(*(__be32 *)data);
> +				break;
> +			case IIO_LE:
> +				value = le32_to_cpu(*(__le32  *)data);
> +				break;
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*val = sign_extend32(value, chan->scan_type.storagebits);
> +	} else {
> +		switch (chan->scan_type.storagebits) {
> +		case 8:
> +			value = *(u8 *)(data);
> +			break;
> +		case 16:
> +			switch (chan->scan_type.endianness) {
> +			case IIO_CPU:
> +				value = *(u16 *)(data);
> +				break;
> +			case IIO_BE:
> +				value = be16_to_cpu(*(__be16 *)data);
> +				break;
> +			case IIO_LE:
> +				value = le16_to_cpu(*(__le16 *)data);
> +				break;
> +			}
> +			break;
> +		case 32:
> +			switch (chan->scan_type.endianness) {
> +			case IIO_CPU:
> +				value = *(u32 *)(data);
> +				break;
> +			case IIO_BE:
> +				value = be32_to_cpu(*(__be32 *)data);
> +				break;
> +			case IIO_LE:
> +				value = le32_to_cpu(*(__le32 *)data);
> +				break;
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		value >>= chan->scan_type.shift;
> +		value &= (1 << chan->scan_type.realbits) - 1;
> +		*val = value;
> +	}
> +
> +	return 0;
> +}
> +
> +static int iio_input_store_to(u8 *data, void *private)
> +{
> +	struct iio_input_state *st = private;
> +	struct iio_channel *channel;
> +	struct iio_input_channel_data *input_data;
> +	int offset = 0;
> +	s32 value;
> +	int ret;
> +
> +	channel = iio_channel_cb_get_channels(st->buff);
> +	while (channel->indio_dev) {
> +		input_data = channel->data;
> +		offset = ALIGN(offset,
> +			       channel->channel->scan_type.storagebits/8);
> +		ret = iio_channel_value(&data[offset],
> +					channel->channel,
> +					&value);
> +		if (ret < 0)
> +			return ret;
> +		offset += channel->channel->scan_type.storagebits/8;
> +
> +		input_report_abs(st->idev, input_data->code, value);
> +		channel++;
> +	}
> +	input_sync(st->idev);
> +
> +	return 0;
> +}
> +
> +static int __devinit iio_input_probe(struct platform_device *pdev)
> +{
> +	struct iio_input_state *st;
> +	int ret;
> +	bool registered;
> +	struct iio_channel *channel;
> +	struct iio_input_channel_data *input_data;
> +
> +	registered = false;
> +	st = kzalloc(sizeof(*st), GFP_KERNEL);
> +	if (st == NULL)
> +		return -ENOMEM;
> +	platform_set_drvdata(pdev, st);
> +	st->buff = iio_channel_get_all_cb(dev_name(&pdev->dev),
> +					  &iio_input_store_to,
> +					  st);
> +	if (IS_ERR(st->buff)) {
> +		ret = PTR_ERR(st->buff);
> +		goto error_free_state;
> +	}
> +
> +	st->idev = input_allocate_device();
> +	if (!st->idev) {
> +		ret = -ENOMEM;
> +		goto error_channels_release_all;
> +	}
> +
> +	__set_bit(EV_ABS, st->idev->evbit);
> +	channel = iio_channel_cb_get_channels(st->buff);
> +	while (channel->indio_dev) {
> +		input_data = channel->data;
> +		input_set_abs_params(st->idev, input_data->code,
> +				     input_data->min,
> +				     input_data->max,
> +				     input_data->fuzz,
> +				     input_data->flat);
> +		channel++;
> +	}
> +
> +	ret = input_register_device(st->idev);
> +	if (ret < 0)
> +		goto error_free_idev;
> +	registered = true;
> +	/* NORMALLY IN THE OPEN */
> +	ret = iio_channel_start_all_cb(st->buff);
> +	if (ret < 0)
> +		goto error_unregister_input;
> +
> +	return 0;
> +error_unregister_input:
> +	if (registered)
> +		input_unregister_device(st->idev);
> +error_free_idev:
> +	if (!registered)
> +		input_free_device(st->idev);
> +error_channels_release_all:
> +	iio_channel_release_all_cb(st->buff);
> +error_free_state:
> +	kfree(st);
> +	return ret;
> +}
> +
> +static int __devexit iio_input_remove(struct platform_device *pdev)
> +{
> +	struct iio_input_state *st = platform_get_drvdata(pdev);
> +	/* NORMALLY IN THE CLOSE */
> +	iio_channel_stop_all_cb(st->buff);
> +	input_unregister_device(st->idev);
> +	iio_channel_release_all_cb(st->buff);
> +
> +	kfree(st);
> +	return 0;
> +}
> +
> +static struct platform_driver iio_input_driver = {
> +	.driver = {
> +		.name = "iio_input_bridge",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = iio_input_probe,
> +	.remove = __devexit_p(iio_input_remove),
> +};
> +
> +module_platform_driver(iio_input_driver);
> +
> +MODULE_AUTHOR("Jonathan Cameron <jic23@cam.ac.uk>");
> +MODULE_DESCRIPTION("IIO input buffer driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/iio_input.h b/drivers/staging/iio/iio_input.h
> new file mode 100644
> index 0000000..cfd1d34
> --- /dev/null
> +++ b/drivers/staging/iio/iio_input.h
> @@ -0,0 +1,23 @@
> +/*
> + * The industrial I/O input client driver
> + *
> + * Copyright (c) 2011 Jonathan Cameron
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +/**
> + * iio_input_channel_data - description of the channel for input subsystem
> + * @code:	Absolute axis.
> + * @min:	Minimum value.
> + * @max:	Maximum value.
> + * @fuzz:	Used to filter noise from the event stream.
> + * @flat:	Values within this value will be discarded by joydev
> + *		and reported as 0 instead.
> + */
> +struct iio_input_channel_data {
> +	unsigned int code;
> +	int min, max, fuzz, flat;
> +};
> 
