Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36502 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756148AbcLAIqG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Dec 2016 03:46:06 -0500
Received: by mail-qk0-f181.google.com with SMTP id n21so237486005qka.3
        for <linux-iio@vger.kernel.org>; Thu, 01 Dec 2016 00:45:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161130212055.b57qkqy66j5gg57q@rob-hp-laptop>
References: <1480000463-9625-1-git-send-email-benjamin.gaignard@st.com>
 <1480000463-9625-4-git-send-email-benjamin.gaignard@st.com> <20161130212055.b57qkqy66j5gg57q@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 1 Dec 2016 09:44:58 +0100
Message-ID: <CA+M3ks5xKHj49bLH1XQ97RrF+2xcXc-e7T5inZNN19uUWVOuRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] PWM: add pwm-stm32 DT bindings
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
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

2016-11-30 22:20 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Thu, Nov 24, 2016 at 04:14:19PM +0100, Benjamin Gaignard wrote:
>> Define bindings for pwm-stm32
>>
>> version 2:
>> - use parameters instead of compatible of handle the hardware configurat=
ion
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../devicetree/bindings/pwm/pwm-stm32.txt          | 37 +++++++++++++++=
+++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/pwm-stm32.txt b/Docum=
entation/devicetree/bindings/pwm/pwm-stm32.txt
>> new file mode 100644
>> index 0000000..36263f0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/pwm-stm32.txt
>> @@ -0,0 +1,37 @@
>> +STMicroelectronics PWM driver bindings for STM32
>> +
>> +Must be a sub-node of STM32 general purpose timer driver
>> +
>> +Required parameters:
>> +- compatible:                Must be "st,stm32-pwm"
>> +- pinctrl-names:     Set to "default".
>> +- pinctrl-0:                 List of phandles pointing to pin configura=
tion nodes
>> +                     for PWM module.
>> +                     For Pinctrl properties, please refer to [1].
>> +
>> +Optional parameters:
>> +- st,breakinput:     Set if the hardware have break input capabilities
>> +- st,breakinput-polarity: Set break input polarity. Default is 0
>> +                      The value define the active polarity:
>> +                       - 0 (active LOW)
>> +                       - 1 (active HIGH)
>> +- st,pwm-num-chan:   Number of available PWM channels.  Default is 0.
>> +- st,32bits-counter: Set if the hardware have a 32 bits counter
>> +- st,complementary:  Set if the hardware have complementary output chan=
nels
>
> What does complementary mean here?

Complementary channels are pwm channels where the signal level is inverted
compare to the original channel.
This parameter indicate that the hardware have this kind of outputs.
If the polarity of the original channel change then polarity of
complementary channel
change too.

>
>> +
>> +[1] Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
>> +
>> +Example:
>> +     gptimer1: gptimer1@40010000 {
>
> timer@...

I would like keep "timer" for timer-trigger sub-node

>
>> +             compatible =3D "st,stm32-gptimer";
>> +             reg =3D <0x40010000 0x400>;
>> +             clocks =3D <&rcc 0 160>;
>> +             clock-names =3D "clk_int";
>> +
>> +             pwm1@0 {
>
> pwm {
>
> Is there more than one?

Not per hardware block but their is 12 of them in the SoC.
Adding a number (which match with SoC documentation) help to find
the wanted pwm in sysfs either we only have the address.

>
>> +                     compatible =3D "st,stm32-pwm";
>> +                     st,pwm-num-chan =3D <4>;
>> +                     st,breakinput;
>> +                     st,complementary;
>> +             };
>> +     };
>> --
>> 1.9.1
>>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
