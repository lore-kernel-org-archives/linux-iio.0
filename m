Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42906 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934401AbdAHJsT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:48:19 -0500
Subject: Re: [PATCH 03/22] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-4-quentin.schulz@free-electrons.com>
 <alpine.DEB.2.02.1701021906450.18919@pmeerw.net>
 <6c683088-1866-c372-d285-9f681c916971@free-electrons.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <eca48969-64dd-e032-7646-7d9d8183d41c@kernel.org>
Date: Sat, 7 Jan 2017 14:06:59 -0500
MIME-Version: 1.0
In-Reply-To: <6c683088-1866-c372-d285-9f681c916971@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/01/17 03:16, Quentin Schulz wrote:
> Hi Peter,
> 
> On 02/01/2017 19:37, Peter Meerwald-Stadler wrote:
>> On Mon, 2 Jan 2017, Quentin Schulz wrote:
>>
> [...]
>>> +#define AXP20X_ADC_RATE_MASK			(3 << 6)
>>
>> could use GENMASK()?
>>
>>> +#define AXP20X_ADC_RATE_25HZ			(0 << 6)
>>> +#define AXP20X_ADC_RATE_50HZ			BIT(6)
>>
>> BIT() doesn't really make sense here
>>
>>> +#define AXP20X_ADC_RATE_100HZ			(2 << 6)
>>> +#define AXP20X_ADC_RATE_200HZ			(3 << 6)
>>> +
>>> +#define AXP22X_ADC_RATE_100HZ			(0 << 6)
>>> +#define AXP22X_ADC_RATE_200HZ			BIT(6)
>>
>> BIT() doesn't really make sense here
>>
> 
> ACK.
> 
>>> +#define AXP22X_ADC_RATE_400HZ			(2 << 6)
>>> +#define AXP22X_ADC_RATE_800HZ			(3 << 6)
>>> +
>>> +#define AXP20X_ADC_CHANNEL(_channel, _name, _type, _reg)	\
>>> +	{							\
>>> +		.type = _type,					\
>>> +		.indexed = 1,					\
>>> +		.channel = _channel,				\
>>> +		.address = _reg,				\
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>>> +				      BIT(IIO_CHAN_INFO_SCALE),	\
>>> +		.datasheet_name = _name,			\
>>> +	}
>>> +
>>> +#define AXP20X_ADC_CHANNEL_OFFSET(_channel, _name, _type, _reg) \
>>> +	{							\
>>> +		.type = _type,					\
>>> +		.indexed = 1,					\
>>> +		.channel = _channel,				\
>>> +		.address = _reg,				\
>>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>>> +				      BIT(IIO_CHAN_INFO_SCALE) |\
>>> +				      BIT(IIO_CHAN_INFO_OFFSET),\
>>> +		.datasheet_name = _name,			\
>>> +	}
>>> +
>>> +struct axp20x_adc_iio {
>>> +	struct iio_dev		*indio_dev;
>>> +	struct regmap		*regmap;
>>> +};
>>> +
>>> +enum axp20x_adc_channel {
>>> +	AXP20X_ACIN_V = 0,
>>> +	AXP20X_ACIN_I,
>>> +	AXP20X_VBUS_V,
>>> +	AXP20X_VBUS_I,
>>> +	AXP20X_TEMP_ADC,
>>> +	AXP20X_GPIO0_V,
>>> +	AXP20X_GPIO1_V,
>>> +	AXP20X_BATT_V,
>>> +	AXP20X_BATT_CHRG_I,
>>> +	AXP20X_BATT_DISCHRG_I,
>>> +	AXP20X_IPSOUT_V,
>>> +};
>>> +
>>> +enum axp22x_adc_channel {
>>> +	AXP22X_TEMP_ADC = 0,
>>> +	AXP22X_BATT_V,
>>> +	AXP22X_BATT_CHRG_I,
>>> +	AXP22X_BATT_DISCHRG_I,
>>> +};
>>> +
>>> +static const struct iio_chan_spec axp20x_adc_channels[] = {
>>
>> not sure if the channel indexing works out as expected;
>> axp20x_adc_channel/axp22x_adc_channel enumerate over all channels, but 
>> here we want to enumerate channels per type I think
>>
>> e.g. you have 6 IIO_VOLTAGE channels, they should have indices 0 to 5;
>> there is one IIO_TEMP channels, it should not be indexed or have index 0 
>>
> 
> Make sense, I'll just have to create enum for each type and have a call
> to different functions in read_raw depending on the requested channel
> type. ACK.
> 
> [...]
>>> +static int axp20x_adc_read_raw(struct iio_dev *indio_dev,
>>> +			       struct iio_chan_spec const *channel, int *val,
>>> +			       int *val2)
>>> +{
>>> +	struct axp20x_adc_iio *info = iio_priv(indio_dev);
>>> +	int size = 12, ret;
>>> +
>>> +	switch (channel->channel) {
>>> +	case AXP20X_BATT_DISCHRG_I:
>>> +		size = 13;
>>> +	case AXP20X_ACIN_V:
>>> +	case AXP20X_ACIN_I:
>>> +	case AXP20X_VBUS_V:
>>> +	case AXP20X_VBUS_I:
>>> +	case AXP20X_TEMP_ADC:
>>> +	case AXP20X_BATT_V:
>>> +	case AXP20X_BATT_CHRG_I:
>>> +	case AXP20X_IPSOUT_V:
>>> +	case AXP20X_GPIO0_V:
>>> +	case AXP20X_GPIO1_V:
>>> +		ret = axp20x_read_variable_width(info->regmap, channel->address,
>>> +						 size);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		*val = ret;
>>> +		return IIO_VAL_INT;
>>> +
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return -EINVAL;
>>
>> dead code? here and elsewhere
>>
> 
> Indeed. Will be removed.
> 
> [...]
>>> +
>>> +		/* Configure ADCs rate */
>>> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
>>> +				   AXP20X_ADC_RATE_MASK, AXP20X_ADC_RATE_50HZ);
>>
>> 100Hz would be a common rate for AXP209 and AXP221
>>
> 
> ACK.
> 
>>> +		break;
>>> +
>>> +	case AXP221_ID:
>>> +		indio_dev->info = &axp22x_adc_iio_info;
>>> +		indio_dev->num_channels = ARRAY_SIZE(axp22x_adc_channels);
>>> +		indio_dev->channels = axp22x_adc_channels;
>>> +
>>> +		/* Enable the ADCs on IP */
>>> +		regmap_write(info->regmap, AXP20X_ADC_EN1, AXP22X_ADC_EN1_MASK);
>>> +
>>> +		/* Configure ADCs rate */
>>> +		regmap_update_bits(info->regmap, AXP20X_ADC_RATE,
>>> +				   AXP20X_ADC_RATE_MASK, AXP22X_ADC_RATE_200HZ);
>>> +		break;
>>> +
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
>>
>> if you need a _remove() -- which you do -- you must not use 
>> devm_iio_device_register()
>>
> 
> ACK. On the same topic, what about the devm_iio_device_alloc at the very
> beginning of the probe function?
That one is fine.  Key thing is that any devm stuff occurs after remove.  So to keep
the remove order the opposite of probe you are fine until you first have a step that needs
reversing that isn't via a managed interface.

In this case the upshot is you disable the hardware slightly before you remove the
userspace interface to access it.
> 
>>> +	if (ret < 0) {
>>> +		dev_err(&pdev->dev, "could not register the device\n");
>>> +		regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>>> +		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>>
>> EN2 is not enabled for AXP221 above?
> 
> No. EN2 controls GPIO0/1 and internal temperature ADCs status and those
> ADCs are not supported in the AXP22X variants. The EN2 register is
> simply not existing in AXP22X documentation, I'll add an if condition on
> info->axp_id for resetting EN2 register.
> 
>> strictly, only certain EN2 bits are set for AXP209 -- here and in 
>> _remove()
>>
> 
> Yes. EN2 register has only bits for controlling GPIO 0/1 and internal
> temperature ADCs status, so setting all bits to zero is fine I guess.
> 
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int axp20x_remove(struct platform_device *pdev)
>>> +{
>>> +	struct axp20x_adc_iio *info;
>>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>> +	info = iio_priv(indio_dev);
>>> +
>>> +	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>>> +	regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>>> +
>>> +	return 0;
>>> +}
> [...]
> 
> Thanks,
> 
> Quentin
> 

