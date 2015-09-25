Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:36577 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbbIYGwi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 25 Sep 2015 02:52:38 -0400
Date: Fri, 25 Sep 2015 08:52:35 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv2 1/2] iio: adc: Add TI ADS868X
In-Reply-To: <1443162580-28293-1-git-send-email-sean.nyekjaer@prevas.dk>
Message-ID: <alpine.DEB.2.02.1509250842470.2707@pmeerw.net>
References: <1443162580-28293-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="324295856-1461148541-1443163955=:2707"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--324295856-1461148541-1443163955=:2707
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT


> This patch adds support for the Texas Intruments ADS868x ADC.

looks good, some minor comments below
maybe add link to datasheet
 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>
> ---
> Changes since v1:
> - Now possible to read and write the actual offset and scale values
> - Removed unused includes
> - Removed unused buffer references
> 
>  drivers/iio/adc/Kconfig      |  10 +
>  drivers/iio/adc/Makefile     |   1 +
>  drivers/iio/adc/ti-ads868x.c | 456 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 467 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads868x.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index deea62c..39924d5 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -322,6 +322,16 @@ config TI_ADC128S052
>  	  This driver can also be built as a module. If so, the module will be
>  	  called ti-adc128s052.
>  
> +config TI_ADS868X
> +	tristate "Texas Instruments ADS8684/8"
> +	depends on SPI && OF
> +	help
> +	  If you say yes here you get support for Texas Instruments ADS8684 and
> +	  and ADS8688 ADC chips
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called ti-ads868x.
> +
>  config TI_AM335X_ADC
>  	tristate "TI's AM335X ADC driver"
>  	depends on MFD_TI_AM335X_TSCADC
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index fa5723a..75170d2 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -31,6 +31,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>  obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
> +obj-$(CONFIG_TI_ADS868X) += ti-ads868x.o
>  obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>  obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>  obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
> diff --git a/drivers/iio/adc/ti-ads868x.c b/drivers/iio/adc/ti-ads868x.c
> new file mode 100644
> index 0000000..66d9b64
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads868x.c
> @@ -0,0 +1,456 @@
> +/*
> + * Copyright (C) 2015 Prevas A/S
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define ADS868X_CMD_REG(x)		(x << 8)
> +#define ADS868X_CMD_REG_NOOP		0x00
> +#define ADS868X_CMD_REG_RST		0x85
> +#define ADS868X_CMD_REG_MAN_CH(chan)	(0xC0 | (4 * chan))
> +#define ADS868X_CMD_DONT_CARE_BITS	16
> +
> +#define ADS868X_PROG_REG(x)		(x << 9)
> +#define ADS868X_PROG_REG_RANGE_CH(chan)	(0x05 + chan)
> +#define ADS868X_PROG_WR_BIT		BIT(8)
> +#define ADS868X_PROG_DONT_CARE_BITS	8
> +
> +#define ADS868X_VREF_MV			4096
> +#define ADS868X_REALBITS		16
> +
> +struct ads868x_chip_info {
> +	unsigned int id;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +	unsigned int flags;
> +	const struct iio_info *iio_info;
> +};
> +
> +struct ads868x_state {
> +	const struct ads868x_chip_info	*chip_info;
> +	struct spi_device		*spi;
> +	struct regulator		*reg;
> +	unsigned int			vref_mv;
> +	char				range[8];
> +	union {
> +		__be32 d32;
> +		u8 d8[4];
> +	} data[2] ____cacheline_aligned;
> +};
> +
> +enum ads868x_id {
> +	ID_ADS8684,
> +	ID_ADS8688,
> +};
> +
> +enum ads868x_range {
> +	ADS868X_PLUSMINUS25VREF		= 0x00,
> +	ADS868X_PLUSMINUS125VREF	= 0x01,
> +	ADS868X_PLUSMINUS0625VREF	= 0x02,
> +	ADS868X_PLUS25VREF		= 0x05,
> +	ADS868X_PLUS125VREF		= 0x06,
> +};
> +
> +struct ads868x_ranges {
> +	enum ads868x_range range;
> +	unsigned int scale;
> +	int offset;
> +};
> +
> +static struct ads868x_ranges ads868x_range_def[5] = {

can be const?

> +	{
> +		.range = ADS868X_PLUSMINUS25VREF,
> +		.scale = 76295,
> +		.offset = -(1 << (ADS868X_REALBITS - 1)),
> +	}, {
> +		.range = ADS868X_PLUSMINUS125VREF,
> +		.scale = 38148,
> +		.offset = -(1 << (ADS868X_REALBITS - 1)),
> +	}, {
> +		.range = ADS868X_PLUSMINUS0625VREF,
> +		.scale = 19074,
> +		.offset = -(1 << (ADS868X_REALBITS - 1)),
> +	}, {
> +		.range = ADS868X_PLUS25VREF,
> +		.scale = 38148,
> +		.offset = 0,
> +	}, {
> +		.range = ADS868X_PLUS125VREF,
> +		.scale = 19074,
> +		.offset = 0,
> +	}
> +};
> +
> +static ssize_t ads868x_show_scales(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct ads868x_state *st = iio_priv(dev_to_iio_dev(dev));
> +
> +	return sprintf(buf, "0.%09u 0.%09u 0.%09u\n",
> +		       ads868x_range_def[0].scale * st->vref_mv,
> +		       ads868x_range_def[1].scale * st->vref_mv,
> +		       ads868x_range_def[2].scale * st->vref_mv);
> +}
> +
> +static ssize_t ads868x_show_offsets(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d %d\n", ads868x_range_def[0].offset,
> +		       ads868x_range_def[3].offset);
> +}
> +
> +static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> +		       ads868x_show_scales, NULL, 0);
> +static IIO_DEVICE_ATTR(in_voltage_offset_available, S_IRUGO,
> +		       ads868x_show_offsets, NULL, 0);
> +
> +static struct attribute *ads868x_attributes[] = {
> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_voltage_offset_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ads868x_attribute_group = {
> +	.attrs = ads868x_attributes,
> +};
> +
> +#define ADS868X_CHAN(index)					\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = index,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
> +			      | BIT(IIO_CHAN_INFO_SCALE)	\
> +			      | BIT(IIO_CHAN_INFO_OFFSET),	\
> +}
> +
> +static const struct iio_chan_spec ads8684_channels[] = {
> +	ADS868X_CHAN(0),
> +	ADS868X_CHAN(1),
> +	ADS868X_CHAN(2),
> +	ADS868X_CHAN(3),
> +};
> +
> +static const struct iio_chan_spec ads8688_channels[] = {
> +	ADS868X_CHAN(0),
> +	ADS868X_CHAN(1),
> +	ADS868X_CHAN(2),
> +	ADS868X_CHAN(3),
> +	ADS868X_CHAN(4),
> +	ADS868X_CHAN(5),
> +	ADS868X_CHAN(6),
> +	ADS868X_CHAN(7),
> +};
> +
> +static int ads868x_prog_write(struct iio_dev *indio_dev, unsigned int addr,
> +			      unsigned int val)
> +{
> +	struct ads868x_state *st = iio_priv(indio_dev);
> +	unsigned int tmp;

tmp could be u32 to make it clear that it is turned into a 32-bit values

> +
> +	tmp = ADS868X_PROG_REG(addr) | ADS868X_PROG_WR_BIT | val;
> +	tmp <<= ADS868X_PROG_DONT_CARE_BITS;
> +	st->data[0].d32 = cpu_to_be32(tmp);
> +
> +	return spi_write(st->spi, &st->data[0].d8[1], 3);
> +}
> +
> +static int ads868x_reset(struct iio_dev *indio_dev)
> +{
> +	struct ads868x_state *st = iio_priv(indio_dev);
> +	unsigned int tmp;
> +
> +	tmp = ADS868X_CMD_REG(ADS868X_CMD_REG_RST);
> +	tmp <<= ADS868X_CMD_DONT_CARE_BITS;
> +	st->data[0].d32 = cpu_to_be32(tmp);
> +
> +	return spi_write(st->spi, &st->data[0].d8[0], 4);
> +}
> +
> +static int ads868x_read(struct iio_dev *indio_dev, unsigned int chan)
> +{
> +	struct ads868x_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int tmp;
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->data[0].d8[0],
> +			.len = 4,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = &st->data[1].d8[0],
> +			.rx_buf = &st->data[1].d8[0],
> +			.len = 4,
> +		},
> +	};
> +
> +	tmp = ADS868X_CMD_REG(ADS868X_CMD_REG_MAN_CH(chan));
> +	tmp <<= ADS868X_CMD_DONT_CARE_BITS;
> +	st->data[0].d32 = cpu_to_be32(tmp);
> +
> +	tmp = ADS868X_CMD_REG(ADS868X_CMD_REG_NOOP);
> +	tmp <<= ADS868X_CMD_DONT_CARE_BITS;
> +	st->data[1].d32 = cpu_to_be32(tmp);
> +
> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	return be32_to_cpu(st->data[1].d32) & 0xffff;
> +}
> +
> +static int ads868x_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long m)
> +{
> +	int ret, offset, i;
> +	unsigned long scale_mv;
> +
> +	struct ads868x_state *st = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&indio_dev->mlock);
> +		ret = ads868x_read(indio_dev, chan->channel);
> +		mutex_unlock(&indio_dev->mlock);
> +		if (ret < 0)
> +			return ret;
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		scale_mv = st->vref_mv;
> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++) {
> +			if (st->range[chan->channel] == ads868x_range_def[i].range)
> +				scale_mv *= ads868x_range_def[i].scale;
> +		}
> +		*val = 0;
> +		*val2 = scale_mv;
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++) {
> +			if (st->range[chan->channel] == ads868x_range_def[i].range)
> +				offset = ads868x_range_def[i].offset;
> +		}
> +		*val = offset;
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ads868x_write_reg_range(struct iio_dev *indio_dev,
> +				   struct iio_chan_spec const *chan,
> +				   enum ads868x_range range)
> +{
> +	unsigned int tmp;
> +	int ret;
> +
> +	tmp = ADS868X_PROG_REG_RANGE_CH(chan->channel);
> +	mutex_lock(&indio_dev->mlock);
> +	ret = ads868x_prog_write(indio_dev, tmp, range);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	return ret;
> +}
> +
> +static int ads868x_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ads868x_state *st = iio_priv(indio_dev);
> +	unsigned int scale = 0;
> +	int ret = -EINVAL, i, offset = 0;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
> +			if (st->range[chan->channel] ==
> +			    ads868x_range_def[i].range) {
> +				offset = ads868x_range_def[i].offset;
> +				if (offset == 0 &&
> +				    val2 == ads868x_range_def[0].scale *
> +				    st->vref_mv / 1000)
> +					return ret;
> +				break;
> +			}
> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
> +			if (val2 ==
> +			    ads868x_range_def[i].scale * st->vref_mv / 1000 &&
> +			    offset == ads868x_range_def[i].offset) {
> +				ret = ads868x_write_reg_range(indio_dev, chan,
> +					ads868x_range_def[i].range);
> +			}
> +		break;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (!(ads868x_range_def[0].offset == val ||
> +		    ads868x_range_def[3].offset == val))
> +			return ret;
> +		if (0 == val &&
> +		    st->range[chan->channel] == ADS868X_PLUSMINUS25VREF)
> +			return ret;
> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
> +			if (st->range[chan->channel] ==
> +			    ads868x_range_def[i].range)
> +				scale = ads868x_range_def[i].scale;
> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
> +			if (val == ads868x_range_def[i].offset &&
> +			    scale == ads868x_range_def[i].scale) {
> +				ret = ads868x_write_reg_range(indio_dev, chan,
> +					ads868x_range_def[i].range);
> +			}
> +		break;
> +	default:
> +		ret = -EINVAL;

ret already is -EINVAL

> +	}
> +
> +	if (!ret)
> +		st->range[chan->channel] = ads868x_range_def[i].range;
> +
> +	return ret;
> +}
> +
> +static const struct iio_info ads868x_info = {
> +	.read_raw = &ads868x_read_raw,
> +	.write_raw = &ads868x_write_raw,
> +	.attrs = &ads868x_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static const struct ads868x_chip_info ads868x_chip_info_tbl[] = {
> +	[ID_ADS8684] = {
> +		.channels = ads8684_channels,
> +		.num_channels = ARRAY_SIZE(ads8684_channels),
> +		.iio_info = &ads868x_info,
> +	},
> +	[ID_ADS8688] = {
> +		.channels = ads8688_channels,
> +		.num_channels = ARRAY_SIZE(ads8688_channels),
> +		.iio_info = &ads868x_info,
> +	},
> +};
> +
> +static int ads868x_probe(struct spi_device *spi)
> +{
> +	struct ads868x_state *st;
> +	struct iio_dev *indio_dev;
> +	bool ext_ref;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	if (spi->dev.of_node)
> +		ext_ref = of_property_read_bool(spi->dev.of_node,
> +						"vref-supply");
> +	else
> +		ext_ref = false;
> +
> +	if (ext_ref) {
> +		st->reg = devm_regulator_get(&spi->dev, "vref");
> +		if (!IS_ERR(st->reg)) {
> +			ret = regulator_enable(st->reg);
> +			if (ret)
> +				return ret;
> +
> +			ret = regulator_get_voltage(st->reg);
> +			if (ret < 0)
> +				goto error_out;
> +		st->vref_mv = ret / 1000;

indentation

> +		}
> +	} else {
> +		/* Use internal reference */
> +		st->vref_mv = ADS868X_VREF_MV;
> +	}
> +
> +	st->chip_info =	&ads868x_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> +
> +	spi->mode = SPI_MODE_1;
> +
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->spi = spi;
> +
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = st->chip_info->num_channels;
> +	indio_dev->info = st->chip_info->iio_info;
> +
> +	/* Reset ADS868x */

