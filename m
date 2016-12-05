Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:34221 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbcLELIj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Dec 2016 06:08:39 -0500
Received: by mail-qk0-f175.google.com with SMTP id q130so154313749qke.1
        for <linux-iio@vger.kernel.org>; Mon, 05 Dec 2016 03:08:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161205065350.GA18069@ulmo.ba.sec>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-4-git-send-email-benjamin.gaignard@st.com> <20161205065350.GA18069@ulmo.ba.sec>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Mon, 5 Dec 2016 12:08:32 +0100
Message-ID: <CA+M3ks4-JQNGYtdiXNj1J701x0njKD0_bf4yN1mLSjEcT2Z=6A@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] PWM: add pwm-stm32 DT bindings
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
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

2016-12-05 7:53 GMT+01:00 Thierry Reding <thierry.reding@gmail.com>:
> On Fri, Dec 02, 2016 at 11:17:18AM +0100, Benjamin Gaignard wrote:
>> Define bindings for pwm-stm32
>>
>> version 2:
>> - use parameters instead of compatible of handle the hardware configuration
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> new file mode 100644
>> index 0000000..575b9fb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> @@ -0,0 +1,38 @@
>> +STMicroelectronics PWM driver bindings for STM32
>
> Technically this bindings describe devices, so "driver binding" is a
> somewhat odd wording. Perhaps:
>
>         STMicroelectronics STM32 General Purpose Timer PWM bindings
>
> ?
 done

>
>> +
>> +Must be a sub-node of STM32 general purpose timer driver
>> +Parent node properties are describe in ../mfd/stm32-general-purpose-timer.txt
>
> Again, "driver parent node" is odd. Perhaps:
>
>         Must be a sub-node of an STM32 General Purpose Timer device tree
>         node. See ../mfd/stm32-general-purpose-timer.txt for details about
>         the parent node.
>
> ?

done

>
>> +Required parameters:
>> +- compatible:                Must be "st,stm32-pwm"
>> +- pinctrl-names:     Set to "default".
>> +- pinctrl-0:                 List of phandles pointing to pin configuration nodes
>> +                     for PWM module.
>> +                     For Pinctrl properties, please refer to [1].
>
> Your indentation and capitalization are inconsistent. Also, please refer
> to the pinctrl bindings by relative path and inline, rather than as a
> footnote reference.

OK

>
>> +
>> +Optional parameters:
>> +- st,breakinput:     Set if the hardware have break input capabilities
>> +- st,breakinput-polarity: Set break input polarity. Default is 0
>> +                      The value define the active polarity:
>> +                       - 0 (active LOW)
>> +                       - 1 (active HIGH)
>
> Could we fold these into a single property? If st,breakinput-polarity is
> not present it could simply mean that there is no break input, and if it
> is present you don't have to rely on a default.

I need to know if I have to activate breakinput feature and on which level
I will rewrite it like that:
Optional parameters:
- st,breakinput-polarity-high: Set if break input polarity is active
on high level.
- st,breakinput-polarity-high: Set if break input polarity is active
on low level.

>> +- st,pwm-num-chan:   Number of available PWM channels.  Default is 0.
>
> The pwm- prefix is rather redundant since the node is already named pwm.
> Why not simply st,channels? Or simply channels, since it's not really
> anything specific to this hardware.
>
> Come to think of it, might be worth having a discussion with our DT
> gurus about what their stance is on using the # as prefix for numbers
> (such as in #address-cells or #size-cells). This could be #channels to
> mark it more explicitly as representing a count.
>
>> +- st,32bits-counter: Set if the hardware have a 32 bits counter
>> +- st,complementary:  Set if the hardware have complementary output channels
>
> "hardware has" and also maybe mention explicitly that this is a boolean
> property. Otherwise people might be left wondering what it should be set
> to. Or maybe word this differently to imply that it's boolean:
>
>         - st,32bits-counter: if present, the hardware has a 32 bit counter
>         - st,complementary: if present, the hardware has a complementary
>                             output channel

I found a way to detect, at probe time, the number of channels, counter size,
break input capability and complementary channels so I will remove
"st,breakinput", "st,32bits-counter", "st,complementary" and "st,pwm-num-chan"
parameters

>
> Thierry
