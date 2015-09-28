Return-Path: <prvs=706c1e439=Sean.Nyekjaer@prevas.dk>
Subject: Re: [PATCHv2 1/2] iio: adc: Add TI ADS868X
To: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
References: <1443162580-28293-1-git-send-email-sean.nyekjaer@prevas.dk>
 <5607FF50.9070207@kernel.org>
CC: <devicetree@vger.kernel.org>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <56096A51.7020803@prevas.dk>
Date: Mon, 28 Sep 2015 18:26:57 +0200
MIME-Version: 1.0
In-Reply-To: <5607FF50.9070207@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi

Just to clear thing up :-)

All the mess in the write_raw functions are from the allowed scales.
if you are in ±0.625×Vref mode you are not allowed set an offset value of 0.

INPUT RANGE POSITIVE FULL SCALE NEGATIVE FULL SCALE FULL-SCALE RANGE
±2.5 × V REF 10.24 V –10.24 V 20.48 V
±1.25 × V REF 5.12 V –5.12 V 10.24 V
±0.625 × V REF 2.56 V –2.56 V 5.12 V
0 to 2.5 × V REF 10.24 V 0V 10.24 V
0 to 1.25 × V REF 5.12 V 0V 5.12 V

I will update the driver with your comments :-)

/Sean

