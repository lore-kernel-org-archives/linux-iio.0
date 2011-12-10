Return-Path: <jic23@kernel.org>
Message-ID: <4EE365C7.60900@kernel.org>
Date: Sat, 10 Dec 2011 13:59:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio:adc: Add AD7265/AD7266 support
References: <1323333852-4975-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1323333852-4975-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/08/2011 08:44 AM, Lars-Peter Clausen wrote:
> This patch adds support for the Analog Devices AD7265 and AD7266
> Analog-to-Digital converters.
> 
A few minor bits inline.
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/Kconfig  |   10 +
>  drivers/staging/iio/adc/Makefile |    1 +
>  drivers/staging/iio/adc/ad7266.c |  407 ++++++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/adc/ad7266.h |   54 +++++
>  4 files changed, 472 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/staging/iio/adc/ad7266.c
>  create mode 100644 drivers/staging/iio/adc/ad7266.h
> 
> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
> index c310a68..58f9821 100644
> --- a/drivers/staging/iio/adc/Kconfig
> +++ b/drivers/staging/iio/adc/Kconfig
> @@ -13,6 +13,16 @@ config AD7091
>  	  Say yes here to build support for Analog Devices AD7091
>  	  ADC.
>  
> +config AD7266
> +	tristate "Analog Devices AD7265/AD7266 ADC driver"
> +	select IIO_BUFFER
> +	select IIO_TRIGGER
> +	select IIO_SW_RING
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD7265 and AD7266
> +	  ADC.
> +
>  config AD7291
>  	tristate "Analog Devices AD7291 ADC driver"
>  	depends on I2C
> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
> index 6e3b807..85a3eb7 100644
> --- a/drivers/staging/iio/adc/Makefile
> +++ b/drivers/staging/iio/adc/Makefile
> @@ -30,6 +30,7 @@ ad7298-$(CONFIG_IIO_BUFFER) += ad7298_ring.o
>  obj-$(CONFIG_AD7298) += ad7298.o
>  
>  obj-$(CONFIG_AD7091) += ad7091.o
> +obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7780) += ad7780.o
>  obj-$(CONFIG_AD7793) += ad7793.o
> diff --git a/drivers/staging/iio/adc/ad7266.c b/drivers/staging/iio/adc/ad7266.c
> new file mode 100644
> index 0000000..684b0d0
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ad7266.c
> @@ -0,0 +1,407 @@
> +/*
> + * AD7266/65 SPI ADC driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/module.h>
> +
> +#include <linux/interrupt.h>
> +
> +#include "../iio.h"
> +#include "../trigger_consumer.h"
> +#include "../buffer.h"
> +#include "../ring_sw.h"
> +
> +#include "ad7266.h"
> +
> +struct ad7266_state {
> +	struct spi_device	*spi;
> +	struct regulator	*reg;
> +	unsigned long		vref_uv;
> +
> +	struct spi_transfer	single_xfer[3];
> +	struct spi_message	single_msg;
> +
> +	enum ad7266_range	range;
> +	enum ad7266_mode	mode;
> +	bool			fixed_addr;
> +	struct gpio		gpios[3];
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	uint8_t data[ALIGN(4, sizeof(s64)) + sizeof(s64)] ____cacheline_aligned;
> +};
> +
> +static irqreturn_t ad7266_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	struct ad7266_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = spi_read(st->spi, st->data, 4);
> +	if (ret == 0) {
> +		if (buffer->scan_timestamp)
> +			((s64 *)st->data)[2] = pf->timestamp;
[2]?  Not [1]?  Before this we have 2 16 bit values I think so we are
only up to 32.
Can start the timestamp at offset 64 rather than offset 128.
Also should timestamp be in the chanspec arrays?  Otherwise it is not
controllable and
the core has no idea where to find it.
> +		iio_push_to_buffer(buffer, (u8 *)st->data, pf->timestamp);
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
Extra white line here to loose...
> +
> +static void ad7266_select_input(struct ad7266_state *st, unsigned int nr)
> +{
> +	unsigned int i;
> +
> +	if (st->fixed_addr)
> +		return;
> +
> +	switch (st->mode) {
> +	case AD7266_MODE_SINGLE_ENDED:
> +		nr >>= 1;
> +		break;
> +	case AD7266_MODE_PSEUDO_DIFF:
> +		nr |= 1;
> +		break;
> +	case AD7266_MODE_DIFF:
> +		nr &= ~1;
> +		break;
> +	}
> +
> +	for (i = 0; i < 3; ++i)
> +		gpio_set_value(st->gpios[i].gpio, (bool)(nr & BIT(i)));
> +}
> +
> +int ad7266_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *scan_mask)
> +{
> +	struct ad7266_state *st = iio_priv(indio_dev);
> +	unsigned int nr = __ffs(*scan_mask);
I'd prefer find_first_set() from linux/bitmap.h.
> +
> +	ad7266_select_input(st, nr);
> +
> +	return 0;
> +}
> +
> +static int ad7266_read_single(struct ad7266_state *st, int *val,
> +	unsigned int address)
> +{
> +	int ret;
> +
> +	ad7266_select_input(st, address);
> +
> +	ret = spi_sync(st->spi, &st->single_msg);
> +	*val = be16_to_cpu(st->data[address % 2]);
> +
> +	return ret;
> +}
> +
> +static int ad7266_read_raw(struct iio_dev *indio_dev,
> +	struct iio_chan_spec const *chan, int *val, int *val2, long m)
> +{
> +	struct ad7266_state *st = iio_priv(indio_dev);
> +	unsigned long scale_uv;
> +	int ret;
> +
> +	switch (m) {
> +	case 0:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		ret = ad7266_read_single(st, val, chan->address);
> +		if (ret)
> +			return ret;
> +
> +		*val = (*val >> 2) & 0xfff;
> +		if (chan->scan_type.sign == 's')
> +			*val = sign_extend32(*val, 11);
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		scale_uv = (st->vref_uv * 100);
> +		if (st->range == AD7266_RANGE_2VREF)
> +			scale_uv *= 2;
> +
> +		scale_uv >>= chan->scan_type.realbits;
> +		*val =  scale_uv / 100000;
> +		*val2 = (scale_uv % 100000) * 10;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (st->range == AD7266_RANGE_2VREF &&
> +			st->mode == AD7266_MODE_SINGLE_ENDED)
> +			*val = -2048;
> +		else
> +			*val = 0;
> +		return IIO_VAL_INT;
> +	}
> +	return -EINVAL;
> +}
> +
> +#define AD7266_CHAN(_chan, _sign) {			\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.channel = (_chan),				\
> +	.address = (_chan),				\
> +	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT	\
> +		| IIO_CHAN_INFO_OFFSET_SHARED_BIT,	\
> +	.scan_index = (_chan),				\
> +	.scan_type = IIO_ST((_sign), 12, 16, 2),	\
> +}
> +
> +#define AD7266_DECLARE_SINGLE_ENDED_CHANNELS(_name, _sign) \
> +const struct iio_chan_spec ad7266_channels_##_name[] = { \
> +	AD7266_CHAN(0, (_sign)), \
> +	AD7266_CHAN(1, (_sign)), \
> +	AD7266_CHAN(2, (_sign)), \
> +	AD7266_CHAN(3, (_sign)), \
> +	AD7266_CHAN(4, (_sign)), \
> +	AD7266_CHAN(5, (_sign)), \
> +	AD7266_CHAN(6, (_sign)), \
> +	AD7266_CHAN(7, (_sign)), \
> +	AD7266_CHAN(8, (_sign)), \
> +	AD7266_CHAN(9, (_sign)), \
> +	AD7266_CHAN(10, (_sign)), \
> +	AD7266_CHAN(11, (_sign)), \
> +};
> +
> +static AD7266_DECLARE_SINGLE_ENDED_CHANNELS(u, 'u');
> +static AD7266_DECLARE_SINGLE_ENDED_CHANNELS(s, 's');
> +
> +#define AD7266_CHAN_DIFF(_chan) {			\
> +	.type = IIO_VOLTAGE,				\
> +	.indexed = 1,					\
> +	.channel = (_chan) * 2,				\
> +	.channel2 = (_chan) * 2 + 1,			\
> +	.address = (_chan),				\
> +	.info_mask = IIO_CHAN_INFO_SCALE_SHARED_BIT,	\
> +	.scan_index = (_chan),				\
> +	.scan_type = IIO_ST('s', 12, 16, 2),		\
> +	.differential = 1,				\
> +}
> +
> +static const struct iio_chan_spec ad7266_channels_diff[] = {
> +	AD7266_CHAN_DIFF(0),
> +	AD7266_CHAN_DIFF(1),
> +	AD7266_CHAN_DIFF(2),
> +	AD7266_CHAN_DIFF(3),
> +	AD7266_CHAN_DIFF(4),
> +	AD7266_CHAN_DIFF(5),
> +};
> +
> +static const struct iio_info ad7266_info = {
> +	.read_raw = &ad7266_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static unsigned long ad7266_available_scan_masks[] = {
> +	0x003,
> +	0x00c,
> +	0x030,
> +	0x0c0,
> +	0x300,
> +	0xc00,
> +	0x000,
> +};
> +
> +static unsigned long ad7266_available_scan_masks_diff[] = {
> +	0x003,
> +	0x00c,
> +	0x030,
> +	0x000,
> +};
> +
> +static unsigned long ad7266_available_scan_masks_fixed[] = {
> +	0x003,
> +	0x000,
> +};
> +
> +static const char * const ad7266_gpio_labels[] = {
> +	"AD0", "AD1", "AD2",
> +};
> +
> +static int __devinit ad7266_probe(struct spi_device *spi)
> +{
> +	struct ad7266_platform_data *pdata = spi->dev.platform_data;
> +	struct iio_dev *indio_dev;
> +	unsigned long *scan_masks;
> +	struct ad7266_state *st;
> +	unsigned int i;
> +	int ret;
> +
> +	indio_dev = iio_allocate_device(sizeof(*st));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->reg = regulator_get(&spi->dev, "vref");
> +	if (!IS_ERR_OR_NULL(st->reg)) {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			goto error_put_reg;
> +
> +		st->vref_uv = regulator_get_voltage(st->reg);
> +	} else {
> +		/* Use internal reference */
This is a little nasty. I see from the datasheet that use of
vref is controlled using a pin.  I guess you are assuming that
board designers will typically hardwire that high or low dependent
on whether they are supply an external reference.  Thus assumption
is that if we have a regulator above then we aren't using the
internal ref?  If so, perhaps a comment would make this obvious.
> +		st->vref_uv = 2500000;
> +	}
> +
> +	if (pdata) {
> +		st->fixed_addr = pdata->fixed_addr;
> +		st->mode = pdata->mode;
> +		st->range = pdata->range;
> +
> +		if (!st->fixed_addr) {
> +			for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
> +				st->gpios[i].gpio = pdata->addr_gpios[i];
> +				st->gpios[i].flags = GPIOF_OUT_INIT_LOW;
> +				st->gpios[i].label = ad7266_gpio_labels[i];
> +			}
> +			ret = gpio_request_array(st->gpios,
> +				ARRAY_SIZE(st->gpios));
> +			if (ret)
> +				goto error_disable_reg;
> +		}
> +	} else {
> +		st->fixed_addr = true;
> +		st->range = AD7266_RANGE_VREF;
> +		st->mode = AD7266_MODE_DIFF;
> +	}
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	st->spi = spi;
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ad7266_info;
> +
Interesting. I vaguely wonder if we want to support controlling the pins
that set whether single ended vs differential?  That way it can be
controlled
in software (assuming pin is wired up.)  Guess that is getting a little
fiddly unless there is a user who actually does have a board wired to allow
controlling this though...

