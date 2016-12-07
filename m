Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:44728 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932209AbcLGTE4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Dec 2016 14:04:56 -0500
Date: Wed, 7 Dec 2016 20:04:54 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matt Weber <matthew.weber@rockwellcollins.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org,
        cristina.moraru09@gmail.com,
        Maury Anderson <maury.anderson@rockwellcollins.com>
Subject: Re: [PATCH] iio: max5481: Add support for Maxim digital
 potentiometers
In-Reply-To: <1481136052-1660-1-git-send-email-matthew.weber@rockwellcollins.com>
Message-ID: <alpine.DEB.2.02.1612071958050.32025@pmeerw.net>
References: <1481136052-1660-1-git-send-email-matthew.weber@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Add implementation for Maxim Integrated 5481, 5482, 5483,
> and 5484 digital potentiometer devices.

nitpicking below
 
> Datasheet:
> http://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
> 
> Signed-off-by: Maury Anderson <maury.anderson@rockwellcollins.com>
> Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
> ---
> 
> This patch is a proposed implementation which compiles and
> is based on the 5487 part.  The integration of the component
> was cancelled but we wanted to still share this work hoping
> that others might pick it up.
> 
> ---
>  .../bindings/iio/potentiometer/max5481.txt         |  23 +++
>  drivers/iio/potentiometer/Kconfig                  |  12 ++
>  drivers/iio/potentiometer/Makefile                 |   1 +
>  drivers/iio/potentiometer/max5481.c                | 212 +++++++++++++++++++++
>  4 files changed, 248 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
>  create mode 100644 drivers/iio/potentiometer/max5481.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt b/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
> new file mode 100644
> index 0000000..3bc59b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
> @@ -0,0 +1,23 @@
> +* Maxim Linear-Taper Digital Potentiometer MAX5481-MAX5484
> +
> +The node for this driver must be a child node of a SPI controller, hence
> +all mandatory properties described in
> +
> +        Documentation/devicetree/bindings/spi/spi-bus.txt
> +
> +must be specified.
> +
> +Required properties:
> +	- compatible:  	Must be one of the following, depending on the
> +			model:
> +			"maxim,max5481"
> +			"maxim,max5482"
> +			"maxim,max5483"
> +			"maxim,max5484"
> +
> +Example:
> +max548x: max548x@0 {
> +	compatible = "maxim,max5482";
> +	spi-max-frequency = <7000000``>;

there are two backticks ``?

> +	reg = <0>; /* chip-select */
> +};
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 2e9da1c..872b25b 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -15,6 +15,18 @@ config DS1803
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ds1803.
>  
> +config MAX5481
> +        tristate "Maxim MAX5481-MAX5484 Digital Potentiometer driver"
> +        depends on SPI
> +        help
> +          Say yes here to build support for the Maxim
> +          MAX5481, MAX5482, MAX5483, MAX5484 digital potentiometer
> +          chips.
> +
> +          To compile this driver as a module, choose M here: the
> +          module will be called max5481.
> +
> +c

there is an extra 'c'

>  config MAX5487
>          tristate "Maxim MAX5487/MAX5488/MAX5489 Digital Potentiometer driver"
>          depends on SPI
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 8adb58f..2260d40 100644
> --- a/drivers/iio/potentiometer/Makefile
> +++ b/drivers/iio/potentiometer/Makefile
> @@ -4,6 +4,7 @@
>  
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_DS1803) += ds1803.o
> +obj-$(CONFIG_MAX5481) += max5481.o
>  obj-$(CONFIG_MAX5487) += max5487.o
>  obj-$(CONFIG_MCP4131) += mcp4131.o
>  obj-$(CONFIG_MCP4531) += mcp4531.o
> diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
> new file mode 100644
> index 0000000..f3feefc
> --- /dev/null
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -0,0 +1,212 @@
> +/*
> + * Maxim Integrated MAX5481-MAX5484 digital potentiometer driver
> + * Copyright 2016 Rockwell Collins
> + *
> + * Datasheet:
> + * http://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the gnu general public license version 2 as
> + * published by the free software foundation.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/of.h>
> +#include <linux/acpi.h>
> +
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/iio.h>
> +
> +/* write wiper reg */
> +#define MAX5481_WRITE_WIPER (0 << 4)
> +/* copy wiper reg to NV reg */
> +#define MAX5481_COPY_AB_TO_NV (2 << 4)
> +/* copy NV reg to wiper reg */
> +#define MAX5481_COPY_NV_TO_AB (3 << 4)
> +
> +#define MAX5481_MAX_POS    1023
> +
> +enum max5481_variant {
> +	max5481,
> +	max5482,
> +	max5483,
> +	max5484

add , on the last line, chances are the list will be extended...

> +};
> +
> +struct max5481_cfg {
> +	int kohms;
> +	int maxpos;
> +};
> +
> +static const struct max5481_cfg max5481_cfg[] = {
> +	[max5481] = { .kohms =  10, .maxpos = MAX5481_MAX_POS },
> +	[max5482] = { .kohms =  50, .maxpos = MAX5481_MAX_POS },
> +	[max5483] = { .kohms =  10, .maxpos = MAX5481_MAX_POS },
> +	[max5484] = { .kohms =  50, .maxpos = MAX5481_MAX_POS },
> +};

