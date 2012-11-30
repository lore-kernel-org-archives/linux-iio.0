Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57031 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756702Ab2K3NNO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 08:13:14 -0500
Message-ID: <50B8B0EA.6000104@kernel.org>
Date: Fri, 30 Nov 2012 13:13:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
	Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio:gyro: adis16136: divide by zero in write_frequency()
References: <20121127072452.GA8239@elgon.mountain> <50B5092E.7060103@metafoo.de>
In-Reply-To: <50B5092E.7060103@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/27/2012 06:40 PM, Lars-Peter Clausen wrote:
> On 11/27/2012 08:24 AM, Dan Carpenter wrote:
>> It's slightly cleaner to use kstrtouint() because we pass unsigned ints
>> to adis16136_set_freq().  On 64 bit systems, if the user passed LONG_MIN
>> then it we would get past the test against zero but crash in
>> adis16136_set_freq() because we truncate the high bits away.
>>
>>
> 
> Thanks,
> 
> Acked-By: Lars-Peter Clausen <lars@metafoo.de>
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Added to togreg branch of

git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

>>
>> diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
>> index 05486df..b4ee339 100644
>> --- a/drivers/iio/gyro/adis16136.c
>> +++ b/drivers/iio/gyro/adis16136.c
>> @@ -203,10 +203,10 @@ static ssize_t adis16136_write_frequency(struct device *dev,
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct adis16136 *adis16136 = iio_priv(indio_dev);
>> -	long val;
>> +	unsigned int val;
>>  	int ret;
>>  
>> -	ret = kstrtol(buf, 10, &val);
>> +	ret = kstrtouint(buf, 10, &val);
>>  	if (ret)
>>  		return ret;
>>  
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
