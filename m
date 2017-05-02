Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50023 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbdEBQcK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 May 2017 12:32:10 -0400
Subject: Re: [PATCH v2 2/4] iio: accel: adxl345_core: Introduce set_mode and
 data_ready functions
To: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
        michael.hennerich@analog.com, daniel.baluta@gmail.com,
        amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
        linux-kernel@vger.kernel.org
References: <cover.1493450577.git.eraretuya@gmail.com>
 <96d20633a6ff9792f7be642a590669fc07d9ad63.1493450577.git.eraretuya@gmail.com>
 <652e2497-d091-9468-a4ee-983bcc626d6b@kernel.org>
 <20170502113902.GA3030@Socrates-UM>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <07a80519-2f22-5974-b03a-8d8aff2f2f07@kernel.org>
Date: Tue, 2 May 2017 17:32:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170502113902.GA3030@Socrates-UM>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/17 12:39, Eva Rachel Retuya wrote:
> On Mon, May 01, 2017 at 01:22:52AM +0100, Jonathan Cameron wrote:
> Hello Jonathan,
> [...]
>>> +static int adxl345_set_mode(struct adxl345_data *data, u8 mode)
>>> +{
>>> +	struct device *dev = regmap_get_device(data->regmap);
>>> +	int ret;
>>> +
>>> +	ret = regmap_write(data->regmap, ADXL345_REG_POWER_CTL, mode);
>>> +	if (ret < 0) {
>>> +		dev_err(dev, "Failed to set power mode, %d\n", ret);
>>> +		return ret;
>> drop the return ret here and just return ret at the end of the function.
>> One of the static checkers will probably moan about this otherwise.
> 
> OK.
> 
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int adxl345_data_ready(struct adxl345_data *data)
>>> +{
>> So this is a polling the dataready bit.  Will ensure we always
>> get fresh data when a read occurs.  Please add a comment to
>> that effect as that's not always how devices work.
> 
> OK.
> 
>>> +	struct device *dev = regmap_get_device(data->regmap);
>>> +	int tries = 5;
>>> +	u32 val;
>>> +	int ret;
>>> +
>>> +	do {
>>> +		/*
>>> +		 * 1/ODR + 1.1ms; 11.1ms at ODR of 0.10 Hz
>>> +		 * Sensor currently operates at default ODR of 100 Hz
>>> +		 */
>>> +		usleep_range(1100, 11100);
>> That's a huge range to allow... I'm not following the argument for why.
>> Or do we have a stray 0?
>>
> 
> Not a stray 0. Range is from 1.1ms to 11.1ms, this represents the
> wake-up time when going to standby/other power saving modes ->
> measurement mode. I'm going to clarify the comment on why it is needed
> on the next revision.
The point about a range sleep is to allow the kernel flexibility in scheduling
so as to avoid waking the processor from lower power states when high precision is
not needed.

If the thing you are talking about needs the maximum time sometimes then you
should set the minimum value to that and add a bit to avoid unnecessary processor
wake ups.
> 
>>> +
>>> +		ret = regmap_read(data->regmap, ADXL345_REG_INT_SOURCE, &val);
>>> +		if (ret < 0)
>>> +			return ret;
>>> +		if ((val & ADXL345_INT_DATA_READY) == ADXL345_INT_DATA_READY)
>>> +			return 0;
>>> +	} while (--tries);
>>> +	dev_err(dev, "Data is not yet ready, try again.\n");
>>> +
>> This is almost certainly a hardware fault. I'd be more brutal with
>> the error and return -EIO.  If you get here your hardware is very unlikely
>> to be working correctly if you try again.
> 
> OK, will change it to -EIO then.
> 
>>> +	return -EAGAIN;
>>> +}
>>> +
>>>  #define ADXL345_CHANNEL(reg, axis) {					\
>>>  	.type = IIO_ACCEL,						\
>>>  	.modified = 1,							\
>>> @@ -72,6 +118,19 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>>>  
>>>  	switch (mask) {
>>>  	case IIO_CHAN_INFO_RAW:
>>> +		mutex_lock(&data->lock);
>>> +		ret = adxl345_set_mode(data, ADXL345_POWER_CTL_MEASURE);
>>> +		if (ret < 0) {
>>> +			mutex_unlock(&data->lock);
>>> +			return ret;
>>> +		}
>>> +
>>> +		ret = adxl345_data_ready(data);
>>> +		if (ret < 0) {
>>> +			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
>>> +			mutex_unlock(&data->lock);
>> What is the logic that puts the mutex_unlock here in the error case
>> and before the set_mode in the normal path?  Even if it doesn't
>> matter make them the same as it is less likely to raise questions
>> in the future!
> 
> OK, will make it consistent.
> 
>>> +			return ret;
>>> +		}
>>>  		/*
>>>  		 * Data is stored in adjacent registers:
>>>  		 * ADXL345_REG_DATA(X0/Y0/Z0) contain the least significant byte
>>> @@ -79,10 +138,15 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>>>  		 */
>>>  		ret = regmap_bulk_read(data->regmap, chan->address, &regval,
>>>  				       sizeof(regval));
>>> -		if (ret < 0)
>>> +		mutex_unlock(&data->lock);
>>> +		if (ret < 0) {
>>> +			adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
>>>  			return ret;
>>> +		}
>>>  
>>>  		*val = sign_extend32(le16_to_cpu(regval), 12);
>>> +		adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
>>> +
>>>  		return IIO_VAL_INT;
>>>  	case IIO_CHAN_INFO_SCALE:
>>>  		*val = 0;
> [...]
>>> @@ -169,8 +224,7 @@ int adxl345_core_remove(struct device *dev)
>>>  
>>>  	iio_device_unregister(indio_dev);
>>>  
>>> -	return regmap_write(data->regmap, ADXL345_REG_POWER_CTL,
>>> -			    ADXL345_POWER_CTL_STANDBY);
>>> +	return adxl345_set_mode(data, ADXL345_POWER_CTL_STANDBY);
>> Under what circumstances would we not already be in the correct state?
>> A brief comment here would be good.
> 
> I'm leaving this unremoved to catch cases where in the sensor fails to
> return to standby mode after a read. Will add the said comment.
> 
> Thanks,
> Eva
> 
>>>  }
>>>  EXPORT_SYMBOL_GPL(adxl345_core_remove);
>>>  
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

