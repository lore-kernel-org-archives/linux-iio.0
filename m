Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59063 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756375Ab3IKU4v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Sep 2013 16:56:51 -0400
Message-ID: <5230E72C.3080901@kernel.org>
Date: Wed, 11 Sep 2013 22:57:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/18] staging:iio:hmc5843: Fix measurement conversion
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net> <1378170320-27538-2-git-send-email-pmeerw@pmeerw.net> <5228D8FA.6000301@metafoo.de>
In-Reply-To: <5228D8FA.6000301@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 20:18, Lars-Peter Clausen wrote:
> On 09/03/2013 03:05 AM, Peter Meerwald wrote:
>> recently broken, cd6fe06588423ff4cca85c85c4402027b04dccf1
> 
> When referring to a commit usually the commit title is also mentioned after the commit id. E.g. 12345678 ("abc foobar")

Patch description edited and applied to the fixes-togreg branch of iio.git

Thanks

Jonathan
> 
>>
>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> ---
>>   drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
>> index d2748c3..c3f3f53 100644
>> --- a/drivers/staging/iio/magnetometer/hmc5843.c
>> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
>> @@ -229,7 +229,7 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
>>       if (result < 0)
>>           return -EINVAL;
>>
>> -    *val = result;
>> +    *val = sign_extend32(result, 15);
>>       return IIO_VAL_INT;
>>   }
>>
>>
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
