Return-Path: <SRS0=QWKi=67=linaro.org=benjamin.gaignard@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
References: <1501172340-8448-1-git-send-email-fabrice.gasnier@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Fri, 28 Jul 2017 10:14:06 +0200
Message-ID: <CA+M3ks5c98rc2RavW5Eon+MXqnMEpSxcFDaQeL=t4rGbjhR3Xg@mail.gmail.com>
Subject: Re: [PATCH 0/4] iio: trigger: stm32-timer fixes
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

2017-07-27 18:18 GMT+02:00 Fabrice Gasnier <fabrice.gasnier@st.com>:
> Miscellaneous fixes for stm32-timer-trigger driver.
> Last patch adds enable attribute, which unlocks use of
> encoder mode.
>
> Fabrice Gasnier (4):
>   iio: trigger: stm32-timer: fix quadrature mode get routine
>   iio: trigger: stm32-timer: fix write_raw return value
>   iio: trigger: stm32-timer: fix get/set down count direction
>   iio: trigger: stm32-timer: add enable attribute
>

For the series:

Acked-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>

>  drivers/iio/trigger/stm32-timer-trigger.c | 80 ++++++++++++++++++++++---=
------
>  1 file changed, 58 insertions(+), 22 deletions(-)
>
> --
> 1.9.1
>



--=20
Benjamin Gaignard

Graphic Study Group

Linaro.org =E2=94=82 Open source software for ARM SoCs

Follow Linaro: Facebook | Twitter | Blog
