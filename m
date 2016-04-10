Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43330 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbcDJLYI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Apr 2016 07:24:08 -0400
Subject: Re: [PATCH v2] iio: max5487: Add support for Maxim digital
 potentiometers
To: Cristina Moraru <cristina.moraru09@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, peda@axentia.se,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	daniel.baluta@intel.com, octavian.purdila@intel.com
References: <1458818485-2770-1-git-send-email-cristina.moraru09@gmail.com>
 <1460190283-3296-1-git-send-email-cristina.moraru09@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <570A37D4.6010003@kernel.org>
Date: Sun, 10 Apr 2016 12:24:04 +0100
MIME-Version: 1.0
In-Reply-To: <1460190283-3296-1-git-send-email-cristina.moraru09@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/04/16 09:24, Cristina Moraru wrote:
> Add implementation for Maxim MAX5487, MAX5488, MAX5489
> digital potentiometers.
> 
> Datasheet:
> http://datasheets.maximintegrated.com/en/ds/MAX5487-MAX5489.pdf
> 
> Signed-off-by: Cristina Moraru <cristina.moraru09@gmail.com>
> CC: Daniel Baluta <daniel.baluta@intel.com>
Looks pretty good.  A few nitpicks + a somewhat theoretical race condition
in the remove function due to use of devm_iio_device_register.
Rule of thumb is you can't use this unless you have no remove function at all.
(less obviously than normal in this case though!)

Jonathan
> ---
> Changes since v1:
>         Fix spacing
>         Eliminate max5487_cfg struct
>         Add kohms as driver data
>  drivers/iio/potentiometer/Kconfig   |  11 +++
>  drivers/iio/potentiometer/Makefile  |   1 +
>  drivers/iio/potentiometer/max5487.c | 169 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 181 insertions(+)
>  create mode 100644 drivers/iio/potentiometer/max5487.c
> 
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index fd75db7..242c62d 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -5,6 +5,17 @@
>  
>  menu "Digital potentiometers"
>  
> +config MAX5487
> +        tristate "Maxim MAX5487/MAX5488/MAX5489  Digital Potentiometer driver"
> +        depends on SPI
> +        help
> +          Say yes here to build support for the Maxim
> +          MAX5487, MAX5488, MAX5489 digital potentiomenter
> +          chips.
> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called max5487.
> +
>  config MCP4531
>  	tristate "Microchip MCP45xx/MCP46xx Digital Potentiometer driver"
>  	depends on I2C
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 8afe492..bc2dfd8 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -3,4 +3,5 @@
>  #
>  
>  # When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_MAX5487) += max5487.o
>  obj-$(CONFIG_MCP4531) += mcp4531.o
> diff --git a/drivers/iio/potentiometer/max5487.c b/drivers/iio/potentiometer/max5487.c
> new file mode 100644
> index 0000000..fa455b8
> --- /dev/null
> +++ b/drivers/iio/potentiometer/max5487.c
> @@ -0,0 +1,169 @@
> +/*
> + * max5487.c - Support for MAX5487, MAX5488, MAX5489 digital potentiometers
> + *
> + * Copyright (C) Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/acpi.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/iio.h>
> +
> +#define MAX5487_DRV_NAME "max5487"
This is one of my pet hates ;)  Why have this in a define at the top
of the driver if it is used in only one place - and that place is where
I would expect to look to see what that the driver is called.
Still I don't care that much if you want to leave it here.  Just being fussy.
> +
> +#define MAX5487_WRITE_WIPER_A	0x01
> +#define MAX5487_WRITE_WIPER_B	0x02
> +
> +/* copy both wiper regs to NV regs */
> +#define MAX5487_COPY_AB_TO_NV	0x23
> +/* copy both NV regs to wiper regs */
> +#define MAX5487_COPY_NV_TO_AB	0x33
> +
> +#define MAX5487_MAX_POS		255
> +
> +struct max5487_data {
> +	struct regmap *regmap;
> +	int kohms;
> +};
> +
> +#define MAX5487_CHANNEL(ch, addr) {				\
> +	.type = IIO_RESISTANCE,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = ch,						\
> +	.address = addr,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec max5487_channels[] = {
> +	MAX5487_CHANNEL(0, MAX5487_WRITE_WIPER_A),
> +	MAX5487_CHANNEL(1, MAX5487_WRITE_WIPER_B),
> +};
> +
> +static int max5487_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct max5487_data *data = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	*val = 1000 * data->kohms;
> +	*val2 = MAX5487_MAX_POS;
Blank line here marginally preferred.
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int max5487_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct max5487_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > MAX5487_MAX_POS)
> +			return -EINVAL;
> +		return regmap_write(data->regmap, chan->address, val);
> +	default:
> +		return -EINVAL;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info max5487_info = {
> +	.read_raw = &max5487_read_raw,
> +	.write_raw = &max5487_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const struct regmap_config max5487_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +
> +	.max_register = MAX5487_COPY_NV_TO_AB,
> +};
> +
> +static int max5487_spi_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max5487_data *data;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&spi->dev, indio_dev);
> +	data = iio_priv(indio_dev);
> +
> +	data->regmap = devm_regmap_init_spi(spi, &max5487_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	data->kohms = id->driver_data;
> +
> +	indio_dev->info = &max5487_info;
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = max5487_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max5487_channels);
> +
> +	/* restore both wiper regs from NV regs */
> +	ret = regmap_write(data->regmap, MAX5487_COPY_NV_TO_AB, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
Hmm. Interesting case here - using this clearly doesn't result in a driver
crash, but it could in theory result in a 'race' of expectations...

As you are using the devm_ register here, the unregister will only occur
after everything in max5487_spi_remove has run. As the userspace api will
remain available until then, it is in theory possible to have the wiper
values stored to the non volatile memory and then get a sneaky change in
after that on request from userspace.  Thus userspace may think that the
value has been writen to the non volatile memory but it hasn't.

Hence, pleasee switch to the non devm_ version of iio_device_register
and call iio_device_unregister before you save the wiper regs out.
It's also more 'obviously correct' to unwind in a remove in the precise
reverse order of the probe.  Makes reviewer's job easier :)

> +}
> +
> +static int max5487_spi_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> +	struct max5487_data *data = iio_priv(indio_dev);
> +
> +	/* save both wiper regs to NV regs */
> +	return regmap_write(data->regmap, MAX5487_COPY_AB_TO_NV, 0);
> +}
> +
> +static const struct spi_device_id max5487_id[] = {
> +	{ "MAX5487", 10 },
> +	{ "MAX5488", 50 },
> +	{ "MAX5489", 100 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max5487_id);
> +
> +static const struct acpi_device_id max5487_acpi_match[] = {
> +	{ "MAX5487", 10 },
> +	{ "MAX5488", 50 },
> +	{ "MAX5489", 100 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, max5487_acpi_match);
> +
> +static struct spi_driver max5487_driver = {
> +	.driver = {
> +		.name = MAX5487_DRV_NAME,
> +		.owner = THIS_MODULE,
> +		.acpi_match_table = ACPI_PTR(max5487_acpi_match),
> +	},
> +	.id_table = max5487_id,
> +	.probe = max5487_spi_probe,
> +	.remove = max5487_spi_remove
> +};
> +module_spi_driver(max5487_driver);
> +
> +MODULE_AUTHOR("Cristina-Gabriela Moraru <cristina.moraru09@gmail.com>");
> +MODULE_DESCRIPTION("max5487 SPI driver");
> +MODULE_LICENSE("GPL v2");
> 

