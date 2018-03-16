Return-Path: <SRS0=p6sS=GG=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH 0/2] iio: stm32-dfsdm-adc: fix filter & rate setting
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>
References: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <1ddfcfad-f06e-738f-53cf-11dc56e61da1@st.com>
Date: Fri, 16 Mar 2018 10:10:09 +0100
MIME-Version: 1.0
In-Reply-To: <1520950986-23116-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Hello,

For the series:
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

On 03/13/2018 03:23 PM, Fabrice Gasnier wrote:
> This series brings fixes to STM32 DFSDM ADC driver.
> 
> Fabrice Gasnier (2):
>   iio: adc: stm32-dfsdm: fix successive oversampling settings
>   iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock
> 
>  drivers/iio/adc/stm32-dfsdm-adc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
