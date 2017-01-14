Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50777 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbdANKio (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2017 05:38:44 -0500
Subject: Re: [PATCH v2] iio: max5481: Add support for Maxim digital
 potentiometers
To: Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org
References: <20170108185733.GA8511@x220.localdomain>
Cc: cristina.moraru09@gmail.com, matthew.weber@rockwellcollins.com,
        maury.anderson@rockwellcollins.com,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ee973aa1-c881-6bc8-c61a-9f36b8598f5f@kernel.org>
Date: Sat, 14 Jan 2017 10:38:38 +0000
MIME-Version: 1.0
In-Reply-To: <20170108185733.GA8511@x220.localdomain>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/17 18:57, Slawomir Stepien wrote:
> From: Matt Weber <matthew.weber@rockwellcollins.com>
> 
> Add implementation for Maxim Integrated 5481, 5482, 5483,
> and 5484 digital potentiometer devices.
> 
> Datasheet:
> http://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
> 
> Signed-off-by: Maury Anderson <maury.anderson@rockwellcollins.com>
> Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
As this has device tree bindings it should have gone to linux-devicetree,
Rob and Mark (maintainers of bindings).

Spi buffers for spi_write need to be cacheline aligned.  See below
for roughly why.

Jonathan
> ---
> 
> This is my resubmission of this patch after original authors decided not to
> pursuit it inclusion into kernel.
> 
> Tested using signal analyzer.
> 
> Changes since v1:
> * removed not needed '``' and 'c' chars
> * includes are now sorted
> * added coma to last item in enum max5481_variant
> * removed maxpos from struct max5481_cfg
> * max5481_CHANNEL is no MAX5481_CHANNEL and it does not have 'ch' argument
> * max5481_write_cmd is now based around switch
> * removed not needed cast in max5481_write_cmd
> * wpier state is saved after iio_device_unregister
> * changed names in spi_device_id and acpi_device_id to be equal to names in of_device_id
> 
> ---
>  .../bindings/iio/potentiometer/max5481.txt         |  23 +++
>  drivers/iio/potentiometer/Kconfig                  |  11 ++
>  drivers/iio/potentiometer/Makefile                 |   1 +
>  drivers/iio/potentiometer/max5481.c                | 215 +++++++++++++++++++++
>  4 files changed, 250 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
>  create mode 100644 drivers/iio/potentiometer/max5481.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt b/Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
> new file mode 100644
> index 000000000000..6a91b106e076
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
> +	spi-max-frequency = <7000000>;
> +	reg = <0>; /* chip-select */
> +};
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 2e9da1cf3297..8bf282510be6 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -15,6 +15,17 @@ config DS1803
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
>  config MAX5487
>          tristate "Maxim MAX5487/MAX5488/MAX5489 Digital Potentiometer driver"
>          depends on SPI
> diff --git a/drivers/iio/potentiometer/Makefile b/drivers/iio/potentiometer/Makefile
> index 8adb58f38c0b..2260d40e0936 100644
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
> index 000000000000..59ced74b0252
> --- /dev/null
> +++ b/drivers/iio/potentiometer/max5481.c
> @@ -0,0 +1,215 @@
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
> +#include <linux/acpi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/spi/spi.h>
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
> +	max5484,
> +};
> +
> +struct max5481_cfg {
> +	int kohms;
> +};
> +
> +static const struct max5481_cfg max5481_cfg[] = {
> +	[max5481] = { .kohms =  10, },
> +	[max5482] = { .kohms =  50, },
> +	[max5483] = { .kohms =  10, },
> +	[max5484] = { .kohms =  50, },
> +};
> +
> +struct max5481_data {
> +	struct spi_device *spi;
> +	const struct max5481_cfg *cfg;
> +};
> +
> +#define MAX5481_CHANNEL {					\
> +	.type = IIO_RESISTANCE,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = 0,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +}
> +
> +static const struct iio_chan_spec max5481_channels[] = {
> +	MAX5481_CHANNEL,
> +};
> +
> +static int max5481_write_cmd(struct spi_device *spi, u8 cmd, u16 val)
> +{
> +	/* SPI Format from MAX5481-MAX5484 (19-3708; Rev 5; 4/10) pg 15 */
> +	u8 msg[3];
It's clearly one of those days - same issue in two drivers in a row. :(
Still I can refine me response ;)

There are requirements for buffers passed directly to spi_read / spi_write.
They get passed to spi_sync which calls into the spi master drivers.
SPI master drivers are explicitly allowed to directly use this buffer
in dma. On most modern platforms it is fine to do DMA from any location...

However, cacheline corruption comes in here. There is no guarantee that
the SPI controller won't write back to this address, as it it will be
bypassing the processor whilst doing this, that can result in a difference
in other parts of the cacheline between what is in the cache and what is
in main memory.  At the end of the dma transfer any changes elsewhere in
the cacheline can be wiped out as result. (or something like that ;)

Anyhow, two solutions.  Either allocate the memory in it's own cacheline
which will naturally happen if you allocate on the heap using kmalloc
or use the fact we carefully align the iio_priv memory to be cacheline
aligned. This means that if you stick a __cacheline_aligned buffer at the
end of your iio_priv structure it was also be in it's own cacheline.

Not doing this is the source of really hard to track down bugs!
> +
> +	msg[0] = cmd;
> +
> +	switch (cmd) {
> +	case MAX5481_WRITE_WIPER:
> +		msg[1] = val >> 2;
> +		msg[2] = (val & 0x3) << 6;
> +		return spi_write(spi, msg, ARRAY_SIZE(msg));
> +
> +	case MAX5481_COPY_AB_TO_NV:
> +	case MAX5481_COPY_NV_TO_AB:
> +		return spi_write(spi, msg, sizeof(u8));
> +
> +	default:
> +		return -EIO;
> +	}
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
> +	*val2 = MAX5481_MAX_POS;
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
> +	if (val < 0 || val > MAX5481_MAX_POS)
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
> +
> +	iio_device_unregister(indio_dev);
> +
> +	/* save wiper reg to NV reg */
> +	return max5481_write_cmd(spi, MAX5481_COPY_AB_TO_NV, 0);
> +}
> +
> +static const struct spi_device_id max5481_id_table[] = {
> +	{ "max5481", max5481 },
> +	{ "max5482", max5482 },
> +	{ "max5483", max5483 },
> +	{ "max5484", max5484 },
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
> +	{ "max5481", max5481 },
> +	{ "max5482", max5482 },
> +	{ "max5483", max5483 },
> +	{ "max5484", max5484 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, max5481_acpi_match);
> +#endif
> +
> +static struct spi_driver max5481_driver = {
> +	.driver = {
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

