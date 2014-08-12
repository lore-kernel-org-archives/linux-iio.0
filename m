Return-Path: <knaack.h@gmx.de>
Message-ID: <53E9CF93.9040906@gmx.de>
Date: Tue, 12 Aug 2014 10:25:55 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: =?UTF-8?B?U8O4cmVuIEFuZGVyc2Vu?= <san@rosetechnology.dk>,
 jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [patch v2 2/3] iio: adc: mcp320x. Add support for more ADCs
References: <1407488350.6599.6.camel@sanws1.rosetechnology.dk> <53E94B00.5030304@gmx.de>
In-Reply-To: <53E94B00.5030304@gmx.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hartmut Knaack schrieb:
> Søren Andersen schrieb:
>> Signed-off-by: Soeren Andersen <san at rosetechnology.dk>
> Hi,
> the first patch of this series could have been merged in this one, as it depends on this patch. Therefore, the cleanup in this patch (which is not mentioned in the subject and giving git diff and the reviewer a harder time) would have better been in the first patch. Other comment in line.
>> ---
>>  drivers/iio/adc/mcp320x.c | 352
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
>>  1 file changed, 267 insertions(+), 85 deletions(-)
>>
>> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
>> index 28a086e..2871777 100644
>> --- a/drivers/iio/adc/mcp320x.c
>> +++ b/drivers/iio/adc/mcp320x.c
>> @@ -1,9 +1,22 @@
>>  /*
>>   * Copyright (C) 2013 Oskar Andero <oskar.andero@gmail.com>
>> + * Copyright (C) 2014 Allan Bendorff Jensen <abj@rosetechnology.dk>
>>   *
>> - * Driver for Microchip Technology's MCP3204 and MCP3208 ADC chips.
>> + * Driver for following ADC chips from Microchip Technology's:
>> + * 10 Bit converter
>> + * MCP3001
>> + * MCP3002
>> + * MCP3004
>> + * MCP3008
>> + * ------------
>> + * 12 bit converter
>> + * MCP3201
>> + * MCP3202
>> + * MCP3204
>> + * MCP3208
>> + * ------------
>>   * Datasheet can be found here:
>> - * http://ww1.microchip.com/downloads/en/devicedoc/21298c.pdf
>> + * http://www.microchip.com/
> I would prefer to have URLs provided for all datasheets here, instead of having to search through that website.
>>   *
>>   * This program is free software; you can redistribute it and/or modify
>>   * it under the terms of the GNU General Public License version 2 as
>> @@ -16,10 +29,17 @@
>>  #include <linux/iio/iio.h>
>>  #include <linux/regulator/consumer.h>
>>  
>> -#define MCP_SINGLE_ENDED	(1 << 3)
>> -#define MCP_START_BIT		(1 << 4)
>> +static int mcp320x_read_raw(struct iio_dev *indio_dev,
>> +			struct iio_chan_spec const *channel, int *val,
>> +			int *val2, long mask);
> Did I miss something, or is this function declaration unnecessary?
>>  
>>  enum {
>> +	mcp3001,
>> +	mcp3002,
>> +	mcp3004,
>> +	mcp3008,
>> +	mcp3201,
>> +	mcp3202,
>>  	mcp3204,
>>  	mcp3208,
>>  };
>> @@ -36,86 +56,37 @@ struct mcp320x {
>>  	struct mutex lock;
>>  };
>>  
>> -static int mcp320x_adc_conversion(struct mcp320x *adc, u8 msg)
>> -{
>> -	int ret;
>> -
>> -	adc->tx_buf =sg;
>> -	ret =pi_sync(adc->spi, &adc->msg);
>> -	if (ret < 0)
>> -		return ret;
>> -
>> -	return ((adc->rx_buf[0] & 0x3f) << 6)  |
>> -		(adc->rx_buf[1] >> 2);
>> -}
>> -
>> -static int mcp320x_read_raw(struct iio_dev *indio_dev,
>> -			    struct iio_chan_spec const *channel, int *val,
>> -			    int *val2, long mask)
>> -{
>> -	struct mcp320x *adc =io_priv(indio_dev);
>> -	int ret =EINVAL;
>> -
>> -	mutex_lock(&adc->lock);
>> -
>> -	switch (mask) {
>> -	case IIO_CHAN_INFO_RAW:
>> -		if (channel->differential)
>> -			ret =cp320x_adc_conversion(adc,
>> -				MCP_START_BIT | channel->address);
>> -		else
>> -			ret =cp320x_adc_conversion(adc,
>> -				MCP_START_BIT | MCP_SINGLE_ENDED |
>> -				channel->address);
>> -		if (ret < 0)
>> -			goto out;
>> -
>> -		*val =et;
>> -		ret =IO_VAL_INT;
>> -		break;
>> -
>> -	case IIO_CHAN_INFO_SCALE:
>> -		/* Digital output code =4096 * Vin) / Vref */
>> -		ret =egulator_get_voltage(adc->reg);
>> -		if (ret < 0)
>> -			goto out;
>> -
>> -		*val =et / 1000;
>> -		*val2 =2;
>> -		ret =IO_VAL_FRACTIONAL_LOG2;
>> -		break;
>> -
>> -	default:
>> -		break;
>> +#define MCP320X_VOLTAGE_CHANNEL(num)					\
>> +	{								\
>> +		.type =IO_VOLTAGE,					\
>> +		.indexed =,						\
>> +		.channel =num),					\
>> +		.address =num),					\
>> +		.info_mask_separate =IT(IIO_CHAN_INFO_RAW),		\
>> +		.info_mask_shared_by_type =IT(IIO_CHAN_INFO_SCALE)	\
>>  	}
>>  
>> -out:
>> -	mutex_unlock(&adc->lock);
>> -
>> -	return ret;
>> -}
>> -
>> -#define MCP320X_VOLTAGE_CHANNEL(num)				\
>> -	{							\
>> -		.type =IO_VOLTAGE,				\
>> -		.indexed =,					\
>> -		.channel =num),				\
>> -		.address =num),				\
>> -		.info_mask_separate =IT(IIO_CHAN_INFO_RAW),	\
>> -		.info_mask_shared_by_type =IT(IIO_CHAN_INFO_SCALE) \
>> +#define MCP320X_VOLTAGE_CHANNEL_DIFF(num)				\
>> +	{								\
>> +		.type =IO_VOLTAGE,					\
>> +		.indexed =,						\
>> +		.channel =num * 2),					\
>> +		.channel2 =num * 2 + 1),				\
>> +		.address =num * 2),					\
>> +		.differential =,					\
>> +		.info_mask_separate =IT(IIO_CHAN_INFO_RAW),		\
>> +		.info_mask_shared_by_type =IT(IIO_CHAN_INFO_SCALE)	\
>>  	}
>>  
>> -#define MCP320X_VOLTAGE_CHANNEL_DIFF(num)			\
>> -	{							\
>> -		.type =IO_VOLTAGE,				\
>> -		.indexed =,					\
>> -		.channel =num * 2),				\
>> -		.channel2 =num * 2 + 1),			\
>> -		.address =num * 2),				\
>> -		.differential =,				\
>> -		.info_mask_separate =IT(IIO_CHAN_INFO_RAW),	\
>> -		.info_mask_shared_by_type =IT(IIO_CHAN_INFO_SCALE) \
>> -	}
> These cleanups should have been separated.
>> +static const struct iio_chan_spec mcp3201_channels[] =
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
>> +};
>> +
>> +static const struct iio_chan_spec mcp3202_channels[] =
>> +	MCP320X_VOLTAGE_CHANNEL(0),
>> +	MCP320X_VOLTAGE_CHANNEL(1),
>> +	MCP320X_VOLTAGE_CHANNEL_DIFF(0),
>> +};
>>  
>>  static const struct iio_chan_spec mcp3204_channels[] =
>>  	MCP320X_VOLTAGE_CHANNEL(0),
>> @@ -146,12 +117,37 @@ static const struct iio_info mcp320x_info =
>>  	.driver_module = HIS_MODULE,
>>  };
>>  
>> -struct mcp3208_chip_info {
>> +struct mcp320x_chip_info {
>>  	const struct iio_chan_spec *channels;
>>  	unsigned int num_channels;
>> +	unsigned int resolution;
> resolution is still unused, but would make a lot of sense to be used in mcp320x_read_raw.
>>  };
>>  
>> -static const struct mcp3208_chip_info mcp3208_chip_infos[] =
>> +static const struct mcp320x_chip_info mcp320x_chip_infos[] = 
>> +	[mcp3001] = 
>> +		.channels = cp3201_channels,
>> +		.num_channels =RRAY_SIZE(mcp3201_channels)
>> +	},
>> +	[mcp3002] =
>> +		.channels = cp3202_channels,
>> +		.num_channels =RRAY_SIZE(mcp3202_channels)
>> +	},
>> +	[mcp3004] =
>> +		.channels = cp3204_channels,
>> +		.num_channels =RRAY_SIZE(mcp3204_channels)
>> +	},
>> +	[mcp3008] =
>> +		.channels = cp3208_channels,
>> +		.num_channels =RRAY_SIZE(mcp3208_channels)
>> +	},
>> +	[mcp3201] =
>> +		.channels = cp3201_channels,
>> +		.num_channels =RRAY_SIZE(mcp3201_channels)
>> +	},
>> +	[mcp3202] =
>> +		.channels = cp3202_channels,
>> +		.num_channels =RRAY_SIZE(mcp3202_channels)
>> +	},
>>  	[mcp3204] =
>>  		.channels = cp3204_channels,
>>  		.num_channels =RRAY_SIZE(mcp3204_channels)
>> @@ -162,11 +158,159 @@ static const struct mcp3208_chip_info
>> mcp3208_chip_infos[] =
>>  	},
>>  };
>>  
>> +static int channel_to_tx_data(const struct mcp320x_chip_info
>> *chip_info,
>> +			const unsigned int channel, bool differential)
> The function name should be prefixed with mcp320x_, also parameters should be indented with opening parenthesis.
>> +{
>> +	unsigned int tx_data =;
>> +
>> +	if (chip_info->num_channels - 1 =2) {
> I think comparing with ARRAY_SIZE(mcp3202_channels) would be way easier to read/understand (similar below).
>> +		tx_data =x12 | (differential ? 0 << 3 : 1 << 3) |
>> +				((channel & 0x01) << 2);
>> +	} else if (chip_info->num_channels - 2 =4) {
>> +		tx_data =x20 | (differential ? 0 << 4 : 1 << 4) |
>> +				((channel & 0x03) << 1);
>> +	} else if (chip_info->num_channels - 4 =8) {
>> +		tx_data =x20 | (differential ? 0 << 4 : 1 << 4) |
>> +				((channel & 0x07) << 1);
>> +	}
One more thing: since diffential is of type bool, you can just shift its value into the right position, like ... | (differential << 3) | ...
> If you shift tx_data one bit to the left on devices with 4 or 8 channels here, you will get the same alignment of rx_buf as for the 2 channel devices. This way you would just have to distinguish in mcp320x_read_raw between 1 channel 10 bit, more channels 10 bit, 1 channel 12 bit and more channels 12 bit.
>> +
>> +	return tx_data;
>> +}
>> +
>> +static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>> +			bool differential, int device_index)
> Better indentation of the arguments^^
>> +{
>> +	int ret;
>> +	u16 adc_value;
> You can easily drop adc_value, see below.
>> +	__be16 buf;
>> +
>> +	const struct mcp320x_chip_info *chip_info =ULL;
>> +
>> +	if (device_index =-1)
>> +		return -1;
> Better return a valid error code, like -EINVAL?
>> +
>> +	chip_info =mcp320x_chip_infos[device_index];
>> +	if (chip_info =NULL)
>> +		return -1;
> Also better error code?
>> +
>> +	adc->rx_buf[0] =;
>> +	adc->rx_buf[1] =;
>> +	adc->tx_buf =hannel_to_tx_data(chip_info, channel, differential);
>> +
>> +	if (device_index !=cp3001 && device_index != mcp3201) {
>> +		ret =pi_sync(adc->spi, &adc->msg);
>> +		if (ret < 0)
>> +			return ret;
>> +	} else {
>> +		ret =pi_read(adc->spi, (u8 *)&buf, 2);
>> +		if (ret < 0)
>> +			return ret;
>> +	}
>> +
>> +	switch (device_index) {
>> +	case mcp3001:
>> +		adc_value =be16_to_cpu(buf) >> 3);
> According to the datasheet, the 2 MSBs are unspecified and should be masked out: & 0x3ff
>> +		break;
>> +	case mcp3002:
> When preparing the tx_buf like mentioned above, you could add mcp3004 and mcp3008 here, and drop the section below.
>> +		spi_sync(adc->spi, &adc->msg);
> I think this spi_sync is unnecessary.
>> +		adc_value =dc->rx_buf[0];
>> +		adc_value =(adc_value << 2) |
>> +			((adc->rx_buf[1] & 0xC0) >> 6)) & 0x03ff;
> return (adc->rx_buf[0] << 2) | (adc->rx_buf[1] >> 6); should do the job.
>> +		break;
>> +	case mcp3004:
>> +	case mcp3008:
>> +		adc_value =dc->rx_buf[0] & 0x7f;
>> +		adc_value =(adc_value << 3) |
>> +			((adc->rx_buf[1] & 0xe0) >> 5)) & 0x03ff;
> Same as above.
>> +		break;
>> +	case mcp3201:
>> +		adc_value =be16_to_cpu(buf) >> 1);
> Same as above, mask with 0xfff.
>> +		break;
>> +	case mcp3202:
>> +		adc_value =dc->rx_buf[0];
>> +		adc_value =(adc_value << 4) |
>> +			((adc->rx_buf[1] & 0xf0) >> 4)) & 0x0fff;
> Same as above, no masking necessary.
>> +		break;
>> +	case mcp3204:
>> +	case mcp3208:
>> +		adc_value =dc->rx_buf[0] & 0x7f;
>> +		adc_value =(adc_value << 5) |
>> +			((adc->rx_buf[1] & 0xf8) >> 3)) & 0x0fff;
> Same here, as well.
>> +		break;
>> +	default:
>> +		adc_value =;
>> +		break;
> Just return an appropriate error code, like -EINVAL?
>> +	}
>> +
>> +	return adc_value;
>> +}
>> +
>> +static int mcp320x_read_raw(struct iio_dev *indio_dev,
>> +			struct iio_chan_spec const *channel, int *val,
>> +			int *val2, long mask)
> Should be better indented.
>> +{
>> +	struct mcp320x *adc =io_priv(indio_dev);
>> +	int ret =EINVAL;
>> +	int device_index =;
>> +
>> +	mutex_lock(&adc->lock);
>> +
>> +	device_index =pi_get_device_id(adc->spi)->driver_data;
>> +
>> +	if (device_index =-1)
>> +		goto out;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		ret =cp320x_adc_conversion(adc, channel->address,
>> +			channel->differential, device_index);
> Better indention here.
>> +
>> +		if (ret < 0)
>> +			goto out;
>> +
>> +		*val =et;
>> +		ret =IO_VAL_INT;
>> +		break;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
> This section contains quite verbose comments for very basic things - are they necessary?
>> +		/*
>> +		 * Digital output code =resolution * Vin) / Vref
>> +		 * Get regulator output voltage in uV.
>> +		 */
>> +		ret =egulator_get_voltage(adc->reg);
>> +		if (ret < 0)
>> +			goto out;
>> +
>> +		/* convert regulator output voltage to mV */
>> +		*val  =et / 1000;
>> +		*val2 =1;
> I don't see the need to set a value for *val2 here.
>> +		if (device_index =mcp3001 || device_index == mcp3002 ||
>> +			device_index =mcp3004 || device_index == mcp3008)
>> +			*val2 =0;
> Actually, the resolution attribute from chip_info should be used here.
>> +		else if (device_index =mcp3201 || device_index == mcp3202 ||
>> +			device_index =mcp3204 || device_index == mcp3208)
>> +			*val2 =2;
>> +		else
>> +			goto out;
>> +
>> +		ret =IO_VAL_FRACTIONAL_LOG2;
>> +		break;
> This break is not really needed, as long as the default section doesn't contain operational code.
>> +
>> +	default:
>> +		break;
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&adc->lock);
>> +
>> +	return ret;
>> +}
>> +
>>  static int mcp320x_probe(struct spi_device *spi)
>>  {
>>  	struct iio_dev *indio_dev;
>>  	struct mcp320x *adc;
>> -	const struct mcp3208_chip_info *chip_info;
>> +	const struct mcp320x_chip_info *chip_info;
>>  	int ret;
>>  
>>  	indio_dev =evm_iio_device_alloc(&spi->dev, sizeof(*adc));
>> @@ -181,7 +325,7 @@ static int mcp320x_probe(struct spi_device *spi)
>>  	indio_dev->modes =NDIO_DIRECT_MODE;
>>  	indio_dev->info =mcp320x_info;
>>  
>> -	chip_info =mcp3208_chip_infos[spi_get_device_id(spi)->driver_data];
>> +	chip_info =mcp320x_chip_infos[spi_get_device_id(spi)->driver_data];
>>  	indio_dev->channels =hip_info->channels;
>>  	indio_dev->num_channels =hip_info->num_channels;
>>  
>> @@ -226,7 +370,45 @@ static int mcp320x_remove(struct spi_device *spi)
>>  	return 0;
>>  }
>>  
>> +#if defined(CONFIG_OF)
>> +static const struct of_device_id mcp320x_dt_ids[] =
>> +	{
>> +		.compatible =mcp3001",
>> +		.data =mcp320x_chip_infos[mcp3001],
>> +	}, {
>> +		.compatible =mcp3002",
>> +		.data =mcp320x_chip_infos[mcp3002],
>> +	}, {
>> +		.compatible =mcp3004",
>> +		.data =mcp320x_chip_infos[mcp3004],
>> +	}, {
>> +		.compatible =mcp3008",
>> +		.data =mcp320x_chip_infos[mcp3004],
> I think you meant mcp3008.
>> +	}, {
>> +		.compatible =mcp3201",
>> +		.data =mcp320x_chip_infos[mcp3201],
>> +	}, {
>> +		.compatible =mcp3202",
>> +		.data =mcp320x_chip_infos[mcp3202],
>> +	}, {
>> +		.compatible =mcp3204",
>> +		.data =mcp320x_chip_infos[mcp3204],
>> +	}, {
>> +		.compatible =mcp3008",
> This should be mcp3208.
>> +		.data =mcp320x_chip_infos[mcp3208],
>> +	}, {
>> +	}
>> +};
>> +MODULE_DEVICE_TABLE(of, mcp320x_dt_ids);
>> +#endif
>> +
>>  static const struct spi_device_id mcp320x_id[] =
>> +	{ "mcp3001", mcp3001 },
>> +	{ "mcp3002", mcp3002 },
>> +	{ "mcp3004", mcp3004 },
>> +	{ "mcp3008", mcp3008 },
>> +	{ "mcp3201", mcp3201 },
>> +	{ "mcp3202", mcp3202 },
>>  	{ "mcp3204", mcp3204 },
>>  	{ "mcp3208", mcp3208 },
>>  	{ }
>> @@ -245,5 +427,5 @@ static struct spi_driver mcp320x_driver =
>>  module_spi_driver(mcp320x_driver);
>>  
>>  MODULE_AUTHOR("Oskar Andero <oskar.andero@gmail.com>");
>> -MODULE_DESCRIPTION("Microchip Technology MCP3204/08");
>> +MODULE_DESCRIPTION("Microchip Technology MCP3x01/02/04/08");
>>  MODULE_LICENSE("GPL v2");
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
