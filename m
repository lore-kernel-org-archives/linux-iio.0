Return-Path: <SRS0=ZWEJ=7D=lechnology.com=david@kernel.org>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads7950: Allow to use on ACPI
 platforms
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org
References: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
 <20170728222015.43574-2-andriy.shevchenko@linux.intel.com>
 <9d74cad7-be8e-9893-58bd-9fdd50298723@lechnology.com>
 <20170730143158.3b907e8f@kernel.org>
 <1501602326.29303.332.camel@linux.intel.com>
 <51d5783f-4a7d-b51e-fd45-e4d84576f1c3@lechnology.com>
 <1501605706.29303.339.camel@linux.intel.com>
From: David Lechner <david@lechnology.com>
Message-ID: <5355ac7e-e828-ff2f-dbde-18b4a0fc91c3@lechnology.com>
Date: Tue, 1 Aug 2017 12:09:33 -0500
MIME-Version: 1.0
In-Reply-To: <1501605706.29303.339.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 08/01/2017 11:41 AM, Andy Shevchenko wrote:
> On Tue, 2017-08-01 at 11:21 -0500, David Lechner wrote:
>> On 08/01/2017 10:45 AM, Andy Shevchenko wrote:
>>>     
>>>>>> +	/* Use hard coded value for reference voltage in ACPI
>>>>>> case */
>>>>>> +	if (ACPI_COMPANION(&spi->dev))
>>>>>> +		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
>>>>>
>>>>> Instead of checking or ACPI, you could just say "if we have a
>>>>> dummy
>>>>> regulator, then use the default value".
>>>
>>>
>>>> Agreed. Sounds sensible to me.  Hopefully in DT people will
>>>> provide the right regulator, but chances are this won't
>>>> always happen.
>>>
>>> There is no call like
>>> regulator_is_dummy()
>>> (and, looking into the code of regulator framework, can't be)
>>>
>>> Can you elaborate a bit, maybe I'm missing something obvious?
>>>
>>
>> I haven't tested this, but shouldn't regulator_get_voltage() return
>> an
>> error for a dummy regulator? You could use this as your test.
> 
> While it would work it's very fragile.
> 
> _regulator_get_voltage() will return error code even for normal
> regulators if something happened there. And user gets an impression that
> everything is okay while it's not.
> 
> So, I wouldn't go this way.
> 
>>
>> static int ti_ads7950_get_range(struct ti_ads7950_state *st)
>> {
>> 	int vref;
>>
>> 	vref = regulator_get_voltage(st->reg);
>> 	if (vref < 0)
>> -		return vref;
>> +		vref = 2500000;
>>
>> 	vref /= 1000;
>>
>> 	if (st->settings & TI_ADS7950_CR_RANGE_5V)
>> 		vref *= 2;
>>
>> 	return vref;
>> }
>>
> 

OK. There is also devm_regulator_get_optional(). This will return 
ERR_PTR(-ENODEV) instead of a dummy regulator. Then you could add a 
check for this error and set st->reg = NULL if we get -ENODEV. Make the 
enable and disable conditional. And use the default voltage if we don't 
have a regulator.


But this is probably even messier than the original ACPI patch. :-/
