Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43789 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbcCLLZb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Mar 2016 06:25:31 -0500
Subject: Re: [RFC PATCH v2 2/2] staging: iio: ad7192: use
 iio_device_{claim|release}_direct_mode()
To: Alison Schofield <amsfield22@gmail.com>,
	outreachy-kernel@googlegroups.com
References: <cover.1457549841.git.amsfield22@gmail.com>
 <dd3f346d97cfb11f4d18e44eb67309c889639ba7.1457549841.git.amsfield22@gmail.com>
 <56E3FBA9.9070500@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56E3FCA9.9030208@kernel.org>
Date: Sat, 12 Mar 2016 11:25:29 +0000
MIME-Version: 1.0
In-Reply-To: <56E3FBA9.9070500@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/03/16 11:21, Jonathan Cameron wrote:
> On 09/03/16 19:30, Alison Schofield wrote:
>> Replace the code that guarantees the device stays in direct mode with
>> iio_device_{claim|release}_direct_mode() which does same.
>>
>> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> A small improvement inline - don't eat the errors within the
> driver. 
As it is trivial - I've fixed it up as suggested and applied.
Seemed silly to go round again for such a small change.

I'm hoping you have the opportunity to take this tree wide.

Thanks,

Jonathan
> 
> Jonathan
>> ---
>>  drivers/staging/iio/adc/ad7192.c | 24 +++++++++---------------
>>  1 file changed, 9 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
>> index f843f19..94a2e06 100644
>> --- a/drivers/staging/iio/adc/ad7192.c
>> +++ b/drivers/staging/iio/adc/ad7192.c
>> @@ -349,11 +349,9 @@ static ssize_t ad7192_write_frequency(struct device *dev,
>>  	if (lval == 0)
>>  		return -EINVAL;
>>  
>> -	mutex_lock(&indio_dev->mlock);
>> -	if (iio_buffer_enabled(indio_dev)) {
>> -		mutex_unlock(&indio_dev->mlock);
>> +	ret = iio_device_claim_direct_mode(indio_dev);
>> +	if (ret)
>>  		return -EBUSY;
> return ret;  In theory we might be returning some other
> error code so best not to 'eat' the result.
>> -	}
>>  
>>  	div = st->mclk / (lval * st->f_order * 1024);
>>  	if (div < 1 || div > 1023) {
>> @@ -366,7 +364,7 @@ static ssize_t ad7192_write_frequency(struct device *dev,
>>  	ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
>>  
>>  out:
>> -	mutex_unlock(&indio_dev->mlock);
>> +	iio_device_release_direct_mode(indio_dev);
>>  
>>  	return ret ? ret : len;
>>  }
>> @@ -434,11 +432,9 @@ static ssize_t ad7192_set(struct device *dev,
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	mutex_lock(&indio_dev->mlock);
>> -	if (iio_buffer_enabled(indio_dev)) {
>> -		mutex_unlock(&indio_dev->mlock);
>> +	ret = iio_device_claim_direct_mode(indio_dev);
>> +	if (ret)
>>  		return -EBUSY;
> Same here.
>> -	}
>>  
>>  	switch ((u32)this_attr->address) {
>>  	case AD7192_REG_GPOCON:
>> @@ -461,7 +457,7 @@ static ssize_t ad7192_set(struct device *dev,
>>  		ret = -EINVAL;
>>  	}
>>  
>> -	mutex_unlock(&indio_dev->mlock);
>> +	iio_device_release_direct_mode(indio_dev);
>>  
>>  	return ret ? ret : len;
>>  }
>> @@ -555,11 +551,9 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>>  	int ret, i;
>>  	unsigned int tmp;
>>  
>> -	mutex_lock(&indio_dev->mlock);
>> -	if (iio_buffer_enabled(indio_dev)) {
>> -		mutex_unlock(&indio_dev->mlock);
>> +	ret = iio_device_claim_direct_mode(indio_dev);
>> +	if (ret)
>>  		return -EBUSY;
> And here.
>> -	}
>>  
>>  	switch (mask) {
>>  	case IIO_CHAN_INFO_SCALE:
>> @@ -582,7 +576,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>>  		ret = -EINVAL;
>>  	}
>>  
>> -	mutex_unlock(&indio_dev->mlock);
>> +	iio_device_release_direct_mode(indio_dev);
>>  
>>  	return ret;
>>  }
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

