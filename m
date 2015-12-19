Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:36958 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964791AbbLSRGf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 19 Dec 2015 12:06:35 -0500
Date: Sat, 19 Dec 2015 18:06:32 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: add ad5761 DAC driver
In-Reply-To: <1450272464-13992-1-git-send-email-ricardo.ribalda@gmail.com>
Message-ID: <alpine.DEB.2.02.1512191736230.3182@pmeerw.net>
References: <1450272464-13992-1-git-send-email-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> ad5761 is a 1-channel DAC with configurable output range.
> The driver uses the regulator interface for its voltage ref.

some nitpicking below

> It shares its register layout with ad5761r, ad5721 and ad5721r.
> 
> Differences:
> ad5761* are 16 bit, ad5721* are 12 bits.
> ad57*1r have an internal reference.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
>  CREDITS                  |   1 +
>  drivers/iio/dac/Kconfig  |  10 ++
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad5761.c | 425 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 437 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5761.c
> 
> diff --git a/CREDITS b/CREDITS
> index 8207cc62ee9d..44ea433d70a1 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -3035,6 +3035,7 @@ D: PLX USB338x driver
>  D: PCA9634 driver
>  D: Option GTM671WFS
>  D: Fintek F81216A
> +D: AD5761 iio driver
>  D: Various kernel hacks
>  S: Qtechnology A/S
>  S: Valby Langgade 142
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index e701e28fb1cd..4caedd671360 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -111,6 +111,16 @@ config AD5755
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5755.
>  
> +config AD5761
> +	tristate "Analog Devices AD5761/61R/21/21R DAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD5761, AD5761R, AD5721,
> +	  AD5721R Digital to Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5761.
> +
>  config AD5764
>  	tristate "Analog Devices AD5764/64R/44/44R DAC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 63ae05633e0c..cb525b53fc7b 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_AD5504) += ad5504.o
>  obj-$(CONFIG_AD5446) += ad5446.o
>  obj-$(CONFIG_AD5449) += ad5449.o
>  obj-$(CONFIG_AD5755) += ad5755.o
> +obj-$(CONFIG_AD5761) += ad5761.o
>  obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5791) += ad5791.o
>  obj-$(CONFIG_AD5686) += ad5686.o
> diff --git a/drivers/iio/dac/ad5761.c b/drivers/iio/dac/ad5761.c
> new file mode 100644
> index 000000000000..b4eac59ef81f
> --- /dev/null
> +++ b/drivers/iio/dac/ad5761.c
> @@ -0,0 +1,425 @@
> +/*
> + * AD5721, AD5721R, AD5761, AD5761R, Voltage Output Digital to Analog Converter
> + *
> + * Copyright 2015 Qtechnology A/S
> + *
> + * Licensed under the GPL-2.
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/bitops.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +#define AD5761_ADDR(addr)		((addr&0xf) << 16)

maybe add whitespace around &

> +#define AD5761_ADDR_NOOP		0x0
> +#define AD5761_ADDR_DAC_WRITE		0x3
> +#define AD5761_ADDR_CTRL_WRITE_REG	0x4
> +#define AD5761_ADDR_SW_DATA_RESET	0x7
> +#define AD5761_ADDR_DAC_READ		0xb
> +#define AD5761_ADDR_CTRL_READ_REG	0xc
> +#define AD5761_ADDR_SW_FULL_RESET	0xf
> +
> +#define AD5761_CTRL_USE_INTVREF		BIT(5)
> +#define AD5761_CTRL_ETS			BIT(6)
> +
> +/**
> + * struct ad5761_chip_info - chip specific information
> + * @int_vref:	Value of the internal reference voltage in mV - 0 if external
> + *		reference voltage is used
> + * @channel	channel specification

@channel:

> +*/
> +
> +struct ad5761_chip_info {
> +	unsigned long int_vref;
> +	const struct iio_chan_spec channel;
> +};
> +
> +struct ad5761_range_params {
> +	int m;
> +	int c;
> +};
> +
> +/**
> + * ad5761_supported_device_ids:
> + */
> +
> +enum ad5761_supported_device_ids {
> +	ID_AD5721,
> +	ID_AD5721R,
> +	ID_AD5761,
> +	ID_AD5761R,
> +};
> +
> +/**
> + * struct ad5761_state - driver instance specific data
> + * @spi:		spi_device
> + * @chip_info:		chip model specific constants
> + * @vref_mv:		actual reference voltage used

there is no chip_info and no vref_mv in ad5761_state

vref_reg, use_intref, vref, range, data exist but have no explanation

> + */
> +struct ad5761_state {
> +	struct spi_device		*spi;
> +	struct regulator		*vref_reg;
> +
> +	bool use_intref;
> +	int vref;
> +	int range;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +	union {
> +		__be32 d32;
> +		u8 d8[4];
> +	} data[3] ____cacheline_aligned;
> +};
> +
> +enum ad5761_range_ids {
> +	MODE_M10V_10V,
> +	MODE_0V_10V,
> +	MODE_M5V_5V,
> +	MODE_0V_5V,
> +	MODE_M2V5_7V5,
> +	MODE_M3V_3V,
> +	MODE_0V_16V,
> +	MODE_0V_20V,
> +};
> +
> +static const struct ad5761_range_params ad5761_range_params[] = {
> +	[MODE_M10V_10V] = {
> +		.m = 80,
> +		.c = 40,
> +	},
> +	[MODE_0V_10V] = {
> +		.m = 40,
> +		.c = 0,
> +	},
> +	[MODE_M5V_5V] = {
> +		.m = 40,
> +		.c = 20,
> +	},
> +	[MODE_0V_5V] = {
> +		.m = 20,
> +		.c = 0,
> +	},
> +	[MODE_M2V5_7V5] = {
> +		.m = 40,
> +		.c = 10,
> +	},
> +	[MODE_M3V_3V] = {
> +		.m = 24,
> +		.c = 12,
> +	},
> +	[MODE_0V_16V] = {
> +		.m = 64,
> +		.c = 0,
> +	},
> +	[MODE_0V_20V] = {
> +		.m = 80,
> +		.c = 0,
> +	},
> +};
> +
> +static const char * const ad5761_ranges[] = {
> +	[MODE_M10V_10V] = "-10V_10V",
> +	[MODE_0V_10V] = "0V_10V",
> +	[MODE_M5V_5V] = "-5V_5V",
> +	[MODE_0V_5V] = "0V_5V",
> +	[MODE_M2V5_7V5] = "-2V5_7V5",
> +	[MODE_M3V_3V] = "-3V_3V",
> +	[MODE_0V_16V] = "0V_16V",
> +	[MODE_0V_20V] = "0V_20V",
> +};
> +
> +static int ad5761_spi_write(struct ad5761_state *st, u8 addr, u16 val)
> +{
> +	st->data[0].d32 = cpu_to_be32(AD5761_ADDR(addr) | val);
> +
> +	return spi_write(st->spi, &st->data[0].d8[1], 3);
> +}
> +
> +static int ad5761_spi_read(struct ad5761_state *st, u8 addr, u16 *val)
> +{
> +	int ret;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &st->data[0].d8[1],
> +			.bits_per_word = 8,
> +			.len = 3,
> +			.cs_change = true,
> +		}, {
> +			.tx_buf = &st->data[1].d8[1],
> +			.rx_buf = &st->data[2].d8[1],
> +			.bits_per_word = 8,
> +			.len = 3,
> +		},
> +	};
> +
> +	st->data[0].d32 = cpu_to_be32(AD5761_ADDR(addr));
> +	st->data[1].d32 = cpu_to_be32(AD5761_ADDR(AD5761_ADDR_NOOP));
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +
> +	*val = be32_to_cpu(st->data[2].d32);
> +
> +	return ret;
> +}
> +
> +static int ad5761_spi_set_range(struct ad5761_state *st, int range)
> +{
> +	u16 aux;
> +	int ret;
> +
> +	aux = range;
> +	aux |= AD5761_CTRL_ETS;
> +	if (st->use_intref)
> +		aux |= AD5761_CTRL_USE_INTVREF;
> +	ret = ad5761_spi_write(st, AD5761_ADDR_CTRL_WRITE_REG, aux);
> +	if (ret)
> +		return ret;
> +	ret = ad5761_spi_write(st, AD5761_ADDR_SW_DATA_RESET, 0);
> +	if (ret)
> +		return ret;
> +
> +	st->range = range;
> +	return 0;
> +}
> +
> +static int ad5761_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long m)

