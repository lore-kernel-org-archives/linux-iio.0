Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59945 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdCEMId (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 07:08:33 -0500
Subject: Re: [PATCH v2] iio: adc: meson-saradc: add calibration for meson gxbb
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <89a21983-b722-cbb8-42db-13c447f2e527@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <13e3cdeb-5a9c-03df-4129-e38b13f63b58@kernel.org>
Date: Sun, 5 Mar 2017 12:08:30 +0000
MIME-Version: 1.0
In-Reply-To: <89a21983-b722-cbb8-42db-13c447f2e527@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/03/17 16:29, Heiner Kallweit wrote:
> The calibration on Meson GXBB is different from the one on GXM/GXL.
> This patch only supports GXBB as I don't have other spec and test hw.
> Points 25% vref and 75% vref are used for calibration.
> 
> Adding a calibration scale resulted in no improvement, therefore
> only a simple calibration bias is supported.
You probably want to update this description ;)
> 
> Successfully tested on a Odroid C2.  Calibbias is 8 on my system.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
Looks good to me.  Will want Martin's Ack on this, so I'll wait for that
before applying.

Jonathan
> v2:
> - added calibration scale
> ---
>  drivers/iio/adc/meson_saradc.c | 74 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 23710088..d5aa0d04 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -173,7 +173,9 @@
>  	.channel = _chan,						\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>  				BIT(IIO_CHAN_INFO_AVERAGE_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
> +				BIT(IIO_CHAN_INFO_CALIBBIAS) |		\
> +				BIT(IIO_CHAN_INFO_CALIBSCALE),		\
>  	.datasheet_name = "SAR_ADC_CH"#_chan,				\
>  }
>  
> @@ -233,6 +235,8 @@ struct meson_sar_adc_priv {
>  	struct clk				*adc_div_clk;
>  	struct clk_divider			clk_div;
>  	struct completion			done;
> +	int					calibbias;
> +	int					calibscale;
>  };
>  
>  static const struct regmap_config meson_sar_adc_regmap_config = {
> @@ -252,6 +256,16 @@ static unsigned int meson_sar_adc_get_fifo_count(struct iio_dev *indio_dev)
>  	return FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
>  }
>  
> +static int meson_sar_adc_calib_val(struct iio_dev *indio_dev, int val)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int tmp;
> +
> +	tmp = div_s64((s64)val * priv->calibscale, 1000000) + priv->calibbias;
> +
> +	return clamp(tmp, 0, (1 << priv->data->resolution) - 1);
> +}
> +
>  static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> @@ -303,7 +317,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>  	fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK,
>  			     regval);
>  	fifo_val &= GENMASK(priv->data->resolution - 1, 0);
> -	*val = fifo_val;
> +	*val = meson_sar_adc_calib_val(indio_dev, fifo_val);
>  
>  	return 0;
>  }
> @@ -529,6 +543,15 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>  		*val2 = priv->data->resolution;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = priv->calibbias;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = priv->calibscale / 1000000;
> +		*val2 = priv->calibscale % 1000000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -754,6 +777,47 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int meson_sar_adc_calib(struct iio_dev *indio_dev)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int ret, nominal0, nominal1, value0, value1;
> +
> +	/* use points 25% and 75% for calibration */
> +	nominal0 = (1 << priv->data->resolution) / 4;
> +	nominal1 = (1 << priv->data->resolution) * 3 / 4;
> +
> +	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
> +	usleep_range(10, 20);
> +	ret = meson_sar_adc_get_sample(indio_dev,
> +				       &meson_sar_adc_iio_channels[7],
> +				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
> +	if (ret < 0)
> +		goto out;
> +
> +	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
> +	usleep_range(10, 20);
> +	ret = meson_sar_adc_get_sample(indio_dev,
> +				       &meson_sar_adc_iio_channels[7],
> +				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (value1 <= value0) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	priv->calibscale = div_s64((nominal1 - nominal0) * 1000000LL,
> +				   value1 - value0);
> +	priv->calibbias = nominal0 - div_s64((s64)value0 * priv->calibscale,
> +					     1000000);
> +	ret = 0;
> +out:
> +	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_CH7_INPUT);
> +
> +	return ret;
> +}
> +
>  static const struct iio_info meson_sar_adc_iio_info = {
>  	.read_raw = meson_sar_adc_iio_info_read_raw,
>  	.driver_module = THIS_MODULE,
> @@ -893,6 +957,8 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->vref);
>  	}
>  
> +	priv->calibscale = 1000000;
> +
>  	ret = meson_sar_adc_init(indio_dev);
>  	if (ret)
>  		goto err;
> @@ -901,6 +967,10 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err;
>  
> +	ret = meson_sar_adc_calib(indio_dev);
> +	if (ret)
> +		goto err_hw;
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = iio_device_register(indio_dev);
> 

