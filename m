Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38847 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756887AbcGJN03 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 09:26:29 -0400
Subject: Re: [PATCH v6] iio: temperature: add support for Maxim thermocouple
 chips
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1467683644-10594-1-git-send-email-mranostay@gmail.com>
Cc: Marek Vasut <marex@denx.de>, Matt Porter <mporter@konsulko.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a321e966-9430-06e6-8bd6-12c344aaa7f2@kernel.org>
Date: Sun, 10 Jul 2016 14:26:27 +0100
MIME-Version: 1.0
In-Reply-To: <1467683644-10594-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/07/16 02:54, Matt Ranostay wrote:
> Add initial driver support for MAX6675, and MAX31855 thermocouple chips.
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Matt Porter <mporter@konsulko.com>
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
Hi Matt,

Very nice.  Applied to the togreg branch of iio.git.
Initially pushed out as testing for the autobuilders to play with it.
Unless Linus decides to delay the next merge window this has missed
now I'm afraid.

Jonathan
> ---
> 
> Changes from v1:
> * switch to iio_device_*_direct_mode wrappers
> * add const to structs
> * removed useless cast
> 
> Changes from v2:
> * mark buffer data invalid on disconnected thermocouple
> * add .address = 0 to be consistent
> * add missing scan_mask for the max31855 part
> 
> Changes from v3:
> * fixed several typos of max31855 part number
> 
> Changes from v4:
> * drop maxim_thermocouple_validate_buffer() due to peer review saying
>   this is an incorrect way to signal an invalid reading
> 
> Changes from v5:
>  * reorder struct maxim_thermocouple_chip to reduce alignment padding
>  * add ____cacheline_aligned to the spi data buffer
> 
> .../iio/temperature/maxim_thermocouple.txt         |  21 ++
>  drivers/iio/temperature/Kconfig                    |  14 +
>  drivers/iio/temperature/Makefile                   |   1 +
>  drivers/iio/temperature/maxim_thermocouple.c       | 281 +++++++++++++++++++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
>  create mode 100644 drivers/iio/temperature/maxim_thermocouple.c
> 
> diff --git a/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
> new file mode 100644
> index 000000000000..28bc5c4d965b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
> @@ -0,0 +1,21 @@
> +Maxim thermocouple support
> +
> +* https://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
> +* https://datasheets.maximintegrated.com/en/ds/MAX31855.pdf
> +
> +Required properties:
> +
> +	- compatible: must be "maxim,max31855" or "maxim,max6675"
> +	- reg: SPI chip select number for the device
> +	- spi-max-frequency: must be 4300000
> +	- spi-cpha: must be defined for max6675 to enable SPI mode 1
> +
> +	Refer to spi/spi-bus.txt for generic SPI slave bindings.
> +
> +Example:
> +
> +	max31855@0 {
> +		compatible = "maxim,max31855";
> +		reg = <0>;
> +		spi-max-frequency = <4300000>;
> +	};
> diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
> index c4664e5de791..1d3da05eca39 100644
> --- a/drivers/iio/temperature/Kconfig
> +++ b/drivers/iio/temperature/Kconfig
> @@ -3,6 +3,20 @@
>  #
>  menu "Temperature sensors"
>  
> +config MAXIM_THERMOCOUPLE
> +	tristate "Maxim thermocouple sensors"
> +	depends on SPI
> +	help
> +	  If you say yes here you get support for the Maxim series of
> +	  thermocouple sensors connected via SPI.
> +
> +	  Supported sensors:
> +	   * MAX6675
> +	   * MAX31855
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called maxim_thermocouple.
> +
>  config MLX90614
>  	tristate "MLX90614 contact-less infrared sensor"
>  	depends on I2C
> diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
> index 02bc79d49b24..78c3de0dc3f0 100644
> --- a/drivers/iio/temperature/Makefile
> +++ b/drivers/iio/temperature/Makefile
> @@ -2,6 +2,7 @@
>  # Makefile for industrial I/O temperature drivers
>  #
>  
> +obj-$(CONFIG_MAXIM_THERMOCOUPLE) += maxim_thermocouple.o
>  obj-$(CONFIG_MLX90614) += mlx90614.o
>  obj-$(CONFIG_TMP006) += tmp006.o
>  obj-$(CONFIG_TSYS01) += tsys01.o
> diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
> new file mode 100644
> index 000000000000..62ae88bcc4e7
> --- /dev/null
> +++ b/drivers/iio/temperature/maxim_thermocouple.c
> @@ -0,0 +1,281 @@
> +/*
> + * maxim_thermocouple.c  - Support for Maxim thermocouple chips
> + *
> + * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/mutex.h>
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +
> +#define MAXIM_THERMOCOUPLE_DRV_NAME	"maxim_thermocouple"
> +
> +enum {
> +	MAX6675,
> +	MAX31855,
> +};
> +
> +const struct iio_chan_spec max6675_channels[] = {
> +	{	/* thermocouple temperature */
> +		.type = IIO_TEMP,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 13,
> +			.storagebits = 16,
> +			.shift = 3,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(1),
> +};
> +
> +const struct iio_chan_spec max31855_channels[] = {
> +	{	/* thermocouple temperature */
> +		.type = IIO_TEMP,
> +		.address = 2,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 14,
> +			.storagebits = 16,
> +			.shift = 2,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	{	/* cold junction temperature */
> +		.type = IIO_TEMP,
> +		.address = 0,
> +		.channel2 = IIO_MOD_TEMP_AMBIENT,
> +		.modified = 1,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 12,
> +			.storagebits = 16,
> +			.shift = 4,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
> +};
> +
> +static const unsigned long max31855_scan_masks[] = {0x3, 0};
> +
> +struct maxim_thermocouple_chip {
> +	const struct iio_chan_spec *channels;
> +	const unsigned long *scan_masks;
> +	u8 num_channels;
> +	u8 read_size;
> +
> +	/* bit-check for valid input */
> +	u32 status_bit;
> +};
> +
> +const struct maxim_thermocouple_chip maxim_thermocouple_chips[] = {
> +	[MAX6675] = {
> +			.channels = max6675_channels,
> +			.num_channels = ARRAY_SIZE(max6675_channels),
> +			.read_size = 2,
> +			.status_bit = BIT(2),
> +		},
> +	[MAX31855] = {
> +			.channels = max31855_channels,
> +			.num_channels = ARRAY_SIZE(max31855_channels),
> +			.read_size = 4,
> +			.scan_masks = max31855_scan_masks,
> +			.status_bit = BIT(16),
> +		},
> +};
> +
> +struct maxim_thermocouple_data {
> +	struct spi_device *spi;
> +	const struct maxim_thermocouple_chip *chip;
> +
> +	u8 buffer[16] ____cacheline_aligned;
> +};
> +
> +static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
> +				   struct iio_chan_spec const *chan, int *val)
> +{
> +	unsigned int storage_bytes = data->chip->read_size;
> +	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
> +	unsigned int buf;
> +	int ret;
> +
> +	ret = spi_read(data->spi, (void *) &buf, storage_bytes);
> +	if (ret)
> +		return ret;
> +
> +	switch (storage_bytes) {
> +	case 2:
> +		*val = be16_to_cpu(buf);
> +		break;
> +	case 4:
> +		*val = be32_to_cpu(buf);
> +		break;
> +	}
> +
> +	/* check to be sure this is a valid reading */
> +	if (*val & data->chip->status_bit)
> +		return -EINVAL;
> +
> +	*val = sign_extend32(*val >> shift, chan->scan_type.realbits - 1);
> +
> +	return 0;
> +}
> +
> +static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
> +{
> +	struct iio_poll_func *pf = private;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
> +	if (!ret) {
> +		iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> +						   iio_get_time_ns());
> +	}
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int maxim_thermocouple_read_raw(struct iio_dev *indio_dev,
> +				       struct iio_chan_spec const *chan,
> +				       int *val, int *val2, long mask)
> +{
> +	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = maxim_thermocouple_read(data, chan, val);
> +		iio_device_release_direct_mode(indio_dev);
> +
> +		if (!ret)
> +			return IIO_VAL_INT;
> +
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel2) {
> +		case IIO_MOD_TEMP_AMBIENT:
> +			*val = 62;
> +			*val2 = 500000; /* 1000 * 0.0625 */
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +			break;
> +		default:
> +			*val = 250; /* 1000 * 0.25 */
> +			ret = IIO_VAL_INT;
> +		};
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct iio_info maxim_thermocouple_info = {
> +	.driver_module = THIS_MODULE,
> +	.read_raw = maxim_thermocouple_read_raw,
> +};
> +
> +static int maxim_thermocouple_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct iio_dev *indio_dev;
> +	struct maxim_thermocouple_data *data;
> +	const struct maxim_thermocouple_chip *chip =
> +			&maxim_thermocouple_chips[id->driver_data];
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	indio_dev->info = &maxim_thermocouple_info;
> +	indio_dev->name = MAXIM_THERMOCOUPLE_DRV_NAME;
> +	indio_dev->channels = chip->channels;
> +	indio_dev->available_scan_masks = chip->scan_masks;
> +	indio_dev->num_channels = chip->num_channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	data = iio_priv(indio_dev);
> +	data->spi = spi;
> +	data->chip = chip;
> +
> +	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +				maxim_thermocouple_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_unreg_buffer;
> +
> +	return 0;
> +
> +error_unreg_buffer:
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int maxim_thermocouple_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +
> +	iio_device_unregister(indio_dev);
> +	iio_triggered_buffer_cleanup(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id maxim_thermocouple_id[] = {
> +	{"max6675", MAX6675},
> +	{"max31855", MAX31855},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
> +
> +static struct spi_driver maxim_thermocouple_driver = {
> +	.driver = {
> +		.name	= MAXIM_THERMOCOUPLE_DRV_NAME,
> +	},
> +	.probe		= maxim_thermocouple_probe,
> +	.remove		= maxim_thermocouple_remove,
> +	.id_table	= maxim_thermocouple_id,
> +};
> +module_spi_driver(maxim_thermocouple_driver);
> +
> +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
> +MODULE_DESCRIPTION("Maxim thermocouple sensors");
> +MODULE_LICENSE("GPL");
> 

