Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 19 Nov 2013 11:51:56 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org,
    linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: mxs-lradc: compute temperature from channel 8 and
 9
In-Reply-To: <1384857392-2199-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <alpine.DEB.2.01.1311191149130.18664@pmeerw.net>
References: <1384857392-2199-1-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> The mxs LRADC is able to read an internal die temperature sensor. The
> temperature has to be calculated from the value read on channel 8 and channel 9.
> To be able to expose the result to hwmon, implement iio channel 8 as
> (channel 9 - channel 8). Then, implement IIO_CHAN_INFO_SCALE and
> IIO_CHAN_INFO_OFFSET so that it can be processed by hwmon through the in kernel
> provider/consumer mechanism.

wouldn't IIO_CHAN_INFO_PROCESSED be more suitable than IIO_CHAN_INFO_RAW?

> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 91 +++++++++++++++++++++++++++++++------
>  1 file changed, 78 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index a08c1736458b..fec76090dae5 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -231,20 +231,11 @@ struct mxs_lradc {
>  /*
>   * Raw I/O operations
>   */
> -static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> -			const struct iio_chan_spec *chan,
> -			int *val, int *val2, long m)
> +static int mxs_lradc_read_single(struct iio_dev *iio_dev, int chan, int *val)
>  {
>  	struct mxs_lradc *lradc = iio_priv(iio_dev);
>  	int ret;
>  
> -	if (m != IIO_CHAN_INFO_RAW)
> -		return -EINVAL;
> -
> -	/* Check for invalid channel */
> -	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
> -		return -EINVAL;
> -
>  	/*
>  	 * See if there is no buffered operation in progess. If there is, simply
>  	 * bail out. This can be improved to support both buffered and raw IO at
> @@ -269,7 +260,7 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>  	/* Clean the slot's previous content, then set new one. */
>  	writel(LRADC_CTRL4_LRADCSELECT_MASK(0),
>  		lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_CLR);
> -	writel(chan->channel, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
> +	writel(chan, lradc->base + LRADC_CTRL4 + STMP_OFFSET_REG_SET);
>  
>  	writel(0, lradc->base + LRADC_CH(0));
>  
> @@ -298,6 +289,71 @@ err:
>  	return ret;
>  }
>  
> +static int mxs_lradc_read_temp(struct iio_dev *iio_dev, int *val)
> +{
> +	int ret, min, max;
> +
> +	ret = mxs_lradc_read_single(iio_dev, 8, &min);
> +	if (ret != IIO_VAL_INT)
> +		return ret;
> +
> +	ret = mxs_lradc_read_single(iio_dev, 9, &max);
> +	if (ret != IIO_VAL_INT)
> +		return ret;
> +
> +	*val = max - min;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
> +			const struct iio_chan_spec *chan,
> +			int *val, int *val2, long m)
> +{
> +	/* Check for invalid channel */
> +	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
> +		return -EINVAL;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_TEMP)
> +			return mxs_lradc_read_temp(iio_dev, val);
> +
> +		return mxs_lradc_read_single(iio_dev, chan->channel, val);
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_TEMP) {
> +			/* From the datasheet, we have to multiply by 1.012 and
> +			 * divide by 4
> +			 */
> +			*val = 0;
> +			*val2 = 253000;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +
> +		return -EINVAL;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type == IIO_TEMP) {
> +			/* The calculated value from the ADC is in Kelvin, we
> +			 * want Celsius for hwmon so the offset is
> +			 * -272.15 * scale
> +			 */
> +			*val = -1075;
> +			*val2 = 691699;
> +
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
> +
> +		return -EINVAL;
> +
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info mxs_lradc_iio_info = {
>  	.driver_module		= THIS_MODULE,
>  	.read_raw		= mxs_lradc_read_raw,
> @@ -835,8 +891,17 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
>  	MXS_ADC_CHAN(5, IIO_VOLTAGE),
>  	MXS_ADC_CHAN(6, IIO_VOLTAGE),
>  	MXS_ADC_CHAN(7, IIO_VOLTAGE),	/* VBATT */
> -	MXS_ADC_CHAN(8, IIO_TEMP),	/* Temp sense 0 */
> -	MXS_ADC_CHAN(9, IIO_TEMP),	/* Temp sense 1 */
> +	/* Combined Temperature sensors */
> +	{
> +		.type = IIO_TEMP,
> +		.indexed = 1,
> +		.scan_index = 8,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.channel = 8,
> +		.scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
> +	},
>  	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
>  	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
>  	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
