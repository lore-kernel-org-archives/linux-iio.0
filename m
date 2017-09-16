Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55400 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751183AbdIPKfE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Sep 2017 06:35:04 -0400
Subject: Re: [PATCH v4 4/6] iio: adc: sun4i-gpadc-iio: add support for H3
 thermal sensor
To: icenowy@aosc.io
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-5-icenowy@aosc.io>
 <445ea236-35e9-8d5a-e580-b2bdcf5f7776@free-electrons.com>
 <0b395ea1743a14a62855fc2a2dc74411@aosc.io>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <486005c0-3954-bd49-d2e1-072661fe31a7@free-electrons.com>
Date: Sat, 16 Sep 2017 12:35:01 +0200
MIME-Version: 1.0
In-Reply-To: <0b395ea1743a14a62855fc2a2dc74411@aosc.io>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Icenowy,

On 16/09/2017 12:14, icenowy@aosc.io wrote:
> 在 2017-09-16 17:45，Quentin Schulz 写道：
>> Hi Icenowy,
>>
>> On 14/09/2017 16:52, Icenowy Zheng wrote:
>>> This adds support for the Allwinner H3 thermal sensor.
>>>
>>> Allwinner H3 has a thermal sensor like the one in A33, but have its
>>> registers nearly all re-arranged, sample clock moved to CCU and a pair
>>> of bus clock and reset added. It's also the base of newer SoCs' thermal
>>> sensors.
>>>
>>> The thermal sensors on A64 and H5 is like the one on H3, but with of
>>> course different formula factors.
>>>
>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>> ---
>>> Changes in v4:
>>> - Splitted out some code refactors.
>>> - Code sequence changed back. (The gpadc_data went back to the start of
>>>   the source file)
>>>
>>>  drivers/iio/adc/sun4i-gpadc-iio.c | 48
>>> +++++++++++++++++++++++++++++++++++++++
>>>  include/linux/mfd/sun4i-gpadc.h   | 27 ++++++++++++++++++++++
>>>  2 files changed, 75 insertions(+)
[...]
>>>  #define SUN4I_GPADC_CTRL3                0x0c
>>> +/*
>>> + * This register is named "Average filter Control Register" in H3
>>> Datasheet,
>>> + * but the register's definition is the same as the old CTRL3 register.
>>> + */
>>> +#define SUN8I_H3_GPADC_CTRL3                0x70
>>>
>>
>> I would name it as it is in the documentation:
>> SUN8I_H3_THS_FILTER
> 
> The definition of this register is the same as the CTRL3.
> 
> Maybe this name is better, but the similarity between them still needs
> to be documented, as the SUN4I_GPADC_CTRL3_XXX macros will be used to
> populate this register.
> 
>>
>> No need for comments then.
>>
>>>  #define SUN4I_GPADC_CTRL3_FILTER_EN            BIT(2)
>>>  #define SUN4I_GPADC_CTRL3_FILTER_TYPE(x)        (GENMASK(1, 0) & (x))

They have _FILTER_ in their name, isn't it enough?

Just a matter of taste for me.

>>> @@ -71,6 +84,13 @@
>>>  #define SUN4I_GPADC_INT_FIFOC_TP_UP_IRQ_EN        BIT(1)
>>>  #define SUN4I_GPADC_INT_FIFOC_TP_DOWN_IRQ_EN        BIT(0)
>>>
>>> +#define SUN8I_H3_GPADC_INTC                0x44
>>> +
>>> +#define SUN8I_H3_GPADC_INTC_TEMP_PERIOD(x)        ((GENMASK(19, 0) &
>>> (x)) << 12)
>>> +#define SUN8I_H3_GPADC_INTC_TEMP_DATA            BIT(8)
>>> +#define SUN8I_H3_GPADC_INTC_TEMP_SHUT            BIT(4)
>>> +#define SUN8I_H3_GPADC_INTC_TEMP_ALARM            BIT(0)
>>> +
>>
>> Since it isn't an ADC anymore but rather just a THS, why don't you use
>> SUN8I_H3_THS instead of SUN8I_H3_GPADC? That way, it also matches the
>> datasheet.
>>
>>>  #define SUN4I_GPADC_INT_FIFOS                0x14
>>>
>>>  #define SUN4I_GPADC_INT_FIFOS_TEMP_DATA_PENDING        BIT(18)
>>> @@ -80,9 +100,16 @@
>>>  #define SUN4I_GPADC_INT_FIFOS_TP_UP_PENDING        BIT(1)
>>>  #define SUN4I_GPADC_INT_FIFOS_TP_DOWN_PENDING        BIT(0)
>>>
>>> +#define SUN8I_H3_GPADC_INTS                0x44
>>
>> 0x48
>>
>> [...]
>>
>> 1) You're not using irqs, why would you define registers that will never
>> be used?
> 
> I will then rework it to use IRQs, but not now.
> 
> Maybe I should add it when I use them?
> 

Why not make it work right away the way we want :)?

>>
>> 2) Why aren't you using irqs? I remember we discussed on IRC that you
>> had some problems with the H3 when resuming or when probing the driver.
>> The register would have a zero in it until you have a first sample that
>> arrived (i.e. after the sample rate you set with T_ACQ) that would make
>> the thermal framework panic since the thermal sensor would return
>> something way too hot and shutdown your board?
> 
> Nope, it's another problem -- the runtime resume function is even not
> called before the first sample, and the first sample will happen when
> the THS is still suspended.
> 

As discussed on IRC (a long time ago :) ), it's a combination of two
problems:
1) get_temp (used by thermal framework) uses pm_runtime function that
isn't ready yet <= I will send a patch for registering thermal framework
after pm_runtime to you, hopefully in the upcoming hour or tomorrow,

2) The A33 (and H3 in your implementation) does not wait for an
interrupt to read the TEMP_DATA register which resets to 0 when the
sensor is disabled (or until a first sample arrives) i.e. when probing
or when resuming. Using IRQs would get rid of 2). It isn't critical for
A33 as the formula for temp returns something really cold so thermal
does not care. But for the H3, it's critically hot and shuts down your
board. To make it work on the H3, we would have to use a delay in the
pm_resume function equal to the sensor sampling rate and I don't really
like that. If we could use IRQs, it'd be better IMHO (but they aren't
working on A33).

Thanks,
Quentin

>>
>> The H3 apparently supports IRQs, why do you not support them for the
>> temperature? They might be broken as it is on A33 but then it might be a
>> good idea to write it down in a comment in the driver (and not adding
>> the unused registers in the header file) or at least in the commit log.
>>
>> 3) Now that you have support for clocks, wouldn't it be a good idea to
>> disable them during suspend?
> 
> Interesting... It's meaningful to disable the mod clock during suspend.
> 
>>
>> Thanks,
>> Quentin
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
