Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 20 Nov 2016 18:10:02 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: David Lechner <david@lechnology.com>, Jonathan Cameron <jic23@kernel.org>
cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
    linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: New driver for TI ADS79XX chips
In-Reply-To: <f0034a6c-fb08-3007-54ae-b695cbd1f531@kernel.org>
Message-ID: <alpine.DEB.2.02.1611201754150.12696@pmeerw.net>
References: <1479508084-2665-1-git-send-email-david@lechnology.com> <f0034a6c-fb08-3007-54ae-b695cbd1f531@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Sat, 19 Nov 2016, Jonathan Cameron wrote:

> On 18/11/16 22:28, David Lechner wrote:
> > This adds a new driver for TI ADS79XX ADC chips. These communicate using
> > SPI and come in 8/10/12-bit and 4/8/12/16 channel varieties.
> > 
> > Signed-off-by: David Lechner <david@lechnology.com>

some more trivial comments

> Anyhow pretty good.  Various style comments and a few places where there
> are utility functions that can replace some boiler plate code.  All fairly
> trivial.

> > ---
> >  drivers/iio/adc/Kconfig      |  13 ++
> >  drivers/iio/adc/Makefile     |   1 +
> >  drivers/iio/adc/ti-ads79xx.c | 492 +++++++++++++++++++++++++++++++++++++++++++
> Don't use wild cards in naming.  Just pick a part and name it after that.
> Wild cards have gone wrong far too many times!  Pesky hardware manufacturers
> have a nasty habbit of releasing new parts that don't meet the assumptions.
> 
> Same applies to all the prefixes in the drivers.
> 
> >  3 files changed, 506 insertions(+)
> >  create mode 100644 drivers/iio/adc/ti-ads79xx.c
> > 
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 99c0514..e87e8a5 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -503,6 +503,19 @@ config TI_ADS1015
> >  	  This driver can also be built as a module. If so, the module will be
> >  	  called ti-ads1015.
> >  
> > +config TI_ADS79XX
> > +	tristate "Texas Instruments ADS79XX ADC driver"
> > +	depends on SPI
> > +	select IIO_BUFFER
> > +	select IIO_TRIGGERED_BUFFER
> > +	help
> > +	  Say yes here to build support for Texas Instruments ADS7950, ADS7951,
> > +	  ADS7952, ADS7953, ADS7954, ADS7955, ADS7956, ADS7957, ADS7958, ADS7959.
> > +	  ADS7960, ADS7961.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ti-ads79xx.
> > +
> >  config TI_ADS8688
> >  	tristate "Texas Instruments ADS8688"
> >  	depends on SPI && OF
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 7a40c04..8d0659a 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -47,6 +47,7 @@ obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
> >  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
> >  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
> >  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> > +obj-$(CONFIG_TI_ADS79XX) += ti-ads79xx.o
> >  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> >  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
> >  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
> > diff --git a/drivers/iio/adc/ti-ads79xx.c b/drivers/iio/adc/ti-ads79xx.c
> > new file mode 100644
> > index 0000000..42cade0
> > --- /dev/null
> > +++ b/drivers/iio/adc/ti-ads79xx.c
> > @@ -0,0 +1,492 @@
> > +/*
> > + * Texas Instruments ADS79XX SPI ADC driver
> > + *
> > + * Copyright 2016 David Lechner <david@lechnology.com>
> > + *
> > + * Based on iio/ad7923.c:
> > + * Copyright 2011 Analog Devices Inc
> > + * Copyright 2012 CS Systemes d'Information
> > + *
> > + * And also on hwmon/ads79xx.c
> > + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
> > + *	Nishanth Menon
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +#include <linux/module.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +
> > +#define ADS79XX_CR_MANUAL	(1 << 12)
> > +#define ADS79XX_CR_WRITE	(1 << 11)
> > +#define ADS79XX_CR_CHAN(ch)	(ch << 7)

put parenthesis around (ch)

> > +#define ADS79XX_CR_RANGE_5V	(1 << 6)
> > +
> > +#define ADS79XX_MAX_CHAN	16
> > +
> > +/* val = value, dec = left shift, bits = number of bits of the mask */
> > +#define EXTRACT(val, dec, bits)		((val >> dec) & ((1 << bits) - 1))

same here, parenthesis around (val), (dec), (bits) to avoid macro madness

