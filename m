Return-Path: <wharms@bfs.de>
Message-ID: <539812DB.5080903@bfs.de>
Date: Wed, 11 Jun 2014 10:27:07 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Jonathan Cameron <jic23@kernel.org>,
 Grant Likely <grant.likely@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Josh Wu <josh.wu@atmel.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Thomas Meyer <thomas@m3y3r.de>,
 Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
 Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] iio: adc: at91: signedness bug in at91_adc_get_trigger_value_by_name()
References: <20140611065356.GB16443@mwanda> <53980711.5030604@bfs.de> <20140611081220.GP5500@mwanda>
In-Reply-To: <20140611081220.GP5500@mwanda>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>



Am 11.06.2014 10:12, schrieb Dan Carpenter:
> On Wed, Jun 11, 2014 at 09:36:49AM +0200, walter harms wrote:
>>
>>
>> Am 11.06.2014 08:53, schrieb Dan Carpenter:
>>> The function returns a u8 so the -ENOMEM is truncated to a positive
>>> value.  The caller tests for zero returns and treats them as an error
>>> so I have changed the -ENOMEM to 0.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>
>>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
>>> index 3b5bacd..5ebe33d 100644
>>> --- a/drivers/iio/adc/at91_adc.c
>>> +++ b/drivers/iio/adc/at91_adc.c
>>> @@ -525,7 +525,7 @@ static u8 at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
>>>  				idev->id,
>>>  				triggers[i].name);
>>>  		if (!name)
>>> -			return -ENOMEM;
>>> +			return 0;
>>>  
>>>  		if (strcmp(trigger_name, name) == 0) {
>>>  			value = triggers[i].value;
>>
>>
>> hi Dan,
>> LXR says there is only 1 caller (and he is checking for ENOMON)
>                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> No, it's not?  It's checking for zero.
> 

i as looking at at91_adc_configure_trigger() may it has changed lately

363
364         value = at91_adc_get_trigger_value_by_name(idev,
365                                                    st->trigger_list,
366                                                    idev->trig->name);
367         if (value == 0)
368                 return -EINVAL;

>> perhaps it is better to change  the return value to int.
> 
> In theory, it's always better to preserve the error code but in real
> life, this memory allocation is going to succeed.  I'm not able to
> compile this code, and that change is quite a bit more involved, but
> I'll send it anyway.

no problem with me, it was only a hint, maybe the maintainer will pick it up.
In practice I found it is better to stay with int than to thing about
"optimisation" and using char or friends, it does not save anything most times
instead it has unintended consequences later.

re,
wh


> regards,
> dan carpenter
> 
> 
