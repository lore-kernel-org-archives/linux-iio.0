Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34609 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939360AbdD3Pvo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 11:51:44 -0400
Subject: Re: [PATCHv2 2/2] iio: adc: add driver for the ti-adc084s021 chip
To: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
References: <1493556822-2601-1-git-send-email-marten.lindahl@axis.com>
 <1493556822-2601-3-git-send-email-marten.lindahl@axis.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <88d6c17d-8eae-6a41-b304-5224a7a2194a@kernel.org>
Date: Sun, 30 Apr 2017 16:51:38 +0100
MIME-Version: 1.0
In-Reply-To: <1493556822-2601-3-git-send-email-marten.lindahl@axis.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/04/17 13:53, Mårten Lindahl wrote:
> From: Mårten Lindahl <martenli@axis.com>
> 
> This adds support for the Texas Instruments ADC084S021 ADC chip.
> 
> Signed-off-by: Mårten Lindahl <martenli@axis.com>
A few more bits inline.  Mostly stuff that has come up
in the V2 changes (and the inevitable bits I missed the
first time!)

Jonathan
> ---
> Changes in v2:
> - Removed most #defines in favor of inlines
> - Corrected channel macro
> - Removed configuration array with only one item
> - Updated func adc084s021_adc_conversion to use be16_to_cpu
> - Added IIO_CHAN_INFO_SCALE to func adc084s021_read_raw
> - Use iio_device_claim_direct_mode in func adc084s021_read_raw
> - Removed documentation for standard driver functions
> - Changed retval to ret everywhere
> - Removed dynamic alloc for data buffer in trigger handler
> - Keeping mutex for all iterations in trigger handler
> - Removed usage of events in this driver
> - Removed info log in probe
> - Use spi_message_init_with_transfers for spi message structs
> - Use preenable and postdisable functions for regulator
> - Inserted blank line before last return in all functions
> 
>  drivers/iio/adc/Kconfig         |  12 ++
>  drivers/iio/adc/Makefile        |   1 +
>  drivers/iio/adc/ti-adc084s021.c | 294 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-adc084s021.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dedae7a..13141e5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -560,6 +560,18 @@ config TI_ADC0832
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc0832.
>  
> +config TI_ADC084S021
> +	tristate "Texas Instruments ADC084S021"
> +	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +	help
> +	  If you say yes here you get support for Texas Instruments ADC084S021
> +	  chips.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-adc084s021.
> +
>  config TI_ADC12138
>  	tristate "Texas Instruments ADC12130/ADC12132/ADC12138"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d001262..b1a6158 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
> +obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
>  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> new file mode 100644
> index 0000000..2dce257
> --- /dev/null
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -0,0 +1,294 @@
> +/**
> + * Copyright (C) 2017 Axis Communications AB
> + *
> + * Driver for Texas Instruments' ADC084S021 ADC chip.
> + * Datasheets can be found here:
> + * http://www.ti.com/lit/ds/symlink/adc084s021.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define ADC084S021_DRIVER_NAME "adc084s021"
> +
> +struct adc084s021 {
> +	struct spi_device *spi;
> +	struct spi_message message;
> +	struct spi_transfer spi_trans[2];
> +	struct regulator *reg;
> +	struct mutex lock;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	union {
> +		u16 tx_buf;
> +		__be16 rx_buf;
> +	} ____cacheline_aligned;
> +};
> +
> +/**
> + * Channel specification
> + */
Comment doesn't add much so I'd drop it.
> +#define ADC084S021_VOLTAGE_CHANNEL(num)                  \
> +	{                                                      \
> +		.type = IIO_VOLTAGE,                                 \
> +		.channel = (num),                                    \
> +		.address = (num) << 3,                               \
This does feel a little pointless as you can just do the shift inline and
use the channel value instead.  Doesn't really matter though.
> +		.indexed = 1,                                        \
> +		.scan_index = (num),                                 \
> +		.scan_type = {                                       \
> +			.sign = 'u',                                       \
> +			.realbits = 8,                                     \
> +			.storagebits = 16,                                 \
> +			.shift = 4,                                        \
> +			.endianness = IIO_BE,                              \
> +		},                                                   \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),        \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> +	}
> +
> +static const struct iio_chan_spec adc084s021_channels[] = {
> +	ADC084S021_VOLTAGE_CHANNEL(0),
> +	ADC084S021_VOLTAGE_CHANNEL(1),
> +	ADC084S021_VOLTAGE_CHANNEL(2),
> +	ADC084S021_VOLTAGE_CHANNEL(3),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +};
> +
> +/**
> + * Read an ADC channel and return its value.
> + *
> + * @adc: The ADC SPI data.
> + * @channel: The IIO channel data structure.
> + */
> +static int adc084s021_adc_conversion(struct adc084s021 *adc,
> +			   struct iio_chan_spec const *channel)
> +{
> +	u8 value;
> +	int ret;
> +
> +	adc->tx_buf = channel->address;
> +
> +	/* Do the transfer */
> +	ret = spi_sync(adc->spi, &adc->message);
> +	if (ret < 0)
> +		return ret;
> +
> +	value = (be16_to_cpu(adc->rx_buf) >> channel->scan_type.shift) & 0xff;You want to do this for the read_raw sysfs calls, but not the buffered ones
(where this shift and mask is made userspace's problem).
> +
> +	dev_dbg(&adc->spi->dev, "value 0x%02X on channel %d\n",
> +			     value, channel->channel);
> +
> +	return value;
> +}
> +
> +static int adc084s021_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *channel, int *val,
> +			   int *val2, long mask)
> +{
> +	struct adc084s021 *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
Unless I'm dozing off this morning, you don't have any power..
So you'll need to enable the regulator first in this path.

Note that the runtime power management autosuspend stuff can
be good for this as it stops the power cycling if a short burst
of readings is taken.
> +		ret = adc084s021_adc_conversion(adc, channel);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_get_voltage(adc->reg);
Given the regulator is currently off as far as this device is concerned
it's possible the answer will be 0...
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret / 1000;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/**
> + * Read enabled ADC channels and push data to the buffer.
> + *
> + * @irq: The interrupt number (not used).
> + * @pollfunc: Pointer to the poll func.
> + */
> +static irqreturn_t adc084s021_buffer_trigger_handler(int irq, void *pollfunc)
> +{
> +	struct iio_poll_func *pf = pollfunc;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adc084s021 *adc = iio_priv(indio_dev);
> +	__be16 data[8] = {0}; /* 4 * 16-bit words of data + 8 bytes timestamp */
> +	int scan_index;
> +	int i = 0;
> +
> +	mutex_lock(&adc->lock);
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		const struct iio_chan_spec *channel =
> +			&indio_dev->channels[scan_index];
> +		data[i++] = adc084s021_adc_conversion(adc, channel);
This is clearly a rather simplistic way of handling the read outs.
Perfectly good for an initial version (which may never get improved
on!) but you could do the spi transfers for a set of channels much
more efficiently.

Figure 1 on the datasheet shows how the control register for the next
read can be written in parallel with the previous read. That would
mean each scan took N + 1 2 byte transfers rather than 2N as currently.

I'm not particularly suggesting you do this, but thought I'd just
comment on the possibility as it is a common situation with spi
ADCs (sometimes you get a greater lag between setup and read out
making this even fiddlier!)

If you do want to do this, the trick is to do your transfer setup
and creation stuff in preenable so that it can be customised for
whatever channels are enabled.
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +					   iio_get_time_ns(indio_dev));
> +	mutex_unlock(&adc->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int adc084s021_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct adc084s021 *adc = iio_priv(indio_dev);
> +
> +	return regulator_enable(adc->reg);
> +}
> +
> +static int adc084s021_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct adc084s021 *adc = iio_priv(indio_dev);
> +
> +	return regulator_disable(adc->reg);
> +}
> +
> +static const struct iio_info adc084s021_info = {
> +	.read_raw = adc084s021_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const struct iio_buffer_setup_ops adc084s021_buffer_setup_ops = {
> +	.preenable = adc084s021_buffer_preenable,
> +	.postenable = iio_triggered_buffer_postenable,
> +	.predisable = iio_triggered_buffer_predisable,
> +	.postdisable = adc084s021_buffer_postdisable,
> +};
> +
> +static int adc084s021_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adc084s021 *adc;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		dev_err(&spi->dev, "Failed to allocate IIO device\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +	spi->bits_per_word = 8;
> +
> +	/* Update the SPI device with config and connect the iio dev */
> +	ret = spi_setup(spi);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to update SPI device\n");
> +		return ret;
> +	}
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	/* Initiate the Industrial I/O device */
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->dev.of_node = spi->dev.of_node;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &adc084s021_info;
> +	indio_dev->channels = adc084s021_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adc084s021_channels);
> +
> +	/* Create SPI transfer for channel reads */
> +	adc->spi_trans[0].tx_buf = &adc->tx_buf;
> +	adc->spi_trans[0].len = 2;
> +	adc->spi_trans[0].speed_hz = spi->max_speed_hz;
You don't need to set these for individual transfers unless they
are different from how the spi bus has been set up...

