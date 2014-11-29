Return-Path: <knaack.h@gmx.de>
Message-ID: <547A0D0A.2010404@gmx.de>
Date: Sat, 29 Nov 2014 19:14:34 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?Q?Kristina_Mart=c5=a1enko?=
 <kristina.martsenko@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, marex@denx.de, jbe@pengutronix.de
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com> <5478FB6D.8000303@gmx.de> <2014173365.467082.1417259209904.JavaMail.open-xchange@oxbaltgw07.schlund.de>
In-Reply-To: <2014173365.467082.1417259209904.JavaMail.open-xchange@oxbaltgw07.schlund.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Stefan Wahren schrieb am 29.11.2014 um 12:06:
> Hi Hartmut,
> 
> thanks for your review. I added Marek and Juergen in CC.
> 
>> Hartmut Knaack <knaack.h@gmx.de> hat am 28. November 2014 um 23:47
>> geschrieben:
>>
>>
>> Stefan Wahren schrieb am 19.11.2014 um 23:19:
>>> The devicetree binding for mxs-lradc defines ranges for the
>>> touchscreen properties. In order to avoid unexpected behavior like
>>> division by zero, we better check these ranges during probe and
>>> abort in error case.
>>>
>> This patch is functional correct, but I see some style issues:
>> To make a review with the DT bindings easier, it would help to compare against
>> the values which got used there (which are not in hex). For sample count, the
>> range is defined as 1...31, so it would look easier like this: if (_cnt < 1 ||
>> _cnt > 31) =>error.
> 
> I have concerns about that. The upper range is defined by the bitmask in the
> register and the lower range is defined the usage of lradc->over_sample_cnt as a
> divisor (mxs_lradc_read_raw_channel). Consequently i should use the "magic
> number" 2047 instead of LRADC_DELAY_DELAY_MASK for the other parameters?
> 
>> Another thing to consider would be to do the boundary check on adapt, and only
>> assign it to over_sample_cnt (or the other elements) if it is valid. Thinking
>> this further, it would even make sense to assign a default value to
>> over_sample_count (and the other ones) only in case that no DT property is
>> set, instead of doing it in advance and overwriting it with the custom value.
> 
> Do you think of the following?
> 
> 	if (!of_property_read_u32(lradc_node, "fsl,ave-ctrl", &adapt)) {
> 		if (adapt < 1 || adapt > 31) {
> 			dev_err(lradc->dev, "Invalid sample count (%lu)\n",
> 				adapt);
> 			return -EINVAL;
> 		}
> 		lradc->over_sample_cnt = adapt;
> 	} else
> 		lradc->over_sample_cnt = 4;
> 
Yes, that's what I had in mind. Just keep in mind, that when the if-part uses { }, the else part should use them as well.
>> A minor style nitpick inline.
>>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
>>> ---
>>> drivers/staging/iio/adc/mxs-lradc.c | 20 ++++++++++++++++++++
>>> 1 file changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
>>> b/drivers/staging/iio/adc/mxs-lradc.c
>>> index 6757f10..57c3cf6 100644
>>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>>> @@ -1500,16 +1500,36 @@ static int mxs_lradc_probe_touchscreen(struct
>>> mxs_lradc *lradc,
>>> if (ret == 0)
>>> lradc->over_sample_cnt = adapt;
>>>
>>> + if (!lradc->over_sample_cnt || lradc->over_sample_cnt > 0x1f) {
>>> + dev_err(lradc->dev, "Invalid sample count (%u)\n",
>>> + lradc->over_sample_cnt);
>> The parameter should be indented with the opening parenthesis. Same for the
>> other instances below.
> 
> Fixed in the example above ;-)
> 
> I wonder why checkpatch doesn't complain about it.
> 
You need to run it with --strict to check for minor nitpicks ;-)
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
