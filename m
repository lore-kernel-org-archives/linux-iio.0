Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751094AbeETLRi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 07:17:38 -0400
Date: Sun, 20 May 2018 12:17:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Veenstra <davidjulianveenstra@gmail.com>
Cc: lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 12/12] staging: iio: ad2s1200: Move driver out of
 staging
Message-ID: <20180520121732.132f688e@archlinux>
In-Reply-To: <fb7eafef53d6766a49c978be98d71ecfecd8d392.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
        <fb7eafef53d6766a49c978be98d71ecfecd8d392.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 18 May 2018 20:23:40 +0200
David Veenstra <davidjulianveenstra@gmail.com> wrote:

> Move the iio driver for the ad2s1200 and ad2s1205 resolver-to-digital
> converter out of staging, into mainline iio subsystems.
> 
> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
Some totally trivial rubbish inline that I noticed.
Doesn't need fixing really, I just might as well point it out whilst
looking at the rest.

Anyhow, the device tree bindings are outstanding, but only for reasons
of the formatting of the binding doc rather than real issues.  Please
follow through on that with a new version and I'd like to see an Ack
from Rob Herring for that.

Otherwise, looks good to me.  Thanks for you hard work on this.
Ideally we'd get it tested.  I do have a possibly working resolver now
so I might get to this in a few months.  If we find stuff then we can
fix it up outside staging just fine.  Seems fairly unlikely given
how simple the code ended up after you had cleaned it up but who knows.

