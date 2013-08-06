Return-Path: <Josh.wu@atmel.com>
Message-ID: <5200CECE.7030804@atmel.com>
Date: Tue, 6 Aug 2013 18:24:14 +0800
From: Josh Wu <josh.wu@atmel.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, "nicolas.ferre@atmel.com"
	<nicolas.ferre@atmel.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
	"plagnioj@jcrosoft.com" <plagnioj@jcrosoft.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/5] iio: at91: introduce touch screen support in iio
 adc driver
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-6-git-send-email-josh.wu@atmel.com> <20130722131747.GA32221@e106331-lin.cambridge.arm.com> <51F0DA36.3090608@atmel.com> <20130725164503.GB22291@e106331-lin.cambridge.arm.com>
In-Reply-To: <20130725164503.GB22291@e106331-lin.cambridge.arm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Dear Mark

Thanks for the detailed comment. Check mine in below:

On 7/26/2013 12:45 AM, Mark Rutland wrote:
> On Thu, Jul 25, 2013 at 08:56:38AM +0100, Josh Wu wrote:
>> Hi, Dear Mark
>>
>> On 7/22/2013 9:17 PM, Mark Rutland wrote:
>>> On Sun, Jul 14, 2013 at 09:04:29AM +0100, Josh Wu wrote:
>>>> AT91 ADC hardware integrate touch screen support. So this patch add touch
>>>> screen support for at91 adc iio driver.
>>>> To enable touch screen support in adc, you need to add the dt parameters:
>>>>     which type of touch are used? (4 or 5 wires), sample period time,
>>>>     pen detect debounce time, average samples and pen detect resistor.
>>>>
>>>> In the meantime, since touch screen will use a interal period trigger of adc,
>>>> so it is conflict to other hardware triggers. Driver will disable the hardware
>>>> trigger support if touch screen is enabled.
>>>>
>>>> This driver has been tested in AT91SAM9X5-EK and SAMA5D3x-EK.
>>>>
>>>> Signed-off-by: Josh Wu <josh.wu@atmel.com>
>>>> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>>>> ---
>>>>    .../devicetree/bindings/arm/atmel-adc.txt          |   13 +
>>>>    arch/arm/mach-at91/include/mach/at91_adc.h         |   34 ++
>>>>    drivers/iio/adc/at91_adc.c                         |  389 ++++++++++++++++++--
>>>>    3 files changed, 412 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/atmel-adc.txt b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>>>> index 0db2945..925d656 100644
>>>> --- a/Documentation/devicetree/bindings/arm/atmel-adc.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/atmel-adc.txt
>>>> @@ -29,6 +29,19 @@ Optional properties:
>>>>      - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
>>>>      - atmel,adc-clock-rate: ADC clock rate. If not specified, use the default
>>>>                             adc_op_clk.
>>>> +  - atmel,adc-touchscreen-wires: Number of touch screen wires. Only support
>>>> +                                4 and 5 wires touch screen.
>>> Are 4 and 5 wire configurations that can exist, or the only ones
>>> supported by the driver?
>> It can be set:
>>
>> atmel,adc-touchscreen-wires = <4>;
>> or
>> atmel,adc-touchscreen-wires = <5>;
>>
>> according to your touch screen.
> That doesn't answer my question.
>
> Is it possible that 3 or 6 wire configurations might exist, for example,
> even if not supported by this driver? Or does the design of the adc
> prevent this?

No, only 4-wire or 5-wire touch screen support in market so far.

>
> Is there any documentation that might make this clearer?
>
>>>> +    NOTE: when adc touch screen enabled, the adc hardware trigger will be
>>>> +          disabled. Since touch screen will occupied the trigger register.
>>>> +  - atmel,adc-ts-pendet-debounce: Debounce time in microsecond for touch pen
>>>> +                                 detect.
>>> For consistency with the adc-touchscreen-wires property, and  other
>>> properties with timing information, how about
>>> atmel,adc-touchscreen-debounce-delay-us ?
>> sound nice to me.
> Additionally, is this likely to vary from board to board? This feels
> like configuration that could be done based on the compatible string...
>
>>>> +  - atmel,adc-ts-sample-period-time: Sample Period Time in microsecond for
>>>> +                                    touch screen
>>> Again, please be consistent with ts or touchscreen. It may also be good
>>> to have -us to make the units explicit (though it does leave the
>>> property name being quite a mothful):
>>>
>>> atmel,adc-touchscreen-sample-period-us ?
>> nice. I will use this one.
> Looking again at the driver code, it looks like a value derived from
> this eventually gets written to the hardware. Is this a fixed value at
> integration time, or is this a configuration value? If it's the latter,
> can the driver not derive a good value for this itself?

After a further thinking, I think it is better to remove this sample 
period us & pen detect debouce us.
Since it is a fixed value and no need to change it so far (in 
at91sam9x5ek, sama5d3xek).

>
>>>> +  - atmel,adc-ts-filter-average: Numbers of sampling data will be averaged.
>>>> +    0 means no average. 1 means average two samples. 2 means average four
>>>> +    samples. 3 means average eight samples.
>>> Is this averaging done in the hardware, or the kernel driver?
>> It is done in the hardware.
> Similarly, this seems to eventually get written to hardware, and thus
> seems more like configuration than hardware description. Why does this
> need to be in the DT?
>
> As an aside, in general it's nicer to describe a property as a logical
> value rather than the raw value that gets programmed into hardware (e.g.
> this property could by 2, 4, or 8 rather than 1, 2, or 4).
>
>> But for some soc, like AT91SAM9G45, hardware doesn't support hardware
>> average.
>> So I am wondering use it as for both hardware and softer average.
>>
>> BTW, you mentioned the kernel driver, do you mean a filter algorithm is
>> already implemented in kernel library?
> I do not know of any such filter algorithm in the kernel, though there
> may be one. I was simply confused as to what this was used for.
>
>>> If it's the latter, this can be left for the kernel to decide.
>>>
>>>> +  - atmel,adc-ts-pendet-sensitivity: Pen Detection input pull-up resistor.
>>>> +    It can be 0, 1, 2, 3.
>>> I think "pendet" is a bit opaque. "pen-detect" may be better.
>> yes. I'll change this.
>>
>>> What
>>> physical property does this represent (are these discrete values, or an
>>> enumeration)?
>> This property is supported by hardware, it can change the adc internal
>> resistor value for better pen detection,
>>        * 0 = 200 kOhm, 1 = 150 kOhm, 2 = 100 kOhm, 3 = 50 kOhm
>> In general, we just use default value 2 for 100kOhm.
> This value eventually gets written to hardware, and seems more like
> configuration than hardware description. Why does this need to be in the
> DT?

I am a little bit confused by the hardware configuration and hardware 
description.
It seems I prefer to put all the hardware configurable value to DT. 
Since I think this can be changed in DT.
But as you mentioned above, only the hardware description can be in DT.
Could you give me a more detail about the difference between hardware 
configuration and hardware description?

Thanks in advance.

>
> Thanks,
> Mark.

[... ...]

Best Regards,
Josh Wu
