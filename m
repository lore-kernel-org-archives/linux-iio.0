Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:14265 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbbIJHWk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 10 Sep 2015 03:22:40 -0400
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Subject: Re: [PATCH] Add support for the Texas Intruments ADS868x ADC.
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1441618498-17542-1-git-send-email-sean.nyekjaer@prevas.dk>
 <55F0897D.6040003@kernel.org>
Message-ID: <55F12FBD.1070300@prevas.dk>
Date: Thu, 10 Sep 2015 09:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <55F0897D.6040003@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan

Regarding ads868x_show_scales.
Yes it is register values, the challenge here is the [±1.25*vref, 
+2.5*vref] and [±0.625*VREF, +1.25*VREF] results in the same scaling 
values. How can we control this?

Sean

On 2015-09-09 21:33, Jonathan Cameron wrote:
> On 07/09/15 10:34, Sean Nyekjaer wrote:
> A comment here describing the device and the functionality supported by
> the driver would be good.
>
> Also, there are device tree bindings in here.  They should have
> accompanying documentation (cc'd to the device tree list).
>
> Various comments inline. Nothing particularly major, though be
> careful to obey the ABI and not use magic values in attributes.
>
> Jonathan
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>> Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>
>> ---
>>   drivers/iio/adc/Kconfig      |  10 ++
>>   drivers/iio/adc/Makefile     |   1 +
>>   drivers/iio/adc/ti-ads868x.c | 398 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 409 insertions(+)
>>   create mode 100644 drivers/iio/adc/ti-ads868x.c
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index deea62c..39924d5 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -322,6 +322,16 @@ config TI_ADC128S052
>>   	  This driver can also be built as a module. If so, the module will be
>>   	  called ti-adc128s052.
>>
>> +config TI_ADS868X
>> +	tristate "Texas Instruments ADS8684/8"
>> +	depends on SPI && OF
>> +	help
>> +	  If you say yes here you get support for Texas Instruments ADS8684 and
>> +	  and ADS8688 ADC chips
>> +
>> +	  This driver can also be built as a module. If so, the module will be
>> +	  called ti-ads868x.
>> +
>>   config TI_AM335X_ADC
>>   	tristate "TI's AM335X ADC driver"
>>   	depends on MFD_TI_AM335X_TSCADC
>> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> index fa5723a..75170d2 100644
>> --- a/drivers/iio/adc/Makefile
>> +++ b/drivers/iio/adc/Makefile
>> @@ -31,6 +31,7 @@ obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
>>   obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
>>   obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
>>   obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>> +obj-$(CONFIG_TI_ADS868X) += ti-ads868x.o
>>   obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
>>   obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
>>   obj-$(CONFIG_TWL6030_GPADC) += twl6030-gpadc.o
>> diff --git a/drivers/iio/adc/ti-ads868x.c b/drivers/iio/adc/ti-ads868x.c
>> new file mode 100644
>> index 0000000..368e22c
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-ads868x.c
>> @@ -0,0 +1,398 @@
>> +/*
>> + * Copyright (C) 2015 Prevas A/S
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/err.h>
>> +#include <linux/delay.h>
> Not used that I can immediately spot.
>
>> +#include <linux/module.h>
>> +#include <linux/interrupt.h>
> not used
>
>> +#include <linux/of.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/buffer.h>
> Not currently used.
>> +
>> +#define ADS868X_CMD_REG(x)		(x << 8)
>> +#define	ADS868X_CMD_REG_NOOP		0x00
>> +#define ADS868X_CMD_REG_RST		0x85
>> +#define ADS868X_CMD_REG_MAN_CH(chan)	(0xC0 | (4 * chan))
>> +#define ADS868X_CMD_DONT_CARE_BITS	16
>> +
>> +#define ADS868X_PROG_REG(x)		(x << 9)
>> +#define ADS868X_PROG_REG_RANGE_CH(chan)	(0x05 + chan)
>> +#define ADS868X_PROG_WR_BIT		(1 << 8)
> BIT Macro preferred.
>> +#define ADS868X_PROG_DONT_CARE_BITS	8
>> +
>> +#define ADS868X_VREF_MV			4096
>> +
>> +struct ads868x_chip_info {
>> +	unsigned int id;
>> +	const struct iio_chan_spec *channels;
>> +	unsigned int num_channels;
>> +	unsigned int flags;
>> +	const struct iio_info *iio_info;
>> +};
>> +
>> +struct ads868x_state {
>> +	const struct ads868x_chip_info	*chip_info;
>> +	struct spi_device		*spi;
>> +	struct regulator		*reg;
>> +	unsigned long			vref_mv;
>> +	char				range[8];
>> +	union {
>> +		__be32 d32;
>> +		u8 d8[4];
>> +	} data[2] ____cacheline_aligned;
>> +};
>> +
>> +enum ads868x_id {
>> +	ID_ADS8684,
>> +	ID_ADS8688,
>> +};
>> +
>> +enum ads868x_range {
>> +	ADS868X_PLUSMINUS25VREF		=	0x00,
>> +	ADS868X_PLUSMINUS125VREF	=	0x01,
>> +	ADS868X_PLUSMINUS0625VREF	=	0x02,
>> +	ADS868X_PLUS25VREF		=	0x05,
>> +	ADS868X_PLUS125VREF		=	0x06,
>> +};
>> +
>> +static const char ads868x_range_def[] = {
>> +	ADS868X_PLUSMINUS25VREF,
>> +	ADS868X_PLUSMINUS125VREF,
>> +	ADS868X_PLUSMINUS0625VREF,
>> +	ADS868X_PLUS25VREF,
>> +	ADS868X_PLUS125VREF,
>> +};
>> +
>> +static ssize_t ads868x_show_scales(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	int i, len = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
>> +		len += sprintf(buf + len, "%d ", ads868x_range_def[i]);
>> +
>> +	len += sprintf(buf + len, "\n");
> These values don't look like scales in appropriate units?  They
> look to be perhaps register values.
>
> Scale should be such that (raw_value + offset)*scale = real value
> as per the ABI in Documentation/ABI/testing/sysfs-bus-iio
>
>> +
>> +	return len;
>> +}
>> +
>> +static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
>> +		       ads868x_show_scales, NULL, 0);
>> +
>> +static struct attribute *ads868x_attributes[] = {
>> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group ads868x_attribute_group = {
>> +	.attrs = ads868x_attributes,
>> +};
>> +
>> +#define ADS868X_CHAN(index)					\
>> +{								\
>> +	.type = IIO_VOLTAGE,					\
>> +	.indexed = 1,						\
>> +	.channel = index,					\
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)		\
>> +			      | BIT(IIO_CHAN_INFO_SCALE),	\
> If address == channel then no point in setting it, use channel instead.
>> +	.address = index,					\
> No buffer support as yet so no need for everything below here.
>
>> +	.scan_index = index,					\
>> +	.scan_type = {						\
>> +		.sign = 'u',					\
>> +		.realbits = 16,					\
>> +		.storagebits = 16,				\
>> +		.endianness = IIO_BE,				\
>> +	},							\
>> +}
>> +
>> +static const struct iio_chan_spec ads8684_channels[] = {
>> +	ADS868X_CHAN(0),
>> +	ADS868X_CHAN(1),
>> +	ADS868X_CHAN(2),
>> +	ADS868X_CHAN(3),
>> +};
>> +
>> +static const struct iio_chan_spec ads8688_channels[] = {
>> +	ADS868X_CHAN(0),
>> +	ADS868X_CHAN(1),
>> +	ADS868X_CHAN(2),
>> +	ADS868X_CHAN(3),
>> +	ADS868X_CHAN(4),
>> +	ADS868X_CHAN(5),
>> +	ADS868X_CHAN(6),
>> +	ADS868X_CHAN(7),
>> +};
>> +
>> +static int ads868x_prog_write(struct iio_dev *indio_dev, unsigned int addr,
>> +			      unsigned int val)
>> +{
>> +	struct ads868x_state *st = iio_priv(indio_dev);
>> +	unsigned int tmp;
>> +
>> +	tmp = ADS868X_PROG_REG(addr) | ADS868X_PROG_WR_BIT | val;
>> +	tmp <<= ADS868X_PROG_DONT_CARE_BITS;
>> +	st->data[0].d32 = cpu_to_be32(tmp);
>> +
>> +	return spi_write(st->spi, &st->data[0].d8[1], 3);
>> +}
>> +
>> +static int ads868x_reset(struct iio_dev *indio_dev)
>> +{
>> +	struct ads868x_state *st = iio_priv(indio_dev);
>> +	unsigned int tmp;
>> +
>> +	tmp = ADS868X_CMD_REG(ADS868X_CMD_REG_RST);
>> +	tmp <<= ADS868X_CMD_DONT_CARE_BITS;
>> +	st->data[0].d32 = cpu_to_be32(tmp);
>> +
>> +	return spi_write(st->spi, &st->data[0].d8[0], 4);
>> +}
>> +
>> +static int ads868x_read(struct iio_dev *indio_dev, unsigned int chan)
>> +{
>> +	struct ads868x_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +	unsigned int tmp;
>> +	struct spi_transfer t[] = {
>> +		{
>> +			.tx_buf = &st->data[0].d8[0],
>> +			.len = 4,
>> +			.cs_change = 1,
>> +		}, {
>> +			.tx_buf = &st->data[1].d8[0],
>> +			.rx_buf = &st->data[1].d8[0],
>> +			.len = 4,
>> +		},
>> +	};
>> +
>> +	tmp = ADS868X_CMD_REG(ADS868X_CMD_REG_MAN_CH(chan));
>> +	tmp <<= ADS868X_CMD_DONT_CARE_BITS;
>> +	st->data[0].d32 = cpu_to_be32(tmp);
>> +
>> +	tmp = ADS868X_CMD_REG(ADS868X_CMD_REG_NOOP);
>> +	tmp <<= ADS868X_CMD_DONT_CARE_BITS;
>> +	st->data[1].d32 = cpu_to_be32(tmp);
>> +
>> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> Fiddly!  Ah well.
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return be32_to_cpu(st->data[1].d32) & 0xffff;
>> +}
>> +
>> +static int ads868x_read_raw(struct iio_dev *indio_dev,
>> +			    struct iio_chan_spec const *chan,
>> +			    int *val, int *val2, long m)
>> +{
>> +	int ret;
>> +	unsigned long scale_mv;
>> +	struct ads868x_state *st = iio_priv(indio_dev);
>> +
>> +	switch (m) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&indio_dev->mlock);
>> +		ret = ads868x_read(indio_dev, chan->channel);
>> +		mutex_unlock(&indio_dev->mlock);
>> +		if (ret < 0)
>> +			return ret;
>> +		*val = ret;
>> +		return IIO_VAL_INT;
>> +	case IIO_CHAN_INFO_SCALE:
>> +		scale_mv = st->vref_mv;
>> +		switch (st->range[chan->channel]) {
>> +		case ADS868X_PLUSMINUS25VREF:
>> +			scale_mv *= 5;
>> +			break;
>> +		case ADS868X_PLUSMINUS125VREF:
>> +		case ADS868X_PLUS25VREF:
>> +			scale_mv = scale_mv * 25 / 10;
>> +			break;
>> +		case ADS868X_PLUSMINUS0625VREF:
>> +		case ADS868X_PLUS125VREF:
>> +			scale_mv = scale_mv * 125 / 100;
>> +			break;
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +		*val = scale_mv;
>> +		*val2 = chan->scan_type.realbits;
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ads868x_write_raw(struct iio_dev *indio_dev,
>> +			struct iio_chan_spec const *chan,
>> +			int val, int val2, long mask)
>> +{
>> +	struct ads868x_state *st = iio_priv(indio_dev);
>> +	unsigned int tmp;
>> +	int ret, i;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		ret = -EINVAL;
>> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
>> +			if (val != ads868x_range_def[i])
>> +				continue;
> This logic is a bit flipped around to the more conventional loop
> and break with the error set by checking if we reached the end
> of the search range or not.  I think I'd slightly prefer the more
> conventional option.  Personally I prefer to see error cases
> as the 'exception' rather than set on the more natural flow through
> the code.
>
>> +
>> +			ret = 0;
>> +			st->range[chan->channel] = val;
>> +			mutex_lock(&indio_dev->mlock);
>> +			tmp = ADS868X_PROG_REG_RANGE_CH(chan->channel);
>> +			ads868x_prog_write(indio_dev, tmp, val);
> check for write errors.  Also the cached value should be set after
> the write has succeeded not before.
>
>> +			mutex_unlock(&indio_dev->mlock);
> mlock is really intended as a lock on the device operating mode, but
> I suppose using it for other things in a driver that doesn't
> handle device state changes (no buffer support) is fine if not
> as obvious as a local lock might be.
>
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct iio_info ads868x_info = {
>> +	.read_raw = &ads868x_read_raw,
>> +	.write_raw = &ads868x_write_raw,
>> +	.attrs = &ads868x_attribute_group,
>> +	.driver_module = THIS_MODULE,
>> +};
>> +
>> +static const struct ads868x_chip_info ads868x_chip_info_tbl[] = {
>> +	[ID_ADS8684] = {
>> +		.channels = ads8684_channels,
>> +		.num_channels = ARRAY_SIZE(ads8684_channels),
>> +		.iio_info = &ads868x_info,
>> +	},
>> +	[ID_ADS8688] = {
>> +		.channels = ads8688_channels,
>> +		.num_channels = ARRAY_SIZE(ads8688_channels),
>> +		.iio_info = &ads868x_info,
>> +	},
>> +};
>> +
>> +static int ads868x_probe(struct spi_device *spi)
>> +{
>> +	struct ads868x_state *st;
>> +	struct iio_dev *indio_dev;
>> +	bool ext_ref;
>> +	enum ads868x_id drv_id;
> I'm unconvinced this local drv_id adds anything in terms of readability.
> If it's just here to avoid overly long lines, note the checkpatch warning
> for that should be taken as a recomendation only!
>
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +	if (indio_dev == NULL)
>> +		return -ENOMEM;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	if (spi->dev.of_node)
>> +		ext_ref = of_property_read_bool(spi->dev.of_node,
>> +						"vref-supply");
>> +	else
>> +		ext_ref = false;
>> +
>> +	if (ext_ref) {
>> +		st->reg = devm_regulator_get(&spi->dev, "vref");
>> +		if (!IS_ERR_OR_NULL(st->reg)) {
> As far as I can see from a quick look at get_regulator docs
> (driver/regulator/core.c) which is called from the devm call
> the null condition cannot occur.  Hence IS_ERR is probably
> more appropriate (and more commonly used).
>
>> +			ret = regulator_enable(st->reg);
>> +			if (ret)
>> +				return ret;
>> +
>> +			ret = regulator_get_voltage(st->reg);
>> +			if (ret < 0)
>> +				goto error_out;
>> +		st->vref_mv = ret / 1000;
>> +		}
>> +	} else {
>> +		/* Use internal reference */
>> +		st->vref_mv = ADS868X_VREF_MV;
>> +	}
>> +
>> +	drv_id = spi_get_device_id(spi)->driver_data;
>> +	st->chip_info =	&ads868x_chip_info_tbl[drv_id];
>> +
>> +	spi->mode = SPI_MODE_1;
>> +
>> +	spi_set_drvdata(spi, indio_dev);
>> +
>> +	st->spi = spi;
>> +
>> +	indio_dev->name = spi_get_device_id(spi)->name;
>> +	indio_dev->dev.parent = &spi->dev;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->channels = st->chip_info->channels;
>> +	indio_dev->num_channels = st->chip_info->num_channels;
>> +	indio_dev->info = st->chip_info->iio_info;
>> +
>> +	/* Reset ADS868x */
>> +	mutex_lock(&indio_dev->mlock);
>> +	ads868x_reset(indio_dev);
>> +	mutex_unlock(&indio_dev->mlock);
>> +
>> +	ret = iio_device_register(indio_dev);
>> +	if (ret)
>> +		goto error_out;
>> +
>> +	return 0;
>> +
>> +error_out:
>> +	if (!IS_ERR_OR_NULL(st->reg))
>> +		regulator_disable(st->reg);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ads868x_remove(struct spi_device *spi)
>> +{
>> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +	struct ads868x_state *st = iio_priv(indio_dev);
>> +
>> +	iio_device_unregister(indio_dev);
>> +
>> +	if (!IS_ERR_OR_NULL(st->reg))
>> +		regulator_disable(st->reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct spi_device_id ads868x_id[] = {
>> +	{"ads8684", ID_ADS8684},
>> +	{"ads8688", ID_ADS8688},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(spi, ads868x_id);
>> +
>> +static const struct of_device_id ads868x_of_match[] = {
>> +	{ .compatible = "ti,ads8684" },
>> +	{ .compatible = "ti,ads8688" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ads868x_of_match);
>> +
>> +static struct spi_driver ads868x_driver = {
>> +	.driver = {
>> +		.name	= "ads868x",
>> +		.owner	= THIS_MODULE,
>> +	},
>> +	.probe		= ads868x_probe,
>> +	.remove		= ads868x_remove,
>> +	.id_table	= ads868x_id,
>> +};
>> +module_spi_driver(ads868x_driver);
>> +
>> +MODULE_AUTHOR("Sean Nyekjaer <sean.nyekjaer@prevas.dk>");
>> +MODULE_DESCRIPTION("Texas Instruments ADS868x driver");
>> +MODULE_LICENSE("GPL v2");
>>

