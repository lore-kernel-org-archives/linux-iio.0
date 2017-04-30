Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bes.se.axis.com ([195.60.68.10]:56220 "EHLO bes.se.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753178AbdD3MYN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Apr 2017 08:24:13 -0400
Message-ID: <1493555049.2883.18.camel@axis.com>
Subject: Re: [PATCH] iio: adc: add driver for the ti-adc084s021 chip
From: =?ISO-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: =?ISO-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>,
        jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Date: Sun, 30 Apr 2017 14:24:09 +0200
In-Reply-To: <alpine.DEB.2.20.1704212149070.2470@vps.pmeerw.net>
References: <1492786703-5149-1-git-send-email-marten.lindahl@axis.com>
         <alpine.DEB.2.20.1704212149070.2470@vps.pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 2017-04-21 at 22:19 +0200, Peter Meerwald-Stadler wrote:
> > From: Mårten Lindahl <martenli@axis.com>
> 
> comments below

Hi! Thanks for the comments! Please see my reply below.
Thanks,
Mårten

>  
> > This adds support for the Texas Instruments ADC084S021 ADC chip.
> > 
> > Signed-off-by: Mårten Lindahl <martenli@axis.com>
> > ---
> >  .../devicetree/bindings/iio/adc/ti-adc084s021.txt  |  25 ++
> >  drivers/iio/adc/Kconfig                            |  12 +
> >  drivers/iio/adc/Makefile                           |   1 +
> >  drivers/iio/adc/ti-adc084s021.c                    | 342 +++++++++++++++++++++
> >  4 files changed, 380 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> >  create mode 100644 drivers/iio/adc/ti-adc084s021.c
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> > new file mode 100644
> > index 0000000..921eb46
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti-adc084s021.txt
> > @@ -0,0 +1,25 @@
> > +* Texas Instruments' ADC084S021
> > +
> > +Required properties:
> > + - compatible        : Must be "ti,adc084s021"
> > + - reg               : SPI chip select number for the device
> > + - vref-supply       : The regulator supply for ADC reference voltage
> > + - spi-max-frequency : Definition as per Documentation/devicetree/bindings/spi/spi-bus.txt
> > +
> > +Optional properties:
> > + - spi-cpol          : SPI inverse clock polarity, as per spi-bus bindings
> > + - spi-cpha          : SPI shifted clock phase (CPHA), as per spi-bus bindings
> > + - spi-cs-high       : SPI chip select active high, as per spi-bus bindings
> > +
> > +
> > +Example:
> > +adc@0 {
> > +	compatible = "ti,adc084s021";
> > +	reg = <0>;
> > +	vref-supply = <&adc_vref>;
> > +	spi-cpol;
> > +	spi-cpha;
> > +	spi-cs-high;
> > +	spi-max-frequency = <16000000>;
> > +	pl022,com-mode = <0x2>; /* DMA */
> 
> what is this?
It does not belong here. It is removed i v2. This dt-bindings part is
split into its own patch in v2.
> 
> > +};
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
> > index 0000000..4f33b91
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-adc084s021.c
> > @@ -0,0 +1,342 @@
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
> > +#include <linux/iio/events.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#define MODULE_NAME     "adc084s021"
> > +#define DRIVER_VERSION  "1.0"
> 
> is only used once at the very end...
Removed in v2.
> 
> > +#define ADC_RESOLUTION  8
> > +#define ADC_N_CHANNELS  4
> 
> we want a consistent prefix, such as ADC084S021_
I use values inline i v2.
> 
> > +
> > +struct adc084s021_configuration {
> > +	const struct iio_chan_spec *channels;
> > +	u8 num_channels;
> 
> no need for u8, perhaps unsigned?
I removed this struct in v2 and use direct addressing.
> 
> > +};
> > +
> > +struct adc084s021 {
> > +	struct spi_device *spi;
> > +	struct spi_message message;
> > +	struct spi_transfer spi_trans[2];
> > +	struct regulator *reg;
> > +	struct mutex lock;
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) requires the
> > +	 * transfer buffers to live in their own cache lines.
> > +	 */
> > +	union {
> > +		u8 tx_buf[2];
> > +		u8 rx_buf[2];
> > +	} ____cacheline_aligned;
> > +	u8 cur_adc_values[ADC_N_CHANNELS];
> > +};
> > +
> > +/**
> > + * Event triggered when value changes on a channel
> > + */
> > +static const struct iio_event_spec adc084s021_event = {
> > +	.type = IIO_EV_TYPE_CHANGE,
> > +	.dir = IIO_EV_DIR_NONE,
> > +};
> > +
> > +/**
> > + * Channel specification
> > + */
> > +#define ADC084S021_VOLTAGE_CHANNEL(num)                  \
> > +	{                                                      \
> > +		.type = IIO_VOLTAGE,                                 \
> > +		.channel = (num),                                    \
> > +		.address = (num << 3),                               \
> 
> parenthesis should be around (num)
Fixed in v2.
> 
> > +		.indexed = 1,                                        \
> > +		.scan_index = num,                                   \
> 
> parenthesis?
Fixed in v2.
> 
> > +		.scan_type = {                                       \
> > +			.sign = 'u',                                       \
> > +			.realbits = 8,                                     \
> > +			.storagebits = 32,                                 \
> > +			.shift = 24 - ((num << 3)),                        \
> 
> no need for (( )) around the expression, parenthesis should be around num
> 
> the shift doesn't make sense, you are shifting in 
> 
> adc084s021_adc_conversion() already and return just 8 bits (so storagebits 
> should be 8)?
> 
> you could/should use realbits = 8, storagebits = 16, shift = 4 and 
> endianness = IIO_BE if I read Figure 1 of the datasheet correctly
> 
This macro has been fixed according to your suggestion (and the
datasheet) in v2.
> > +		},                                                   \
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),        \
> 
> likely this is missing _SCALE
> IIO expects data to be returned in millivolt, see 
> Documentation/ABI/testing/sysfs-bus-iio
> 
Added IIO_CHAN_INFO_SCALE in v2.
> > +		.event_spec = &adc084s021_event,                     \
> > +		.num_event_specs = 1,                                \
> 
> ARRAY_SIZE(&adc084s021_event) to be extensible?
Removed events in v2.
> 
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
> > +static const struct adc084s021_configuration adc084s021_config[] = {
> > +	{ adc084s021_channels, ARRAY_SIZE(adc084s021_channels) },
> 
> for just one configuration, this is not really needed; so you plan/forsee 
> more chips being added soonish?
No more than this chip supported by this driver, so I use direct
addressing in v2.
> 
> > +};
> > +
> > +/**
> > + * Read an ADC channel and return its value.
> > + *
> > + * @adc: The ADC SPI data.
> > + * @channel: The IIO channel data structure.
> > + */
> > +static int adc084s021_adc_conversion(struct adc084s021 *adc,
> > +			   struct iio_chan_spec const *channel)
> > +{
> > +	u16 value;
> 
> value should be u8, but is not really needed
Fixed in v2.
> 
> > +	int ret;
> > +
> > +	mutex_lock(&adc->lock);
> > +	adc->tx_buf[0] = channel->address;
> > +
> > +	/* Do the transfer */
> > +	ret = spi_sync(adc->spi, &adc->message);
> > +
> 
> no newline here please
Fixed in v2.
> 
> > +	if (ret < 0) {
> > +		mutex_unlock(&adc->lock);
> > +		return ret;
> > +	}
> > +
> > +	value = (adc->rx_buf[0] << 4) | (adc->rx_buf[1] >> 4);
> 
> I recommend using __be16 for rx_buf and
> ret = (be16_to_cpu(adc->rx_buf) >> 4) & 0xff;
Fixed in v2.
> 
> > +	mutex_unlock(&adc->lock);
> > +
> > +	dev_dbg(&adc->spi->dev, "value 0x%02X on channel %d\n",
> > +			     value, channel->channel);
> > +	return value;
> > +}
> > +
> > +/**
> > + * Make a readout of requested IIO channel info.
> 
> no need to document this, it is found in every IIO driver...
Removed documentation for standard driver functions in v2.
> 
> > + *
> > + * @indio_dev: The industrial I/O device.
> > + * @channel: The IIO channel data structure.
> > + * @val: First element of value (integer).
> > + * @val2: Second element of value (fractional).
> > + * @mask: The info_mask to read.
> > + */
> > +static int adc084s021_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *channel, int *val,
> > +			   int *val2, long mask)
> > +{
> > +	struct adc084s021 *adc = iio_priv(indio_dev);
> > +	int retval;
> 
> how about using ret everywhere?
Fixed in v2.
> 
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> 
> probably want iio_device_claim_direct_mode() so to not interfere with 
> buffered access
Fixed in v2.
> 
> > +		retval = adc084s021_adc_conversion(adc, channel);
> > +		if (retval < 0)
> > +			return retval;
> > +
> > +		*val = retval;
> > +		return IIO_VAL_INT;
> > +
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
> > +static irqreturn_t adc084s021_trigger_handler(int irq, void *pollfunc)
> > +{
> > +	struct iio_poll_func *pf = pollfunc;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct adc084s021 *adc = iio_priv(indio_dev);
> > +	u8 *data;
> > +	s64 timestamp;
> > +	int value, scan_index;
> > +
> > +	data = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> 
> pre-allocate buffer with maximum size statically; allocation is 
> potentially expensive; don't forget space for the timestamp and padding...
Fixed in v2.
> 
> > +	if (!data) {
> > +		iio_trigger_notify_done(indio_dev->trig);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	timestamp = iio_get_time_ns(indio_dev);
> > +
> > +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> > +			 indio_dev->masklength) {
> > +		const struct iio_chan_spec *channel =
> > +			&indio_dev->channels[scan_index];
> > +		value = adc084s021_adc_conversion(adc, channel);
> 
> lock is taken and released for each channel, probably want to do it just 
> once?
Fixed in v2.
> 
> > +		data[scan_index] = value;
> > +
> > +		/*
> > +		 * Compare read data to previous read. If it differs send
> > +		 * event notification for affected channel.
> > +		 */
> > +		if (adc->cur_adc_values[scan_index] != (u8)value) {
> 
> cur_adc_values is not initialized (probably set to 0);
> so on first read, should the notification be sent?
Events no longer used in v2, so no need for this check anymore.
> 
> > +			adc->cur_adc_values[scan_index] = (u8)value;
> > +			iio_push_event(indio_dev,
> > +						  IIO_EVENT_CODE(IIO_VOLTAGE, 0,
> > +						    IIO_NO_MOD, IIO_EV_DIR_NONE,
> > +						    IIO_EV_TYPE_CHANGE,
> > +						    channel->channel, 0, 0),
> > +						  timestamp);
> > +			dev_dbg(&indio_dev->dev,
> > +					    "new value on ch%d: 0x%02X (ts %llu)\n",
> > +					    channel->channel, value, timestamp);
> > +		}
> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +	kfree(data);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static const struct iio_info adc084s021_info = {
> > +	.read_raw = adc084s021_read_raw,
> > +	.driver_module = THIS_MODULE,
> > +};
> > +
> > +/**
> > + * Create and register ADC IIO device for SPI.
> 
> comment is rather pointless
Fixed in v2.
> 
> > + */
> > +static int adc084s021_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct adc084s021 *adc;
> > +	int config = spi_get_device_id(spi)->driver_data;
> > +	int retval;
> 
> ret maybe
Using ret everywhere in v2.
> 
> > +
> > +	/* Allocate an Industrial I/O device */
> 
> obviously...
:) Fixed in v2.
> 
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> > +	if (!indio_dev) {
> > +		dev_err(&spi->dev, "Failed to allocate IIO device\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	adc = iio_priv(indio_dev);
> > +	adc->spi = spi;
> > +	spi->bits_per_word = ADC_RESOLUTION;
> > +
> > +	/* Update the SPI device with config and connect the iio dev */
> > +	retval = spi_setup(spi);
> > +	if (retval) {
> > +		dev_err(&spi->dev, "Failed to update SPI device\n");
> > +		return retval;
> > +	}
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	/* Initiate the Industrial I/O device */
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->dev.of_node = spi->dev.of_node;
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &adc084s021_info;
> > +	indio_dev->channels = adc084s021_config[config].channels;
> > +	indio_dev->num_channels = adc084s021_config[config].num_channels;
> 
> could do it directly as long there is just one configuration
Yes, fixed in v2.
> 
> > +
> > +	/* Create SPI transfer for channel reads */
> > +	adc->spi_trans[0].tx_buf = &adc->tx_buf[0];
> > +	adc->spi_trans[0].len = 2;
> > +	adc->spi_trans[0].speed_hz = spi->max_speed_hz;
> > +	adc->spi_trans[0].bits_per_word = spi->bits_per_word;
> > +	adc->spi_trans[1].rx_buf = &adc->rx_buf[0];
> > +	adc->spi_trans[1].len = 2;
> > +	adc->spi_trans[1].speed_hz = spi->max_speed_hz;
> > +	adc->spi_trans[1].bits_per_word = spi->bits_per_word;
> > +
> > +	/* Setup SPI message for channel reads */
> > +	spi_message_init(&adc->message);
> > +	spi_message_add_tail(&adc->spi_trans[0], &adc->message);
> > +	spi_message_add_tail(&adc->spi_trans[1], &adc->message);
> > +
> > +	adc->reg = devm_regulator_get(&spi->dev, "vref");
> > +	if (IS_ERR(adc->reg))
> > +		return PTR_ERR(adc->reg);
> > +
> > +	retval = regulator_enable(adc->reg);
> > +	if (retval < 0)
> > +		return retval;
> > +
> > +	mutex_init(&adc->lock);
> > +
> > +	/* Setup triggered buffer with pollfunction */
> > +	retval = iio_triggered_buffer_setup(indio_dev, NULL,
> 
> devm_()
I have not changed this yet in v2 since Jonathan has another opinion
about this.
> 
> > +					    adc084s021_trigger_handler, NULL);
> > +	if (retval) {
> > +		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
> > +		goto buffer_setup_failed;
> > +	}
> > +
> > +	retval = iio_device_register(indio_dev);
> > +	if (retval) {
> > +		dev_err(&spi->dev, "Failed to register IIO device\n");
> > +		goto device_register_failed;
> > +	}
> > +
> > +	dev_info(&spi->dev, "probed!\n");
> 
> no logging please, just outputs clutter
Fixed in v2.
> 
> > +	return 0;
> > +
> > +device_register_failed:
> > +	iio_triggered_buffer_cleanup(indio_dev);
> > +buffer_setup_failed:
> > +	regulator_disable(adc->reg);
> > +	return retval;
> > +}
> > +
> > +/**
> > + * Unregister ADC IIO device for SPI.
> > + */
> > +static int adc084s021_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct adc084s021 *adc = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	iio_triggered_buffer_cleanup(indio_dev);
> > +	regulator_disable(adc->reg);
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id adc084s021_of_match[] = {
> > +	{ .compatible = "ti,adc084s021", },
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, adc084s021_of_match);
> > +
> > +static const struct spi_device_id adc084s021_id[] = {
> > +	{ MODULE_NAME, 0},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(spi, adc084s021_id);
> > +
> > +static struct spi_driver adc084s021_driver = {
> > +	.driver = {
> > +		.name = MODULE_NAME,
> > +		.of_match_table = of_match_ptr(adc084s021_of_match),
> > +	},
> > +	.probe = adc084s021_probe,
> > +	.remove = adc084s021_remove,
> > +	.id_table = adc084s021_id,
> > +};
> > +
> > +module_spi_driver(adc084s021_driver);
> > +
> > +MODULE_AUTHOR("Mårten Lindahl <martenli@axis.com>");
> > +MODULE_DESCRIPTION("Texas Instruments ADC084S021");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_VERSION(DRIVER_VERSION);
> > 
> 


