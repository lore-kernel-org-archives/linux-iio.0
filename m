Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeIYCV0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Sep 2018 22:21:26 -0400
Date: Mon, 24 Sep 2018 21:17:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 3/3] iio: adc: meson-saradc: simplify access to
 meson_sar_adc_param
Message-ID: <20180924211727.72ab0066@archlinux>
In-Reply-To: <20180922222102.12023-4-martin.blumenstingl@googlemail.com>
References: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
        <20180922222102.12023-4-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 23 Sep 2018 00:21:02 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Commit 053ffe3c8cfe31 ("iio: adc: meson-saradc: squash and share the
> common adc platform data") put all the data which is needed at runtime
> from struct meson_sar_adc_data to a new struct meson_sar_adc_param so
> we can re-use the platform specific configuration without having to
> duplicate everything just to change the name.
> 
> The only place where struct meson_sar_adc_data is now needed is the
> _probe function which has to pass the name to the iio_dev. All other
> functions only need access to struct meson_sar_adc_param. This means we
> can simplify struct meson_sar_adc_priv.
> 
> The goal of this patch is to make the code a bit easier to read since
> this removes one level of nesting. No functional changes intended.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 9d8f2139debc..1c4ba83c0725 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -234,7 +234,7 @@ struct meson_sar_adc_data {
>  struct meson_sar_adc_priv {
>  	struct regmap				*regmap;
>  	struct regulator			*vref;
> -	const struct meson_sar_adc_data		*data;
> +	const struct meson_sar_adc_param	*param;
>  	struct clk				*clkin;
>  	struct clk				*core_clk;
>  	struct clk				*adc_sel_clk;
> @@ -279,7 +279,7 @@ static int meson_sar_adc_calib_val(struct iio_dev *indio_dev, int val)
>  	/* use val_calib = scale * val_raw + offset calibration function */
>  	tmp = div_s64((s64)val * priv->calibscale, MILLION) + priv->calibbias;
>  
> -	return clamp(tmp, 0, (1 << priv->data->param->resolution) - 1);
> +	return clamp(tmp, 0, (1 << priv->param->resolution) - 1);
>  }
>  
>  static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
> @@ -331,7 +331,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>  	}
>  
>  	fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK, regval);
> -	fifo_val &= GENMASK(priv->data->param->resolution - 1, 0);
> +	fifo_val &= GENMASK(priv->param->resolution - 1, 0);
>  	*val = meson_sar_adc_calib_val(indio_dev, fifo_val);
>  
>  	return 0;
> @@ -450,7 +450,7 @@ static int meson_sar_adc_lock(struct iio_dev *indio_dev)
>  
>  	mutex_lock(&indio_dev->mlock);
>  
> -	if (priv->data->param->has_bl30_integration) {
> +	if (priv->param->has_bl30_integration) {
>  		/* prevent BL30 from using the SAR ADC while we are using it */
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
>  				MESON_SAR_ADC_DELAY_KERNEL_BUSY,
> @@ -478,7 +478,7 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
>  
> -	if (priv->data->param->has_bl30_integration)
> +	if (priv->param->has_bl30_integration)
>  		/* allow BL30 to use the SAR ADC again */
>  		regmap_update_bits(priv->regmap, MESON_SAR_ADC_DELAY,
>  				MESON_SAR_ADC_DELAY_KERNEL_BUSY, 0);
> @@ -562,7 +562,7 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>  		}
>  
>  		*val = ret / 1000;
> -		*val2 = priv->data->param->resolution;
> +		*val2 = priv->param->resolution;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
>  	case IIO_CHAN_INFO_CALIBBIAS:
> @@ -635,7 +635,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  	 */
>  	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_CH7_INPUT);
>  
> -	if (priv->data->param->has_bl30_integration) {
> +	if (priv->param->has_bl30_integration) {
>  		/*
>  		 * leave sampling delay and the input clocks as configured by
>  		 * BL30 to make sure BL30 gets the values it expects when
> @@ -715,7 +715,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	ret = clk_set_rate(priv->adc_clk, priv->data->param->clock_rate);
> +	ret = clk_set_rate(priv->adc_clk, priv->param->clock_rate);
>  	if (ret) {
>  		dev_err(indio_dev->dev.parent,
>  			"failed to set adc clock rate\n");
> @@ -728,7 +728,7 @@ static int meson_sar_adc_init(struct iio_dev *indio_dev)
>  static void meson_sar_adc_set_bandgap(struct iio_dev *indio_dev, bool on_off)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> -	const struct meson_sar_adc_param *param = priv->data->param;
> +	const struct meson_sar_adc_param *param = priv->param;
>  	u32 enable_mask;
>  
>  	if (param->bandgap_reg == MESON_SAR_ADC_REG11)
> @@ -848,8 +848,8 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
>  	int ret, nominal0, nominal1, value0, value1;
>  
>  	/* use points 25% and 75% for calibration */
> -	nominal0 = (1 << priv->data->param->resolution) / 4;
> -	nominal1 = (1 << priv->data->param->resolution) * 3 / 4;
> +	nominal0 = (1 << priv->param->resolution) / 4;
> +	nominal1 = (1 << priv->param->resolution) * 3 / 4;
>  
>  	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
>  	usleep_range(10, 20);
> @@ -1000,9 +1000,9 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	priv->data = match_data;
> +	priv->param = match_data->param;
>  
> -	indio_dev->name = priv->data->name;
> +	indio_dev->name = match_data->name;
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->dev.of_node = pdev->dev.of_node;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -1026,7 +1026,7 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	priv->regmap = devm_regmap_init_mmio(&pdev->dev, base,
> -					     priv->data->param->regmap_config);
> +					     priv->param->regmap_config);
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
