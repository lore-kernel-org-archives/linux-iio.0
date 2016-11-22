Return-Path: <benjamin.gaignard@linaro.org>
MIME-Version: 1.0
In-Reply-To: <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com> <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Tue, 22 Nov 2016 18:01:11 +0100
Message-ID: <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
	Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com, devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>, Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

[snip]
>> +     "st,stm32-iio-timer5"
>> +     "st,stm32-iio-timer6"
>> +     "st,stm32-iio-timer7"
>> +     "st,stm32-iio-timer8"
>> +     "st,stm32-iio-timer9"
>> +     "st,stm32-iio-timer10"
>> +     "st,stm32-iio-timer11"
>> +     "st,stm32-iio-timer12"
>> +     "st,stm32-iio-timer13"
>> +     "st,stm32-iio-timer14"
>
> We can't do this. This is a binding for a driver, not for the hardware.
>

Unfortunately each instance for the hardware IP have little
differences like which triggers they could accept or size of the
counter register,
and I doesn't have value inside the hardware to distinguish them so
the only way I found is to use compatible.
