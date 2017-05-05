Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43063 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753123AbdEESwX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 May 2017 14:52:23 -0400
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
 <1493978058.30052.26.camel@linux.intel.com>
 <cab56143-9e49-2f5c-81d5-8d4aeda4a568@siemens.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ad99c0e0-565d-5876-cc98-2751dd4faaf5@kernel.org>
Date: Fri, 5 May 2017 19:52:21 +0100
MIME-Version: 1.0
In-Reply-To: <cab56143-9e49-2f5c-81d5-8d4aeda4a568@siemens.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 11:39, Jan Kiszka wrote:
> On 2017-05-05 11:54, Andy Shevchenko wrote:
>> On Fri, 2017-05-05 at 08:31 +0200, Jan Kiszka wrote:
>>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>>> included.
>>>
>>> Due to the lack of regulators under ACPI, we need a special device
>>> property to define the voltage provide to the VA pin of the ADC
>>> ("va-millivolt"). For DT usage, the regulator "vref-supply" is
>>> requested. Note that DT usage has not been tested.
>>
>> +1 to what Mika commented on this and just some additional information.
>>
>> Other than that looks pretty good.
>>
>>> Changes in v3:
>>>  - Reworked reference voltage handling, splitting up the different
>>> ACPI
>>>    case from DT usage. This also means that the "va-millivolt"
>>>    (formerly and incorrectly called "ext-vin-microvolt") becomes
>>>    ACPI-only
>>
>> Just to be clean, there is *no* such thing as *XYZ-only* device
>> properties. The idea behind them is to provide resource provider
>> agnostic API to read properties.
> 
> Well, as along as ACPI does its own thing /wrt regulators, we have that
> problem. But let's wait until someone designs an ACPI board with that
> chip and a different reference voltage.
> 
>>
>>> +			if (st->reg)
>>> +				*val = regulator_get_voltage(st->reg) 
>>> / 1000;
>>> +			else
>>> +				*val = st->va_millivolt;
>>> +
>>
>> Another way is to not just hard code the value, but create a fixed
>> voltage regulator out of it. In this case you will have one way to get
>> its value.
> 
> That's a good idea.
Agreed. Make sure to cc Mark Brown though as I'll need an ack from him
to have a fixed reg hiding in here.
> 
>>
>>> +		st->reg = devm_regulator_get(&spi->dev, "vref");
>>
>> It should be _optional like I mentioned in one of previous review.
>>
>>> +	if (!IS_ERR(st->reg))
>>
>> This is redundant
> 
> It's not for the existing code because regulator_disable doesn't test
> this for us. It will be, though, when I switch back to making it
> mandatory for everyone.
> 
> Jan
> 
>>
>>> +		regulator_disable(st->reg);
>>
>>> +	if (!IS_ERR(st->reg))
>>
>> Ditto.
>>
>>> +		regulator_disable(st->reg);
>>
>>
> 

