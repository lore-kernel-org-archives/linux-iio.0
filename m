Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:35494 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbcLNNI0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2016 08:08:26 -0500
Received: by mail-qt0-f180.google.com with SMTP id c47so20996260qtc.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Dec 2016 05:07:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+qzhUAMG_jL6CSHz+kHu6M6N8Nko4KfRQRgRgtk-KTKg@mail.gmail.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-2-git-send-email-benjamin.gaignard@st.com>
 <20161212185149.rt3xqpn3mbaavb4l@rob-hp-laptop> <CA+M3ks4ukP14YE5-6+gAzJBjEmjEyGyVbsVGOm8ehVm0EfzO-w@mail.gmail.com>
 <CAL_Jsq+qzhUAMG_jL6CSHz+kHu6M6N8Nko4KfRQRgRgtk-KTKg@mail.gmail.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Wed, 14 Dec 2016 14:07:22 +0100
Message-ID: <CA+M3ks62h6Qnqjp9kaz=mbCHwOf2jmy7TGQQvED2LLH2NP0cGA@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] MFD: add bindings for STM32 Timers driver
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2016-12-13 22:07 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Tue, Dec 13, 2016 at 3:29 AM, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> wrote:
>> 2016-12-12 19:51 GMT+01:00 Rob Herring <robh@kernel.org>:
>>> On Fri, Dec 09, 2016 at 03:15:12PM +0100, Benjamin Gaignard wrote:
>>>> Add bindings information for STM32 Timers
>>>>
>>>> version 6:
>>>> - rename stm32-gtimer to stm32-timers
>>>> - change compatible
>>>> - add description about the IPs
>>>>
>>>> version 2:
>>>> - rename stm32-mfd-timer to stm32-gptimer
>>>> - only keep one compatible string
>>>>
>>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>>> ---
>>>>  .../devicetree/bindings/mfd/stm32-timers.txt       | 46 +++++++++++++=
+++++++++
>>>>  1 file changed, 46 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers=
.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-timers.txt b/=
Documentation/devicetree/bindings/mfd/stm32-timers.txt
>>>> new file mode 100644
>>>> index 0000000..b30868e
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/mfd/stm32-timers.txt
>>>> @@ -0,0 +1,46 @@
>>>> +STM32 Timers driver bindings
>>>> +
>>>> +This IP provides 3 types of timer along with PWM functionality:
>>>> +- advanced-control timers consist of a 16-bit auto-reload counter dri=
ven by a programmable
>>>> +  prescaler, break input feature, PWM outputs and complementary PWM o=
uputs channels.
>>>> +- general-purpose timers consist of a 16-bit or 32-bit auto-reload co=
unter driven by a
>>>> +  programmable prescaler and PWM outputs.
>>>> +- basic timers consist of a 16-bit auto-reload counter driven by a pr=
ogrammable prescaler.
>>>> +
>>>> +Required parameters:
>>>> +- compatible: must be "st,stm32-timers"
>>>> +
>>>> +- reg:                       Physical base address and length of the =
controller's
>>>> +                     registers.
>>>> +- clock-names:               Set to "clk_int".
>>>
>>> 'clk' is redundant. Also, you don't really need -names when there is
>>> only one of them.
>>
>> I use devm_regmap_init_mmio_clk() which get the clock by it name so
>> I have to define it in DT.
>
> Are you sure NULL is not allowed? I don't know, but at least clk_get()
> allows NULL.

regmap_mmio_gen_context() doesn't call clk_get() if the clock name isn't se=
t:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/driver=
s/base/regmap/regmap-mmio.c?id=3Drefs/tags/v4.9#n308

so clock-names field is really needed.

> It's fine to keep, just drop the "clk_" part.

ok

>
>>
>>>> +- clocks:            Phandle to the clock used by the timer module.
>>>> +                     For Clk properties, please refer to ../clock/clo=
ck-bindings.txt
>>>> +
>>>> +Optional parameters:
>>>> +- resets:            Phandle to the parent reset controller.
>>>> +                     See ../reset/st,stm32-rcc.txt
>>>> +
>>>> +Optional subnodes:
>>>> +- pwm:                       See ../pwm/pwm-stm32.txt
>>>> +- timer:             See ../iio/timer/stm32-timer-trigger.txt
>>>> +
>>>> +Example:
>>>> +     timers@40010000 {
>>>> +             #address-cells =3D <1>;
>>>> +             #size-cells =3D <0>;
>>>> +             compatible =3D "st,stm32-timers";
>>>> +             reg =3D <0x40010000 0x400>;
>>>> +             clocks =3D <&rcc 0 160>;
>>>> +             clock-names =3D "clk_int";
>>>> +
>>>> +             pwm {
>>>> +                     compatible =3D "st,stm32-pwm";
>>>> +                     pinctrl-0       =3D <&pwm1_pins>;
>>>> +                     pinctrl-names   =3D "default";
>>>> +             };
>>>> +
>>>> +             timer {
>>>> +                     compatible =3D "st,stm32-timer-trigger";
>>>> +                     reg =3D <0>;
>>>
>>> You don't need reg here as there is only one. In turn, you don't need
>>> #address-cells or #size-cells.
>>
>> I use "reg" to set each timer configuration.
>> From hardware point of view they are all the same except for which hardw=
are
>> signals they could consume and/or send.
>
> This sounds okay, but...
>
>> "reg" is used as index of the two tables in driver code.
>
> this statement doesn't really sound like valid use of reg.
>
> If you keep reg, then the node needs a unit address (timer@0).

I will do that in next version but I will wait for other maintainers (PWM/I=
IO)
remarks before send it

Thanks

Benjamin
>
> Rob



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
