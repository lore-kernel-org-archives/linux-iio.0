Return-Path: <SRS0=YuRD=FR=st.com=arnaud.pouliquen@kernel.org>
Subject: Re: [PATCH 0/7] iio: adc: stm32-dfsdm: misc fixes and improvements
To: Fabrice Gasnier <fabrice.gasnier@st.com>, <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <31c1cd66-f2f5-201e-04e4-5a79b2191560@st.com>
Date: Fri, 23 Feb 2018 14:49:45 +0100
MIME-Version: 1.0
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Hello,

For the series:
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

On 02/23/2018 01:50 PM, Fabrice Gasnier wrote:
> This series brings some fixes and improvements to STM32 DFSDM driver.
> 
> Fabrice Gasnier (7):
>   iio: adc: stm32-dfsdm: fix compatible data use
>   iio: adc: stm32-dfsdm: fix call to stop channel
>   iio: adc: stm32-dfsdm: fix clock source selection
>   iio: adc: stm32-dfsdm: fix multiple channel initialization
>   iio: adc: stm32-dfsdm: misc style improvements and fixes
>   iio: adc: stm32-dfsdm: add check on max filter id
>   iio: adc: stm32-dfsdm: add check on spi-max-frequency
> 
>  drivers/iio/adc/stm32-dfsdm-adc.c  | 52 ++++++++++++++++++++------------------
>  drivers/iio/adc/stm32-dfsdm-core.c | 17 +++++++++++--
>  2 files changed, 42 insertions(+), 27 deletions(-)
> 
