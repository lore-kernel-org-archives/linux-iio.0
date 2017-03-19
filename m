Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48149 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCSKIQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:08:16 -0400
Subject: Re: [PATCH v3] iio: adc: meson-saradc: add calibration
To: Heiner Kallweit <hkallweit1@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <f89d2909-9044-242c-fbfa-b18d8887d1d6@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f846da27-296e-c202-aa79-59b8ccd1567d@kernel.org>
Date: Sun, 19 Mar 2017 10:08:14 +0000
MIME-Version: 1.0
In-Reply-To: <f89d2909-9044-242c-fbfa-b18d8887d1d6@gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/03/17 18:38, Heiner Kallweit wrote:
> This patch adds calibration for the Meson SAR ADC.
> Points 25% vref and 75% vref are used for calibration.
> It usesa simple linear calibration function: SCALE * val + BIAS
> 
> Successfully tested on a Odroid C2.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Looks good to me. I'll leave it a while to let Martin have an opportunity
for one last look and perhaps a reviewed-by tag to supplement the tested-by.

Give me a poke in a week or so if I seem to have forgotten this!

Jonathan
> ---
> v2:
> - added calibration scale
> v3:
> - added define MILLION
> - don't bail out if calibration fails
> ---
>  drivers/iio/adc/meson_saradc.c | 77 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index cde9ca7a..dd4190b5 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -166,6 +166,8 @@
>  
>  #define MESON_SAR_ADC_MAX_FIFO_SIZE				32
>  #define MESON_SAR_ADC_TIMEOUT					100 /* ms */
> +/* for use with IIO_VAL_INT_PLUS_MICRO */
> +#define MILLION							1000000
>  
>  #define MESON_SAR_ADC_CHAN(_chan) {					\
>  	.type = IIO_VOLTAGE,						\
> @@ -173,7 +175,9 @@
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
> @@ -233,6 +237,8 @@ struct meson_sar_adc_priv {
>  	struct clk				*adc_div_clk;
>  	struct clk_divider			clk_div;
>  	struct completion			done;
> +	int					calibbias;
> +	int					calibscale;
>  };
>  
>  static const struct regmap_config meson_sar_adc_regmap_config = {
> @@ -252,6 +258,17 @@ static unsigned int meson_sar_adc_get_fifo_count(struct iio_dev *indio_dev)
>  	return FIELD_GET(MESON_SAR_ADC_REG0_FIFO_COUNT_MASK, regval);
>  }
>  
> +static int meson_sar_adc_calib_val(struct iio_dev *indio_dev, int val)
> +{
> +	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> +	int tmp;
> +
> +	/* use val_calib = scale * val_raw + offset calibration function */
> +	tmp = div_s64((s64)val * priv->calibscale, MILLION) + priv->calibbias;
> +
> +	return clamp(tmp, 0, (1 << priv->data->resolution) - 1);
> +}
> +
>  static int meson_sar_adc_wait_busy_clear(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> @@ -302,7 +319,7 @@ static int meson_sar_adc_read_raw_sample(struct iio_dev *indio_dev,
>  
>  	fifo_val = FIELD_GET(MESON_SAR_ADC_FIFO_RD_SAMPLE_VALUE_MASK, regval);
>  	fifo_val &= GENMASK(priv->data->resolution - 1, 0);
> -	*val = fifo_val;
> +	*val = meson_sar_adc_calib_val(indio_dev, fifo_val);
>  
>  	return 0;
>  }
> @@ -527,6 +544,15 @@ static int meson_sar_adc_iio_info_read_raw(struct iio_dev *indio_dev,
>  		*val2 = priv->data->resolution;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = priv->calibbias;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		*val = priv->calibscale / MILLION;
> +		*val2 = priv->calibscale % MILLION;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -762,6 +788,47 @@ static irqreturn_t meson_sar_adc_irq(int irq, void *data)
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
> +	priv->calibscale = div_s64((nominal1 - nominal0) * (s64)MILLION,
> +				   value1 - value0);
> +	priv->calibbias = nominal0 - div_s64((s64)value0 * priv->calibscale,
> +					     MILLION);
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
> @@ -901,6 +968,8 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(priv->vref);
>  	}
>  
> +	priv->calibscale = MILLION;
> +
>  	ret = meson_sar_adc_init(indio_dev);
>  	if (ret)
>  		goto err;
> @@ -909,6 +978,10 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err;
>  
> +	ret = meson_sar_adc_calib(indio_dev);
> +	if (ret)
> +		dev_warn(&pdev->dev, "calibration failed\n");
> +
>  	platform_set_drvdata(pdev, indio_dev);
>  
>  	ret = iio_device_register(indio_dev);
> 

