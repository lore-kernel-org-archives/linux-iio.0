Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-035.synserver.de ([212.40.185.35]:1033 "EHLO
	smtp-out-035.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3JLKt0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:49:26 -0400
Message-ID: <525929AB.9060807@metafoo.de>
Date: Sat, 12 Oct 2013 12:51:23 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 09/20] staging:iio:lis2l02dq: Share threshold value
 between axis
References: <1381155094-20166-1-git-send-email-lars@metafoo.de> <1381155094-20166-9-git-send-email-lars@metafoo.de> <52593650.3020605@kernel.org>
In-Reply-To: <52593650.3020605@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/12/2013 01:45 PM, Jonathan Cameron wrote:
> On 10/07/13 15:11, Lars-Peter Clausen wrote:
>> The threshold event can be enabled/disabled separately, but the threshold value
>> is shared between all three axis.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Build fix applied as below.
>> ---
>>  drivers/staging/iio/accel/lis3l02dq_core.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
>> index 78187f1..b2d1dfa 100644
>> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
>> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
>> @@ -518,13 +518,13 @@ static const struct iio_event_spec lis3l02dq_event[] = {
>>  	{
>>  		.type = IIO_EV_TYPE_THRESH,
>>  		.dir = IIO_EV_DIR_RISING,
>> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> -			BIT(IIO_EV_INFO_ENABLE),
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE);
> semicolons?

Hm, I might have send out the wrong version of that branch. I think the only
other difference was slightly better wording for the hysteresis sysfs
documentation.

>> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE);
>>  	}, {
>>  		.type = IIO_EV_TYPE_THRESH,
>>  		.dir = IIO_EV_DIR_FALLING,
>> -		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
>> -			BIT(IIO_EV_INFO_ENABLE),
>> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE);
>> +		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE);
>>  	}
>>  };
>>  
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

