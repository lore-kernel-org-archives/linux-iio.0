Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50265 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbaBCVnf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2014 16:43:35 -0500
Message-ID: <52F00DA1.20104@kernel.org>
Date: Mon, 03 Feb 2014 21:44:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@oracle.com>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio:imu:adis16400 remove an unneeded check
References: <20140130115914.GJ12734@elgon.mountain> <52EB6F18.5070202@metafoo.de>
In-Reply-To: <52EB6F18.5070202@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 31/01/14 09:38, Lars-Peter Clausen wrote:
> On 01/30/2014 12:59 PM, Dan Carpenter wrote:
>> We know "ret" is zero here so there is no need to check.
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
>> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
>> index 368660dfe135..411586f49dae 100644
>> --- a/drivers/iio/imu/adis16400_core.c
>> +++ b/drivers/iio/imu/adis16400_core.c
>> @@ -281,7 +281,7 @@ static ssize_t adis16400_write_frequency(struct device *dev,
>>   	st->variant->set_freq(st, val);
>>   	mutex_unlock(&indio_dev->mlock);
>>
>> -	return ret ? ret : len;
>> +	return len;
>>   }
>>
>>   /* Power down the device */
>>
>