It's handled in __spi_validate in drivers/spi/spi.c

	list_for_each_entry(xfer, &message->transfers, transfer_list) {
		message->frame_length += xfer->len;
		if (!xfer->bits_per_word)
			xfer->bits_per_word = spi->bits_per_word;

		if (!xfer->speed_hz)
			xfer->speed_hz = spi->max_speed_hz;
...

So it will set them spi->... in the core if you haven't overridden.

> +	adc->spi_trans[0].bits_per_word = spi->bits_per_word;
> +	adc->spi_trans[1].rx_buf = &adc->rx_buf;
> +	adc->spi_trans[1].len = 2;
> +	adc->spi_trans[1].speed_hz = spi->max_speed_hz;
> +	adc->spi_trans[1].bits_per_word = spi->bits_per_word;
> +
> +	spi_message_init_with_transfers(&adc->message, adc->spi_trans, 2);
> +
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(adc->reg))
> +		return PTR_ERR(adc->reg);
> +
> +	mutex_init(&adc->lock);
> +
> +	/* Setup triggered buffer with pollfunction */
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +					    adc084s021_buffer_trigger_handler,
> +					    &adc084s021_buffer_setup_ops);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
> +		return ret;
> +	}
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to register IIO device\n");
> +		iio_triggered_buffer_cleanup(indio_dev);
With devm usage this won't be needed any more.

Hmm. We should improve the error message from the core as it'll allow us
to remove a lot of boiler plate in drivers. Ah well, a project for
another day.
> +	}
> +
> +	return ret;
> +}
> +
> +static int adc084s021_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
Now you have moved to dynamically enabling the regulator, it makes
sense to use the devm_ versions of iio_device_register and 
iio_triggered_buffer setup.

With those, you'll be able to get rid of the remove callback entirely as
there will be nothing to do.
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id adc084s021_of_match[] = {
> +	{ .compatible = "ti,adc084s021", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, adc084s021_of_match);
> +
> +static const struct spi_device_id adc084s021_id[] = {
> +	{ ADC084S021_DRIVER_NAME, 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, adc084s021_id);
> +
> +static struct spi_driver adc084s021_driver = {
> +	.driver = {
> +		.name = ADC084S021_DRIVER_NAME,
> +		.of_match_table = of_match_ptr(adc084s021_of_match),
> +	},
> +	.probe = adc084s021_probe,
> +	.remove = adc084s021_remove,
> +	.id_table = adc084s021_id,
> +};
> +module_spi_driver(adc084s021_driver);
> +
> +MODULE_AUTHOR("Mårten Lindahl <martenli@axis.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADC084S021");
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION("1.0");
> 

