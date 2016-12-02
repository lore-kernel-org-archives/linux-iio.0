Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35183 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934231AbcLBOXd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Dec 2016 09:23:33 -0500
Received: by mail-qk0-f175.google.com with SMTP id n204so280059893qke.2
        for <linux-iio@vger.kernel.org>; Fri, 02 Dec 2016 06:23:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161202135904.GN2683@dell>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-6-git-send-email-benjamin.gaignard@st.com> <20161202135904.GN2683@dell>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 2 Dec 2016 15:23:31 +0100
Message-ID: <CA+M3ks7GhvApJwZVFK7KAbbvbAhp40sdOVvhkyZWBHZXpLfZDQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] IIO: add bindings for stm32 timer trigger driver
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
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

2016-12-02 14:59 GMT+01:00 Lee Jones <lee.jones@linaro.org>:
> On Fri, 02 Dec 2016, Benjamin Gaignard wrote:
>
>> Define bindings for stm32 timer trigger
>>
>> version 3:
>> - change file name
>> - add cross reference with mfd bindings
>>
>> version 2:
>> - only keep one compatible
>> - add DT parameters to set lists of the triggers:
>>   one list describe the triggers created by the device
>>   another one give the triggers accepted by the device
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>> ---
>>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 39 +++++++++++++++=
+++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-ti=
mer-trigger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-tri=
gger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.=
txt
>> new file mode 100644
>> index 0000000..858816d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.tx=
t
>> @@ -0,0 +1,39 @@
>> +timer trigger bindings for STM32
>> +
>> +Must be a sub-node of STM32 general purpose timer driver
>> +Parent node properties are describe in ../mfd/stm32-general-purpose-tim=
er.txt
>> +
>> +Required parameters:
>> +- compatible:                must be "st,stm32-iio-timer"
>> +- interrupts:                Interrupt for this device
>> +                     See ../interrupt-controller/st,stm32-exti.txt
>> +
>> +Optional parameters:
>> +- st,input-triggers-names:   List of the possible input triggers for
>> +                             the device
>> +- st,output-triggers-names:  List of the possible output triggers for
>> +                             the device
>> +
>> +Possible triggers are defined in include/dt-bindings/iio/timer/st,stm32=
-timer-trigger.h
>> +
>> +Example:
>> +     gptimer1: gptimer1@40010000 {
>> +             compatible =3D "st,stm32-gptimer";
>> +             reg =3D <0x40010000 0x400>;
>> +             clocks =3D <&rcc 0 160>;
>> +             clock-names =3D "clk_int";
>> +
>> +             timer1@0 {
>> +                     compatible =3D "st,stm32-timer-trigger";
>> +                     interrupts =3D <27>;
>> +                     st,input-triggers-names =3D TIM5_TRGO,
>> +                                               TIM2_TRGO,
>> +                                               TIM4_TRGO,
>> +                                               TIM3_TRGO;
>> +                     st,output-triggers-names =3D TIM1_TRGO,
>> +                                                TIM1_CH1,
>> +                                                TIM1_CH2,
>> +                                                TIM1_CH3,
>> +                                                TIM1_CH4;
>
> I see why you've done it like this now ... because it makes things
> easier for you in the driver, since the IIO subsystem matches on names
> such as these.
>
> BUT, this is a Linux-implementation-ism.  Just use pairs of integers
> and create the Linux-ism strings in the driver.

The goal is not to make things easier in driver but to be able to share
the triggers names with other drivers like DAC or ADC.
If each driver have to create it own triggers names it will more difficult
to keep them coherent than it they share the same definitions

>
>> +             };
>> +     };
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