what is the difference between parts?

> +
> +struct max5481_data {
> +	struct spi_device *spi;
> +	const struct max5481_cfg *cfg;
> +};
> +
> +#define max5481_CHANNEL(ch) {					\

MAX5481_CHANNEL
is the ch parameter needed?

> +	.type = IIO_RESISTANCE,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = (ch),					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec max5481_channels[] = {
> +	max5481_CHANNEL(0),
> +};
> +
> +static int max5481_write_cmd(struct spi_device *spi, int cmd, int val)
> +{
> +	/* SPI Format from MAX5481-MAX5484 (19-3708; Rev 5; 4/10) pg 15 */
> +	u8 msg[3] = {
> +		(u8)cmd,

cast (u8) needed?

> +		(u8)((u16)val >> 2),
> +		(u8)(val & 0x3) << 6
> +	};
> +
> +	return spi_write(spi, msg, (cmd == MAX5481_WRITE_WIPER) ? sizeof(msg) : sizeof(u8));
> +}
> +
> +static int max5481_read_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan,
> +		int *val, int *val2, long mask)
> +{
> +	struct max5481_data *data = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_SCALE)
> +		return -EINVAL;
> +
> +	*val = 1000 * data->cfg->kohms;
> +	*val2 = data->cfg->maxpos;
> +
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +static int max5481_write_raw(struct iio_dev *indio_dev,
> +		struct iio_chan_spec const *chan,
> +		int val, int val2, long mask)
> +{
> +	struct max5481_data *data = iio_priv(indio_dev);
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if (val < 0 || val > data->cfg->maxpos)
> +		return -EINVAL;
> +
> +	return max5481_write_cmd(data->spi, MAX5481_WRITE_WIPER, val);
> +}
> +
> +static const struct iio_info max5481_info = {
> +	.read_raw = max5481_read_raw,
> +	.write_raw = max5481_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int max5481_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max5481_data *data;
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
> +	data->spi = spi;
> +	data->cfg = &max5481_cfg[id->driver_data];
> +
> +	indio_dev->name = id->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* variant specific configuration */
> +	indio_dev->info = &max5481_info;
> +	indio_dev->channels = max5481_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(max5481_channels);
> +
> +	/* restore wiper from NV */
> +	ret = max5481_write_cmd(data->spi, MAX5481_COPY_NV_TO_AB, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	return iio_device_register(indio_dev);
> +}
> +
> +static int max5481_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> +	int ret;
> +
> +	/* save wiper reg to NV reg */
> +	ret = max5481_write_cmd(spi, MAX5481_COPY_AB_TO_NV, 0);
> +
> +	iio_device_unregister(indio_dev);

unregister first, then save

> +
> +	return ret;
> +}
> +
> +static const struct spi_device_id max5481_id_table[] = {
> +	{ "MAX5481", max5481 },
> +	{ "MAX5482", max5482 },
> +	{ "MAX5483", max5483 },
> +	{ "MAX5484", max5484 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, max5481_id_table);
> +
> +#if defined(CONFIG_OF)
> +static const struct of_device_id max5481_match[] = {
> +	{ .compatible = "maxim,max5481", .data = &max5481_cfg[max5481] },
> +	{ .compatible = "maxim,max5482", .data = &max5481_cfg[max5482] },
> +	{ .compatible = "maxim,max5483", .data = &max5481_cfg[max5483] },
> +	{ .compatible = "maxim,max5484", .data = &max5481_cfg[max5484] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max5481_match);
> +#endif
> +
> +#if defined(CONFIG_ACPI)
> +static const struct acpi_device_id max5481_acpi_match[] = {
> +	{ "MAX5481", max5481 },
> +	{ "MAX5482", max5482 },
> +	{ "MAX5483", max5483 },
> +	{ "MAX5484", max5484 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, max5481_acpi_match);
> +#endif
> +
> +static struct spi_driver max5481_driver =
> +{
> +	.driver =
> +	{
> +		.name  = "max5481",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_match_ptr(max5481_match),
> +		.acpi_match_table = ACPI_PTR(max5481_acpi_match),
> +	},
> +	.probe = max5481_probe,
> +	.remove = max5481_remove,
> +	.id_table = max5481_id_table,
> +};
> +
> +module_spi_driver(max5481_driver);
> +
> +MODULE_AUTHOR("Maury Anderson <maury.anderson@rockwellcollins.com>");
> +MODULE_DESCRIPTION("max5481 SPI driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
