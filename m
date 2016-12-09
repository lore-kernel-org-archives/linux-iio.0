Return-Path: <SRS0=8KPB=XY=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161209085331.GB3625@dell.home>
References: <1481199650-22484-1-git-send-email-benjamin.gaignard@st.com>
 <1481199650-22484-2-git-send-email-benjamin.gaignard@st.com> <20161209085331.GB3625@dell.home>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 9 Dec 2016 13:40:16 +0100
Message-ID: <CA+M3ks4AKfj9_uXo9AiW22TnB8WUzDV1NnmsO1yJ3hZfHUvoJw@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] MFD: add bindings for STM32 General Purpose Timer driver
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2016-12-09 9:53 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> Sorry to do this Ben.  Not much to do now though!
>
>> Add bindings information for STM32 General Purpose Timer
>>
>> version 2:
>> - rename stm32-mfd-timer to stm32-gptimer
>> - only keep one compatible string
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../bindings/mfd/stm32-general-purpose-timer.txt   | 39 +++++++++++++++=
+++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-general-=
purpose-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/stm32-general-purpose=
-timer.txt b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-ti=
mer.txt
>> new file mode 100644
>> index 0000000..ce67755
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/stm32-general-purpose-timer.=
txt
>> @@ -0,0 +1,39 @@
>> +STM32 General Purpose Timer driver bindings
>
> This is a great place to describe what we're *actually* trying to
> achieve with this driver, and the worst place to use the term "general
> purpose", since this IP is so much more than that.
>
>
> "STM32 Timers
>
> This IP provides 3 types of timer along with PWM functionality.
>
> [...]"
>
> ... then go on to explain what the 3 types are and how they can be
> used.
>
>> +Required parameters:
>> +- compatible: must be "st,stm32-gptimer"
>
> I vehemently disagree that this entire IP is a GP Timer.  It contains
> GP timers, sure, but it also contains Advanced and Basic timers.
>
> IMHO this compatible should be "st,stm32-timers".
>
> And the file name of both this and the *.c file should reflect that
> too.

I will do those name changes in v6.

>
> Remainder looks nice.
>
>> +- reg:                       Physical base address and length of the co=
ntroller's
>> +                     registers.
>> +- clock-names:               Set to "clk_int".
>> +- clocks:            Phandle to the clock used by the timer module.
>> +                     For Clk properties, please refer to ../clock/clock=
-bindings.txt
>> +
>> +Optional parameters:
>> +- resets:            Phandle to the parent reset controller.
>> +                     See ../reset/st,stm32-rcc.txt
>> +
>> +Optional subnodes:
>> +- pwm:                       See ../pwm/pwm-stm32.txt
>> +- timer:             See ../iio/timer/stm32-timer-trigger.txt
>> +
>> +Example:
>> +     timers@40010000 {
>> +             #address-cells =3D <1>;
>> +             #size-cells =3D <0>;
>> +             compatible =3D "st,stm32-gptimer";
>> +             reg =3D <0x40010000 0x400>;
>> +             clocks =3D <&rcc 0 160>;
>> +             clock-names =3D "clk_int";
>> +
>> +             pwm@0 {
>
> Out of interest, do you use the "@0", "@1" for anything now?

No I don't use them so I will remove them in v6

>
>> +                     compatible =3D "st,stm32-pwm";
>> +                     pinctrl-0       =3D <&pwm1_pins>;
>> +                     pinctrl-names   =3D "default";
>> +             };
>> +
>> +             timer@0 {
>> +                     compatible =3D "st,stm32-timer-trigger";
>> +                     reg =3D <0>;
>> +             };
>> +     };
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
