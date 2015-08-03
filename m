Return-Path: <mporter@konsulko.com>
Date: Mon, 3 Aug 2015 19:13:02 -0400
From: Matt Porter <mporter@konsulko.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple converter
 driver
Message-ID: <20150803231302.GK15004@beef>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
 <1438635410-3757-3-git-send-email-mporter@konsulko.com>
 <alpine.DEB.2.02.1508032313380.17732@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1508032313380.17732@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Aug 03, 2015 at 11:26:12PM +0200, Peter Meerwald wrote:
> On Mon, 3 Aug 2015, Matt Porter wrote:
> 
> > Add a driver for the MAX6675 thermocouple converter. This
> > device interfaces with K-type thermocouples and provides
> > cold-junction compensated temperature readings via a
> > SPI interface.
> 
> comments below

Thanks for the fast turnaround on the review! Will incorporate
the comments into v2 as noted below.

> > Signed-off-by: Matt Porter <mporter@konsulko.com>
> > ---
> >  drivers/iio/temperature/Kconfig   |  11 +++
> >  drivers/iio/temperature/Makefile  |   1 +
> >  drivers/iio/temperature/max6675.c | 155 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 167 insertions(+)
> >  create mode 100644 drivers/iio/temperature/max6675.c
> > 
> > diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> > index 21feaa4..b73fbf4 100644
> > --- a/drivers/iio/temperature/Kconfig
> > +++ b/drivers/iio/temperature/Kconfig
> > @@ -3,6 +3,17 @@
> >  #
> >  menu "Temperature sensors"
> >  
> > +config MAX6675
> > +	tristate "MAX6675 thermocouple converter"
> > +	depends on SPI
> > +	help
> > +	  If you say yes here you get support for the Maxim
> > +	  MAX6675 thermocouple converter connected with SPI.
> > +
> > +	  This driver can also be built as a module. If so, the module will
> > +	  be called max6675.
> > +
> 
> extra newline

Ok

> 
> > +
> >  config MLX90614
> >  	tristate "MLX90614 contact-less infrared sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> > index 40710a8..d67ef40 100644
> > --- a/drivers/iio/temperature/Makefile
> > +++ b/drivers/iio/temperature/Makefile
> > @@ -2,5 +2,6 @@
> >  # Makefile for industrial I/O temperature drivers
> >  #
> >  
> > +obj-$(CONFIG_MAX6675) += max6675.o
> >  obj-$(CONFIG_MLX90614) += mlx90614.o
> >  obj-$(CONFIG_TMP006) += tmp006.o
> > diff --git a/drivers/iio/temperature/max6675.c b/drivers/iio/temperature/max6675.c
> > new file mode 100644
> > index 0000000..2d1fda2
> > --- /dev/null
> > +++ b/drivers/iio/temperature/max6675.c
> > @@ -0,0 +1,155 @@
> > +/*
> > + * max6675.c - MAX6675 thermocouple converter driver
> > + *
> > + * Copyright (C) 2015 Konsulko Group, Matt Porter <mporter@konsulko.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/spi/spi.h>
> > +
> > +struct max6675_state {
> > +	struct spi_device *spi;
> > +};
> > +
> > +static const struct iio_chan_spec max6675_channels[] = {
> > +	{
> > +		.type = IIO_TEMP,
> > +		.info_mask_separate =
> > +			BIT(IIO_CHAN_INFO_RAW) |
> > +			BIT(IIO_CHAN_INFO_SCALE),
> > +	},
> > +};
> > +
> > +static int max6675_read(struct max6675_state *st, int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = spi_read(st->spi, val, 2);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	/* Temperature is bits 14..3 */
> > +	*val = (*val >> 3) & 0xfff;
> 
> what about endianness conversion?
> use be16_to_cpu()

Ok, will fix.

> > +
> > +	return ret;
> > +}
> > +
> > +static int max6675_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val,
> > +			    int *val2,
> > +			    long m)
> > +{
> > +	struct max6675_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	if (m == IIO_CHAN_INFO_RAW) {
> > +		*val2 = 0;
> 
> no need to set *val2 to 0 when returning VAL_INT

Ok

> 
> > +		ret = max6675_read(st, val);
> > +		if (ret)
> > +			return ret;
> > +	} else if (m == IIO_CHAN_INFO_SCALE) {
> > +		*val = 250;
> > +		*val2 = 0;
> > +	} else
> > +		return -EINVAL;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static const struct iio_info max6675_info = {
> > +	.driver_module = THIS_MODULE,
> > +	.read_raw = &max6675_read_raw,
> > +};
> > +
> > +static int max6675_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct max6675_state *st;
> > +	int ret = 0;
> 
> no need to initialize ret

Ok

> 
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st = iio_priv(indio_dev);
> > +	st->spi = spi;
> > +
> > +	spi->mode = SPI_MODE_1;
> > +	spi->bits_per_word = 16;
> > +
> > +	spi_set_drvdata(spi, indio_dev);
> > +
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->name = spi_get_device_id(spi)->name;
> > +	indio_dev->channels = max6675_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(max6675_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->info = &max6675_info;
> > +
> > +	ret = iio_device_register(indio_dev);
> 
> devm_ and drop _remove()

Ok

> 
> > +	if (ret < 0)
> > +		dev_err(&spi->dev, "unable to register device\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int max6675_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct acpi_device_id max6675_acpi_ids[] = {
> > +	{ "MXIM6675", 0 },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(acpi, max6675_acpi_ids);
> > +
> > +static const struct of_device_id max6675_dt_ids[] = {
> > +	{ .compatible = "maxim,max6675" },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, max6675_dt_ids);
> > +
> > +static const struct spi_device_id max6675_spi_ids[] = {
> > +	{"max6675", 0},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(spi, max6675_spi_ids);
> > +
> > +static struct spi_driver max6675_driver = {
> > +	.driver = {
> > +		.name	= "max6675",
> > +		.owner	= THIS_MODULE,
> > +		.acpi_match_table = ACPI_PTR(max6675_acpi_ids),
> > +		.of_match_table = of_match_ptr(max6675_dt_ids),
> > +	},
> > +	.probe		= max6675_probe,
> > +	.remove		= max6675_remove,
> > +	.id_table	= max6675_spi_ids,
> > +};
> > +module_spi_driver(max6675_driver);
> > +
> > +MODULE_AUTHOR("Matt Porter <mporter@konsulko.com>");
> > +MODULE_DESCRIPTION("MAX6675 thermocouple converter driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("spi:max6675");
> > 
> 
> -- 
> 
> Peter Meerwald
> +43-664-2444418 (mobile)
