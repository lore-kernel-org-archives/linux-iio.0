Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46849 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202AbaAAOOr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Jan 2014 09:14:47 -0500
Message-ID: <52C422D7.4030609@kernel.org>
Date: Wed, 01 Jan 2014 14:14:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH]staging:iio:ad799x make use of platform_data optional
References: <52C00C37.2080009@gmx.de> <52C4105F.3020600@kernel.org> <52C4154F.2050902@gmx.de>
In-Reply-To: <52C4154F.2050902@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 01/01/14 13:17, Hartmut Knaack wrote:
> Jonathan Cameron schrieb:
>> On 29/12/13 11:49, Hartmut Knaack wrote:
>>> Setting Vref with platform_data is a neat feature, though it is
>>> not essential for operating these devices. So make the use of
>>> platform_data optional and set default value of 1000 mV if
>>> nothing else is defined.
>>>
>>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
>> Hi Hartmut,
> Hi
>>
>> Why a default of 1V?  Does that correspond to anything in
>> particular?
> This makes it easier to calculate your real voltage, since you only
> need to multiply with your reference voltage. Another reason: if you
> are more interested in the relation of your input in the range
> [0V-Vref], you can simply get the per mill value.
Sorry, but I'm not going to take this as whilst I can see how it
is useful for your use case, it would introduce a new non standard
interface.
>>
>> Whilst the way this is set here is clunky there is a need for this
>> voltage to be supplied in some fashion.  Now we'd do it via a
>> regulator to give us nice standard device tree bindings and to
>> allow for less simplistic hardware configurations.
>>
>> So lets say we convert this to use a regulator, is there still a
>> reason why one might want a default value?
> I'm not aware of the current state of the device tree implementation
> at the moment. My intention is to also be able to use this driver
> without the need of compiling a custom kernel (so to use the
> distribution of choice out of the box).
Then it needs to be device tree enabled and the configuration done
via that.

Jonathan
>>> ---
>>> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
>>> index 9428be8..e32a555 100644
>>> --- a/drivers/staging/iio/adc/ad799x_core.c
>>> +++ b/drivers/staging/iio/adc/ad799x_core.c
>>> @@ -545,10 +545,12 @@ static int ad799x_probe(struct i2c_client *client,
>>>
>>>    	/* TODO: Add pdata options for filtering and bit delay */
>>>
>>> -	if (!pdata)
>>> -		return -EINVAL;
>>> -
>>> -	st->int_vref_mv = pdata->vref_mv;
>>> +	if ((!pdata) || (!pdata->vref_mv)) {
>>> +		dev_warn(&client->dev,
>>> +			 "No platform data found, setting Vref to 1000 mV\n");
>>> +		st->int_vref_mv = 1000;
>>> +	} else
>>> +		st->int_vref_mv = pdata->vref_mv;
>>>
>>>    	st->reg = devm_regulator_get(&client->dev, "vcc");
>>>    	if (!IS_ERR(st->reg)) {
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
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
