Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:34141 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbcK2Isf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Nov 2016 03:48:35 -0500
Received: by mail-qk0-f172.google.com with SMTP id q130so167489320qke.1
        for <linux-iio@vger.kernel.org>; Tue, 29 Nov 2016 00:48:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b78a21f7-38a1-5a40-b96e-d1c9156aee68@kernel.org>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-2-git-send-email-benjamin.gaignard@st.com>
 <2b751c4a-3038-4220-05d8-d745c51a3691@kernel.org> <b78a21f7-38a1-5a40-b96e-d1c9156aee68@kernel.org>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 29 Nov 2016 09:48:34 +0100
Message-ID: <CA+M3ks4Y4FnJGqwyH0oitrxvzRnKNHA261wqfEOSfc1aA4am4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] MFD: add bindings for stm32 general purpose timer driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-11-27 16:41 GMT+01:00 Jonathan Cameron <jic23@kernel.org>:
> On 27/11/16 14:10, Jonathan Cameron wrote:
>> On 24/11/16 15:14, Benjamin Gaignard wrote:
>>> Add bindings information for stm32 general purpose timer
>>>
>>> version 2:
>>> - rename stm32-mfd-timer to stm32-gptimer
>>> - only keep one compatible string
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>> ---
>>>  .../bindings/mfd/stm32-general-purpose-timer.txt   | 43 ++++++++++++++=
++++++++
>>>  1 file changed, 43 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general=
-purpose-timer.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpos=
e-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-t=
imer.txt
>>> new file mode 100644
>>> index 0000000..2f10e67
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer=
.txt
>>> @@ -0,0 +1,43 @@
>>> +STM32 general purpose timer driver
>>> +
>>> +Required parameters:
>>> +- compatible: must be "st,stm32-gptimer"
>>> +
>>> +- reg:                      Physical base address and length of the co=
ntroller's
>>> +                    registers.
>>> +- clock-names:              Set to "clk_int".
>>> +- clocks:           Phandle to the clock used by the timer module.
>>> +                    For Clk properties, please refer to ../clock/clock=
-bindings.txt
>>> +
>>> +Optional parameters:
>>> +- resets:           Phandle to the parent reset controller.
>>> +                    See ..reset/st,stm32-rcc.txt
>>> +
>>> +Optional subnodes:
>>> +- pwm:                      See ../pwm/pwm-stm32.txt
>>> +- iiotimer:         See ../iio/timer/stm32-iio-timer.txt
>> Naming issue here.  Can't mention IIO as that's a linux subsystem and al=
l
>> bindings must be independent of OS.
>>
>> Perhaps adc-trigger-timer?
>>> +
>>> +Example:
>>> +    gptimer1: gptimer1@40010000 {
>>> +            compatible =3D "st,stm32-gptimer";
>>> +            reg =3D <0x40010000 0x400>;
>>> +            clocks =3D <&rcc 0 160>;
>>> +            clock-names =3D "clk_int";
>>> +
>>> +            pwm1@0 {
>>> +                    compatible =3D "st,stm32-pwm";
>>> +                    st,pwm-num-chan =3D <4>;
>>> +                    st,breakinput;
>>> +                    st,complementary;
>>> +            };
>>> +
>>> +            iiotimer1@0 {
>>> +                    compatible =3D "st,stm32-iio-timer";
>> Again, avoid the use of iio in here (same issue you had with mfd in the =
previous
>> version).
>>> +                    interrupts =3D <27>;
>>> +                    st,input-triggers-names =3D TIM5_TRGO,
>> Docs for these should be introduced before they are used in an example.
>> Same for the PWM ones above.  Expand the detail fo the example as you ad=
d
>> the other elements.
>
> I've just dived into the datasheet for these timers.
> http://www.st.com/content/ccc/resource/technical/document/reference_manua=
l/3d/6d/5a/66/b4/99/40/d4/DM00031020.pdf/files/DM00031020.pdf/jcr:content/t=
ranslations/en.DM00031020.pdf
>

I really appreciate that you do this effort, thanks.

>
> I think you need a binding that describes the capabilities of each of the=
 timers
> explicitly.   Down to the level of whether there is a repetition counter =
or not.
> Each should exists as a separate entity in device tree.
>
> They then have an existence as timers separate to the description of what=
 they
> are used for.
>
> Here the only way we are saying they exist is by their use which doesn't =
feel
> right to me.
>
> So I think you need to move back to what you had in the first place.  The=
 key
> thing is that ever timer needs describing fully.  They are different enou=
gh
> that for example the datasheet doesn't even try to describe them in one s=
ection.
> (it has 4 separate chapters covering different sets of these hardware blo=
cks).
> The naming isn't really based on index, we are talking different hardware
> that the datasheet authors have decided not to give different names to!

Even if the hardware are named differently in the documentation they
all share the
same registers definitions and mapping but configurations are
different for each device.

>
> If they'd called them
> advanced timers
> generic timers
> basic timers
> really basic timers meant for driving the DAC (6 and 7)
>
> We'd all have been quite happy with different compatible strings giving a=
way
> what they can do.

4 compatible strings will not be enough to describe devices
configuration, for example
in the documentation general purpose timers could have a 16 or 32 bit
counter, for 1 to 4
pwm channels and triggers (accepted or generated by the device) are
different for each device.

DAC could be drive by timers 2, 4, 5, 6, 7 and 8.
ADC could be driver by 32 triggers

> What you have here is far too specific to what you are trying to do with =
them
> right now.
>
> These things are separately capable of timing capture (which is I guess w=
here
> the IIO device later comes in).
>
> So my expectation is that we end up potentially instantiating:
>
> 1) An MFD to handle the shared elements of the timers.
> 2) Up to 12ish timers each with separate existence as a device in the dri=
ver model
> and in device tree.
> (nasty corner cases here are using timers as perscalers for other timers =
- I'd be
> tempted to leave that for now)
> Note that each of these devices has a different register set I think? Any=
 shared
> bits are handled via the mfd above (if we even need that MFD which I'm st=
arting
> to doubt looking at the datasheet).
>

pwm and trigger share the same registers but not the same bits.
With regmap write functions I don't have sharing problems.

> 3) Up to N pwms again with there own existence in the device model.  Thes=
e don't
> do much other than wrap the timer and stick it in output mode.
> 4) Up to N iio triggers - this is basically using the timer as a periodic=
 interrupt
> (though without the interrupt having visibility to the kernel) which fire=
s off
> sampling on associated ADCs.
> 5) Up to N iio capture devices for all channels that support timing captu=
re.
> Note there is also hardware encoder capture support in these which should=
 be
> correctly handled as well.  This comes back to an ancient discussion on t=
he
> TI ecap units which have similar capabilities (driver never went anywhere=
 but
> I think that was because the author left TI).
>
> Certainly for the IIO devices these should no be bound up into one instan=
ce
> as you have done here.
>
> Anyhow, I fear that right now this discussion is missing the key ingredie=
nt
> that the hardware is horrendously variable in it's capabilities and reall=
y
> is 4-5 different types of hardware that just happen to share a few bits o=
f
> their offsets in their register maps.

Hardware really share the same registers mapping that why I have wrote
one only driver
per framework. Only the configurations are different

>
> So after all that I'm almost more confused than I was at the start!
>
> Jonathan
>
>
>>> +                                              TIM2_TRGO,
>>> +                                              TIM4_TRGO,
>>> +                                              TIM3_TRGO;
>>> +                    st,output-triggers-names =3D TIM1_TRGO;
>>> +            };
>>> +    };
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
