Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38991 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752806AbbDSMhj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Apr 2015 08:37:39 -0400
Message-ID: <5533A18E.1060500@kernel.org>
Date: Sun, 19 Apr 2015 13:37:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: sathyanarayanan.kuppuswamy@linux.intel.com
CC: pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/5] iio: ltr501: Add integration time support
References: <cover.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>    <1caf8ef18d039f83d6a89d86a3fc38e17bbbce37.1429326499.git.sathyanarayanan.kuppuswamy@linux.intel.com>    <55323A1E.5080202@kernel.org> <52227.10.252.194.55.1429436198.squirrel@linux.intel.com>
In-Reply-To: <52227.10.252.194.55.1429436198.squirrel@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/15 10:36, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> Hi Jonathan,
> 
>> On 18/04/15 06:15, Kuppuswamy Sathyanarayanan wrote:
>>> Added support to modify and read ALS integration time.
>>>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan
>>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Cool, didn't know about this regmap field stuff before.  Not exactly
>> heavily
>> used but looks helpful!
> yes. It simplifies the bit wise manipulations and makes it more readable.
> Avoids use of masks and logical operations.
>>
>> A few questions inline..
>>
>> 1) A spot where a variable name change would make it easier to follow.
> Fixed it in next set.
>> 2) Why are the struct reg_field not defined as const in the regmap_field
>> allocators?  Here it gives the impression we are restricting ourselves to
>> one instance of this chip, but in reality they seem to actually be const
>> so we aren't.
> There are few use cases in kernel where they allocate the reg_map fields
> in an array. In these cases same reg_field can be used with few index
> manipulations. Add const to allocators would restrict users in doing that.
I may be half asleep today but....

