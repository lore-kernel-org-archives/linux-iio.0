Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
 <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, robh+dt@kernel.org,
 Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
 devicetree@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org,
 jic23@kernel.org, knaack.h@gmx.de, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Fabrice Gasnier <fabrice.gasnier@st.com>, Gerald Baeza
 <gerald.baeza@st.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@st.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <216b3783-9f7f-4ead-81fb-5568c762e90f@metafoo.de>
Date: Tue, 22 Nov 2016 18:02:42 +0100
MIME-Version: 1.0
In-Reply-To: <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 11/22/2016 06:01 PM, Benjamin Gaignard wrote:
> [snip]
>>> +     "st,stm32-iio-timer5"
>>> +     "st,stm32-iio-timer6"
>>> +     "st,stm32-iio-timer7"
>>> +     "st,stm32-iio-timer8"
>>> +     "st,stm32-iio-timer9"
>>> +     "st,stm32-iio-timer10"
>>> +     "st,stm32-iio-timer11"
>>> +     "st,stm32-iio-timer12"
>>> +     "st,stm32-iio-timer13"
>>> +     "st,stm32-iio-timer14"
>>
>> We can't do this. This is a binding for a driver, not for the hardware.
>>
> 
> Unfortunately each instance for the hardware IP have little
> differences like which triggers they could accept or size of the
> counter register,
> and I doesn't have value inside the hardware to distinguish them so
> the only way I found is to use compatible.

But IIO is not a piece of hardware, its a software framework in the Linux
kernel.
