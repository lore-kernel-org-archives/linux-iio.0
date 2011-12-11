Return-Path: <lars@metafoo.de>
Message-ID: <4EE4E05A.6080107@metafoo.de>
Date: Sun, 11 Dec 2011 17:54:50 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio:adc: Add AD7265/AD7266 support
References: <1323333852-4975-1-git-send-email-lars@metafoo.de> <4EE365C7.60900@kernel.org>
In-Reply-To: <4EE365C7.60900@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/10/2011 02:59 PM, Jonathan Cameron wrote:
> On 12/08/2011 08:44 AM, Lars-Peter Clausen wrote:
>> This patch adds support for the Analog Devices AD7265 and AD7266
>> Analog-to-Digital converters.
>>
> A few minor bits inline.
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>[...]
>> diff --git a/drivers/staging/iio/adc/ad7266.c b/drivers/staging/iio/adc/ad7266.c
>> new file mode 100644
>> index 0000000..684b0d0
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7266.c
>> @@ -0,0 +1,407 @@
>[...]
>> +static irqreturn_t ad7266_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct iio_buffer *buffer = indio_dev->buffer;
>> +	struct ad7266_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = spi_read(st->spi, st->data, 4);
>> +	if (ret == 0) {
>> +		if (buffer->scan_timestamp)
>> +			((s64 *)st->data)[2] = pf->timestamp;
> [2]?  Not [1]?  Before this we have 2 16 bit values I think so we are
> only up to 32.
> Can start the timestamp at offset 64 rather than offset 128.
> Also should timestamp be in the chanspec arrays?  Otherwise it is not
> controllable and
> the core has no idea where to find it.

Yes, you are correct regarding both issues. Will fix it.

[...]
>> +
>> +static int __devinit ad7266_probe(struct spi_device *spi)
>> +{
>> +	struct ad7266_platform_data *pdata = spi->dev.platform_data;
>> +	struct iio_dev *indio_dev;
>> +	unsigned long *scan_masks;
>> +	struct ad7266_state *st;
>> +	unsigned int i;
>> +	int ret;
>> +
>> +	indio_dev = iio_allocate_device(sizeof(*st));
>> +	if (indio_dev == NULL)
>> +		return -ENOMEM;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	st->reg = regulator_get(&spi->dev, "vref");
>> +	if (!IS_ERR_OR_NULL(st->reg)) {
>> +		ret = regulator_enable(st->reg);
>> +		if (ret)
>> +			goto error_put_reg;
>> +
>> +		st->vref_uv = regulator_get_voltage(st->reg);
>> +	} else {
>> +		/* Use internal reference */
> This is a little nasty. I see from the datasheet that use of
> vref is controlled using a pin.  I guess you are assuming that
> board designers will typically hardwire that high or low dependent
> on whether they are supply an external reference.  Thus assumption
> is that if we have a regulator above then we aren't using the
> internal ref?  If so, perhaps a comment would make this obvious.
>> +		st->vref_uv = 2500000;
>> +	}
>> +
>> +	if (pdata) {
>> +		st->fixed_addr = pdata->fixed_addr;
>> +		st->mode = pdata->mode;
>> +		st->range = pdata->range;
>> +
>> +		if (!st->fixed_addr) {
>> +			for (i = 0; i < ARRAY_SIZE(st->gpios); ++i) {
>> +				st->gpios[i].gpio = pdata->addr_gpios[i];
>> +				st->gpios[i].flags = GPIOF_OUT_INIT_LOW;
>> +				st->gpios[i].label = ad7266_gpio_labels[i];
>> +			}
>> +			ret = gpio_request_array(st->gpios,
>> +				ARRAY_SIZE(st->gpios));
>> +			if (ret)
>> +				goto error_disable_reg;
>> +		}
>> +	} else {
>> +		st->fixed_addr = true;
>> +		st->range = AD7266_RANGE_VREF;
>> +		st->mode = AD7266_MODE_DIFF;
>> +	}
>> +
>> +	spi_set_drvdata(spi, indio_dev);
>> +	st->spi = spi;
>> +
>> +	indio_dev->dev.parent = &spi->dev;
>> +	indio_dev->name = spi_get_device_id(spi)->name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &ad7266_info;
>> +
> Interesting. I vaguely wonder if we want to support controlling the pins
> that set whether single ended vs differential?  That way it can be
> controlled
> in software (assuming pin is wired up.)  Guess that is getting a little
> fiddly unless there is a user who actually does have a board wired to allow
> controlling this though...
> 

Yes, I think this is a general issues with devices where the behavior can be
controller using external pins. The pin can either be hardwired to high,
hardwired to low or software controllable. So what this driver currently
implements is some kind of a compromise. The address pins are software
controllable the range, vref and diff/sgl pins are not, simply because it's
more likely that the address pins are software controllable on an actual board.
In theory it is also possible that for example only two of address pins are
software controllable and the third one is hard wired. And if for example the
diff/sgl pin is software controllable we probably don't want to support both
single-ended and differential modes on all pins. It's more likely the case that
you'd want to support single-ended conversion on some and differential
conversions on others. So we'd need a per channel mask which conversion types
should be supported for this channel.

So yes, there is room for improvement of the drivers feature set here, but I
think it is something we can save for later when we actually meet an
application which needs these features.


>> +	if (st->mode == AD7266_MODE_SINGLE_ENDED) {
>> +		if (st->range == AD7266_RANGE_VREF) {
>> +			indio_dev->channels = ad7266_channels_u;
>> +			indio_dev->num_channels = ARRAY_SIZE(ad7266_channels_u);
>> +		} else {
>> +			indio_dev->channels = ad7266_channels_s;
>> +			indio_dev->num_channels = ARRAY_SIZE(ad7266_channels_s);
>> +		}
>> +		scan_masks = ad7266_available_scan_masks;
>> +	} else {
>> +		indio_dev->channels = ad7266_channels_diff;
>> +		indio_dev->num_channels = ARRAY_SIZE(ad7266_channels_diff);
>> +		scan_masks = ad7266_available_scan_masks_diff;
>> +	}
>> +
>> +	if (!st->fixed_addr) {
>> +		indio_dev->available_scan_masks = scan_masks;
>> +		indio_dev->masklength = indio_dev->num_channels;
>> +	} else {
>> +		indio_dev->available_scan_masks = ad7266_available_scan_masks_fixed;
>> +		indio_dev->masklength = 2;
>> +		indio_dev->num_channels = 2;
>> +	}
>> +
>> +	/* wakeup */
>> +	st->single_xfer[0].rx_buf = &st->data;
>> +	st->single_xfer[0].len = 2;
>> +	st->single_xfer[0].cs_change = 1;
>> +	/* conversion */
>> +	st->single_xfer[1].rx_buf = &st->data;
>> +	st->single_xfer[1].len = 4;
>> +	st->single_xfer[1].cs_change = 1;
>> +	/* powerdown */
>> +	st->single_xfer[2].tx_buf = &st->data;
>> +	st->single_xfer[2].len = 1;
>> +
>> +	spi_message_init(&st->single_msg);
>> +	spi_message_add_tail(&st->single_xfer[0], &st->single_msg);
>> +	spi_message_add_tail(&st->single_xfer[1], &st->single_msg);
>> +	spi_message_add_tail(&st->single_xfer[2], &st->single_msg);
>> +
>> +	ret = iio_sw_rb_simple_setup(indio_dev, &iio_pollfunc_store_time,
>> +		&ad7266_trigger_handler);
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret)
>> +		goto error_free_gpios;
>> +
>> +	return 0;
>> +
>> +error_free_gpios:
>> +	gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
>> +error_disable_reg:
>> +	if (!IS_ERR_OR_NULL(st->reg))
>> +		regulator_disable(st->reg);
>> +error_put_reg:
>> +	if (!IS_ERR_OR_NULL(st->reg))
>> +		regulator_put(st->reg);
>> +
>> +	iio_free_device(indio_dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int __devexit ad7266_remove(struct spi_device *spi)
>> +{
>> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +	struct ad7266_state *st = iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +	gpio_free_array(st->gpios, ARRAY_SIZE(st->gpios));
>> +	if (!IS_ERR_OR_NULL(st->reg)) {
>> +		regulator_disable(st->reg);
>> +		regulator_put(st->reg);
>> +	}
>> +	iio_free_device(indio_dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_device_id ad7266_id[] = {
>> +	{"ad7265", 0},
>> +	{"ad7266", 0},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(spi, ad7266_id);
>> +
>> +static struct spi_driver ad7266_driver = {
>> +	.driver = {
>> +		.name	= "ad7266",
>> +		.owner	= THIS_MODULE,
>> +	},
>> +	.probe		= ad7266_probe,
>> +	.remove		= __devexit_p(ad7266_remove),
>> +	.id_table	= ad7266_id,
>> +};
>> +
>> +static int __init ad7266_init(void)
>> +{
>> +	return spi_register_driver(&ad7266_driver);
>> +}
>> +module_init(ad7266_init);
>> +
>> +static void __exit ad7266_exit(void)
>> +{
>> +	spi_unregister_driver(&ad7266_driver);
>> +}
>> +module_exit(ad7266_exit);
>> +
>> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>> +MODULE_DESCRIPTION("Analog Devices AD7266/65 ADC");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/staging/iio/adc/ad7266.h b/drivers/staging/iio/adc/ad7266.h
>> new file mode 100644
>> index 0000000..dd96be7
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7266.h
>> @@ -0,0 +1,54 @@
>> +/*
>> + * AD7266/65 SPI ADC driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef __IIO_ADC_AD7266_H__
>> +#define __IIO_ADC_AD7266_H__
>> +
>> +/*
>> + * ad7266_range - AD7266 reference voltage range
>> + * @AD7266_RANGE_VREF: Device is configured for input range 0V - VREF
>> + *			(RANGE pin set to low)
>> + * @AD7266_RANGE_2VREF: Device is configured for input range 0V - 2VREF
>> + *			(RANGE pin set to high)
>> + */
>> +enum ad7266_range {
>> +	AD7266_RANGE_VREF,
>> +	AD7266_RANGE_2VREF,
>> +};
>> +
>> +/*
>> + * ad7266_mode - AD7266 sample mode
>> + * @AD7266_MODE_DIFF: Device is configured for full differntial mode
>> + *				(SGL/DIFF pin set to low, AD0 pin set to low)
>> + * @AD7266_MODE_PSEUDO_DIFF: Device is configured for pseudo differential mode
>> + *				(SGL/DIFF pin set to low, AD0 pin set to high)
>> + * @AD7266_MODE_SINGLE_ENDED: Device is configured for signle-ended mode
> typo signle->single
>> + *				(SGL/DIFF pin set to high)
>> + */
>> +enum ad7266_mode {
>> +	AD7266_MODE_DIFF,
>> +	AD7266_MODE_PSEUDO_DIFF,
>> +	AD7266_MODE_SINGLE_ENDED,
>> +};
>> +
>> +/*
> I think this isn't quite kernel doc style.  Please run it through
> kernel-doc and see
> what that moans about.

Ok, will do. I wasn't aware of the tool.

Thanks for the review :)

- Lars
