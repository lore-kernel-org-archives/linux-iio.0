Return-Path: <lars@metafoo.de>
Message-ID: <50544ADF.8020405@metafoo.de>
Date: Sat, 15 Sep 2012 11:31:11 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 Milo Kim <Milo.Kim@ti.com>,
 anish kumar <anish198519851985@gmail.com>
Subject: Re: [PATCH 3/4] iio:inkern: Add function to read the processed value
References: <1347636104-3419-1-git-send-email-lars@metafoo.de> <1347636104-3419-3-git-send-email-lars@metafoo.de> <505449BB.5020606@kernel.org>
In-Reply-To: <505449BB.5020606@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/15/2012 11:26 AM, Jonathan Cameron wrote:
> On 09/14/2012 04:21 PM, Lars-Peter Clausen wrote:
>> Add a function to read a processed value from a channel. The function will first
>> attempt to read the IIO_CHAN_INFO_PROCESSED attribute. If that fails it will
>> read the IIO_CHAN_INFO_RAW attribute and convert the result from a raw value to
>> a processed value.
>>
>> The patch also introduces a function to convert raw value to a processed value
>> and exports it, in case a user needs or wants to do the conversion by itself.
> Take another look at this one... Either that or there is a dependency here on something
> you haven't mentioned (and some of the sparse warnings are about stuff entirely in here).
> 

I should clearly stop sending out patches late in the afternoon... the fixes
for all these errors slipped into patch 4...

