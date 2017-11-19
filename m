Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdKSPqr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:46:47 -0500
Date: Sun, 19 Nov 2017 15:46:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 3/5] iio: adc: meson-saradc: Meson8 and Meson8b do not
 have REG11 and REG13
Message-ID: <20171119154643.78826fd4@archlinux>
In-Reply-To: <20171031200147.14660-4-martin.blumenstingl@googlemail.com>
References: <20171031200147.14660-1-martin.blumenstingl@googlemail.com>
        <20171031200147.14660-4-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 Oct 2017 21:01:45 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The Meson GXBB and newer SoCs have a few more registers than the older
> Meson8 and Meson8b SoCs.
> Use a separate regmap config to limit the older SoCs to the DELTA_10
> register.
> 
> Fixes: 6c76ed31cd05 ("iio: adc: meson-saradc: add Meson8b SoC compatibility")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

While this may not have any obvious symptoms, I think it is better to make sure
it is fixed in stable so it doesn't bite us in unexpected ways later.

Applied to the fixes-togreg branch of iio.git and marked for stable.
> ---
>  drivers/iio/adc/meson_saradc.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index abe9df879b2a..7dc7d297a0fc 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -224,6 +224,7 @@ struct meson_sar_adc_data {
>  	u32					bandgap_reg;
>  	unsigned int				resolution;
>  	const char				*name;
> +	const struct regmap_config		*regmap_config;
>  };
>  
>  struct meson_sar_adc_priv {
> @@ -243,13 +244,20 @@ struct meson_sar_adc_priv {
>  	int					calibscale;
>  };
>  
> -static const struct regmap_config meson_sar_adc_regmap_config = {
> +static const struct regmap_config meson_sar_adc_regmap_config_gxbb = {
>  	.reg_bits = 8,
>  	.val_bits = 32,
>  	.reg_stride = 4,
>  	.max_register = MESON_SAR_ADC_REG13,
>  };
>  
> +static const struct regmap_config meson_sar_adc_regmap_config_meson8 = {
> +	.reg_bits = 8,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = MESON_SAR_ADC_DELTA_10,
> +};
> +
>  static unsigned int meson_sar_adc_get_fifo_count(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> @@ -860,6 +868,7 @@ static const struct iio_info meson_sar_adc_iio_info = {
>  static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
>  	.has_bl30_integration = false,
>  	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
> +	.regmap_config = &meson_sar_adc_regmap_config_meson8,
>  	.resolution = 10,
>  	.name = "meson-meson8-saradc",
>  };
> @@ -867,6 +876,7 @@ static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
>  static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
>  	.has_bl30_integration = false,
>  	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
> +	.regmap_config = &meson_sar_adc_regmap_config_meson8,
>  	.resolution = 10,
>  	.name = "meson-meson8b-saradc",
>  };
> @@ -874,6 +884,7 @@ static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
>  static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>  	.has_bl30_integration = true,
>  	.bandgap_reg = MESON_SAR_ADC_REG11,
> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>  	.resolution = 10,
>  	.name = "meson-gxbb-saradc",
>  };
> @@ -881,6 +892,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>  static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>  	.has_bl30_integration = true,
>  	.bandgap_reg = MESON_SAR_ADC_REG11,
> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>  	.resolution = 12,
>  	.name = "meson-gxl-saradc",
>  };
> @@ -888,6 +900,7 @@ static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>  static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  	.has_bl30_integration = true,
>  	.bandgap_reg = MESON_SAR_ADC_REG11,
> +	.regmap_config = &meson_sar_adc_regmap_config_gxbb,
>  	.resolution = 12,
>  	.name = "meson-gxm-saradc",
>  };
> @@ -965,7 +978,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> -					     &meson_sar_adc_regmap_config);
> +					     priv->data->regmap_config);
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  

