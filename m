Return-Path: <SRS0=Hfsx=YY=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170109180448.f3pcpuarhcddo76b@rob-hp-laptop>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-6-git-send-email-benjamin.gaignard@st.com> <20170109180448.f3pcpuarhcddo76b@rob-hp-laptop>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 10 Jan 2017 09:55:26 +0100
Message-ID: <CA+M3ks713cwuaeBwrPett+KrbQC5-w0oyq7aSTrdHReWYVQRoQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] IIO: add bindings for STM32 timer trigger driver
To: Rob Herring <robh@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	Alexandre Torgue <alexandre.torgue@st.com>, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	Linux PWM List <linux-pwm@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

2017-01-09 19:04 GMT+01:00 Rob Herring <robh@kernel.org>:
> On Thu, Jan 05, 2017 at 10:25:41AM +0100, Benjamin Gaignard wrote:
>> Define bindings for STM32 timer trigger
>>
>> version 4:
>> - remove triggers enumeration from DT
>> - add reg parameter
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
>>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 +++++++++++++++=
+++++++
>>  1 file changed, 23 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-ti=
mer-trigger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iio/timer/stm32-timer-tri=
gger.txt b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.=
txt
>> new file mode 100644
>> index 0000000..36a6c4a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.tx=
t
>> @@ -0,0 +1,23 @@
>> +STMicroelectronics STM32 Timers IIO timer bindings
>> +
>> +Must be a sub-node of an STM32 Timers device tree node.
>> +See ../mfd/stm32-timers.txt for details about the parent node.
>> +
>> +Required parameters:
>> +- compatible:        Must be "st,stm32-timer-trigger".
>> +- reg:               Define triggers configuration of the hardware IP.
>
> Valid values? Not sure this makes sense for use of reg. reg should be
> how you address or id a device.

I use reg like an id to distinguish device and get the right
configuration inside
the driver.

>
>> +
>> +Example:
>> +     timers@40010000 {
>> +             #address-cells =3D <1>;
>> +             #size-cells =3D <0>;
>> +             compatible =3D "st,stm32-timers";
>> +             reg =3D <0x40010000 0x400>;
>> +             clocks =3D <&rcc 0 160>;
>> +             clock-names =3D "clk_int";
>> +
>> +             timer {
>
> This would also need an unit address.

Ok I will fix that

>
>> +                     compatible =3D "st,stm32-timer-trigger";
>> +                     reg =3D <0>;
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
