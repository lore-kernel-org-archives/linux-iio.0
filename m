Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbdJUQu1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 12:50:27 -0400
Date: Sat, 21 Oct 2017 17:50:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: stm32: add tim15 trigger
Message-ID: <20171021175022.791d4836@archlinux>
In-Reply-To: <1508326767-24215-1-git-send-email-fabrice.gasnier@st.com>
References: <1508326767-24215-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Oct 2017 13:39:27 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add TIM15_TRGO trigger that is now supported on STM32H7.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/stm32-adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index cc7ca50..4725756 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -501,6 +501,7 @@ struct stm32_adc_info {
>  	{ TIM2_TRGO, STM32_EXT11 },
>  	{ TIM4_TRGO, STM32_EXT12 },
>  	{ TIM6_TRGO, STM32_EXT13 },
> +	{ TIM15_TRGO, STM32_EXT14 },
>  	{ TIM3_CH4, STM32_EXT15 },
>  	{ LPTIM1_OUT, STM32_EXT18 },
>  	{ LPTIM2_OUT, STM32_EXT19 },

