Return-Path: <SRS0=iAnx=IF=gmail.com=davidjulianveenstra@kernel.org>
References: <cover.1524432236.git.davidjulianveenstra@gmail.com> <9d2aa4821674e6886166b72acb19f11f91ddf47c.1524432236.git.davidjulianveenstra@gmail.com> <20180428184658.560435a9@archlinux>
From: David Julian Veenstra <davidjulianveenstra@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de, linux-iio@vger.kernel.org, daniel.baluta@nxp.com, devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 9/9] staging: iio: ad2s1200: Move driver out of staging
In-reply-to: <20180428184658.560435a9@archlinux>
Date: Fri, 18 May 2018 15:17:08 +0200
Message-ID: <871se9cdd7.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

On 28, April 2018 17:46, Jonathan Cameron wrote:

> On Mon, 23 Apr 2018 00:04:42 +0200
> David Veenstra <davidjulianveenstra@gmail.com> wrote:
>
>> Move the iio driver for the ad2s1200 and ad2s1205 resolver-to-digital
>> converter out of staging, into mainline iio subsystems.
>> 
>> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
> A few more minor bits and bobs + suggestions.
>
> Some little things that I missed in earlier patches.  If I haven't
> taken the relevant patch, please roll the fixes in for V4.  If I have
> just do a little follow up patch.
>
> Very nearly there!
>

Thanks, I'll add all the recommendations in V4.

Best regards,
David Veenstra

