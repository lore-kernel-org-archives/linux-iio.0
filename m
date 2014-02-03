Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50281 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbaBCVoq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2014 16:44:46 -0500
Message-ID: <52F00DE8.5070002@kernel.org>
Date: Mon, 03 Feb 2014 21:45:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@oracle.com>
CC: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: dac: ad7303: remove an unneeded check
References: <20140130115849.GI12734@elgon.mountain> <52EB6EF4.9020203@metafoo.de>
In-Reply-To: <52EB6EF4.9020203@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 31/01/14 09:37, Lars-Peter Clausen wrote:
> On 01/30/2014 12:58 PM, Dan Carpenter wrote:
>> "ret" is zero here.  There is no need to check again.
>>
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
>
> Thanks.
>
>>
>> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
>> index d0505fd22ef4..fa2810032968 100644
>> --- a/drivers/iio/dac/ad7303.c
>> +++ b/drivers/iio/dac/ad7303.c
>> @@ -92,7 +92,7 @@ static ssize_t ad7303_write_dac_powerdown(struct iio_dev *indio_dev,
>>   	ad7303_write(st, chan->channel, st->dac_cache[chan->channel]);
>>
>>   	mutex_unlock(&indio_dev->mlock);
>> -	return ret ? ret : len;
>> +	return len;
>>   }
>>
>>   static int ad7303_get_vref(struct ad7303_state *st,
>>
>
