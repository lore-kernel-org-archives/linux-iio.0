Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46177 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635Ab2KBLGi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 2 Nov 2012 07:06:38 -0400
Message-ID: <5093A93D.70302@kernel.org>
Date: Fri, 02 Nov 2012 11:06:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio:dac:ad5449: unlock on error path
References: <20121024071307.GC2536@elgon.mountain> <5087A55C.6010202@metafoo.de>
In-Reply-To: <5087A55C.6010202@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/2012 09:22 AM, Lars-Peter Clausen wrote:
> On 10/24/2012 09:13 AM, Dan Carpenter wrote:
>> There is an unlock missing on this error path.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks,
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Thanks applied to togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

> 
>> ---
>> Only needed in linux-next.
>>
>> diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
>> index 5b43030..0ee6f8e 100644
>> --- a/drivers/iio/dac/ad5449.c
>> +++ b/drivers/iio/dac/ad5449.c
>> @@ -124,12 +124,13 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
>>  
>>  	ret = spi_sync(st->spi, &msg);
>>  	if (ret < 0)
>> -		return ret;
>> +		goto out_unlock;
>>  
>>  	*val = be16_to_cpu(st->data[1]);
>> -	mutex_unlock(&indio_dev->mlock);
>>  
>> -	return 0;
>> +out_unlock:
>> +	mutex_unlock(&indio_dev->mlock);
>> +	return ret;
>>  }
>>  
>>  static int ad5449_read_raw(struct iio_dev *indio_dev,
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