drop comment, pretty obvious what's going on next :)
locking is probably not needed in _probe()

> +	mutex_lock(&indio_dev->mlock);
> +	ads868x_reset(indio_dev);
> +	mutex_unlock(&indio_dev->mlock);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error_out;
> +
> +	return 0;
> +
> +error_out:
> +	if (!IS_ERR_OR_NULL(st->reg))
> +		regulator_disable(st->reg);
> +
> +	return ret;
> +}
> +
> +static int ads868x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ads868x_state *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +
> +	if (!IS_ERR_OR_NULL(st->reg))
> +		regulator_disable(st->reg);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id ads868x_id[] = {
> +	{"ads8684", ID_ADS8684},
> +	{"ads8688", ID_ADS8688},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ads868x_id);
> +
> +static const struct of_device_id ads868x_of_match[] = {
> +	{ .compatible = "ti,ads8684" },
> +	{ .compatible = "ti,ads8688" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ads868x_of_match);
> +
> +static struct spi_driver ads868x_driver = {
> +	.driver = {
> +		.name	= "ads868x",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= ads868x_probe,
> +	.remove		= ads868x_remove,
> +	.id_table	= ads868x_id,
> +};
> +module_spi_driver(ads868x_driver);
> +
> +MODULE_AUTHOR("Sean Nyekjaer <sean.nyekjaer@prevas.dk>");
> +MODULE_DESCRIPTION("Texas Instruments ADS868x driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
--324295856-1461148541-1443163955=:2707--