often 'mask' is used instead of m

> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u16 aux;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad5761_spi_read(st, AD5761_ADDR_DAC_READ, &aux);
> +		if (ret)
> +			return ret;
> +		*val = aux >> chan->scan_type.shift;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref * ad5761_range_params[st->range].m;
> +		*val /= 10;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1<<chan->scan_type.realbits);

whitespace around <<

> +		*val *=	ad5761_range_params[st->range].c;
> +		*val /=	ad5761_range_params[st->range].m;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +

delete newline

> +}
> +
> +static int ad5761_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +	u16 aux;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		aux =  val << chan->scan_type.shift;

delete extra space before val

> +		return ad5761_spi_write(st, AD5761_ADDR_DAC_WRITE, aux);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5761_set_range(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan, unsigned int range)
> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +
> +	return ad5761_spi_set_range(st, range);
> +}
> +
> +static int ad5761_get_range(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *chan)
> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +	u16 aux;
> +	int ret;
> +
> +	ret = ad5761_spi_read(st, AD5761_ADDR_CTRL_READ_REG, &aux);
> +	if (ret)
> +		return ret;
> +
> +	return aux & 0x7;
> +}
> +
> +static const struct iio_info ad5761_info = {
> +	.read_raw = &ad5761_read_raw,
> +	.write_raw = &ad5761_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const struct iio_enum ad5761_range_enum = {
> +	.items = ad5761_ranges,
> +	.num_items = ARRAY_SIZE(ad5761_ranges),
> +	.get = ad5761_get_range,
> +	.set = ad5761_set_range,
> +};
> +
> +static struct iio_chan_spec_ext_info ad5761_ext_info[] = {
> +	IIO_ENUM("range", IIO_SHARED_BY_TYPE,
> +		 &ad5761_range_enum),
> +	IIO_ENUM_AVAILABLE("range", &ad5761_range_enum),
> +	{ },
> +};
> +
> +#define AD5761_CHAN(_bits) {				\
> +	.type = IIO_VOLTAGE,				\
> +	.output = 1,					\
> +	.indexed = 1,					\

since there is only one channel, .indexed could be 0 (or not set)

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_type = {					\

the driver does not support buffered mode, not sure if scan_type should be 
used to store the number of bits; I think it would be cleaner to put this 
in chip_info

> +		.sign = 'u',				\
> +		.realbits = (_bits),			\
> +		.storagebits = 16,			\
> +		.shift = 16 - (_bits),			\
> +	},						\
> +	.ext_info = ad5761_ext_info,			\
> +}
> +
> +static const struct ad5761_chip_info ad5761_chip_infos[] = {
> +	[ID_AD5721] = {
> +		.int_vref = 0,
> +		.channel = AD5761_CHAN(12),
> +	},
> +	[ID_AD5721R] = {
> +		.int_vref = 2500,
> +		.channel = AD5761_CHAN(12),
> +	},
> +	[ID_AD5761] = {
> +		.int_vref = 0,
> +		.channel = AD5761_CHAN(16),
> +	},
> +	[ID_AD5761R] = {
> +		.int_vref = 2500,
> +		.channel = AD5761_CHAN(16),
> +	},
> +};
> +
> +static void ad5761_get_vref(struct ad5761_state *st)
> +{
> +	int ret;
> +

delete extra newline

> +
> +	st->vref_reg = devm_regulator_get(&st->spi->dev, "vref");
> +	if (IS_ERR(st->vref_reg))
> +		return;
> +
> +	ret = regulator_enable(st->vref_reg);
> +	if (ret) {
> +		dev_warn(&st->spi->dev, "Failed to enable vref. Using internal");

put \n at the end of the message (here and elsewhere)

> +		return;
> +	}
> +
> +	ret = regulator_get_voltage(st->vref_reg);
> +	if (ret < 0) {
> +		regulator_disable(st->vref_reg);
> +		dev_warn(&st->spi->dev,
> +			 "Failed to get vref value. Using internal");
> +		return;
> +	}
> +
> +	if (ret < 2000000 || ret > 3000000) {
> +		regulator_disable(st->vref_reg);
> +		dev_warn(&st->spi->dev,
> +				"Invalid external vref value. Using internal");
> +		return;
> +	}
> +
> +	st->vref = ret / 1000;
> +	st->use_intref = false;
> +}
> +
> +static int ad5761_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev;
> +	struct ad5761_state *st;
> +	int ret;
> +	const struct ad5761_chip_info *chip_info =
> +		&ad5761_chip_infos[spi_get_device_id(spi)->driver_data];
> +
> +	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +	st = iio_priv(iio_dev);
> +
> +	st->spi = spi;
> +	spi_set_drvdata(spi, iio_dev);
> +
> +	st->use_intref = true;
> +	st->vref = chip_info->int_vref;
> +	ad5761_get_vref(st);

