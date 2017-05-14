Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46954 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759207AbdENPfF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 11:35:05 -0400
Subject: Re: [PATCH v4 2/2] iio: adc: add driver for the ti-adc084s021 chip
To: =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
References: <1494345901-4714-1-git-send-email-marten.lindahl@axis.com>
 <1494345901-4714-3-git-send-email-marten.lindahl@axis.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <79792da9-40ea-b366-84cc-93be792abc0e@kernel.org>
Date: Sun, 14 May 2017 16:35:02 +0100
MIME-Version: 1.0
In-Reply-To: <1494345901-4714-3-git-send-email-marten.lindahl@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/17 17:05, Mårten Lindahl wrote:
> From: Mårten Lindahl <martenli@axis.com>
> 
> This adds support for the Texas Instruments ADC084S021 ADC chip.
> 
> Signed-off-by: Mårten Lindahl <martenli@axis.com>
Nice driver.

Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> Changes in v4:
> - Use same cacheline for rx and tx buffers
> - Inlining regulator enable/disable instead of functions
> - Do kernel endian conversion only for _read_raw access
> 
> Changes in v3:
> - Removed unnecessary comment about channel specification
> - Skipped usage of 'address' in iio_chan_spec config macro
> - Mask and shift channel readings only for _read_raw function
> - Enable/disable regulator in _read_raw function
> - Improved setup of ADC channel readings
> - Use SPI config of speed_hz and bits_per_word
> - Use devm_iio_triggered_buffer_setup and devm_iio_device_register
> - Removed error message for failed devm_iio_device_register
> - Removed driver _remove callback function
> 
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
>   drivers/iio/adc/Kconfig         |  12 ++
>   drivers/iio/adc/Makefile        |   1 +
>   drivers/iio/adc/ti-adc084s021.c | 275 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 288 insertions(+)
>   create mode 100644 drivers/iio/adc/ti-adc084s021.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index dedae7a..13141e5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -560,6 +560,18 @@ config TI_ADC0832
>   	  This driver can also be built as a module. If so, the module will be
>   	  called ti-adc0832.
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
>   config TI_ADC12138
>   	tristate "Texas Instruments ADC12130/ADC12132/ADC12138"
>   	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index d001262..b1a6158 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
>   obj-$(CONFIG_STM32_ADC) += stm32-adc.o
>   obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>   obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
> +obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
>   obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
>   obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>   obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> new file mode 100644
> index 0000000..a355121
> --- /dev/null
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -0,0 +1,275 @@
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
> +	struct spi_transfer spi_trans;
> +	struct regulator *reg;
> +	struct mutex lock;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache line.
> +	 */
> +	u16 tx_buf[4] ____cacheline_aligned;
> +	__be16 rx_buf[5]; /* First 16-bits are trash */
> +};
> +
> +#define ADC084S021_VOLTAGE_CHANNEL(num)                  \
> +	{                                                      \
> +		.type = IIO_VOLTAGE,                                 \
> +		.channel = (num),                                    \
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
> + * @data: Buffer for converted data.
> + */
> +static int adc084s021_adc_conversion(struct adc084s021 *adc, void *data)
> +{
> +	int n_words = (adc->spi_trans.len >> 1) - 1; /* Discard first word */
> +	int ret, i = 0;
> +	u16 *p = data;
> +
> +	/* Do the transfer */
> +	ret = spi_sync(adc->spi, &adc->message);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (; i < n_words; i++)
> +		*(p + i) = adc->rx_buf[i + 1];
> +
> +	return ret;
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
> +		ret = regulator_enable(adc->reg);
> +		if (ret) {
> +			iio_device_release_direct_mode(indio_dev);
> +			return ret;
> +		}
> +
> +		adc->tx_buf[0] = channel->channel << 3;
> +		ret = adc084s021_adc_conversion(adc, val);
> +		iio_device_release_direct_mode(indio_dev);
> +		regulator_disable(adc->reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = be16_to_cpu(*val);
> +		*val = (*val >> channel->scan_type.shift) & 0xff;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regulator_enable(adc->reg);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_get_voltage(adc->reg);
> +		regulator_disable(adc->reg);
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
> +
> +	mutex_lock(&adc->lock);
> +
> +	if (adc084s021_adc_conversion(adc, &data) < 0)
> +		dev_err(&adc->spi->dev, "Failed to read data\n");
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
> +	int scan_index;
> +	int i = 0;
> +
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		const struct iio_chan_spec *channel =
> +			&indio_dev->channels[scan_index];
> +		adc->tx_buf[i++] = channel->channel << 3;
> +	}
> +	adc->spi_trans.len = 2 + (i * sizeof(__be16)); /* Trash + channels */
> +
> +	return regulator_enable(adc->reg);
> +}
> +
> +static int adc084s021_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct adc084s021 *adc = iio_priv(indio_dev);
> +
> +	adc->spi_trans.len = 4; /* Trash + single channel */
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
> +
> +	/* Connect the SPI device and the iio dev */
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
> +	adc->spi_trans.tx_buf = adc->tx_buf;
> +	adc->spi_trans.rx_buf = adc->rx_buf;
> +	adc->spi_trans.len = 4; /* Trash + single channel */
> +	spi_message_init_with_transfers(&adc->message, &adc->spi_trans, 1);
> +
> +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> +	if (IS_ERR(adc->reg))
> +		return PTR_ERR(adc->reg);
> +
> +	mutex_init(&adc->lock);
> +
> +	/* Setup triggered buffer with pollfunction */
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +					    adc084s021_buffer_trigger_handler,
> +					    &adc084s021_buffer_setup_ops);
> +	if (ret) {
> +		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
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
> +	.id_table = adc084s021_id,
> +};
> +module_spi_driver(adc084s021_driver);
> +
> +MODULE_AUTHOR("Mårten Lindahl <martenli@axis.com>");
> +MODULE_DESCRIPTION("Texas Instruments ADC084S021");
> +MODULE_LICENSE("GPL v2");
> +MODULE_VERSION("1.0");
> 

