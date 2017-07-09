Return-Path: <SRS0=c94r=6M=redhat.com=hdegoede@kernel.org>
Subject: Re: [PATCH] iio: adc: axp288: Fix the GPADC pin reading often wrongly
 returning 0
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
References: <20170708131157.13704-1-hdegoede@redhat.com>
 <20170709192204.0c7131d4@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d9d7599e-fcad-43aa-122e-f537f92435df@redhat.com>
Date: Sun, 9 Jul 2017 20:24:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170709192204.0c7131d4@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi,

On 09-07-17 20:22, Jonathan Cameron wrote:
> On Sat,  8 Jul 2017 15:11:57 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> I noticed in its DSDT that one of my tablets actually is using the GPADC
>> pin for temperature monitoring.
>>
>> The whole axp288_adc_set_ts() function is a bit weird, in the past it was
>> removed because it seems to make no sense, then this was reverted because
>> of regressions.
>>
>> So I decided to test the special GPADC pin handling on this tablet.
>> Conclusion: not only is axp288_adc_set_ts() necessary, we need to sleep a
>> bit after making the AXP288_ADC_TS_PIN_CTRL changes before sampling the
>> GPADC, otherwise it will often (about 80% of the time) read 0 instead of
>> its actual value.
>>
>> It seems that there is only 1 bias current source and to be able to use it
>> for the GPIO0 pin in GPADC mode it must be temporarily turned off for the
>> TS pin, but the datasheet does not mention this.
>>
>> This commit adds a sleep after disabling the TS pin bias current,
>> fixing the GPADC more often then not wrongly returning 0.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Hans,
> 
> This is sufficiently weird that I want your opinion on what
> to do with this.   Are we looking at a necessary fix for a hardware
> platform that we should push out asap and mark for stable?
> 
> Or is this a bit of an odd corner case where a slower path makes
> more sense?

Since we have had this bug for ages and no-one has noticed I think
taking this a bit slower is fine. Would be nice to get it into 4.13,
but no need for a Cc stable IMHO.

Thanks & Regards,

Hans


> 
> I'm happy either way.
> 
> Jonathan
>> ---
>>   drivers/iio/adc/axp288_adc.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
>> index 7fd24949c0c1..462a99c13e7a 100644
>> --- a/drivers/iio/adc/axp288_adc.c
>> +++ b/drivers/iio/adc/axp288_adc.c
>> @@ -126,11 +126,21 @@ static int axp288_adc_read_channel(int *val, unsigned long address,
>>   static int axp288_adc_set_ts(struct regmap *regmap, unsigned int mode,
>>   				unsigned long address)
>>   {
>> +	int ret;
>> +
>>   	/* channels other than GPADC do not need to switch TS pin */
>>   	if (address != AXP288_GP_ADC_H)
>>   		return 0;
>>   
>> -	return regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, mode);
>> +	ret = regmap_write(regmap, AXP288_ADC_TS_PIN_CTRL, mode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* When switching to the GPADC pin give things some time to settle */
>> +	if (mode == AXP288_ADC_TS_PIN_GPADC)
>> +		usleep_range(6000, 10000);
>> +
>> +	return 0;
>>   }
>>   
>>   static int axp288_adc_read_raw(struct iio_dev *indio_dev,
> 