No it wouldn't.  You can quite happily pass non constant variables to
functions taking a const.  All you are guaranteeing is the function
won't do anything to it and hence you can pass a constant variable to
it if you like.  The current lack of const specifier means that will be
an error.  The other way around should be unaffected.
>>
>> messy :(
>>
>>> ---
>>>  drivers/iio/light/ltr501.c | 87
>>> +++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 86 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
>>> index 84ee2b3..22769c8 100644
>>> --- a/drivers/iio/light/ltr501.c
>>> +++ b/drivers/iio/light/ltr501.c
>>> @@ -28,6 +28,7 @@
>>>
>>>  #define LTR501_ALS_CONTR 0x80 /* ALS operation mode, SW reset */
>>>  #define LTR501_PS_CONTR 0x81 /* PS operation mode */
>>> +#define LTR501_ALS_MEAS_RATE 0x85 /* ALS integ time, measurement rate*/
>>>  #define LTR501_PART_ID 0x86
>>>  #define LTR501_MANUFAC_ID 0x87
>>>  #define LTR501_ALS_DATA1 0x88 /* 16-bit, little endian */
>>> @@ -49,11 +50,16 @@
>>>
>>>  #define LTR501_REGMAP_NAME "ltr501_regmap"
>>>
>>> +static int int_time_mapping[] = {100000, 50000, 200000, 400000};
>>> +
>>> +static struct reg_field reg_it = REG_FIELD(LTR501_ALS_MEAS_RATE, 3, 4);
>> Naming could be clearer.  The reg_it here and the regmap_field below
>> are different structures, but their name doesn't make this clear.
> Fixed it in next set.
>>
>> Also, why is the above not const?  Obviously regmap doesn't take a const
>> but I can't see why not... Mark?
> I agree. Fixed it in next set.
>>
>> It is only used to initialize elements (by copying) in the regmap_field
>> that allocator of which it is passed to.
>>> +
>>>  struct ltr501_data {
>>>  	struct i2c_client *client;
>>>  	struct mutex lock_als, lock_ps;
>>>  	u8 als_contr, ps_contr;
>>>  	struct regmap *regmap;
>>> +	struct regmap_field *reg_it;
>>>  };
>>>
>>>  static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
>>> @@ -74,6 +80,58 @@ static int ltr501_drdy(struct ltr501_data *data, u8
>>> drdy_mask)
>>>  	return -EIO;
>>>  }
>>>
>>> +static int ltr501_set_it_time(struct ltr501_data *data, int it)
>>> +{
>>> +	int ret, i, index = -1, status;
>>> +
>>> +	for (i = 0; i < ARRAY_SIZE(int_time_mapping); i++) {
>>> +		if (int_time_mapping[i] == it) {
>>> +			index = i;
>>> +			break;
>>> +		}
>>> +	}
>>> +	/* Make sure integ time index is valid */
>>> +	if (index < 0)
>>> +		return -EINVAL;
>>> +
>>> +	ret = regmap_read(data->regmap, LTR501_ALS_CONTR, &status);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	if (status & LTR501_CONTR_ALS_GAIN_MASK) {
>>> +		/*
>>> +		 * 200 ms and 400 ms integ time can only be
>>> +		 * used in dynamic range 1
>>> +		 */
>>> +		if (index > 1)
>>> +			return -EINVAL;
>>> +	} else
>>> +		/* 50 ms integ time can only be used in dynamic range 2 */
>>> +		if (index == 1)
>>> +			return -EINVAL;
>>> +
>>> +	return regmap_field_write(data->reg_it, index);
>>> +}
>>> +
>>> +/* read int time in micro seconds */
>>> +static int ltr501_read_it_time(struct ltr501_data *data, int *val, int
>>> *val2)
>>> +{
>>> +	int ret, index;
>>> +
>>> +	ret = regmap_field_read(data->reg_it, &index);
>>> +	if (ret < 0)
>>> +		return ret;
>>> +
>>> +	/* Make sure integ time index is valid */
>>> +	if (index < 0 || index >= ARRAY_SIZE(int_time_mapping))
>>> +		return -EINVAL;
>>> +
>>> +	*val2 = int_time_mapping[index];
>>> +	*val = 0;
>>> +
>>> +	return IIO_VAL_INT_PLUS_MICRO;
>>> +}
>>> +
>>>  static int ltr501_read_als(struct ltr501_data *data, __le16 buf[2])
>>>  {
>>>  	int ret = ltr501_drdy(data, LTR501_STATUS_ALS_RDY);
>>> @@ -119,7 +177,7 @@ static int ltr501_read_ps(struct ltr501_data *data)
>>>  static const struct iio_chan_spec ltr501_channels[] = {
>>>  	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0),
>>>  	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
>>> -		BIT(IIO_CHAN_INFO_SCALE)),
>>> +		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_INT_TIME)),
>>>  	{
>>>  		.type = IIO_PROXIMITY,
>>>  		.address = LTR501_PS_DATA,
>>> @@ -195,6 +253,13 @@ static int ltr501_read_raw(struct iio_dev
>>> *indio_dev,
>>>  		default:
>>>  			return -EINVAL;
>>>  		}
>>> +	case IIO_CHAN_INFO_INT_TIME:
>>> +		switch (chan->type) {
>>> +		case IIO_INTENSITY:
>>> +			return ltr501_read_it_time(data, val, val2);
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>>  	}
>>>  	return -EINVAL;
>>>  }
>>> @@ -245,16 +310,30 @@ static int ltr501_write_raw(struct iio_dev
>>> *indio_dev,
>>>  		default:
>>>  			return -EINVAL;
>>>  		}
>>> +	case IIO_CHAN_INFO_INT_TIME:
>>> +		switch (chan->type) {
>>> +		case IIO_INTENSITY:
>>> +			if (val != 0)
>>> +				return -EINVAL;
>>> +			mutex_lock(&data->lock_als);
>>> +			i = ltr501_set_it_time(data, val2);
>>> +			mutex_unlock(&data->lock_als);
>>> +			return i;
>>> +		default:
>>> +			return -EINVAL;
>>> +		}
>>>  	}
>>>  	return -EINVAL;
>>>  }
>>>
>>>  static IIO_CONST_ATTR(in_proximity_scale_available, "1 0.25 0.125
>>> 0.0625");
>>>  static IIO_CONST_ATTR(in_intensity_scale_available, "1 0.005");
>>> +static IIO_CONST_ATTR_INT_TIME_AVAIL("0.05 0.1 0.2 0.4");
>>>
>>>  static struct attribute *ltr501_attributes[] = {
>>>  	&iio_const_attr_in_proximity_scale_available.dev_attr.attr,
>>>  	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
>>> +	&iio_const_attr_integration_time_available.dev_attr.attr,
>>>  	NULL
>>>  };
>>>
>>> @@ -396,6 +475,12 @@ static int ltr501_probe(struct i2c_client *client,
>>>  	mutex_init(&data->lock_als);
>>>  	mutex_init(&data->lock_ps);
>>>
>>> +	data->reg_it = devm_regmap_field_alloc(&client->dev, regmap, reg_it);
>>> +	if (IS_ERR(data->reg_it)) {
>>> +		dev_err(&client->dev, "Integ time reg field init failed.\n");
>>> +		return PTR_ERR(data->reg_it);
>>> +	}
>>> +
>>>  	ret = regmap_read(data->regmap, LTR501_PART_ID, &partid);
>>>  	if (ret < 0)
>>>  		return ret;
>>>
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

