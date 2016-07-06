Return-Path: <martink@posteo.de>
Subject: Re: [PATCH v1] drivers:iio:accel:mma8452: removed unwanted return
 statements
To: Jonathan Cameron <jic23@kernel.org>,
 Bijosh Thykkoottathil <bijosh.t@hotmail.com>,
 "knaack.h@gmx.de" <knaack.h@gmx.de>, "lars@metafoo.de" <lars@metafoo.de>,
 "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
 "christoph.muellner@theobroma-systems.com"
 <christoph.muellner@theobroma-systems.com>
References: <KL1PR04MB12050202C107FB05AAB8EAEA80380@KL1PR04MB1205.apcprd04.prod.outlook.com>
 <c6fa0795-b316-2b65-955a-7b0acb92e027@posteo.de>
 <73916037-eaba-a3b2-9445-b3fb572e97c8@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <3c8ab52e-da4f-9cac-acb8-cdce54c65c5a@posteo.de>
Date: Wed, 6 Jul 2016 16:14:28 +0200
MIME-Version: 1.0
In-Reply-To: <73916037-eaba-a3b2-9445-b3fb572e97c8@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Am 2016-07-05 um 22:04 schrieb Jonathan Cameron:
> On 04/07/16 13:23, Martin Kepplinger wrote:
>> Am 2016-07-04 um 13:15 schrieb Bijosh Thykkoottathil:
>>> Removed unwanted return statements from the function
>>> mma8452_set_freefall_mode.
>>
>> You could've said "Don't unnecessarily save a return value.", but
>> whatever :) Thanks for your review!
>>
>>>
>>> Signed-off-by: Bijosh Thykkoottathil <bijosh.t@hotmail.com>
>> Reviewed-by: Martin Kepplinger <martink@posteo.de>
> Hi Martin,
> 
> I've flipped that tag over to an Acked-by which is more
> appropriate in this case as an in depth review as signalled
> by Reviewed-by would be 'interesting' here ;)

Sure, thanks!

> 
> I'm enjoying the slightly doom laden commit messages :)
> 
> Applied.
> 
> Jonathan
>>
>>> ---
>>>  drivers/iio/accel/mma8452.c | 6 +-----
>>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
>>> index e225d3c..d4a6d44 100644
>>> --- a/drivers/iio/accel/mma8452.c
>>> +++ b/drivers/iio/accel/mma8452.c
>>> @@ -518,11 +518,7 @@ static int mma8452_set_freefall_mode(struct mma8452_data *data, bool state)
>>>  		val |= MMA8452_FF_MT_CFG_OAE;
>>>  	}
>>>  
>>> -	val = mma8452_change_config(data, chip->ev_cfg, val);
>>> -	if (val)
>>> -		return val;
>>> -
>>> -	return 0;
>>> +	return mma8452_change_config(data, chip->ev_cfg, val);
>>>  }
>>>  
>>>  static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
