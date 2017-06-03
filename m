Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdFCJcb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:32:31 -0400
Date: Sat, 3 Jun 2017 10:28:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 2/5] iio: adc: stm32: make core adc clock optional by
 default
Message-ID: <20170603102825.00a0d229@kernel.org>
In-Reply-To: <1496050100-25854-3-git-send-email-fabrice.gasnier@st.com>
References: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
        <1496050100-25854-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 11:28:17 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Analog clock input is mandatory on stm32f4. But newer version of
> ADC hardware block allow to select either bus clock or asynchronous
> clock, for analog circuitry.
> 
> So, make it optional by default, but enforce clk presence on stm32f4.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/stm32-adc-core.c | 38 ++++++++++++++++++++++++++------------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 22b7c93..597ab7a 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -85,13 +85,21 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
>  	u32 val;
>  	int i;
>  
> +	/* stm32f4 has one clk input for analog (mandatory), enforce it here */
> +	if (!priv->aclk) {
> +		dev_err(&pdev->dev, "No 'adc' clock found\n");
> +		return -ENOENT;
> +	}
> +
>  	rate = clk_get_rate(priv->aclk);
>  	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
>  		if ((rate / stm32f4_pclk_div[i]) <= STM32F4_ADC_MAX_CLK_RATE)
>  			break;
>  	}
> -	if (i >= ARRAY_SIZE(stm32f4_pclk_div))
> +	if (i >= ARRAY_SIZE(stm32f4_pclk_div)) {
> +		dev_err(&pdev->dev, "adc clk selection failed\n");
>  		return -EINVAL;
> +	}
>  
>  	val = readl_relaxed(priv->common.base + STM32F4_ADC_CCR);
>  	val &= ~STM32F4_ADC_ADCPRE_MASK;
> @@ -227,21 +235,25 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	priv->aclk = devm_clk_get(&pdev->dev, "adc");
>  	if (IS_ERR(priv->aclk)) {
>  		ret = PTR_ERR(priv->aclk);
> -		dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> -		goto err_regulator_disable;
> +		if (ret == -ENOENT) {
> +			priv->aclk = NULL;
> +		} else {
> +			dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> +			goto err_regulator_disable;
> +		}
>  	}
>  
> -	ret = clk_prepare_enable(priv->aclk);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "adc clk enable failed\n");
> -		goto err_regulator_disable;
> +	if (priv->aclk) {
> +		ret = clk_prepare_enable(priv->aclk);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "adc clk enable failed\n");
> +			goto err_regulator_disable;
> +		}
>  	}
>  
>  	ret = stm32f4_adc_clk_sel(pdev, priv);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "adc clk selection failed\n");
> +	if (ret < 0)
>  		goto err_clk_disable;
> -	}
>  
>  	ret = stm32_adc_irq_probe(pdev, priv);
>  	if (ret < 0)
> @@ -261,7 +273,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	stm32_adc_irq_remove(pdev, priv);
>  
>  err_clk_disable:
> -	clk_disable_unprepare(priv->aclk);
> +	if (priv->aclk)
> +		clk_disable_unprepare(priv->aclk);
>  
>  err_regulator_disable:
>  	regulator_disable(priv->vref);
> @@ -276,7 +289,8 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  
>  	of_platform_depopulate(&pdev->dev);
>  	stm32_adc_irq_remove(pdev, priv);
> -	clk_disable_unprepare(priv->aclk);
> +	if (priv->aclk)
> +		clk_disable_unprepare(priv->aclk);
>  	regulator_disable(priv->vref);
>  
>  	return 0;