Anyhow, applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/Kconfig                     |   1 +
>  drivers/iio/Makefile                    |   1 +
>  drivers/iio/resolver/Kconfig            |  17 ++
>  drivers/iio/resolver/Makefile           |   5 +
>  drivers/iio/resolver/ad2s1200.c         | 210 ++++++++++++++++++++++++
>  drivers/staging/iio/resolver/Kconfig    |  12 --
>  drivers/staging/iio/resolver/Makefile   |   1 -
>  drivers/staging/iio/resolver/ad2s1200.c | 210 ------------------------
>  8 files changed, 234 insertions(+), 223 deletions(-)
>  create mode 100644 drivers/iio/resolver/Kconfig
>  create mode 100644 drivers/iio/resolver/Makefile
>  create mode 100644 drivers/iio/resolver/ad2s1200.c
>  delete mode 100644 drivers/staging/iio/resolver/ad2s1200.c
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index d69e85a8bdc3..d08aeb41cd07 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -93,6 +93,7 @@ source "drivers/iio/potentiometer/Kconfig"
>  source "drivers/iio/potentiostat/Kconfig"
>  source "drivers/iio/pressure/Kconfig"
>  source "drivers/iio/proximity/Kconfig"
> +source "drivers/iio/resolver/Kconfig"
>  source "drivers/iio/temperature/Kconfig"
>  
>  endif # IIO
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index d8cba9c229c0..cb5993251381 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -36,5 +36,6 @@ obj-y += potentiometer/
>  obj-y += potentiostat/
>  obj-y += pressure/
>  obj-y += proximity/
> +obj-y += resolver/
>  obj-y += temperature/
>  obj-y += trigger/
> diff --git a/drivers/iio/resolver/Kconfig b/drivers/iio/resolver/Kconfig
> new file mode 100644
> index 000000000000..2ced9f22aa70
> --- /dev/null
> +++ b/drivers/iio/resolver/Kconfig
> @@ -0,0 +1,17 @@
> +#
> +# Resolver/Synchro drivers
> +#
> +menu "Resolver to digital converters"
> +
> +config AD2S1200
> +	tristate "Analog Devices ad2s1200/ad2s1205 driver"
> +	depends on SPI
> +	depends on GPIOLIB || COMPILE_TEST
> +	help
> +	  Say yes here to build support for Analog Devices spi resolver
> +	  to digital converters, ad2s1200 and ad2s1205, provides direct access
> +	  via sysfs.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad2s1200.
> +endmenu
> diff --git a/drivers/iio/resolver/Makefile b/drivers/iio/resolver/Makefile
> new file mode 100644
> index 000000000000..4e1dccae07e7
> --- /dev/null
> +++ b/drivers/iio/resolver/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for Resolver/Synchro drivers
> +#
> +
> +obj-$(CONFIG_AD2S1200) += ad2s1200.o
> diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
> new file mode 100644
> index 000000000000..28e618af9939
> --- /dev/null
> +++ b/drivers/iio/resolver/ad2s1200.c
> @@ -0,0 +1,210 @@
> +/*
> + * ad2s1200.c simple support for the ADI Resolver to Digital Converters:
> + * AD2S1200/1205
> + *
> + * Copyright (c) 2018-2018 David Veenstra <davidjulianveenstra@gmail.com>
> + * Copyright (c) 2010-2010 Analog Devices Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/spi/spi.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define DRV_NAME "ad2s1200"
This feels a little pointless given the fact it is only used in
one place and is hardly a magic value (requiring a define to give it
a useful name.).

Meh, doesn't matter much though

> +
> +/* input clock on serial interface */
> +#define AD2S1200_HZ	8192000
> +/* clock period in nano second */
> +#define AD2S1200_TSCLK	(1000000000 / AD2S1200_HZ)
> +
> +/**
> + * struct ad2s1200_state - driver instance specific data.
> + * @lock:	protects both the GPIO pins and the rx buffer.
> + * @sdev:	spi device.
> + * @sample:	GPIO pin SAMPLE.
> + * @rdvel:	GPIO pin RDVEL.
> + * @rx:		buffer for spi transfers.
> + */
> +struct ad2s1200_state {
> +	struct mutex lock;
> +	struct spi_device *sdev;
> +	struct gpio_desc *sample;
> +	struct gpio_desc *rdvel;
> +	__be16 rx ____cacheline_aligned;
> +};
> +
> +static int ad2s1200_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val,
> +			     int *val2,
> +			     long m)
> +{
> +	struct ad2s1200_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
> +			*val = 0;
> +			*val2 = 1534355;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_ANGL_VEL:
> +			/* 2 * Pi ~= 6.283185 */
> +			*val = 6;
> +			*val2 = 283185;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		gpiod_set_value(st->sample, 0);
> +
> +		/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
> +		udelay(1);
> +		gpiod_set_value(st->sample, 1);
> +		gpiod_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
> +
> +		ret = spi_read(st->sdev, &st->rx, 2);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			*val = be16_to_cpup(&st->rx) >> 4;
> +			break;
> +		case IIO_ANGL_VEL:
> +			*val = sign_extend32(be16_to_cpup(&st->rx) >> 4, 11);
> +			break;
> +		default:
> +			mutex_unlock(&st->lock);
> +			return -EINVAL;
> +		}
> +
> +		/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
> +		udelay(1);
> +		mutex_unlock(&st->lock);
> +
> +		return IIO_VAL_INT;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
Totally trivial, but could move into the above switch
and save a couple of lines of code..  Only get here from the default
path after all.
> +}
> +
> +static const struct iio_chan_spec ad2s1200_channels[] = {
> +	{
> +		.type = IIO_ANGL,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		.type = IIO_ANGL_VEL,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	}
> +};
> +
> +static const struct iio_info ad2s1200_info = {
> +	.read_raw = ad2s1200_read_raw,
> +};
> +
> +static int ad2s1200_probe(struct spi_device *spi)
> +{
> +	struct ad2s1200_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +	st = iio_priv(indio_dev);
> +	mutex_init(&st->lock);
> +	st->sdev = spi;
> +
> +	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->sample)) {
> +		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
> +			PTR_ERR(st->sample));
> +		return PTR_ERR(st->sample);
> +	}
> +
> +	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->rdvel)) {
> +		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
> +			PTR_ERR(st->rdvel));
> +		return PTR_ERR(st->rdvel);
> +	}
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &ad2s1200_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad2s1200_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +
> +	spi->max_speed_hz = AD2S1200_HZ;
> +	spi->mode = SPI_MODE_3;
> +	ret = spi_setup(spi);
> +
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "spi_setup failed!\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad2s1200_of_match[] = {
> +	{ .compatible = "adi,ad2s1200", },
> +	{ .compatible = "adi,ad2s1205", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad2s1200_of_match);
> +
> +static const struct spi_device_id ad2s1200_id[] = {
> +	{ "ad2s1200" },
> +	{ "ad2s1205" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad2s1200_id);
> +
> +static struct spi_driver ad2s1200_driver = {
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(ad2s1200_of_match),
> +	},
> +	.probe = ad2s1200_probe,
> +	.id_table = ad2s1200_id,
> +};
> +module_spi_driver(ad2s1200_driver);
> +
> +MODULE_AUTHOR("David Veenstra <davidjulianveenstra@gmail.com>");
> +MODULE_AUTHOR("Graff Yang <graff.yang@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices AD2S1200/1205 Resolver to Digital SPI driver");
> +MODULE_LICENSE("GPL v2");

...
