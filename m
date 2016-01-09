Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37470 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbcAIQPn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Jan 2016 11:15:43 -0500
Subject: Re: [PATCH v5] iio: add ad5761 DAC driver
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1452274180-16673-1-git-send-email-ricardo.ribalda@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5691322C.2030004@kernel.org>
Date: Sat, 9 Jan 2016 16:15:40 +0000
MIME-Version: 1.0
In-Reply-To: <1452274180-16673-1-git-send-email-ricardo.ribalda@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/16 17:29, Ricardo Ribalda Delgado wrote:
> ad5761 is a 1-channel DAC with configurable output range.
> The driver uses the regulator interface for its voltage ref.
> 
> It shares its register layout with ad5761r, ad5721 and ad5721r.
> 
> Differences:
> ad5761* are 16 bit, ad5721* are 12 bits.
> ad57*1r have an internal reference.
> 
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Hi Ricardo,

Couple of tiny bits inline.  I'd also like to give Lars / Peter
a little more time for another glance at this as we are effectively
very early in the merge cycle so there is no rush!

I'm a little unsure that we shouldn't just fail the probe if the
range is supplied.  Even the default (the best option available)
could in theory do damage to a circuit with a maximum of 3V though
it's probably unlikely...

Otherwise, looking very good.
> ---
> v5: CodeStyle and check val2 value
>     Thanks to Peter Meerwald-Stadler <pmeerw@pmeerw.net> and
> 
> v4: Use locking mechanism
>     Populate errors
>     Thanks to Lars-Peter Clausen <lars@metafoo.de>
> 
> v3: Move programmable voltage range to pdata
>     Exit on error instead of using internal voltage reference
>     Thanks to Jonathan Cameron <jic23@kernel.org>
> 
> v2: A lot of CodeStyle Fixes
>     Thanks to Peter Meerwald-Stadler <pmeerw@pmeerw.net> and
>     Jonathan Cameron <jic23@kernel.org>
> 
>  CREDITS                        |   1 +
>  drivers/iio/dac/Kconfig        |  10 +
>  drivers/iio/dac/Makefile       |   1 +
>  drivers/iio/dac/ad5761.c       | 432 +++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/dac/ad5761.h |  36 ++++
>  5 files changed, 480 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5761.c
>  create mode 100644 include/linux/iio/dac/ad5761.h
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
> index 000000000000..433dd7254c10
> --- /dev/null
> +++ b/drivers/iio/dac/ad5761.c
> @@ -0,0 +1,432 @@
> +/*
> + * AD5721, AD5721R, AD5761, AD5761R, Voltage Output Digital to Analog Converter
> + *
> + * Copyright 2016 Qtechnology A/S
> + * 2016 Ricardo Ribalda <ricardo.ribalda@gmail.com>
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
> +#include <linux/iio/dac/ad5761.h>
> +
> +#define AD5761_ADDR(addr)		((addr & 0xf) << 16)
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
> + * @channel:	channel specification
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
> + * @vref_reg:		reference voltage regulator
> + * @use_intref:		true when the internal voltage reference is used
> + * @vref:		actual voltage reference in mVolts
> + * @range:		output range mode used
> + * @data:		cache aligned spi buffer
> + */
> +struct ad5761_state {
> +	struct spi_device		*spi;
> +	struct regulator		*vref_reg;
> +
> +	bool use_intref;
> +	int vref;
> +	enum ad5761_voltage_range range;
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
> +static const struct ad5761_range_params ad5761_range_params[] = {
> +	[AD5761_VOLTAGE_RANGE_M10V_10V] = {
> +		.m = 80,
> +		.c = 40,
> +	},
> +	[AD5761_VOLTAGE_RANGE_0V_10V] = {
> +		.m = 40,
> +		.c = 0,
> +	},
> +	[AD5761_VOLTAGE_RANGE_M5V_5V] = {
> +		.m = 40,
> +		.c = 20,
> +	},
> +	[AD5761_VOLTAGE_RANGE_0V_5V] = {
> +		.m = 20,
> +		.c = 0,
> +	},
> +	[AD5761_VOLTAGE_RANGE_M2V5_7V5] = {
> +		.m = 40,
> +		.c = 10,
> +	},
> +	[AD5761_VOLTAGE_RANGE_M3V_3V] = {
> +		.m = 24,
> +		.c = 12,
> +	},
> +	[AD5761_VOLTAGE_RANGE_0V_16V] = {
> +		.m = 64,
> +		.c = 0,
> +	},
> +	[AD5761_VOLTAGE_RANGE_0V_20V] = {
> +		.m = 80,
> +		.c = 0,
> +	},
> +};
> +
> +static int _ad5761_spi_write(struct ad5761_state *st, u8 addr, u16 val)
> +{
> +	st->data[0].d32 = cpu_to_be32(AD5761_ADDR(addr) | val);
> +
> +	return spi_write(st->spi, &st->data[0].d8[1], 3);
> +}
> +
> +static int ad5761_spi_write(struct iio_dev *indio_dev, u8 addr, u16 val)
> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	ret = _ad5761_spi_write(st, addr, val);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static int _ad5761_spi_read(struct ad5761_state *st, u8 addr, u16 *val)
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
> +static int ad5761_spi_read(struct iio_dev *indio_dev, u8 addr, u16 *val)
> +{
> +	struct ad5761_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	ret = _ad5761_spi_read(st, addr, val);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static int ad5761_spi_set_range(struct ad5761_state *st,
> +				enum ad5761_voltage_range range)
> +{
> +	u16 aux;
> +	int ret;
> +
> +	aux = (range & 0x7) | AD5761_CTRL_ETS;
> +
> +	if (st->use_intref)
> +		aux |= AD5761_CTRL_USE_INTVREF;
> +
> +	ret = _ad5761_spi_write(st, AD5761_ADDR_SW_FULL_RESET, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = _ad5761_spi_write(st, AD5761_ADDR_CTRL_WRITE_REG, aux);
> +	if (ret)
> +		return ret;
> +
> +	st->range = range;
> +
> +	return 0;
> +}
> +
> +static int ad5761_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val,
> +			   int *val2,
> +			   long mask)
> +{
> +	struct ad5761_state *st;
> +	int ret;
> +	u16 aux;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = ad5761_spi_read(indio_dev, AD5761_ADDR_DAC_READ, &aux);
> +		if (ret)
> +			return ret;
> +		*val = aux >> chan->scan_type.shift;
> +		*val2 = 0;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		st = iio_priv(indio_dev);
> +		*val = st->vref * ad5761_range_params[st->range].m;
> +		*val /= 10;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		st = iio_priv(indio_dev);
> +		*val = -(1 << chan->scan_type.realbits);
> +		*val *=	ad5761_range_params[st->range].c;
> +		*val /=	ad5761_range_params[st->range].m;
> +		*val2 = 0;
Should be no need to set val2 if returning IIO_VAL_INT.
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5761_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long mask)
> +{
> +	u16 aux;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	if (val2 || (val << chan->scan_type.shift) > 0xffff || val < 0)
> +		return -EINVAL;
> +
> +	aux = val << chan->scan_type.shift;
> +
> +	return ad5761_spi_write(indio_dev, AD5761_ADDR_DAC_WRITE, aux);
> +}
> +
> +static const struct iio_info ad5761_info = {
> +	.read_raw = &ad5761_read_raw,
> +	.write_raw = &ad5761_write_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +#define AD5761_CHAN(_bits) {				\
> +	.type = IIO_VOLTAGE,				\
> +	.output = 1,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.scan_type = {					\
> +		.sign = 'u',				\
> +		.realbits = (_bits),			\
> +		.storagebits = 16,			\
> +		.shift = 16 - (_bits),			\
> +	},						\
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
> +static int ad5761_get_vref(struct ad5761_state *st,
> +			   const struct ad5761_chip_info *chip_info)
> +{
> +	int ret;
> +
> +	st->vref_reg = devm_regulator_get_optional(&st->spi->dev, "vref");
> +	if (!st->vref_reg || PTR_ERR(st->vref_reg) == -ENODEV) {
This is a little unusual... Only one of those errors is returned by
devm_regulator_get_optional if the regulator is not specified.
I believe from a quick look at the regulator code that it returns the
-ENODEV part.

So how can it be null?

> +		/* Use Internal regulator */
> +		if (!chip_info->int_vref) {
> +			dev_err(&st->spi->dev,
> +				"Voltage reference not found\n");
> +			return -EIO;
> +		}
> +
> +		st->use_intref = true;
> +		st->vref = chip_info->int_vref;
> +		return 0;
> +	}
> +
> +	if (IS_ERR(st->vref_reg)) {
> +		dev_err(&st->spi->dev,
> +			"Error getting voltage reference regulator\n");
> +		return PTR_ERR(st->vref_reg);
> +	}
> +
> +	ret = regulator_enable(st->vref_reg);
> +	if (ret) {
> +		dev_err(&st->spi->dev,
> +			 "Failed to enable voltage reference\n");
> +		return ret;
> +	}
> +
> +	ret = regulator_get_voltage(st->vref_reg);
> +	if (ret < 0) {
> +		dev_err(&st->spi->dev,
> +			 "Failed to get voltage reference value\n");
> +		goto disable_regulator_vref;
> +	}
> +
> +	if (ret < 2000000 || ret > 3000000) {
> +		dev_warn(&st->spi->dev,
> +			 "Invalid external voltage ref. value %d uV\n", ret);
> +		ret = -EIO;
> +		goto disable_regulator_vref;
> +	}
> +
> +	st->vref = ret / 1000;
> +	st->use_intref = false;
> +
> +	return 0;
> +
> +disable_regulator_vref:
> +	regulator_disable(st->vref_reg);
> +	st->vref_reg = NULL;
> +	return ret;
> +}
> +
> +static int ad5761_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev;
> +	struct ad5761_state *st;
> +	int ret;
> +	const struct ad5761_chip_info *chip_info =
> +		&ad5761_chip_infos[spi_get_device_id(spi)->driver_data];
> +	enum ad5761_voltage_range voltage_range = AD5761_VOLTAGE_RANGE_0V_5V;
> +	struct ad5761_platform_data *pdata = dev_get_platdata(&spi->dev);
> +
> +	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(iio_dev);
> +
> +	st->spi = spi;
> +	spi_set_drvdata(spi, iio_dev);
> +
> +	ret = ad5761_get_vref(st, chip_info);
> +	if (ret)
> +		return ret;
> +
> +	if (pdata)
> +		voltage_range = pdata->voltage_range;
> +
> +	ret = ad5761_spi_set_range(st, voltage_range);
> +	if (ret)
> +		goto disable_regulator_err;
> +
> +	iio_dev->dev.parent = &spi->dev;
> +	iio_dev->info = &ad5761_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->channels = &chip_info->channel;
> +	iio_dev->num_channels = 1;
> +	iio_dev->name = spi_get_device_id(st->spi)->name;
> +	ret = iio_device_register(iio_dev);
> +	if (ret)
> +		goto disable_regulator_err;
> +
> +	return 0;
> +
> +disable_regulator_err:
> +	if (!IS_ERR_OR_NULL(st->vref_reg))
> +		regulator_disable(st->vref_reg);
> +
> +	return ret;
> +}
> +
> +static int ad5761_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev = spi_get_drvdata(spi);
> +	struct ad5761_state *st = iio_priv(iio_dev);
> +
> +	iio_device_unregister(iio_dev);
> +
> +	if (!IS_ERR_OR_NULL(st->vref_reg))
> +		regulator_disable(st->vref_reg);
> +
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
> diff --git a/include/linux/iio/dac/ad5761.h b/include/linux/iio/dac/ad5761.h
> new file mode 100644
> index 000000000000..e3699aff627b
> --- /dev/null
> +++ b/include/linux/iio/dac/ad5761.h
> @@ -0,0 +1,36 @@
> +#ifndef __IIO_DAC_AD5761_H__
> +#define __IIO_DAC_AD5761_H__
> +
> +/**
> + * enum ad5761_voltage_range - Voltage range the AD5761 is configured for.
> + * @AD5761_VOLTAGE_RANGE_M10V_10V:  -10V to  10V
> + * @AD5761_VOLTAGE_RANGE_0V_10V:      0V to  10V
> + * @AD5761_VOLTAGE_RANGE_M5V_5V:     -5V to   5V
M0V_5V is not documented...
> + * @AD5761_VOLTAGE_RANGE_M2V5_7V5: -2.5V to 7.5V
> + * @AD5761_VOLTAGE_RANGE_M3V_3V:     -3V to   3V
> + * @AD5761_VOLTAGE_RANGE_0V_16V:      0V to  16V
> + * @AD5761_VOLTAGE_RANGE_0V_20V:      0V to  20V
> + */
> +
> +enum ad5761_voltage_range {
> +	AD5761_VOLTAGE_RANGE_M10V_10V,
> +	AD5761_VOLTAGE_RANGE_0V_10V,
> +	AD5761_VOLTAGE_RANGE_M5V_5V,
> +	AD5761_VOLTAGE_RANGE_0V_5V,
> +	AD5761_VOLTAGE_RANGE_M2V5_7V5,
> +	AD5761_VOLTAGE_RANGE_M3V_3V,
> +	AD5761_VOLTAGE_RANGE_0V_16V,
> +	AD5761_VOLTAGE_RANGE_0V_20V,
> +};
> +
> +/**
> + * struct ad5761_platform_data - AD5761 DAC driver platform data
> + * @voltage_range: Voltage range the AD5761 is configured for
> + */
> +
> +struct ad5761_platform_data {
> +	enum ad5761_voltage_range voltage_range;
> +};
> +
> +
> +#endif
> 