On 2015-09-27 16:38, Jonathan Cameron wrote:
> On 25/09/15 07:29, Sean Nyekjaer wrote:
>> This patch adds support for the Texas Intruments ADS868x ADC.
>>
>> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
>> Reviewed-by: Martin Hundebøll <martin.hundeboll@prevas.dk>
> Hi
>
> The driver is fundamentally good, but I think a few small changes would make
> it less complex to read which is always a good thing!
>
> Comments inline.
>
> Jonathan
>> ---
>> Changes since v1:
>> - Now possible to read and write the actual offset and scale values
>> - Removed unused includes
>> - Removed unused buffer references
>>
>>   drivers/iio/adc/Kconfig      |  10 +
>>   drivers/iio/adc/Makefile     |   1 +
>>   drivers/iio/adc/ti-ads868x.c | 456 +++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 467 insertions(+)
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
>> index 0000000..66d9b64
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-ads868x.c
>> @@ -0,0 +1,456 @@
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
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/sysfs.h>
>> +
>> +#define ADS868X_CMD_REG(x)		(x << 8)
>> +#define ADS868X_CMD_REG_NOOP		0x00
>> +#define ADS868X_CMD_REG_RST		0x85
>> +#define ADS868X_CMD_REG_MAN_CH(chan)	(0xC0 | (4 * chan))
>> +#define ADS868X_CMD_DONT_CARE_BITS	16
>> +
>> +#define ADS868X_PROG_REG(x)		(x << 9)
>> +#define ADS868X_PROG_REG_RANGE_CH(chan)	(0x05 + chan)
>> +#define ADS868X_PROG_WR_BIT		BIT(8)
>> +#define ADS868X_PROG_DONT_CARE_BITS	8
>> +
>> +#define ADS868X_VREF_MV			4096
>> +#define ADS868X_REALBITS		16
>> +
>> +struct ads868x_chip_info {
>> +	unsigned int id;
>> +	const struct iio_chan_spec *channels;
>> +	unsigned int num_channels;
>> +	unsigned int flags;
> flags isn't used that I can see.
>> +	const struct iio_info *iio_info;
> Why bother? Right now you only have one iio_info structure for both
> supported parts.  Just use it directly and drop it form this structure.
>> +};
>> +
>> +struct ads868x_state {
>> +	const struct ads868x_chip_info	*chip_info;
>> +	struct spi_device		*spi;
>> +	struct regulator		*reg;
>> +	unsigned int			vref_mv;
> prefer u8 type to a char as it clearly isn't actually a character.
>
> See below for more detail, but I'd suggest having a contiguous enum to
> reference into the below ranges structure then store that in your
> device instance specific structure rather than these values.
> It avoids a fair bit of searching!  That would also change the type
> of this to be an array of enums rather than u8/chars.
>
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
>> +	ADS868X_PLUSMINUS25VREF		= 0x00,
>> +	ADS868X_PLUSMINUS125VREF	= 0x01,
>> +	ADS868X_PLUSMINUS0625VREF	= 0x02,
>> +	ADS868X_PLUS25VREF		= 0x05,
>> +	ADS868X_PLUS125VREF		= 0x06,
>> +};
>> +
>> +struct ads868x_ranges {
>> +	enum ads868x_range range;
>> +	unsigned int scale;
>> +	int offset;
>> +};
>> +
> const
>> +static struct ads868x_ranges ads868x_range_def[5] = {
>> +	{
>> +		.range = ADS868X_PLUSMINUS25VREF,
>> +		.scale = 76295,
>> +		.offset = -(1 << (ADS868X_REALBITS - 1)),
>> +	}, {
>> +		.range = ADS868X_PLUSMINUS125VREF,
>> +		.scale = 38148,
>> +		.offset = -(1 << (ADS868X_REALBITS - 1)),
>> +	}, {
>> +		.range = ADS868X_PLUSMINUS0625VREF,
>> +		.scale = 19074,
>> +		.offset = -(1 << (ADS868X_REALBITS - 1)),
>> +	}, {
>> +		.range = ADS868X_PLUS25VREF,
>> +		.scale = 38148,
>> +		.offset = 0,
>> +	}, {
>> +		.range = ADS868X_PLUS125VREF,
>> +		.scale = 19074,
>> +		.offset = 0,
>> +	}
>> +};
>> +
>> +static ssize_t ads868x_show_scales(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct ads868x_state *st = iio_priv(dev_to_iio_dev(dev));
>> +
>> +	return sprintf(buf, "0.%09u 0.%09u 0.%09u\n",
>> +		       ads868x_range_def[0].scale * st->vref_mv,
>> +		       ads868x_range_def[1].scale * st->vref_mv,
>> +		       ads868x_range_def[2].scale * st->vref_mv);
>> +}
>> +
>> +static ssize_t ads868x_show_offsets(struct device *dev,
>> +				    struct device_attribute *attr, char *buf)
>> +{
>> +	return sprintf(buf, "%d %d\n", ads868x_range_def[0].offset,
>> +		       ads868x_range_def[3].offset);
>> +}
>> +
>> +static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
>> +		       ads868x_show_scales, NULL, 0);
>> +static IIO_DEVICE_ATTR(in_voltage_offset_available, S_IRUGO,
>> +		       ads868x_show_offsets, NULL, 0);
>> +
>> +static struct attribute *ads868x_attributes[] = {
>> +	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
>> +	&iio_dev_attr_in_voltage_offset_available.dev_attr.attr,
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
>> +			      | BIT(IIO_CHAN_INFO_SCALE)	\
>> +			      | BIT(IIO_CHAN_INFO_OFFSET),	\
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
>> +	int ret, offset, i;
>> +	unsigned long scale_mv;
>> +
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
>> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++) {
> Having this lookup in several places seems overly complex.
>
> If there weren't gaps in the ads868x_range, I'd suggest just using
> that as an index, but clearly that's awkward here.
>
> Perhaps you just need to define a new enum which doesn't correspond
> directly to the register value and having a reg_value field in your
> indexed structure alongside range etc.
>
> That way your stored channel range enum entries will allow a direct
> lookup rather than searching on each read for the right entry.
>
>> +			if (st->range[chan->channel] == ads868x_range_def[i].range)
>> +				scale_mv *= ads868x_range_def[i].scale;
>> +		}
>> +		*val = 0;
>> +		*val2 = scale_mv;
>> +		return IIO_VAL_INT_PLUS_NANO;
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++) {
>> +			if (st->range[chan->channel] == ads868x_range_def[i].range)
>> +				offset = ads868x_range_def[i].offset;
>> +		}
>> +		*val = offset;
>> +		return IIO_VAL_INT;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int ads868x_write_reg_range(struct iio_dev *indio_dev,
>> +				   struct iio_chan_spec const *chan,
>> +				   enum ads868x_range range)
>> +{
>> +	unsigned int tmp;
>> +	int ret;
>> +
>> +	tmp = ADS868X_PROG_REG_RANGE_CH(chan->channel);
> Technically this lock is really meant to be device state changes (moving
> in and out of buffered mode for example) rather than use in drivers to
> protect bus accesses which is a much lower level.  It probably doesn't actually
> matter, but I'd prefer a locally defined lock for this.
>
>> +	mutex_lock(&indio_dev->mlock);
>> +	ret = ads868x_prog_write(indio_dev, tmp, range);
>> +	mutex_unlock(&indio_dev->mlock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int ads868x_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2, long mask)
>> +{
>> +	struct ads868x_state *st = iio_priv(indio_dev);
>> +	unsigned int scale = 0;
>> +	int ret = -EINVAL, i, offset = 0;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SCALE:
>> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
>> +			if (st->range[chan->channel] ==
>> +			    ads868x_range_def[i].range) {
>> +				offset = ads868x_range_def[i].offset;
>> +				if (offset == 0 &&
>> +				    val2 == ads868x_range_def[0].scale *
>> +				    st->vref_mv / 1000)
> Is this a nasty trick of mess to avoid having iio_val_int_plus nano
> on the write?  Just provide the callback write_raw_get_fmt and keep
> all your units the same across _avail, _read_raw and _write_raw.
>
>> +					return ret;
>> +				break;
>> +			}
>> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
>> +			if (val2 ==
>> +			    ads868x_range_def[i].scale * st->vref_mv / 1000 &&
>> +			    offset == ads868x_range_def[i].offset) {
>> +				ret = ads868x_write_reg_range(indio_dev, chan,
>> +					ads868x_range_def[i].range);
>> +			}
>> +		break;
>> +	case IIO_CHAN_INFO_OFFSET:
> The depth of nesting here is making this next block rather hard to read.
> I'd be tempted to try breaking it out to a utility function  thus dropping
> at least one level of indentation.
>
> A comment here to explain why only the two values are of interest.
> (clearly these are the only choiced, but it's not obvious without searching
> around for where they are defined).
>
>> +		if (!(ads868x_range_def[0].offset == val ||
>> +		    ads868x_range_def[3].offset == val))
>> +			return ret;
> return -EINVAL to make it obvious that we have an error here rather than
> an uninteresting good return path.
>
>> +		if (0 == val &&
>> +		    st->range[chan->channel] == ADS868X_PLUSMINUS25VREF)
>> +			return ret;
> same here.
> I'd also like a comment or two in here to help me understand what is happening.
> First check is about establishing if we have a valid range and picking the
> scale from that, the second about finding the right one to get the offset
> as well?  I can't see why these are separate or for that matter why you
> don't stop looking once a good answer has been found.
> Basically I'm confused :(
>
>
>> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
>> +			if (st->range[chan->channel] ==
>> +			    ads868x_range_def[i].range)
>> +				scale = ads868x_range_def[i].scale;
> Found a scale for the current range?
>> +		for (i = 0; i < ARRAY_SIZE(ads868x_range_def); i++)
>> +			if (val == ads868x_range_def[i].offset &&
>> +			    scale == ads868x_range_def[i].scale) {
> Found an offset compatible with the current scale and hence range?
> I'm clearly missing something here!
>> +				ret = ads868x_write_reg_range(indio_dev, chan,
>> +					ads868x_range_def[i].range);
>> +			}
>> +		break;
>> +	default:
>> +		ret = -EINVAL;
> return -EINVAL then you don't need the if (!ret) below.
>> +	}
>> +
>> +	if (!ret)
>> +		st->range[chan->channel] = ads868x_range_def[i].range;
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
> Could do this as
>          if (spi->dev.of_node && of_property_read_bool(spi->dev.of_node,
> 	                                              "vref-supply"))
>
> I'm not entirely sure it's a good idea even if it saves introducing
> a local variable. Up to you.
>> +	if (ext_ref) {
>> +		st->reg = devm_regulator_get(&spi->dev, "vref");
>> +		if (!IS_ERR(st->reg)) {
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
>> +	st->chip_info =	&ads868x_chip_info_tbl[spi_get_device_id(spi)->driver_data];
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