> thanks,
>
> Jonathan
>
>> ---
>> Changes in v3:
>>  - Add mention of ad2s1205 in commit message.
>> 
>>  drivers/iio/Kconfig                     |   1 +
>>  drivers/iio/Makefile                    |   1 +
>>  drivers/iio/resolver/Kconfig            |  17 +++
>>  drivers/iio/resolver/Makefile           |   5 +
>>  drivers/iio/resolver/ad2s1200.c         | 201 ++++++++++++++++++++++++++++++++
>>  drivers/staging/iio/resolver/Kconfig    |  12 --
>>  drivers/staging/iio/resolver/Makefile   |   1 -
>>  drivers/staging/iio/resolver/ad2s1200.c | 201 --------------------------------
>>  8 files changed, 225 insertions(+), 214 deletions(-)
>>  create mode 100644 drivers/iio/resolver/Kconfig
>>  create mode 100644 drivers/iio/resolver/Makefile
>>  create mode 100644 drivers/iio/resolver/ad2s1200.c
>>  delete mode 100644 drivers/staging/iio/resolver/ad2s1200.c
>> 
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index b3c8c6ef0dff..4bec3ccbf4a1 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -92,6 +92,7 @@ source "drivers/iio/potentiometer/Kconfig"
>>  source "drivers/iio/potentiostat/Kconfig"
>>  source "drivers/iio/pressure/Kconfig"
>>  source "drivers/iio/proximity/Kconfig"
>> +source "drivers/iio/resolver/Kconfig"
>>  source "drivers/iio/temperature/Kconfig"
>>  
>>  endif # IIO
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index b16b2e9ddc40..1865361b8714 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -35,5 +35,6 @@ obj-y += potentiometer/
>>  obj-y += potentiostat/
>>  obj-y += pressure/
>>  obj-y += proximity/
>> +obj-y += resolver/
>>  obj-y += temperature/
>>  obj-y += trigger/
>> diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
>> new file mode 100644
>> index 000000000000..2ced9f22aa70
>> --- /dev/null
>> +++ b/drivers/iio/resolver/Kconfig
>> @@ -0,0 +1,17 @@
>> +#
>> +# Resolver/Synchro drivers
>> +#
>> +menu "Resolver to digital converters"
>> +
>> +config AD2S1200
>> +	tristate "Analog Devices ad2s1200/ad2s1205 driver"
>> +	depends on SPI
>> +	depends on GPIOLIB || COMPILE_TEST
>> +	help
>> +	  Say yes here to build support for Analog Devices spi resolver
>> +	  to digital converters, ad2s1200 and ad2s1205, provides direct access
>> +	  via sysfs.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called ad2s1200.
>> +endmenu
>> diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
>> new file mode 100644
>> index 000000000000..4e1dccae07e7
>> --- /dev/null
>> +++ b/drivers/iio/resolver/Makefile
>> @@ -0,0 +1,5 @@
>> +#
>> +# Makefile for Resolver/Synchro drivers
>> +#
>> +
>> +obj-$(CONFIG_AD2S1200) += ad2s1200.o
>> diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
>> new file mode 100644
>> index 000000000000..d2b62308b31d
>> --- /dev/null
>> +++ b/drivers/iio/resolver/ad2s1200.c
>> @@ -0,0 +1,201 @@
>> +/*
>> + * ad2s1200.c simple support for the ADI Resolver to Digital Converters:
>> + * AD2S1200/1205
>> + *
>> + * Copyright (c) 2010-2010 Analog Devices Inc.
>
> I think you have done enough changes in here that if you want to add your
> own copyright I think it would be justified.
>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>
> One of my pet hates if you want to clean it up :)
> No point in having a blank line above here.
>
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/gpio.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#define DRV_NAME "ad2s1200"
>> +
>> +/* input clock on serial interface */
>> +#define AD2S1200_HZ	8192000
>> +/* clock period in nano second */
>> +#define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
>> +
>> +/**
>> + * struct ad2s1200_state - driver instance specific data.
>> + * @lock:	protects both the GPIO pins and the rx buffer, to prevent
>> + *		concurrent spi transactions.
>> + * @sdev:	spi device.
>> + * @sample:	GPIO pin SAMPLE.
>> + * @rdvel:	GPIO pin RDVEL.
>> + * @rx:		buffer for spi transfers.
>> + */
>> +struct ad2s1200_state {
>> +	struct mutex lock;
>> +	struct spi_device *sdev;
>> +	struct gpio_desc *sample;
>> +	struct gpio_desc *rdvel;
>> +	__be16 rx ____cacheline_aligned;
>> +};
>> +
>> +static int ad2s1200_read_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int *val,
>> +			     int *val2,
>> +			     long m)
>> +{
>> +	struct ad2s1200_state *st = iio_priv(indio_dev);
>> +	int ret = 0;
> We only return ret in paths that set it. So doesn't need
> initializing any more.  This might want to be pushed down
> to the earlier patch changing this code.
>> +
>> +	switch (m) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_ANGL:
>> +			/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
>> +			*val = 0;
>> +			*val2 = 1534355;
>> +			return IIO_VAL_INT_PLUS_NANO;
>> +		case IIO_ANGL_VEL:
>> +			/* 2 * Pi ~= 6.283185 */
>> +			*val = 6;
>> +			*val2 = 283185;
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&st->lock);
>> +		gpiod_set_value(st->sample, 0);
>> +
>> +		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
>> +		udelay(1);
>> +		gpiod_set_value(st->sample, 1);
>> +		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
>> +
>> +		ret = spi_read(st->sdev, &st->rx, 2);
>> +		if (ret < 0) {
>> +			mutex_unlock(&st->lock);
>> +			return ret;
>> +		}
>> +
>> +		switch (chan->type) {
>> +		case IIO_ANGL:
>> +			*val = be16_to_cpup(&st->rx) >> 4;
>> +			break;
>> +		case IIO_ANGL_VEL:
>> +			*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
>> +			break;
>> +		default:
>> +			mutex_unlock(&st->lock);
>> +			return -EINVAL;
>> +		}
>> +
>> +		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
>> +		udelay(1);
>> +		mutex_unlock(&st->lock);
>> +
>> +		return IIO_VAL_INT;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_chan_spec ad2s1200_channels[] = {
>> +	{
>> +		.type = IIO_ANGL,
>> +		.indexed = 1,
>> +		.channel = 0,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +	}, {
>> +		.type = IIO_ANGL_VEL,
>> +		.indexed = 1,
>> +		.channel = 0,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>> +	}
>> +};
>> +
>> +static const struct iio_info ad2s1200_info = {
>> +	.read_raw = ad2s1200_read_raw,
>> +};
>> +
>> +static int ad2s1200_probe(struct spi_device *spi)
>> +{
>> +	struct ad2s1200_state *st;
>> +	struct iio_dev *indio_dev;
>> +	int ret = 0;
> I guess this is left from somewhere and should have been in
> an earlier patch, but there is no need to set to 0 and
> it is set in all paths.
>
> Mind you I've suggested you get rid of the only user
> anyway so that won't matter as this will go away anyway.
>
>> +
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	spi_set_drvdata(spi, indio_dev);
>> +	st = iio_priv(indio_dev);
>> +	mutex_init(&st->lock);
>> +	st->sdev = spi;
>> +
>> +	st->sample = devm_gpiod_get(&spi->dev, "sample", GPIOD_OUT_LOW);
>> +	if (IS_ERR(st->sample)) {
>> +		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
>> +			PTR_ERR(st->sample));
>> +		return PTR_ERR(st->sample);
>> +	}
>> +
>> +	st->rdvel = devm_gpiod_get(&spi->dev, "rdvel", GPIOD_OUT_LOW);
>> +	if (IS_ERR(st->rdvel)) {
>> +		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
>> +			PTR_ERR(st->rdvel));
>> +		return PTR_ERR(st->rdvel);
>> +	}
>> +
>> +	indio_dev->dev.parent = &spi->dev;
>> +	indio_dev->info = &ad2s1200_info;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = ad2s1200_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
>> +	indio_dev->name = spi_get_device_id(spi)->name;
>> +
>> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	spi->max_speed_hz = AD2S1200_HZ;
>> +	spi->mode = SPI_MODE_3;
>> +	spi_setup(spi);
> This ordering is racy.  We could in theory have been
> talking to the device after it's interfaces were exposed
> in the devm_iio_device_register call.
>
> Reorder this to put them before that then just do
> return devm_iio_device_register
> to finish up probe.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_device_id ad2s1200_id[] = {
>> +	{ "ad2s1200" },
> Worth putting in an explicit device tree table for matching
> with the vendor ID.  The intent long term is to remove
> the nasty code that leads to fall back matching with the
> spi_device_id table.
>
> No reason this needs to happen before taking it out of staging.
>
>> +	{ "ad2s1205" },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(spi, ad2s1200_id);
>> +
>> +static struct spi_driver ad2s1200_driver = {
>> +	.driver = {
>> +		.name = DRV_NAME,
>> +	},
>> +	.probe = ad2s1200_probe,
>> +	.id_table = ad2s1200_id,
>> +};
>> +module_spi_driver(ad2s1200_driver);
>> +
>> +MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
>> +MODULE_DESCRIPTION("Analog Devices AD2S1200/1205 Resolver to Digital SPI driver");
>> +MODULE_LICENSE("GPL v2");
> ...