this is ugly, I'd prefer to return something from _get_vref() instead of 
first setting a could of variable and then checking a couple of variables

> +	if (st->use_intref && !chip_info->int_vref) {
> +		dev_err(&spi->dev, "Missing vref, cannot continue");
> +		return -EIO;
> +	}
> +
> +	ad5761_spi_set_range(st, MODE_0V_5V);

this can fail, retval not checked

> +
> +	iio_dev->dev.parent = &spi->dev;
> +	iio_dev->info = &ad5761_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->channels = &chip_info->channel;
> +	iio_dev->num_channels = 1;
> +	iio_dev->name = spi_get_device_id(st->spi)->name;
> +	ret = iio_device_register(iio_dev);
> +	if (ret && !IS_ERR(st->vref_reg))
> +		regulator_disable(st->vref_reg);

maybe vref_reg is disabled twice, here and in get_vref()

> +
> +	return ret;
> +}
> +
> +static int ad5761_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev = spi_get_drvdata(spi);
> +	struct ad5761_state *st = iio_priv(iio_dev);
> +
> +	if (!IS_ERR(st->vref_reg))
> +		regulator_disable(st->vref_reg);
> +	iio_device_unregister(iio_dev);
> +	return 0;
> +}
> +
> +static const struct spi_device_id ad5761_id[] = {
> +	{"ad5721", ID_AD5721},
> +	{"ad5721r", ID_AD5721R},
> +	{"ad5761", ID_AD5761},
> +	{"ad5761r", ID_AD5761R},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad5761_id);
> +
> +static struct spi_driver ad5761_driver = {
> +	.driver = {
> +		   .name = "ad5761",
> +		   .owner = THIS_MODULE,
> +		   },
> +	.probe = ad5761_probe,
> +	.remove = ad5761_remove,
> +	.id_table = ad5761_id,
> +};
> +module_spi_driver(ad5761_driver);
> +
> +MODULE_AUTHOR("Ricardo Ribalda <ricardo.ribalda@gmail.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5721, AD5721R, AD5761, AD5761R driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
