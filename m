Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57673 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756738AbdEGWbG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:31:06 -0400
Subject: Re: [PATCH v3 6/9] iio: light: rpr0521 sample_frequency read/write
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@intel.com>,
        linux-iio@vger.kernel.org
References: <1493983193-8753-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1493983193-8753-6-git-send-email-mikko.koivunen@fi.rohmeurope.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <77e7aff8-f8f7-75eb-42c8-101cc6e07814@kernel.org>
Date: Sun, 7 May 2017 12:51:33 +0100
MIME-Version: 1.0
In-Reply-To: <1493983193-8753-6-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 12:19, Mikko Koivunen wrote:
> Add sysfs read/write sample frequency.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Trivial bit of formatting that could be improved
(mainly because it's a standard target for checkpatch lovers so
I'll only get a 'fix' a few days after this goes live if we don't fix
it now ;)

Jonathan
> ---
> Patch v1->v2 changes:
> multiline comments fixed
> Patch v2->v3 changes:
> multiline comments fixed
> Empty line fixes on switch-case.
> Changed if-elseif-else to switch-case.
> 
> checkpatch.pl OK
> Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
> Builds ok with torvalds/linux feb 27.
> 
>  drivers/iio/light/rpr0521.c |  118 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index da4b374..94a0d9d 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -132,6 +132,30 @@ static const struct rpr0521_gain_info {
>  	},
>  };
>  
> +struct rpr0521_samp_freq {
> +	int	als_hz;
> +	int	als_uhz;
> +	int	pxs_hz;
> +	int	pxs_uhz;
> +};
> +
> +static const struct rpr0521_samp_freq rpr0521_samp_freq_i[13] = {
> +/*	{ALS, PXS},		   W==currently writable option */
> +	{0, 0, 0, 0},		/* W0000, 0=standby */
> +	{0, 0, 100, 0},		/*  0001 */
> +	{0, 0, 25, 0},		/*  0010 */
> +	{0, 0, 10, 0},		/*  0011 */
> +	{0, 0, 2, 500000},	/*  0100 */
> +	{10, 0, 20, 0},		/*  0101 */
> +	{10, 0, 10, 0},		/* W0110 */
> +	{10, 0, 2, 500000},	/*  0111 */
> +	{2, 500000, 20, 0},	/*  1000, measurement 100ms, sleep 300ms */
> +	{2, 500000, 10, 0},	/*  1001, measurement 100ms, sleep 300ms */
> +	{2, 500000, 0, 0},	/*  1010, high sensitivity mode */
> +	{2, 500000, 2, 500000},	/* W1011, high sensitivity mode */
> +	{20, 0, 20, 0}	/* 1100, ALS_data x 0.5, see specification P.18 */
> +};
> +
>  struct rpr0521_data {
>  	struct i2c_client *client;
>  
> @@ -154,9 +178,16 @@ struct rpr0521_data {
>  static IIO_CONST_ATTR(in_intensity_scale_available, RPR0521_ALS_SCALE_AVAIL);
>  static IIO_CONST_ATTR(in_proximity_scale_available, RPR0521_PXS_SCALE_AVAIL);
>  
> +/*
> + * Start with easy freq first, whole table of freq combinations is more
> + * complicated.
> + */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("2.5 10");
> +
>  static struct attribute *rpr0521_attributes[] = {
>  	&iio_const_attr_in_intensity_scale_available.dev_attr.attr,
>  	&iio_const_attr_in_proximity_scale_available.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -172,6 +203,7 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>  		.channel2 = IIO_MOD_LIGHT_BOTH,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
>  	{
>  		.type = IIO_INTENSITY,
> @@ -180,12 +212,14 @@ static const struct iio_chan_spec rpr0521_channels[] = {
>  		.channel2 = IIO_MOD_LIGHT_IR,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	},
>  	{
>  		.type = IIO_PROXIMITY,
>  		.address = RPR0521_CHAN_PXS,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	}
>  };
>  
> @@ -331,6 +365,72 @@ static int rpr0521_set_gain(struct rpr0521_data *data, int chan,
>  				  idx << rpr0521_gain[chan].shift);
>  }
>  
> +static int rpr0521_read_samp_freq(struct rpr0521_data *data,
> +				enum iio_chan_type chan_type,
> +			    int *val, int *val2)
> +{
> +	int reg, ret;
> +
> +	ret = regmap_read(data->regmap, RPR0521_REG_MODE_CTRL, &reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	reg &= RPR0521_MODE_MEAS_TIME_MASK;
> +	if (reg >= ARRAY_SIZE(rpr0521_samp_freq_i))
> +		return -EINVAL;
> +
> +	switch (chan_type) {
> +	case IIO_INTENSITY:
> +		*val = rpr0521_samp_freq_i[reg].als_hz;
> +		*val2 = rpr0521_samp_freq_i[reg].als_uhz;
> +		return 0;
> +
> +	case IIO_PROXIMITY:
> +		*val = rpr0521_samp_freq_i[reg].pxs_hz;
> +		*val2 = rpr0521_samp_freq_i[reg].pxs_uhz;
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
> +				enum iio_chan_type chan_type,
> +				int val, int val2)
> +{
> +	int i;
> +
> +	/*
> +	 * Ignore channel
> +	 * both pxs and als are setup only to same freq because of simplicity
> +	 */
> +	switch (val) {
> +	case 0:
> +		i = 0;
> +		break;
> +
> +	case 2:
> +		if (val2 != 500000)
> +			return -EINVAL;
> +
> +		i = 11;
> +		break;
> +
> +	case 10:
> +		i = 6;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_update_bits(data->regmap,
> +		RPR0521_REG_MODE_CTRL,
> +		RPR0521_MODE_MEAS_TIME_MASK,
> +		i);
> +}
> +
>  static int rpr0521_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan, int *val,
>  			    int *val2, long mask)
> @@ -381,6 +481,15 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->lock);
> +		ret = rpr0521_read_samp_freq(data, chan->type, val, val2);
> +		mutex_unlock(&data->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -401,6 +510,15 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
>  
>  		return ret;
>  
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&data->lock);
> +		ret = rpr0521_write_samp_freq_common(data,
> +			chan->type,
> +			val, val2);
It's trivial but please align arguments to open bracket where possible.
> +		mutex_unlock(&data->lock);
> +
> +		return ret;
> +
>  	default:
>  		return -EINVAL;
>  	}
> 

