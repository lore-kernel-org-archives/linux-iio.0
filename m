Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:58848 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756055AbdDMGu1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Apr 2017 02:50:27 -0400
From: "Koivunen, Mikko" <Mikko.Koivunen@fi.rohmeurope.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] iio: light: rpr0521 disable sensor -bugfix
Date: Thu, 13 Apr 2017 06:35:19 +0000
Message-ID: <E223F49C7E3E1C4E8F3928A8EC9CF0F8DBEC4925@WILL-MAIL002.REu.RohmEu.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <19d68038-5af3-2728-cbc9-8df28b3b26d9@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 8.4.2017 17:47, Jonathan Cameron wrote:
> On 07/04/17 13:07, Mikko Koivunen wrote:
>> Sensor was marked enabled on each call even if the call was for disabling
>> sensor.
>>
>> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> What effect does this have on device operation?

Actually none with current code.
Because it's never called for disabling, not even in_poweroff(). This
could also be fixed by removing second parameter and hardcoding status
as _MODE_x_ENABLE.

> What I'm looking for is info on whether this wants to go to stable as
> it will cause the device not to work, or whether it is wasting power etc.
>
> Also useful to add a fixes tag as that makes it easy for stable maintainers
> to filter incoming patches for relevance to their trees.
>
> Will be looking for Acks from Daniel on all of these as he wrote the original
> and is still active.
>
> Jonathan
>> ---
>> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
>>
>>  drivers/iio/light/rpr0521.c |   11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
>> index 7de0f39..c15529b 100644
>> --- a/drivers/iio/light/rpr0521.c
>> +++ b/drivers/iio/light/rpr0521.c
>> @@ -197,8 +197,10 @@ static int rpr0521_als_enable(struct rpr0521_data *data, u8 status)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	data->als_dev_en = true;
>> -
>> +	if (status & RPR0521_MODE_ALS_MASK)
>> +		data->als_dev_en = true;
>> +	else
>> +		data->als_dev_en = false;
>>  	return 0;
>>  }
>>  
>> @@ -212,7 +214,10 @@ static int rpr0521_pxs_enable(struct rpr0521_data *data, u8 status)
>>  	if (ret < 0)
>>  		return ret;
>>  
>> -	data->pxs_dev_en = true;
>> +	if (status & RPR0521_MODE_PXS_MASK)
>> +		data->pxs_dev_en = true;
>> +	else
>> +		data->pxs_dev_en = false;
>>  
>>  	return 0;
>>  }
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

