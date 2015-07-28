Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:61612 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751077AbbG1XIn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 28 Jul 2015 19:08:43 -0400
Message-ID: <55B80B71.5030203@gmx.de>
Date: Wed, 29 Jul 2015 01:08:33 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH 3/7] iio:accel:stk8312: improve error handling
References: <cover.1437955135.git.knaack.h@gmx.de> <e8f4d5f8a4de19c0bb88846c69be6476b0b612db.1437955135.git.knaack.h@gmx.de> <4586F61A4A291F4DA44D32824E7C0F4022187EF6@IRSMSX109.ger.corp.intel.com>
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4022187EF6@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Breana, Tiberiu A schrieb am 28.07.2015 um 15:38:
>> -----Original Message-----
>> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
>> Sent: Tuesday, July 28, 2015 1:49 AM
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
>> A
>> Subject: [PATCH 3/7] iio:accel:stk8312: improve error handling
>>
>> Improve error handling in the following ways:
>>   - set return value on error condition to an appropriate error code
>>   - return error code immediately in case of an error (slightly changes
>>     code structure)
>>   - pass up real error code
>>   - add missing error handling
>>   - return 0 when error have been caught already
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> Comments inline.
> 

Hi,

<...>
>> +267,12 @@ static int stk8312_set_sample_rate(struct stk8312_data *data,
>> int rate)
>>  	masked_reg = (ret & (~STK8312_SR_MASK)) | rate;
>>
>>  	ret = i2c_smbus_write_byte_data(client, STK8312_REG_SR,
>> masked_reg);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>  		dev_err(&client->dev, "failed to set sampling rate\n");
>> -	else
>> -		data->sample_rate_idx = rate;
>> +		return ret;
> 
> We can't just return here. Bear in mind that earlier in the function we set the
> sensor's operation mode to standby. Return to active mode before returning.
> This should be added @258 as well.
> 

OK, I will respin with a common error path to put the device back in active mode.

>> +	}
>> +
>> +	data->sample_rate_idx = rate;
>>
>>  	return stk8312_set_mode(data, mode);
>>  }
>> @@ -299,10 +305,12 @@ static int stk8312_set_range(struct stk8312_data
>> *data, u8 range)
>>  	masked_reg |= range << STK8312_RNG_SHIFT;
>>
>>  	ret = i2c_smbus_write_byte_data(client, STK8312_REG_STH,
>> masked_reg);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>  		dev_err(&client->dev, "failed to change sensor range\n");
>> -	else
>> -		data->range = range;
>> +		return ret;
>> +	}
>> +
>> +	data->range = range;
>>
>>  	return stk8312_set_mode(data, mode);
>>  }
>> @@ -337,18 +345,21 @@ static int stk8312_read_raw(struct iio_dev
>> *indio_dev,
>>  		ret = stk8312_set_mode(data, data->mode |
>> STK8312_MODE_ACTIVE);
>>  		if (ret < 0) {
>>  			mutex_unlock(&data->lock);
>> -			return -EINVAL;
>> +			return ret;
>>  		}
>>  		ret = stk8312_read_accel(data, chan->address);
>>  		if (ret < 0) {
>>  			stk8312_set_mode(data,
>>  					 data->mode &
>> (~STK8312_MODE_ACTIVE));
>>  			mutex_unlock(&data->lock);
>> -			return -EINVAL;
>> +			return ret;
>>  		}
>>  		*val = sign_extend32(ret, 7);
>> -		stk8312_set_mode(data, data->mode &
>> (~STK8312_MODE_ACTIVE));
>> +		ret = stk8312_set_mode(data,
>> +				       data->mode &
>> (~STK8312_MODE_ACTIVE));
>>  		mutex_unlock(&data->lock);
>> +		if (ret < 0)
>> +			return ret;
> 
> I don't agree with this. We've succesfully read the data, we shouldn't return an
> error if the sensor couldn't be put back to standby. I suggest leaving it as it is.
> 

Well, encountering an error should be an exceptional case, which should not happen
in normal operation (and thus do no harm). But something goes wrong, then better
report it, even a data sample has been read successfully.
Thanks,

Hartmut

>>  		return IIO_VAL_INT;
>>  	case IIO_CHAN_INFO_SCALE:
>>  		*val = stk8312_scale_table[data->range - 1][0]; @@ -608,7
>> +619,7 @@ static int stk8312_probe(struct i2c_client *client,
>>  		goto err_buffer_cleanup;
>>  	}
>>
>> -	return ret;
>> +	return 0;
>>
>>  err_buffer_cleanup:
>>  	iio_triggered_buffer_cleanup(indio_dev);
>> --
>> 2.4.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

