Return-Path: <wharms@bfs.de>
Message-ID: <5093FA4A.2010006@bfs.de>
Date: Fri, 02 Nov 2012 17:52:26 +0100
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio:dac:ad5449: unlock on error path
References: <20121024071307.GC2536@elgon.mountain> <5087A55C.6010202@metafoo.de> <5093A93D.70302@kernel.org>
In-Reply-To: <5093A93D.70302@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>



Am 02.11.2012 12:06, schrieb Jonathan Cameron:
> On 10/24/2012 09:22 AM, Lars-Peter Clausen wrote:
>> On 10/24/2012 09:13 AM, Dan Carpenter wrote:
>>> There is an unlock missing on this error path.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> Thanks,
>>
>> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
> Thanks applied to togreg branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> 
>>
>>> ---
>>> Only needed in linux-next.
>>>
>>> diff --git a/drivers/iio/dac/ad5449.c b/drivers/iio/dac/ad5449.c
>>> index 5b43030..0ee6f8e 100644
>>> --- a/drivers/iio/dac/ad5449.c
>>> +++ b/drivers/iio/dac/ad5449.c
>>> @@ -124,12 +124,13 @@ static int ad5449_read(struct iio_dev *indio_dev, unsigned int addr,
>>>  
>>>  	ret = spi_sync(st->spi, &msg);
>>>  	if (ret < 0)
>>> -		return ret;
>>> +		goto out_unlock;
>>>  
>>>  	*val = be16_to_cpu(st->data[1]);
>>> -	mutex_unlock(&indio_dev->mlock);
>>>  
>>> -	return 0;
>>> +out_unlock:
>>> +	mutex_unlock(&indio_dev->mlock);
>>> +	return ret;
>>>  }
>>>  
>>>  static int ad5449_read_raw(struct iio_dev *indio_dev,
>>> --


if i understand the code correct you can simply the flow
by turning the check on its head.

ret = spi_sync(st->spi, &msg);
if (ret>=0)
    *val = be16_to_cpu(st->data[1]);
mutex_unlock(&indio_dev->mlock);
return ret;

re,
 wh