> This has a generic enough name it may one day 'clash' with something in a
> header.  Probably best to prefix it with ADS7950 (or whatever ;) to
> avoid that hitting us later.
> > +
> > +struct ti_ads79xx_state {

stick with a prefix, either ADS79XX_ or TI_ADS79XX (ads79xx_ or 
ti_ads79xx, resp.) -- and please no wildcards

> > +	struct spi_device	*spi;
> > +	struct spi_transfer	ring_xfer[ADS79XX_MAX_CHAN+2];
> spaces around the + otherwise I'll get an irritating patch to 'fix' that
> later ;)
> > +	struct spi_transfer	scan_single_xfer[3];
> > +	struct spi_message	ring_msg;
> > +	struct spi_message	scan_single_msg;
> > +
> > +	struct regulator	*reg;
> > +
> > +	unsigned int		settings;
> > +
> > +	/*
> > +	 * DMA (thus cache coherency maintenance) requires the
> > +	 * transfer buffers to live in their own cache lines.
> > +	 */
> > +	__be16			rx_buf[ADS79XX_MAX_CHAN] ____cacheline_aligned;
> > +	__be16			tx_buf[ADS79XX_MAX_CHAN];
> > +};
> > +
> > +struct ti_ads79xx_chip_info {
> > +	const struct iio_chan_spec *channels;
> > +	unsigned int num_channels;
> > +};
> > +
> > +enum ti_ads79xx_id {
> > +	ADS7950,
> > +	ADS7951,
> > +	ADS7952,
> > +	ADS7953,
> > +	ADS7954,
> > +	ADS7955,
> > +	ADS7956,
> > +	ADS7957,
> > +	ADS7958,
> > +	ADS7959,
> > +	ADS7960,
> > +	ADS7961,
> > +};
> > +
> > +#define ADS79XX_V_CHAN(index, bits)				\
> > +{								\
> > +	.type = IIO_VOLTAGE,					\
> > +	.indexed = 1,						\
> > +	.channel = index,					\
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> > +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> > +	.address = index,					\
> > +	.datasheet_name = "CH##index",				\
> > +	.scan_index = index,					\
> > +	.scan_type = {						\
> > +		.sign = 'u',					\
> > +		.realbits = (bits),				\

bits has parenthesis, but not index

> > +		.storagebits = 16,				\
> > +		.endianness = IIO_BE,				\
> > +	},							\
> > +}
> > +
> > +#define DECLARE_ADS79XX_4_CHANNELS(name, bits) \
> > +const struct iio_chan_spec name ## _channels[] = { \
> > +	ADS79XX_V_CHAN(0, bits), \
> > +	ADS79XX_V_CHAN(1, bits), \
> > +	ADS79XX_V_CHAN(2, bits), \
> > +	ADS79XX_V_CHAN(3, bits), \
> > +	IIO_CHAN_SOFT_TIMESTAMP(4), \
> > +}
> > +
> > +#define DECLARE_ADS79XX_8_CHANNELS(name, bits) \
> > +const struct iio_chan_spec name ## _channels[] = { \
> > +	ADS79XX_V_CHAN(0, bits), \
> > +	ADS79XX_V_CHAN(1, bits), \
> > +	ADS79XX_V_CHAN(2, bits), \
> > +	ADS79XX_V_CHAN(3, bits), \
> > +	ADS79XX_V_CHAN(4, bits), \
> > +	ADS79XX_V_CHAN(5, bits), \
> > +	ADS79XX_V_CHAN(6, bits), \
> > +	ADS79XX_V_CHAN(7, bits), \
> > +	IIO_CHAN_SOFT_TIMESTAMP(8), \
> > +}
> > +
> > +#define DECLARE_ADS79XX_12_CHANNELS(name, bits) \
> > +const struct iio_chan_spec name ## _channels[] = { \
> > +	ADS79XX_V_CHAN(0, bits), \
> > +	ADS79XX_V_CHAN(1, bits), \
> > +	ADS79XX_V_CHAN(2, bits), \
> > +	ADS79XX_V_CHAN(3, bits), \
> > +	ADS79XX_V_CHAN(4, bits), \
> > +	ADS79XX_V_CHAN(5, bits), \
> > +	ADS79XX_V_CHAN(6, bits), \
> > +	ADS79XX_V_CHAN(7, bits), \
> > +	ADS79XX_V_CHAN(8, bits), \
> > +	ADS79XX_V_CHAN(9, bits), \
> > +	ADS79XX_V_CHAN(10, bits), \
> > +	ADS79XX_V_CHAN(11, bits), \
> > +	IIO_CHAN_SOFT_TIMESTAMP(12), \
> > +}
> > +
> > +#define DECLARE_ADS79XX_16_CHANNELS(name, bits) \
> > +const struct iio_chan_spec name ## _channels[] = { \
> > +	ADS79XX_V_CHAN(0, bits), \
> > +	ADS79XX_V_CHAN(1, bits), \
> > +	ADS79XX_V_CHAN(2, bits), \
> > +	ADS79XX_V_CHAN(3, bits), \
> > +	ADS79XX_V_CHAN(4, bits), \
> > +	ADS79XX_V_CHAN(5, bits), \
> > +	ADS79XX_V_CHAN(6, bits), \
> > +	ADS79XX_V_CHAN(7, bits), \
> > +	ADS79XX_V_CHAN(8, bits), \
> > +	ADS79XX_V_CHAN(9, bits), \
> > +	ADS79XX_V_CHAN(10, bits), \
> > +	ADS79XX_V_CHAN(11, bits), \
> > +	ADS79XX_V_CHAN(12, bits), \
> > +	ADS79XX_V_CHAN(13, bits), \
> > +	ADS79XX_V_CHAN(14, bits), \
> > +	ADS79XX_V_CHAN(15, bits), \
> > +	IIO_CHAN_SOFT_TIMESTAMP(16), \
> > +}
> > +
> > +static DECLARE_ADS79XX_4_CHANNELS(ti_ads7950, 12);
> > +static DECLARE_ADS79XX_8_CHANNELS(ti_ads7951, 12);
> > +static DECLARE_ADS79XX_12_CHANNELS(ti_ads7952, 12);
> > +static DECLARE_ADS79XX_16_CHANNELS(ti_ads7953, 12);
> > +static DECLARE_ADS79XX_4_CHANNELS(ti_ads7954, 10);
> > +static DECLARE_ADS79XX_8_CHANNELS(ti_ads7955, 10);
> > +static DECLARE_ADS79XX_12_CHANNELS(ti_ads7956, 10);
> > +static DECLARE_ADS79XX_16_CHANNELS(ti_ads7957, 10);
> > +static DECLARE_ADS79XX_4_CHANNELS(ti_ads7958, 8);
> > +static DECLARE_ADS79XX_8_CHANNELS(ti_ads7959, 8);
> > +static DECLARE_ADS79XX_12_CHANNELS(ti_ads7960, 8);
> > +static DECLARE_ADS79XX_16_CHANNELS(ti_ads7961, 8);
> > +
> > +static const struct ti_ads79xx_chip_info ti_ads79xx_chip_info[] = {
> > +	[ADS7950] = {
> > +		.channels	= ti_ads7950_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7950_channels),
> > +	},
> > +	[ADS7951] = {
> > +		.channels	= ti_ads7951_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7951_channels),
> > +	},
> > +	[ADS7952] = {
> > +		.channels	= ti_ads7952_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7952_channels),
> > +	},
> > +	[ADS7953] = {
> > +		.channels	= ti_ads7953_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7953_channels),
> > +	},
> > +	[ADS7954] = {
> > +		.channels	= ti_ads7954_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7954_channels),
> > +	},
> > +	[ADS7955] = {
> > +		.channels	= ti_ads7955_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7955_channels),
> > +	},
> > +	[ADS7956] = {
> > +		.channels	= ti_ads7956_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7956_channels),
> > +	},
> > +	[ADS7957] = {
> > +		.channels	= ti_ads7957_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7957_channels),
> > +	},
> > +	[ADS7958] = {
> > +		.channels	= ti_ads7958_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7958_channels),
> > +	},
> > +	[ADS7959] = {
> > +		.channels	= ti_ads7959_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7959_channels),
> > +	},
> > +	[ADS7960] = {
> > +		.channels	= ti_ads7960_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7960_channels),
> > +	},
> > +	[ADS7961] = {
> > +		.channels	= ti_ads7961_channels,
> > +		.num_channels	= ARRAY_SIZE(ti_ads7961_channels),
> > +	},
> > +};
> > +
> > +/*
> > + * ti_ads79xx_update_scan_mode() setup the spi transfer buffer for the new
> > + * scan mask
> > + */
> > +static int ti_ads79xx_update_scan_mode(struct iio_dev *indio_dev,
> > +				       const unsigned long *active_scan_mask)
> > +{
> > +	struct ti_ads79xx_state *st = iio_priv(indio_dev);
> > +	int i, cmd, len;
> > +
> > +	len = 0;
> > +	for_each_set_bit(i, active_scan_mask, indio_dev->num_channels) {
> > +		cmd = ADS79XX_CR_WRITE | ADS79XX_CR_CHAN(i) | st->settings;
> > +		st->tx_buf[len++] = cpu_to_be16(cmd);
> > +	}
> > +
> > +	/* build spi ring message */
> > +	spi_message_init(&st->ring_msg);
> I think you could easily reorder this to do using the init and add messages
> call spi provides.  Would be every so slightly cleaner.
> > +
> > +	/* Data for the 1st channel is not retuned until the 3rd transfer */

returned

> > +	len += 2;
> > +	for (i = 0; i < len; i++) {
> > +		if ((i + 2) < len)
> > +			st->ring_xfer[i].tx_buf = &st->tx_buf[i];
> > +		if (i >= 2)
> > +			st->ring_xfer[i].rx_buf = &st->rx_buf[i - 2];
> > +		st->ring_xfer[i].len = 2;
> > +		st->ring_xfer[i].cs_change = 1;
> > +		spi_message_add_tail(&st->ring_xfer[i], &st->ring_msg);
> > +	}
> > +	/* make sure last transfer's cs_change is not set */
> > +	st->ring_xfer[len - 1].cs_change = 0;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * ti_ads79xx_trigger_handler() bh of trigger launched polling to ring buffer
> > + *
> > + * Currently there is no option in this driver to disable the saving of
> > + * timestamps within the ring.
> 
> It should 'just work' as you have registered a timestamp channel.  If you turn
> it off in sysfs it then the iio_push_to_buffers_with_timestamp will 'eat' it.

delete 'it' before then

> 
> > + */
> > +static irqreturn_t ti_ads79xx_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct ti_ads79xx_state *st = iio_priv(indio_dev);
> > +	int b_sent;
> > +
> > +	b_sent = spi_sync(st->spi, &st->ring_msg);
> > +	if (b_sent)
> > +		goto done;
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,

is there enough space in rx_buf for data + timestamp?

> > +					   iio_get_time_ns(indio_dev));
> > +
> > +done:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int ti_ads79xx_scan_direct(struct ti_ads79xx_state *st, unsigned ch)
> > +{
> > +	int ret, cmd;
> > +
> > +	cmd = ADS79XX_CR_WRITE | ADS79XX_CR_CHAN(ch) | st->settings;
> > +	st->tx_buf[0] = cpu_to_be16(cmd);
> > +
> > +	ret = spi_sync(st->spi, &st->scan_single_msg);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return be16_to_cpu(st->rx_buf[0]);
> > +}
> > +
> > +static int ti_ads79xx_get_range(struct ti_ads79xx_state *st)
> > +{
> > +	int vref;
> > +
> > +	vref = regulator_get_voltage(st->reg);
> > +	if (vref < 0)
> > +		return vref;
> > +
> > +	vref /= 1000;
> > +
> > +	if (st->settings & ADS79XX_CR_RANGE_5V)
> > +		vref *= 2;
> > +
> > +	return vref;
> > +}
> > +
> > +static int ti_ads79xx_read_raw(struct iio_dev *indio_dev,
> > +			       struct iio_chan_spec const *chan,
> > +			       int *val, int *val2, long m)
> > +{
> > +	struct ti_ads79xx_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	switch (m) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		mutex_lock(&indio_dev->mlock);
> 
> Use the iio_device_claim_direct_mode etc helpers to hande this.
> (they haven't been there that long, but do make it a little more obvious what
> is going on in this circumstances).
> 
> > +		if (iio_buffer_enabled(indio_dev))
> > +			ret = -EBUSY;
> > +		else
> > +			ret = ti_ads79xx_scan_direct(st, chan->address);
> > +		mutex_unlock(&indio_dev->mlock);
> > +
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		if (chan->address == EXTRACT(ret, 12, 4))
> > +			*val = EXTRACT(ret, 0, 12);
> > +		else
> > +			return -EIO;
> I'd prefer this flipped around.
> if (chan->address != EXTRACT(ret, 12, 4))
>    return -EIO;
> 
> Nice to keep the error path as the indented flow.
> 
> > +
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		ret = ti_ads79xx_get_range(st);
> > +		if (ret < 0)
> > +			return ret;
> > +		*val = ret;
> > +		*val2 = chan->scan_type.realbits;
> Another real nitpick ;) Keep your blank lines consistent by adding
> one here.
> > +		return IIO_VAL_FRACTIONAL_LOG2;
> > +	}
> And here.
> > +	return -EINVAL;
> > +}
> > +
> > +static const struct iio_info ti_ads79xx_info = {
> > +	.read_raw		= &ti_ads79xx_read_raw,
> > +	.update_scan_mode	= ti_ads79xx_update_scan_mode,
> > +	.driver_module		= THIS_MODULE,
> > +};
> > +
> > +static int ti_ads79xx_probe(struct spi_device *spi)
> > +{
> > +	struct ti_ads79xx_state *st;
> > +	struct iio_dev *indio_dev;
> > +	const struct ti_ads79xx_chip_info *info;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (indio_dev == NULL)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	st->spi = spi;
> > +	st->settings = ADS79XX_CR_MANUAL | ADS79XX_CR_RANGE_5V;
> > +
> > +	info = &ti_ads79xx_chip_info[spi_get_device_id(spi)->driver_data];
> > +
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->channels = info->channels;
> > +	indio_dev->num_channels = info->num_channels;
> > +	indio_dev->info = &ti_ads79xx_info;
> > +
> > +	/*
> > +	 * Setup default message. The chip takes one full cycle to convert a
> > +	 * sample. The conversion process is driven by the SPI clock, which
> > +	 * is why we have 3 transfers. The middle one is just dummy data sent
> > +	 * while the chip is converting the sample from first transfer.
> > +	 */
> > +
> > +	st->scan_single_xfer[0].tx_buf = &st->tx_buf[0];
> > +	st->scan_single_xfer[0].len = 2;
> > +	st->scan_single_xfer[0].cs_change = 1;
> > +	st->scan_single_xfer[1].tx_buf = &st->tx_buf[0];
> > +	st->scan_single_xfer[1].len = 2;
> > +	st->scan_single_xfer[1].cs_change = 1;
> > +	st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
> > +	st->scan_single_xfer[2].len = 2;
> > +
> Use spi_message_init_with_transfers (really minor but why not ;)
> > +	spi_message_init(&st->scan_single_msg);
> > +	spi_message_add_tail(&st->scan_single_xfer[0], &st->scan_single_msg);
> > +	spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
> > +	spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
> > +
> > +	st->reg = devm_regulator_get(&spi->dev, "refin");
> > +	if (IS_ERR(st->reg)) {
> > +		dev_err(&spi->dev, "Failed get get regulator \"refin\"\n");
> > +		return PTR_ERR(st->reg);
> > +	}
> > +
> > +	ret = regulator_enable(st->reg);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to enable regulator \"refin\"\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > +					 &ti_ads79xx_trigger_handler, NULL);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to setup triggered buffer\n");
> > +		goto error_disable_reg;
> > +	}
> > +
> > +	ret = iio_device_register(indio_dev);
> > +	if (ret) {
> > +		dev_err(&spi->dev, "Failed to register iio device\n");
> > +		goto error_cleanup_ring;
> > +	}
> > +
> Don't bother with this. It's easy to tell from sysfs or the results of the
> probe that it worked or not.  This just puts uninformative noise in the
> logs (different matter if there is a serial number of similar that provides
> additional info!)
> > +	dev_info(&spi->dev, "Registered %s\n", indio_dev->name);
> > +
> > +	return 0;
> > +
> > +error_cleanup_ring:
> > +	iio_triggered_buffer_cleanup(indio_dev);
> > +error_disable_reg:
> > +	regulator_disable(st->reg);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ti_ads79xx_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct ti_ads79xx_state *st = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +	iio_triggered_buffer_cleanup(indio_dev);
> > +	regulator_disable(st->reg);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct spi_device_id ti_ads79xx_id[] = {
> > +	{"ti-ads7950", ADS7950},
> > +	{"ti-ads7951", ADS7951},
> > +	{"ti-ads7952", ADS7952},
> > +	{"ti-ads7953", ADS7953},
> > +	{"ti-ads7954", ADS7954},
> > +	{"ti-ads7955", ADS7955},
> > +	{"ti-ads7956", ADS7956},
> > +	{"ti-ads7957", ADS7957},
> > +	{"ti-ads7958", ADS7958},
> > +	{"ti-ads7959", ADS7959},
> > +	{"ti-ads7960", ADS7960},
> > +	{"ti-ads7961", ADS7961},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, ti_ads79xx_id);
> > +
> > +static struct spi_driver ti_ads79xx_driver = {
> > +	.driver = {
> > +		.name	= "ti-ads79xx",
> > +	},
> > +	.probe		= ti_ads79xx_probe,
> > +	.remove		= ti_ads79xx_remove,
> > +	.id_table	= ti_ads79xx_id,
> > +};
> > +module_spi_driver(ti_ads79xx_driver);
> > +
> > +MODULE_AUTHOR("David Lechner <david@lechnology.com>");
> > +MODULE_DESCRIPTION("TI ADS79XX ADC");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
