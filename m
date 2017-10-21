Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbdJUQzq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Oct 2017 12:55:46 -0400
Date: Sat, 21 Oct 2017 17:55:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <benjamin.gaignard@st.com>,
        <benjamin.gaignard@linaro.org>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: adc: stm32: add check on clock rate
Message-ID: <20171021175540.075a1722@archlinux>
In-Reply-To: <1508326812-24297-1-git-send-email-fabrice.gasnier@st.com>
References: <1508326812-24297-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Oct 2017 13:40:12 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Add check on STM32 ADC clock rate to report an explicit error.
> This may avoid division by 0 later in stm32-adc driver.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
I've applied this via the slow path for the next merge window as you haven't
explicitly highlighted it as a fix.  If you want it to go through for stable
etc then let me know...

I have no idea if this can be triggered in sensibly configured system or not!

Thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-adc-core.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 804198e..6aefef9 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -139,6 +139,11 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
>  	}
>  
>  	rate = clk_get_rate(priv->aclk);
> +	if (!rate) {
> +		dev_err(&pdev->dev, "Invalid clock rate: 0\n");
> +		return -EINVAL;
> +	}
> +
>  	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
>  		if ((rate / stm32f4_pclk_div[i]) <= STM32F4_ADC_MAX_CLK_RATE)
>  			break;
> @@ -216,6 +221,10 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  		 * From spec: PLL output musn't exceed max rate
>  		 */
>  		rate = clk_get_rate(priv->aclk);
> +		if (!rate) {
> +			dev_err(&pdev->dev, "Invalid adc clock rate: 0\n");
> +			return -EINVAL;
> +		}
>  
>  		for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
>  			ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;
> @@ -232,6 +241,10 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
>  
>  	/* Synchronous clock modes (e.g. ckmode is 1, 2 or 3) */
>  	rate = clk_get_rate(priv->bclk);
> +	if (!rate) {
> +		dev_err(&pdev->dev, "Invalid bus clock rate: 0\n");
> +		return -EINVAL;
> +	}
>  
>  	for (i = 0; i < ARRAY_SIZE(stm32h7_adc_ckmodes_spec); i++) {
>  		ckmode = stm32h7_adc_ckmodes_spec[i].ckmode;

