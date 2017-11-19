Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbdKSPo0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:44:26 -0500
Date: Sun, 19 Nov 2017 15:44:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 2/5] iio: adc: meson-saradc: initialize the bandgap
 correctly on older SoCs
Message-ID: <20171119154422.3716b00e@archlinux>
In-Reply-To: <20171031200147.14660-3-martin.blumenstingl@googlemail.com>
References: <20171031200147.14660-1-martin.blumenstingl@googlemail.com>
        <20171031200147.14660-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 Oct 2017 21:01:44 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Meson8 and Meson8b do not have the MESON_SAR_ADC_REG11 register. The
> bandgap setting for these SoCs is configured in the
> MESON_SAR_ADC_DELTA_10 register instead.
> Make the driver aware of this difference and use the correct bandgap
> register depending on the SoC.
> This has worked fine on Meson8 and Meson8b because the bootloader is
> already initializing the bandgap setting.
> 
> Fixes: 6c76ed31cd05 ("iio: adc: meson-saradc: add Meson8b SoC compatibility")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 55611244c799..abe9df879b2a 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -221,6 +221,7 @@ enum meson_sar_adc_chan7_mux_sel {
>  
>  struct meson_sar_adc_data {
>  	bool					has_bl30_integration;
> +	u32					bandgap_reg;
>  	unsigned int				resolution;
>  	const char				*name;
>  };
> @@ -685,6 +686,20 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static void meson_sar_adc_set_bandgap(struct iio_dev *indio_dev, bool on_off)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	u32 enable_mask;
> +
> +	if (priv->data->bandgap_reg == MESON_SAR_ADC_REG11)
> +		enable_mask = MESON_SAR_ADC_REG11_BANDGAP_EN;
> +	else
> +		enable_mask = MESON_SAR_ADC_DELTA_10_TS_VBG_EN;
> +
> +	regmap_update_bits(priv->regmap, priv->data->bandgap_reg, enable_mask,
> +			   on_off ? enable_mask : 0);
> +}
> +
>  static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> @@ -717,9 +732,9 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>  	regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
>  			   MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
> -	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
> -			   MESON_SAR_ADC_REG11_BANDGAP_EN,
> -			   MESON_SAR_ADC_REG11_BANDGAP_EN);
> +
> +	meson_sar_adc_set_bandgap(indio_dev, true);
> +
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
>  			   MESON_SAR_ADC_REG3_ADC_EN,
>  			   MESON_SAR_ADC_REG3_ADC_EN);
> @@ -739,8 +754,7 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>  err_adc_clk:
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
>  			   MESON_SAR_ADC_REG3_ADC_EN, 0);
> -	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
> -			   MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
> +	meson_sar_adc_set_bandgap(indio_dev, false);
>  	clk_disable_unprepare(priv->sana_clk);
>  err_sana_clk:
>  	clk_disable_unprepare(priv->core_clk);
> @@ -765,8 +779,8 @@ static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
>  
>  	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG3,
>  			   MESON_SAR_ADC_REG3_ADC_EN, 0);
> -	regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
> -			   MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
> +
> +	meson_sar_adc_set_bandgap(indio_dev, false);
>  
>  	clk_disable_unprepare(priv->sana_clk);
>  	clk_disable_unprepare(priv->core_clk);
> @@ -845,30 +859,35 @@ static const struct iio_info meson_sar_adc_iio_info = {
>  
>  static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
>  	.has_bl30_integration = false,
> +	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
>  	.resolution = 10,
>  	.name = "meson-meson8-saradc",
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
>  	.has_bl30_integration = false,
> +	.bandgap_reg = MESON_SAR_ADC_DELTA_10,
>  	.resolution = 10,
>  	.name = "meson-meson8b-saradc",
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>  	.has_bl30_integration = true,
> +	.bandgap_reg = MESON_SAR_ADC_REG11,
>  	.resolution = 10,
>  	.name = "meson-gxbb-saradc",
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>  	.has_bl30_integration = true,
> +	.bandgap_reg = MESON_SAR_ADC_REG11,
>  	.resolution = 12,
>  	.name = "meson-gxl-saradc",
>  };
>  
>  static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  	.has_bl30_integration = true,
> +	.bandgap_reg = MESON_SAR_ADC_REG11,
>  	.resolution = 12,
>  	.name = "meson-gxm-saradc",
>  };

