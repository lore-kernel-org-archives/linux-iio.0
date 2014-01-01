Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:65166 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825AbaAANRH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 1 Jan 2014 08:17:07 -0500
Received: from [192.168.0.80] ([188.102.227.0]) by mail.gmx.com (mrgmx003)
 with ESMTPSA (Nemesis) id 0MFdDB-1WAjbg2POH-00Ee6A for
 <linux-iio@vger.kernel.org>; Wed, 01 Jan 2014 14:17:06 +0100
Message-ID: <52C4154F.2050902@gmx.de>
Date: Wed, 01 Jan 2014 14:17:03 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH]staging:iio:ad799x make use of platform_data optional
References: <52C00C37.2080009@gmx.de> <52C4105F.3020600@kernel.org>
In-Reply-To: <52C4105F.3020600@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Jonathan Cameron schrieb:
> On 29/12/13 11:49, Hartmut Knaack wrote:
>> Setting Vref with platform_data is a neat feature, though it is not essential
>> for operating these devices. So make the use of platform_data optional and set
>> default value of 1000 mV if nothing else is defined.
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> Hi Hartmut,
Hi
>
> Why a default of 1V?  Does that correspond to anything in particular?
This makes it easier to calculate your real voltage, since you only need to multiply with your reference voltage. Another reason: if you are more interested in the relation of your input in the range [0V-Vref], you can simply get the per mill value.
>
> Whilst the way this is set here is clunky there is a need for this 
> voltage to be supplied in some fashion.  Now we'd do it via a regulator
> to give us nice standard device tree bindings and to allow for less 
> simplistic hardware configurations.
>
> So lets say we convert this to use a regulator, is there still a reason 
> why one might want a default value?
I'm not aware of the current state of the device tree implementation at the moment. My intention is to also be able to use this driver without the need of compiling a custom kernel (so to use the distribution of choice out of the box).
>
> Jonathan
>
>
>> ---
>> diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
>> index 9428be8..e32a555 100644
>> --- a/drivers/staging/iio/adc/ad799x_core.c
>> +++ b/drivers/staging/iio/adc/ad799x_core.c
>> @@ -545,10 +545,12 @@ static int ad799x_probe(struct i2c_client *client,
>>
>>   	/* TODO: Add pdata options for filtering and bit delay */
>>
>> -	if (!pdata)
>> -		return -EINVAL;
>> -
>> -	st->int_vref_mv = pdata->vref_mv;
>> +	if ((!pdata) || (!pdata->vref_mv)) {
>> +		dev_warn(&client->dev,
>> +			 "No platform data found, setting Vref to 1000 mV\n");
>> +		st->int_vref_mv = 1000;
>> +	} else
>> +		st->int_vref_mv = pdata->vref_mv;
>>
>>   	st->reg = devm_regulator_get(&client->dev, "vcc");
>>   	if (!IS_ERR(st->reg)) {
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

