Return-Path: <SRS0=exQp=XV=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161206130048.GH25385@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-2-git-send-email-benjamin.gaignard@st.com> <20161206130048.GH25385@dell.home>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 6 Dec 2016 15:02:18 +0100
Message-ID: <CA+M3ks7nUzbhUeKzi5VzJb0YhC2EWZU5k4gNCEKjHbpGrEWZtg@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] MFD: add bindings for STM32 General Purpose Timer driver
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

[snip]
>
> I'm not going to push too hard, but I still thing "advanced-control"
> would suit better, since this is not *just* a timer.  In fact, the
> parent device (the MFD) doesn't have any timer functionality.  That's
> what "timer@0" does.
>
> The IP is called "Advanced Control" in the datasheet, no?

In datasheet only timers 1 and 8 are called "advanced-control" timers
Timers 2 to 5 and 9 to 14 are called "general purpose" timers.
Timers 6 and 7 are named "basic" timers.

I have ask around in ST and it seems that "general purpose" name was the
best to describe all the timers, so I would like to keep using it.

>
>> +             #address-cells =3D <1>;
>> +             #size-cells =3D <0>;
>> +             compatible =3D "st,stm32-gptimer";
>> +             reg =3D <0x40010000 0x400>;
>> +             clocks =3D <&rcc 0 160>;
>> +             clock-names =3D "clk_int";
>> +
>> +             pwm@0 {
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
