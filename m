Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754447AbdGJUy6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 10 Jul 2017 16:54:58 -0400
Date: Mon, 10 Jul 2017 21:54:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: <robh+dt@kernel.org>, <linux@armlinux.org.uk>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <benjamin.gaignard@linaro.org>,
        <benjamin.gaignard@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: dac: stm32: add support for stm32f4
Message-ID: <20170710215453.057afa22@kernel.org>
In-Reply-To: <1499693040-12994-4-git-send-email-fabrice.gasnier@st.com>
References: <1499693040-12994-1-git-send-email-fabrice.gasnier@st.com>
        <1499693040-12994-4-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 10 Jul 2017 15:23:59 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> This adds support for STM32F4 Digital-To-Analog converter.
> Add compatible configuration data to handle hfsel (not present
> in stm32f4).
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Hmm. I thought for a bit on whether I wanted to see data for the other
part as well to act as documentation.
Whilst that would have been fine, I came to the conclusion this is fine
as well.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to time out on (not sure what is going on there
at the moment but 0day has been struggling for a few days!)

Jonathan
> ---
>  drivers/iio/dac/stm32-dac-core.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index 75e4878..32701be 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -42,6 +42,14 @@ struct stm32_dac_priv {
>  	struct stm32_dac_common common;
>  };
>  
> +/**
> + * struct stm32_dac_cfg - DAC configuration
> + * @has_hfsel: DAC has high frequency control
> + */
> +struct stm32_dac_cfg {
> +	bool has_hfsel;
> +};
> +
>  static struct stm32_dac_priv *to_stm32_dac_priv(struct stm32_dac_common *com)
>  {
>  	return container_of(com, struct stm32_dac_priv, common);
> @@ -57,6 +65,7 @@ static struct stm32_dac_priv *to_stm32_dac_priv(struct stm32_dac_common *com)
>  static int stm32_dac_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> +	const struct stm32_dac_cfg *cfg;
>  	struct stm32_dac_priv *priv;
>  	struct regmap *regmap;
>  	struct resource *res;
> @@ -69,6 +78,8 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> +	cfg = (const struct stm32_dac_cfg *)
> +		of_match_device(dev->driver->of_match_table, dev)->data;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	mmio = devm_ioremap_resource(dev, res);
> @@ -121,12 +132,16 @@ static int stm32_dac_probe(struct platform_device *pdev)
>  		reset_control_deassert(priv->rst);
>  	}
>  
> -	/* When clock speed is higher than 80MHz, set HFSEL */
> -	priv->common.hfsel = (clk_get_rate(priv->pclk) > 80000000UL);
> -	ret = regmap_update_bits(regmap, STM32_DAC_CR, STM32H7_DAC_CR_HFSEL,
> -				 priv->common.hfsel ? STM32H7_DAC_CR_HFSEL : 0);
> -	if (ret)
> -		goto err_pclk;
> +	if (cfg && cfg->has_hfsel) {
> +		/* When clock speed is higher than 80MHz, set HFSEL */
> +		priv->common.hfsel = (clk_get_rate(priv->pclk) > 80000000UL);
> +		ret = regmap_update_bits(regmap, STM32_DAC_CR,
> +					 STM32H7_DAC_CR_HFSEL,
> +					 priv->common.hfsel ?
> +					 STM32H7_DAC_CR_HFSEL : 0);
> +		if (ret)
> +			goto err_pclk;
> +	}
>  
>  	platform_set_drvdata(pdev, &priv->common);
>  
> @@ -158,8 +173,17 @@ static int stm32_dac_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct stm32_dac_cfg stm32h7_dac_cfg = {
> +	.has_hfsel = true,
> +};
> +
>  static const struct of_device_id stm32_dac_of_match[] = {
> -	{ .compatible = "st,stm32h7-dac-core", },
> +	{
> +		.compatible = "st,stm32f4-dac-core",
> +	}, {
> +		.compatible = "st,stm32h7-dac-core",
> +		.data = (void *)&stm32h7_dac_cfg,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, stm32_dac_of_match);

