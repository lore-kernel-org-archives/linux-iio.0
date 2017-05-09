Return-Path: <SRS0=GmJf=4P=axis.com=marten.lindahl@kernel.org>
Message-ID: <1494343072.18621.13.camel@axis.com>
Subject: Re: [PATCH v3 2/2] iio: adc: add driver for the ti-adc084s021 chip
From: =?ISO-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?ISO-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>, knaack.h@gmx.de,
 lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
 robh+dt@kernel.org,  mark.rutland@arm.com, devicetree@vger.kernel.org
Date: Tue, 09 May 2017 17:17:52 +0200
In-Reply-To: <fb177b86-3e28-5051-67cf-bcc81ae0e116@kernel.org>
References: <1493812905-28904-1-git-send-email-marten.lindahl@axis.com>
	 <1493812905-28904-3-git-send-email-marten.lindahl@axis.com>
	 <fb177b86-3e28-5051-67cf-bcc81ae0e116@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2017-05-07 at 15:21 +0100, Jonathan Cameron wrote:
> On 03/05/17 13:01, Mårten Lindahl wrote:
> > From: Mårten Lindahl <martenli@axis.com>
> > 
> > This adds support for the Texas Instruments ADC084S021 ADC chip.
> > 
> > Signed-off-by: Mårten Lindahl <martenli@axis.com>
> A few more minor bits and pieces.
> 
> Jonathan
Hi Jonathan!
I made v4. Please read my comments below. Could there potentially be
garbage in the buffer?
Thanks,
Mårten
> > ---
> > Changes in v3:
> > - Removed unnecessary comment about channel specification
> > - Skipped usage of 'address' in iio_chan_spec config macro
> > - Mask and shift channel readings only for _read_raw function
> > - Enable/disable regulator in _read_raw function
> > - Improved setup of ADC channel readings
> > - Use SPI config of speed_hz and bits_per_word
> > - Use devm_iio_triggered_buffer_setup and devm_iio_device_register
> > - Removed error message for failed devm_iio_device_register
> > - Removed driver _remove callback function
> > 
> > Changes in v2:
> > - Removed most #defines in favor of inlines
> > - Corrected channel macro
> > - Removed configuration array with only one item
> > - Updated func adc084s021_adc_conversion to use be16_to_cpu
> > - Added IIO_CHAN_INFO_SCALE to func adc084s021_read_raw
> > - Use iio_device_claim_direct_mode in func adc084s021_read_raw
> > - Removed documentation for standard driver functions
> > - Changed retval to ret everywhere
> > - Removed dynamic alloc for data buffer in trigger handler
> > - Keeping mutex for all iterations in trigger handler
> > - Removed usage of events in this driver
> > - Removed info log in probe
> > - Use spi_message_init_with_transfers for spi message structs
> > - Use preenable and postdisable functions for regulator
> > - Inserted blank line before last return in all functions
> > 
> >  drivers/iio/adc/Kconfig         |  12 ++
> >  drivers/iio/adc/Makefile        |   1 +
> >  drivers/iio/adc/ti-adc084s021.c | 302 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 315 insertions(+)
> >  create mode 100644 drivers/iio/adc/ti-adc084s021.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index dedae7a..13141e5 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -560,6 +560,18 @@ config TI_ADC0832
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called ti-adc0832.
> >  
> > +config TI_ADC084S021
> > +	tristate "Texas Instruments ADC084S021"
> > +	depends on SPI
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  If you say yes here you get support for Texas Instruments ADC084S021
> > +	  chips.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called ti-adc084s021.
> > +
> >  config TI_ADC12138
> >  	tristate "Texas Instruments ADC12130/ADC12132/ADC12138"
> >  	depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index d001262..b1a6158 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
> >  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
> >  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
> >  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
> > +obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
> >  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
> >  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
> >  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
> > diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> > new file mode 100644
> > index 0000000..f2fb0fa
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-adc084s021.c
> > @@ -0,0 +1,302 @@
> > +/**
> > + * Copyright (C) 2017 Axis Communications AB
> > + *
> > + * Driver for Texas Instruments' ADC084S021 ADC chip.
> > + * Datasheets can be found here:
> > + * http://www.ti.com/lit/ds/symlink/adc084s021.pdf
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/err.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define ADC084S021_DRIVER_NAME "adc084s021"
> > +
> > +struct adc084s021 {
> > +	struct spi_device *spi;
> > +	struct spi_message message;
> > +	struct spi_transfer spi_trans;
> > +	struct regulator *reg;
> > +	struct mutex lock;
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) requires the
> > +	 * transfer buffers to live in their own cache lines.
> > +	 */
> > +	u16 tx_buf[4] ____cacheline_aligned;
> > +	__be16 rx_buf[5] ____cacheline_aligned; /* First 16-bits are trash */
> You only need to do this for tx_buf as then rx_buf will at worst end up
> in the same cacheline as it.  Fairly implausible that this would cause
> issues given they will be read before a transfer and written after.
> Doing it twice results in potential waste of say 64 bytes depending on
> the cacheline length.
Fixed and verified with pahole in v4.
> > +};
> > +
> > +#define ADC084S021_VOLTAGE_CHANNEL(num)                  \
> > +	{                                                      \
> > +		.type = IIO_VOLTAGE,                                 \
> > +		.channel = (num),                                    \
> > +		.indexed = 1,                                        \
> > +		.scan_index = (num),                                 \
> > +		.scan_type = {                                       \
> > +			.sign = 'u',                                       \
> > +			.realbits = 8,                                     \
> > +			.storagebits = 16,                                 \
> > +			.shift = 4,                                        \
> > +			.endianness = IIO_BE,                              \
> They aren't at the moment as you are doing the endian conversion in kernel.
> Drop that in the push to buffers path.
Ok, fixed in "push to buffers path" in v4.
> > +		},                                                   \
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),        \
> > +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> > +	}
> > +
> > +static const struct iio_chan_spec adc084s021_channels[] = {
> > +	ADC084S021_VOLTAGE_CHANNEL(0),
> > +	ADC084S021_VOLTAGE_CHANNEL(1),
> > +	ADC084S021_VOLTAGE_CHANNEL(2),
> > +	ADC084S021_VOLTAGE_CHANNEL(3),
> > +	IIO_CHAN_SOFT_TIMESTAMP(4),
> > +};
> > +
> > +static int adc084s021_power_on(struct adc084s021 *adc)
> > +{
> > +	int ret;
> > +
> > +	ret = regulator_enable(adc->reg);
> > +	if (ret) {
> > +		dev_warn(&adc->spi->dev,
> > +			"Failed to enable supply voltage\n");
> > +	}
> > +
> > +	return ret;
> These two little functions do seem a little unnecessary.
> A regulator fail should be pretty unlikely so I'd be tempted
> to just have the regulator_enable / disable inline instead
> of off in these functions.
Fixed in v4.
> > +}
> > +
> > +static int adc084s021_power_off(struct adc084s021 *adc)
> > +{
> > +	int ret;
> > +
> > +	ret = regulator_disable(adc->reg);
> > +	if (ret) {
> > +		dev_warn(&adc->spi->dev,
> > +			"Failed to disable supply voltage\n");
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * Read an ADC channel and return its value.
> > + *
> > + * @adc: The ADC SPI data.
> > + * @data: Buffer for converted data.
> > + */
> > +static int adc084s021_adc_conversion(struct adc084s021 *adc, void *data)
> > +{
> > +	int n_words = (adc->spi_trans.len >> 1) - 1; /* Discard first word */
> > +	int ret, i = 0;
> > +	u16 *p = data;
> > +
> > +	/* Do the transfer */
> > +	ret = spi_sync(adc->spi, &adc->message);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	for (; i < n_words; i++)
> > +		*(p + i) = be16_to_cpu(adc->rx_buf[i + 1]);
> Should only do the endian conversion in kernel if not
> using it for buffered output.  In buffered output we can
> save a few cycles by leaving it up to userspace.
Ok, fixed in v4.
> > +
> > +	return ret;
> > +}
> > +
> > +static int adc084s021_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *channel, int *val,
> > +			   int *val2, long mask)
> > +{
> > +	struct adc084s021 *adc = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = iio_device_claim_direct_mode(indio_dev);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		ret = adc084s021_power_on(adc);
> > +		if (ret) {
> > +			iio_device_release_direct_mode(indio_dev);
> > +			return ret;
> > +		}
> > +
> > +		adc->tx_buf[0] = channel->channel << 3;
> > +		ret = adc084s021_adc_conversion(adc, val);
> > +		iio_device_release_direct_mode(indio_dev);
> > +		adc084s021_power_off(adc);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = (*val >> channel->scan_type.shift) & 0xff;
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		ret = adc084s021_power_on(adc);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = regulator_get_voltage(adc->reg);
> > +		adc084s021_power_off(adc);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		*val = ret / 1000;
> > +
> > +		return IIO_VAL_INT;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +/**
> > + * Read enabled ADC channels and push data to the buffer.
> > + *
> > + * @irq: The interrupt number (not used).
> > + * @pollfunc: Pointer to the poll func.
> > + */
> > +static irqreturn_t adc084s021_buffer_trigger_handler(int irq, void *pollfunc)
> > +{
> > +	struct iio_poll_func *pf = pollfunc;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct adc084s021 *adc = iio_priv(indio_dev);
> > +	__be16 data[8] = {0}; /* 4 * 16-bit words of data + 8 bytes timestamp */
> > +
> > +	mutex_lock(&adc->lock);
> > +
> > +	if (adc084s021_adc_conversion(adc, &data) < 0)
> > +		dev_err(&adc->spi->dev, "Failed to read data\n");
> hmm. Not sure I'm keen on pushing garbage to the buffer.
> I might fix this up as well... Depends on what else there is ;)
Since the __be16 data[8] array is initialized to 0, and the
adc084s021_adc_conversion function error returns before any data has
been copied to the array it should always contain either zeroes or valid
data as I see it. Would it be wrong to push zeroes?
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> > +					   iio_get_time_ns(indio_dev));
> > +	mutex_unlock(&adc->lock);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int adc084s021_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct adc084s021 *adc = iio_priv(indio_dev);
> > +	int scan_index;
> > +	int i = 0;
> > +
> > +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		const struct iio_chan_spec *channel =
> > +			&indio_dev->channels[scan_index];
> > +		adc->tx_buf[i++] = channel->channel << 3;
> > +	}
> > +	adc->spi_trans.len = 2 + (i * sizeof(__be16)); /* Trash + channels */
> > +
> > +	return adc084s021_power_on(adc);
> > +}
> > +
> > +static int adc084s021_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct adc084s021 *adc = iio_priv(indio_dev);
> > +
> > +	adc->spi_trans.len = 4; /* Trash + single channel */
> > +
> > +	return adc084s021_power_off(adc);
> > +}
> > +
> > +static const struct iio_info adc084s021_info = {
> > +	.read_raw = adc084s021_read_raw,
> > +	.driver_module = THIS_MODULE,
> > +};
> > +
> > +static const struct iio_buffer_setup_ops adc084s021_buffer_setup_ops = {
> > +	.preenable = adc084s021_buffer_preenable,
> > +	.postenable = iio_triggered_buffer_postenable,
> > +	.predisable = iio_triggered_buffer_predisable,
> > +	.postdisable = adc084s021_buffer_postdisable,
> > +};
> > +
> > +static int adc084s021_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adc084s021 *adc;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > +	if (!indio_dev) {
> > +		dev_err(&spi->dev, "Failed to allocate IIO device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	adc = iio_priv(indio_dev);
> > +	adc->spi = spi;
> > +
> > +	/* Connect the SPI device and the iio dev */
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	/* Initiate the Industrial I/O device */
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->dev.of_node = spi->dev.of_node;
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &adc084s021_info;
> > +	indio_dev->channels = adc084s021_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(adc084s021_channels);
> > +
> > +	/* Create SPI transfer for channel reads */
> > +	adc->spi_trans.tx_buf = adc->tx_buf;
> > +	adc->spi_trans.rx_buf = adc->rx_buf;
> > +	adc->spi_trans.len = 4; /* Trash + single channel */
> > +	spi_message_init_with_transfers(&adc->message, &adc->spi_trans, 1);
> > +
> > +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> > +	if (IS_ERR(adc->reg))
> > +		return PTR_ERR(adc->reg);
> > +
> > +	mutex_init(&adc->lock);
> > +
> > +	/* Setup triggered buffer with pollfunction */
> > +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> > +					    adc084s021_buffer_trigger_handler,
> > +					    &adc084s021_buffer_setup_ops);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> > +
> > +	return ret;
> return devm_iio_deivce_register(...
Fixed in v4.
> 
> If this all there is I'll fix it up.
Ok, so I'll send no more patches after v4 then?
> > +}
> > +
> > +static const struct of_device_id adc084s021_of_match[] = {
> > +	{ .compatible = "ti,adc084s021", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, adc084s021_of_match);
> > +
> > +static const struct spi_device_id adc084s021_id[] = {
> > +	{ ADC084S021_DRIVER_NAME, 0},
> > +	{}
> > +};
> > +MODULE_DEVICE_TABLE(spi, adc084s021_id);
> > +
> > +static struct spi_driver adc084s021_driver = {
> > +	.driver = {
> > +		.name = ADC084S021_DRIVER_NAME,
> > +		.of_match_table = of_match_ptr(adc084s021_of_match),
> > +	},
> > +	.probe = adc084s021_probe,
> > +	.id_table = adc084s021_id,
> > +};
> > +module_spi_driver(adc084s021_driver);
> > +
> > +MODULE_AUTHOR("Mårten Lindahl <martenli@axis.com>");
> > +MODULE_DESCRIPTION("Texas Instruments ADC084S021");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_VERSION("1.0");
> > 
> 
