Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbdFCJch (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 05:32:37 -0400
Date: Sat, 3 Jun 2017 10:29:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <linux@armlinux.org.uk>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 4/5] iio: adc: stm32: make per instance bus clock
 optional
Message-ID: <20170603102910.521cab86@kernel.org>
In-Reply-To: <1496050100-25854-5-git-send-email-fabrice.gasnier@st.com>
References: <1496050100-25854-1-git-send-email-fabrice.gasnier@st.com>
        <1496050100-25854-5-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 11:28:19 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> STM32F4 requires one clock per ADC instance for register access. But,
> newer version of ADC hardware block have common bus clock for all
> instances (per instance driver isn't responsible for getting it).
> So, make it optional by default. Still, enforce it's required on STM32F4.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied.
> ---
>  drivers/iio/adc/stm32-adc.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 50b2538..2ba9ca9 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -160,6 +160,7 @@ struct stm32_adc_regspec {
>   * @regs:		registers descriptions
>   * @adc_info:		per instance input channels definitions
>   * @trigs:		external trigger sources
> + * @clk_required:	clock is required
>   * @start_conv:		routine to start conversions
>   * @stop_conv:		routine to stop conversions
>   */
> @@ -167,6 +168,7 @@ struct stm32_adc_cfg {
>  	const struct stm32_adc_regspec	*regs;
>  	const struct stm32_adc_info	*adc_info;
>  	struct stm32_adc_trig_info	*trigs;
> +	bool clk_required;
>  	void (*start_conv)(struct stm32_adc *, bool dma);
>  	void (*stop_conv)(struct stm32_adc *);
>  };
> @@ -1145,14 +1147,21 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  
>  	adc->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(adc->clk)) {
> -		dev_err(&pdev->dev, "Can't get clock\n");
> -		return PTR_ERR(adc->clk);
> +		ret = PTR_ERR(adc->clk);
> +		if (ret == -ENOENT && !adc->cfg->clk_required) {
> +			adc->clk = NULL;
> +		} else {
> +			dev_err(&pdev->dev, "Can't get clock\n");
> +			return ret;
> +		}
>  	}
>  
> -	ret = clk_prepare_enable(adc->clk);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "clk enable failed\n");
> -		return ret;
> +	if (adc->clk) {
> +		ret = clk_prepare_enable(adc->clk);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "clk enable failed\n");
> +			return ret;
> +		}
>  	}
>  
>  	ret = stm32_adc_of_get_resolution(indio_dev);
> @@ -1196,7 +1205,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  		dma_release_channel(adc->dma_chan);
>  	}
>  err_clk_disable:
> -	clk_disable_unprepare(adc->clk);
> +	if (adc->clk)
> +		clk_disable_unprepare(adc->clk);
>  
>  	return ret;
>  }
> @@ -1214,7 +1224,8 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  				  adc->rx_buf, adc->rx_dma_buf);
>  		dma_release_channel(adc->dma_chan);
>  	}
> -	clk_disable_unprepare(adc->clk);
> +	if (adc->clk)
> +		clk_disable_unprepare(adc->clk);
>  
>  	return 0;
>  }
> @@ -1223,6 +1234,7 @@ static int stm32_adc_remove(struct platform_device *pdev)
>  	.regs = &stm32f4_adc_regspec,
>  	.adc_info = &stm32f4_adc_info,
>  	.trigs = stm32f4_adc_trigs,
> +	.clk_required = true,
>  	.start_conv = stm32f4_adc_start_conv,
>  	.stop_conv = stm32f4_adc_stop_conv,
>  };