> 
> drivers/iio/inkern.c:240:47: warning: incorrect type in return expression (invalid types)
> drivers/iio/inkern.c:240:47:    expected incomplete type
> drivers/iio/inkern.c:240:47:    got int
> drivers/iio/inkern.c:254:13: warning: incorrect type in assignment (different base types)
> drivers/iio/inkern.c:254:13:    expected int [signed] [assigned] ret
> drivers/iio/inkern.c:254:13:    got incomplete type
> drivers/iio/inkern.c:269:13: warning: incorrect type in assignment (different base types)
> drivers/iio/inkern.c:269:13:    expected int [signed] ret
> drivers/iio/inkern.c:269:13:    got incomplete type
> drivers/iio/inkern.c:273:20: warning: incorrect type in assignment (different base types)
> drivers/iio/inkern.c:273:20:    expected int [signed] scale_type
> drivers/iio/inkern.c:273:20:    got incomplete type
> drivers/iio/inkern.c:306:5: error: symbol 'iio_convert_raw_to_processed' redeclared with different type (originally
> declared at include/linux/iio/consumer.h:131) - incompatible argument 1 (different modifiers)
> drivers/iio/inkern.c:326:5: error: symbol 'iio_read_channel_processed' redeclared with different type (originally
> declared at include/linux/iio/consumer.h:86) - incompatible argument 1 (different modifiers)
> drivers/iio/inkern.c:362:15: error: undefined identifier 'iio_read_channel'
>   CC [M]  drivers/iio/inkern.o
> drivers/iio/inkern.c:232:8: warning: return type defaults to 'int'
> drivers/iio/inkern.c:306:5: error: conflicting types for 'iio_convert_raw_to_processed'
> include/linux/iio/consumer.h:131:5: note: previous declaration of 'iio_convert_raw_to_processed' was here
> drivers/iio/inkern.c:324:1: error: conflicting types for 'iio_convert_raw_to_processed'
> include/linux/iio/consumer.h:131:5: note: previous declaration of 'iio_convert_raw_to_processed' was here
> drivers/iio/inkern.c:326:5: error: conflicting types for 'iio_read_channel_processed'
> include/linux/iio/consumer.h:86:5: note: previous declaration of 'iio_read_channel_processed' was here
> drivers/iio/inkern.c: In function 'iio_read_channel_processed':
> drivers/iio/inkern.c:328:6: warning: unused variable 'unused'
> drivers/iio/inkern.c: At top level:
> drivers/iio/inkern.c:350:1: error: conflicting types for 'iio_read_channel_processed'
> include/linux/iio/consumer.h:86:5: note: previous declaration of 'iio_read_channel_processed' was here
> drivers/iio/inkern.c: In function 'iio_read_channel_scale':
> drivers/iio/inkern.c:362:2: error: implicit declaration of function 'iio_read_channel'
> make[2]: *** [drivers/iio/inkern.o] Error 1
> 
> 
> 
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/iio/inkern.c         |  114 ++++++++++++++++++++++++++++++++++++++----
>>  include/linux/iio/consumer.h |   38 ++++++++++++++
>>  include/linux/iio/iio.h      |   17 +++++++
>>  3 files changed, 160 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
>> index a14e55d..37299bf 100644
>> --- a/drivers/iio/inkern.c
>> +++ b/drivers/iio/inkern.c
>> @@ -229,9 +229,21 @@ void iio_channel_release_all(struct iio_channel *channels)
>>  }
>>  EXPORT_SYMBOL_GPL(iio_channel_release_all);
>>
>> +static iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>> +	enum iio_chan_info_enum info)
>> +{
>> +	int unused;
>> +
>> +	if (val2 == NULL)
>> +		val2 = &unused;
>> +
>> +	return chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
>> +						val, val2, info);
>> +}
>> +
>>  int iio_read_channel_raw(struct iio_channel *chan, int *val)
>>  {
>> -	int val2, ret;
>> +	int ret;
>>
>>  	mutex_lock(&chan->indio_dev->info_exist_lock);
>>  	if (chan->indio_dev->info == NULL) {
>> @@ -239,10 +251,7 @@ int iio_read_channel_raw(struct iio_channel *chan, int *val)
>>  		goto err_unlock;
>>  	}
>>
>> -	ret = chan->indio_dev->info->read_raw(chan->indio_dev,
>> -					      chan->channel,
>> -					      val, &val2,
>> -					      IIO_CHAN_INFO_RAW);
>> +	ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>>  err_unlock:
>>  	mutex_unlock(&chan->indio_dev->info_exist_lock);
>>
>> @@ -250,6 +259,96 @@ err_unlock:
>>  }
>>  EXPORT_SYMBOL_GPL(iio_read_channel_raw);
>>
>> +static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
>> +	int raw, int *processed, unsigned int scale)
>> +{
>> +	int scale_type, scale_val, scale_val2, offset;
>> +	s64 raw64 = raw;
>> +	int ret;
>> +
>> +	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_SCALE);
>> +	if (ret == 0)
>> +		raw64 += offset;
>> +
>> +	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
>> +					IIO_CHAN_INFO_SCALE);
>> +	if (scale_type < 0)
>> +		return scale_type;
>> +
>> +	switch (scale_type) {
>> +	case IIO_VAL_INT:
>> +		*processed = raw * scale_val;
>> +		break;
>> +	case IIO_VAL_INT_PLUS_MICRO:
>> +		if (scale_val2 < 0)
>> +			*processed = -raw * scale_val;
>> +		else
>> +			*processed = raw * scale_val;
>> +		*processed += div_s64(raw * (s64)scale_val2 * scale, 1000000LL);
>> +		break;
>> +	case IIO_VAL_INT_PLUS_NANO:
>> +		if (scale_val2 < 0)
>> +			*processed = -raw * scale_val;
>> +		else
>> +			*processed = raw * scale_val;
>> +		*processed += div_s64(raw * (s64)scale_val2 * scale, 1000000000LL);
>> +		break;
>> +	case IIO_VAL_FRACTIONAL:
>> +		*processed = div_s64(raw * (s64)scale_val * scale, scale_val2);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>> +	int *processed, unsigned int scale)
>> +{
>> +	int ret;
>> +
>> +	mutex_lock(&chan->indio_dev->info_exist_lock);
>> +	if (chan->indio_dev->info == NULL) {
>> +		ret = -ENODEV;
>> +		goto err_unlock;
>> +	}
>> +
>> +	ret = iio_convert_raw_to_processed_unlocked(chan, raw, processed,
>> +							scale);
>> +err_unlock:
>> +	mutex_unlock(&chan->indio_dev->info_exist_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
>> +
> chan not const here but is in the header..
>> +int iio_read_channel_processed(struct iio_channel *chan, int *val)
>> +{
>> +	int unused, ret;
>> +
>> +	mutex_lock(&chan->indio_dev->info_exist_lock);
>> +	if (chan->indio_dev->info == NULL) {
>> +		ret = -ENODEV;
>> +		goto err_unlock;
>> +	}
>> +
>> +	if (iio_channel_has_info(chan->channel, IIO_CHAN_INFO_PROCESSED)) {
>> +		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_PROCESSED);
>> +	} else {
>> +		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
>> +		if (ret < 0)
>> +			goto err_unlock;
>> +		ret = iio_convert_raw_to_processed_unlocked(chan, *val, val, 1);
>> +	}
>> +
>> +err_unlock:
>> +	mutex_unlock(&chan->indio_dev->info_exist_lock);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(iio_read_channel_processed);
>> +
>>  int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
>>  {
>>  	int ret;
>> @@ -260,10 +359,7 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val, int *val2)
>>  		goto err_unlock;
>>  	}
>>
>> -	ret = chan->indio_dev->info->read_raw(chan->indio_dev,
>> -					      chan->channel,
>> -					      val, val2,
>> -					      IIO_CHAN_INFO_SCALE);
>> +	ret = iio_read_channel(chan, val, val2, IIO_CHAN_INFO_SCALE);
>>  err_unlock:
>>  	mutex_unlock(&chan->indio_dev->info_exist_lock);
>>
>> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
>> index 27759ac3..3f66304 100644
>> --- a/include/linux/iio/consumer.h
>> +++ b/include/linux/iio/consumer.h
>> @@ -71,6 +71,21 @@ int iio_read_channel_raw(struct iio_channel *channel,
>>  			 int *val);
>>
>>  /**
>> + * iio_read_channel_processed() - read processed value from a given channel
>> + * @channel:		The channel being queried.
>> + * @val:		Value read back.
>> + *
>> + * Returns an error code or 0.
>> + *
>> + * This function will read a processed value from a channel. A processed value
>> + * means that this value will have the correct unit and not some device internal
>> + * representation. If the device does not support reporting a processed value
>> + * the function will query the raw value and the channels scale and offset and
>> + * do the appropriate transformation.
>> + */
>> +int iio_read_channel_processed(const struct iio_channel *channel, int *val);
>> +
>> +/**
>>   * iio_get_channel_type() - get the type of a channel
>>   * @channel:		The channel being queried.
>>   * @type:		The type of the channel.
>> @@ -93,4 +108,27 @@ int iio_get_channel_type(struct iio_channel *channel,
>>  int iio_read_channel_scale(struct iio_channel *channel, int *val,
>>  			   int *val2);
>>
>> +/**
>> + * iio_convert_raw_to_processed() - Converts a raw value to a processed value
>> + * @channel:		The channel being queried
>> + * @raw:		The raw IIO to convert
>> + * @processed:		The result of the conversion
>> + * @scale:		Scale factor to apply during the conversion
>> + *
>> + * Returns an error code or 0.
>> + *
>> + * This function converts a raw value to processed value for a specific channel.
>> + * A raw value is the device internal representation of a sample and the value
>> + * returned by iio_read_channel_raw, so the unit of that value is device
>> + * depended. A processed value on the other hand is value has a normed unit
>> + * according with the IIO specification.
>> + *
>> + * The scale factor allows to increase the precession of the returned value. For
>> + * a scale factor of 1 the function will return the result in the normal IIO
>> + * unit for the channel type. E.g. millivolt for voltage channels, if you want
>> + * nanovolts instead pass 1000 as the scale factor.
>> + */
>> +int iio_convert_raw_to_processed(const struct iio_channel *channel, int raw,
>> +	int *processed, unsigned int scale);
> const here but not in implementation....
>> +
>>  #endif
>> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
>> index 30affa5..c0ae76a 100644
>> --- a/include/linux/iio/iio.h
>> +++ b/include/linux/iio/iio.h
>> @@ -40,6 +40,8 @@ enum iio_chan_info_enum {
>>
>>  #define IIO_CHAN_INFO_SHARED_BIT(type) BIT(type*2)
>>  #define IIO_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + 1)
>> +#define IIO_CHAN_INFO_BITS(type) (IIO_CHAN_INFO_SHARED_BIT(type) | \
>> +				    IIO_CHAN_INFO_SEPARATE_BIT(type))
>>
>>  #define IIO_CHAN_INFO_RAW_SEPARATE_BIT			\
>>  	IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_RAW)
>> @@ -261,6 +263,21 @@ struct iio_chan_spec {
>>  	unsigned		differential:1;
>>  };
>>
>> +
>> +/**
>> + * iio_channel_has_info() - Checks whether a channel supports a info attribute
>> + * @chan: The channel to be queried
>> + * @type: Type of the info attribute to be checked
>> + *
>> + * Returns true if the channels supports reporting values for the given info
>> + * attribute type, false otherwise.
>> + */
>> +static inline bool iio_channel_has_info(const struct iio_chan_spec *chan,
>> +	enum iio_chan_info_enum type)
>> +{
>> +	return chan->info_mask & IIO_CHAN_INFO_BITS(type);
>> +}
>> +
>>  #define IIO_ST(si, rb, sb, sh)						\
>>  	{ .sign = si, .realbits = rb, .storagebits = sb, .shift = sh }
>>
>>
