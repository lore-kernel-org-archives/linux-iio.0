Return-Path: <lee.jones@linaro.org>
Date: Tue, 22 Nov 2016 17:18:20 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, robh+dt@kernel.org,
	Mark Rutland <mark.rutland@arm.com>, alexandre.torgue@st.com,
	devicetree@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Gerald Baeza <gerald.baeza@st.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH 5/7] add bindings for stm32 IIO timer drivers
Message-ID: <20161122171820.GL10134@dell.home>
References: <1479831207-32699-1-git-send-email-benjamin.gaignard@st.com>
 <1479831207-32699-6-git-send-email-benjamin.gaignard@st.com>
 <b9a82ce7-745a-1c25-f97f-68aaf0551f3b@metafoo.de>
 <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CA+M3ks6ZoOND4VobU65OntEYU-f_XoNCV4wNZZ0_dYoOxy73+w@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, 22 Nov 2016, Benjamin Gaignard wrote:

> [snip]
> >> +     "st,stm32-iio-timer5"
> >> +     "st,stm32-iio-timer6"
> >> +     "st,stm32-iio-timer7"
> >> +     "st,stm32-iio-timer8"
> >> +     "st,stm32-iio-timer9"
> >> +     "st,stm32-iio-timer10"
> >> +     "st,stm32-iio-timer11"
> >> +     "st,stm32-iio-timer12"
> >> +     "st,stm32-iio-timer13"
> >> +     "st,stm32-iio-timer14"
> >
> > We can't do this. This is a binding for a driver, not for the hardware.
> >
> 
> Unfortunately each instance for the hardware IP have little
> differences like which triggers they could accept or size of the
> counter register,
> and I doesn't have value inside the hardware to distinguish them so
> the only way I found is to use compatible.

Can't you represent these as properties?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
