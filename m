Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46197 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbEGXdo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:44 -0400
Message-ID: <554BEAD5.7050206@kernel.org>
Date: Thu, 07 May 2015 23:44:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, pmeerw@pmeerw.net
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iio: ltr501: Add light channel support
References: <b7a69555f210e3c9565da13dbfb71c89dbb1013b.1430519716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <b7a69555f210e3c9565da13dbfb71c89dbb1013b.1430519716.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/15 23:39, Kuppuswamy Sathyanarayanan wrote:
> Added support to calculate lux value from visible
> and IR spectrum adc count values. Also added IIO_LIGHT
> channel to enable user read the lux value directly
> from device using illuminance input ABI.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
something odd going on here.
you have changed the scan_index values, but not modified the trigger
handler to deal with the change.  Note these only have relevant in
buffered mode.  If you want this to only be exposed via sysfs, that
is fine (and perhaps reasonable) then set the scan_index to -1 (iirc)
and leave the other channels alone.

Jonathan
> ---
>  drivers/iio/light/ltr501.c | 71 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 64 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> index ca4bf47..242cf20 100644
> --- a/drivers/iio/light/ltr501.c
> +++ b/drivers/iio/light/ltr501.c
> @@ -66,6 +66,9 @@
>  
>  #define LTR501_REGMAP_NAME "ltr501_regmap"
>  
> +#define LTR501_LUX_CONV(vis_coeff, vis_data, ir_coeff, ir_data) \
> +			((vis_coeff * vis_data) - (ir_coeff * ir_data))
> +
>  static const int int_time_mapping[] = {100000, 50000, 200000, 400000};
>  
>  static const struct reg_field reg_field_it =
> @@ -298,6 +301,29 @@ static int ltr501_ps_read_samp_period(struct ltr501_data *data, int *val)
>  	return IIO_VAL_INT;
>  }
>  
> +/* IR and visible spectrum coeff's are given in data sheet */
> +static unsigned long ltr501_calculate_lux(u16 vis_data, u16 ir_data)
> +{
> +	unsigned long ratio, lux;
> +
> +	if (vis_data == 0)
> +		return 0;
> +
> +	/* multiply numerator by 100 to avoid handling ratio < 1 */
> +	ratio = DIV_ROUND_UP(ir_data * 100, ir_data + vis_data);
> +
> +	if (ratio < 45)
> +		lux = LTR501_LUX_CONV(1774, vis_data, -1105, ir_data);
> +	else if (ratio >= 45 && ratio < 64)
> +		lux = LTR501_LUX_CONV(3772, vis_data, 1336, ir_data);
> +	else if (ratio >= 64 && ratio < 85)
> +		lux = LTR501_LUX_CONV(1690, vis_data, 169, ir_data);
> +	else
> +		lux = 0;
> +
> +	return lux / 1000;
> +}
> +
>  static int ltr501_drdy(struct ltr501_data *data, u8 drdy_mask)
>  {
>  	int tries = 100;
> @@ -548,11 +574,24 @@ static const struct iio_event_spec ltr501_pxs_event_spec[] = {
>  	.num_event_specs = _evsize,\
>  }
>  
> +#define LTR501_LIGHT_CHANNEL(_idx) { \
> +	.type = IIO_LIGHT, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> +	.scan_index = 0, \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
> +	}, \
> +}
> +
>  static const struct iio_chan_spec ltr501_channels[] = {
> -	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0,
> +	LTR501_LIGHT_CHANNEL(0),
> +	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0,
>  				 ltr501_als_event_spec,
>  				 ARRAY_SIZE(ltr501_als_event_spec)),
> -	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
> +	LTR501_INTENSITY_CHANNEL(2, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
>  				 BIT(IIO_CHAN_INFO_SCALE) |
>  				 BIT(IIO_CHAN_INFO_INT_TIME) |
>  				 BIT(IIO_CHAN_INFO_SAMP_FREQ),
> @@ -562,7 +601,7 @@ static const struct iio_chan_spec ltr501_channels[] = {
>  		.address = LTR501_PS_DATA,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  			BIT(IIO_CHAN_INFO_SCALE),
> -		.scan_index = 2,
> +		.scan_index = 3,
>  		.scan_type = {
>  			.sign = 'u',
>  			.realbits = 11,
> @@ -572,19 +611,20 @@ static const struct iio_chan_spec ltr501_channels[] = {
>  		.event_spec = ltr501_pxs_event_spec,
>  		.num_event_specs = ARRAY_SIZE(ltr501_pxs_event_spec),
>  	},
> -	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
>  static const struct iio_chan_spec ltr301_channels[] = {
> -	LTR501_INTENSITY_CHANNEL(0, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0,
> +	LTR501_LIGHT_CHANNEL(0),
> +	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA0, IIO_MOD_LIGHT_BOTH, 0,
>  				 ltr501_als_event_spec,
>  				 ARRAY_SIZE(ltr501_als_event_spec)),
> -	LTR501_INTENSITY_CHANNEL(1, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
> +	LTR501_INTENSITY_CHANNEL(2, LTR501_ALS_DATA1, IIO_MOD_LIGHT_IR,
>  				 BIT(IIO_CHAN_INFO_SCALE) |
>  				 BIT(IIO_CHAN_INFO_INT_TIME) |
>  				 BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  				 NULL, 0),
> -	IIO_CHAN_SOFT_TIMESTAMP(2),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
>  static int ltr501_read_raw(struct iio_dev *indio_dev,
> @@ -596,6 +636,23 @@ static int ltr501_read_raw(struct iio_dev *indio_dev,
>  	int ret, i;
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (iio_buffer_enabled(indio_dev))
> +			return -EBUSY;
> +
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			mutex_lock(&data->lock_als);
> +			ret = ltr501_read_als(data, buf);
> +			mutex_unlock(&data->lock_als);
> +			if (ret < 0)
> +				return ret;
> +			*val = ltr501_calculate_lux(le16_to_cpu(buf[1]),
> +						    le16_to_cpu(buf[0]));
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_RAW:
>  		if (iio_buffer_enabled(indio_dev))
>  			return -EBUSY;
> 