> +	if (st->mode == AD7266_MODE_SINGLE_ENDED) {
> +		if (st->range == AD7266_RANGE_VREF) {
> +			indio_dev->channels = ad7266_channels_u;
> +			indio_dev->num_channels = ARRAY_SIZE(ad7266_channels_u);
> +		} else {
> +			indio_dev->channels = ad7266_channels_s;
> +			indio_dev->num_channels = ARRAY_SIZE(ad7266_channels_s);
> +		}
> +		scan_masks = ad7266_available_scan_masks;
> +	} else {
> +		indio_dev->channels = ad7266_channels_diff;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7266_channels_diff);
> +		scan_masks = ad7266_available_scan_masks_diff;
> +	}
> +
> +	if (!st->fixed_addr) {
> +		indio_dev->available_scan_masks = scan_masks;
> +		indio_dev->masklength = indio_dev->num_channels;
> +	} else {
> +		indio_dev->available_scan_masks = ad7266_available_scan_masks_fixed;
> +		indio_dev->masklength = 2;
> +		indio_dev->num_channels = 2;
> +	}
> +
> +	/* wakeup */
> +	st->single_xfer[0].rx_buf = &st->data;
> +	st->single_xfer[0].len = 2;
> +	st->single_xfer[0].cs_change = 1;
> +	/* conversion */
> +	st->single_xfer[1].rx_buf = &st->data;
> +	st->single_xfer[1].len = 4;
> +	st->single_xfer[1].cs_change = 1;
> +	/* powerdown */
> +	st->single_xfer[2].tx_buf = &st->data;
> +	st->single_xfer[2].len = 1;
> +
> +	spi_message_init(&st->single_msg);
> +	spi_message_add_tail(&st->single_xfer[0], &st->single_msg);
> +	spi_message_add_tail(&st->single_xfer[1], &st->single_msg);
> +	spi_message_add_tail(&st->single_xfer[2], &st->single_msg);
> +
> +	ret = iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
> +		&ad7266_trigger_handler);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_free_gpios;
> +
> +	return 0;
> +
> +error_free_gpios:
> +	gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
> +error_disable_reg:
> +	if (!IS_ERR_OR_NULL(st->reg))
> +		regulator_disable(st->reg);
> +error_put_reg:
> +	if (!IS_ERR_OR_NULL(st->reg))
> +		regulator_put(st->reg);
> +
> +	iio_free_device(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int __devexit ad7266_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ad7266_state *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
> +	if (!IS_ERR_OR_NULL(st->reg)) {
> +		regulator_disable(st->reg);
> +		regulator_put(st->reg);
> +	}
> +	iio_free_device(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id ad7266_id[] = {
> +	{"ad7265", 0},
> +	{"ad7266", 0},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad7266_id);
> +
> +static struct spi_driver ad7266_driver = {
> +	.driver = {
> +		.name	= "ad7266",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= ad7266_probe,
> +	.remove		= __devexit_p(ad7266_remove),
> +	.id_table	= ad7266_id,
> +};
> +
> +static int __init ad7266_init(void)
> +{
> +	return spi_register_driver(&ad7266_driver);
> +}
> +module_init(ad7266_init);
> +
> +static void __exit ad7266_exit(void)
> +{
> +	spi_unregister_driver(&ad7266_driver);
> +}
> +module_exit(ad7266_exit);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("Analog Devices AD7266/65 ADC");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/staging/iio/adc/ad7266.h b/drivers/staging/iio/adc/ad7266.h
> new file mode 100644
> index 0000000..dd96be7
> --- /dev/null
> +++ b/drivers/staging/iio/adc/ad7266.h
> @@ -0,0 +1,54 @@
> +/*
> + * AD7266/65 SPI ADC driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#ifndef __IIO_ADC_AD7266_H__
> +#define __IIO_ADC_AD7266_H__
> +
> +/*
> + * ad7266_range - AD7266 reference voltage range
> + * @AD7266_RANGE_VREF: Device is configured for input range 0V - VREF
> + *			(RANGE pin set to low)
> + * @AD7266_RANGE_2VREF: Device is configured for input range 0V - 2VREF
> + *			(RANGE pin set to high)
> + */
> +enum ad7266_range {
> +	AD7266_RANGE_VREF,
> +	AD7266_RANGE_2VREF,
> +};
> +
> +/*
> + * ad7266_mode - AD7266 sample mode
> + * @AD7266_MODE_DIFF: Device is configured for full differntial mode
> + *				(SGL/DIFF pin set to low, AD0 pin set to low)
> + * @AD7266_MODE_PSEUDO_DIFF: Device is configured for pseudo differential mode
> + *				(SGL/DIFF pin set to low, AD0 pin set to high)
> + * @AD7266_MODE_SINGLE_ENDED: Device is configured for signle-ended mode
typo signle->single
> + *				(SGL/DIFF pin set to high)
> + */
> +enum ad7266_mode {
> +	AD7266_MODE_DIFF,
> +	AD7266_MODE_PSEUDO_DIFF,
> +	AD7266_MODE_SINGLE_ENDED,
> +};
> +
> +/*
I think this isn't quite kernel doc style.  Please run it through
kernel-doc and see
what that moans about.
> + * ad7266_platform_data - Platform data for the AD7266 driver
> + * @range: Reference voltage range the device is configuired for
> + * @mode: Sample mode the device is configured for
> + * @fixed_addr: Whether the AD pins are hard-wired
> + * @addr_gpios: GPIOs used for controlling the AD pins, only valid if fixed_addr
> + *		is set to false.
> + */
> +struct ad7266_platform_data {
> +	enum ad7266_range range;
> +	enum ad7266_mode mode;
> +	bool fixed_addr;
> +	unsigned int addr_gpios[3];
> +};
> +
> +#endif
