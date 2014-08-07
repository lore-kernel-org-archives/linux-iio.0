Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38448 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbaHGOtP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 10:49:15 -0400
Message-ID: <53E391E8.20809@kernel.org>
Date: Thu, 07 Aug 2014 15:49:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
CC: pmeerw@pmeerw.net
Subject: Re: [PATCH V2 6/8] io: mma8452: Add highpass filter configuration.
References: <20140729090128.4618.92936.stgit@localhost> <20140729090141.4618.89569.stgit@localhost>
In-Reply-To: <20140729090141.4618.89569.stgit@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/07/14 10:01, Martin Fuzzey wrote:
> Allow the cutoff frequency of the high pass filter to be configured.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Good - I'll take these once we've sorted the earlier patches.

> ---
>  drivers/iio/accel/mma8452.c |   65 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 1d1e41b..eb68f9a 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -29,6 +29,8 @@
>  #define MMA8452_INT_SRC 0x0c
>  #define MMA8452_WHO_AM_I 0x0d
>  #define MMA8452_DATA_CFG 0x0e
> +#define MMA8452_HP_FILTER_CUTOFF 0x0f
> +#define MMA8452_HP_FILTER_CUTOFF_SEL_MASK	(BIT(0) | BIT(1))
>  #define MMA8452_TRANSIENT_CFG 0x1d
>  #define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
>  #define MMA8452_TRANSIENT_CFG_CHAN_MASK(chan)	(BIT(1) << chan)
> @@ -162,6 +164,18 @@ static const int mma8452_transient_time_step_us[8] = {
>  	20000
>  };
>  
> +/* Datasheet table 18 (normal mode) */
> +static const int mma8452_hp_filter_cutoff[8][4][2] = {
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },		/* 800 Hz sample */
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },		/* 400 Hz sample */
> +	{ {8, 0}, {4, 0}, {2, 0}, {1, 0} },		/* 200 Hz sample */
> +	{ {4, 0}, {2, 0}, {1, 0}, {0, 500000} },	/* 100 Hz sample */
> +	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 50 Hz sample */
> +	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 12.5 Hz sample */
> +	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 6.25 Hz sample */
> +	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} }	/* 1.56 Hz sample */
> +};
> +
>  static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -176,9 +190,22 @@ static ssize_t mma8452_show_scale_avail(struct device *dev,
>  		ARRAY_SIZE(mma8452_scales));
>  }
>  
> +static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int i = mma8452_get_odr_index(data);
> +
> +	return mma8452_show_int_plus_micros(buf, mma8452_hp_filter_cutoff[i],
> +		ARRAY_SIZE(mma8452_hp_filter_cutoff[0]));
> +}
> +
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
>  static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
>  	mma8452_show_scale_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
> +			S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
>  
>  static int mma8452_get_samp_freq_index(struct mma8452_data *data,
>  	int val, int val2)
> @@ -194,6 +221,15 @@ static int mma8452_get_scale_index(struct mma8452_data *data,
>  		ARRAY_SIZE(mma8452_scales), val, val2);
>  }
>  
> +static int mma8452_get_hp_filter_index(struct mma8452_data *data,
> +	int val, int val2)
> +{
> +	int i = mma8452_get_odr_index(data);
> +
> +	return mma8452_get_int_plus_micros_index(mma8452_hp_filter_cutoff[i],
> +		ARRAY_SIZE(mma8452_scales[0]), val, val2);
> +}
> +
>  static int mma8452_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
> @@ -232,6 +268,16 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		*val = sign_extend32(ret, 7);
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		ret = i2c_smbus_read_byte_data(data->client,
> +						MMA8452_HP_FILTER_CUTOFF);
> +		if (ret < 0)
> +			return ret;
> +		i = mma8452_get_odr_index(data);
> +		ret &= MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
> +		*val = mma8452_hp_filter_cutoff[i][ret][0];
> +		*val2 = mma8452_hp_filter_cutoff[i][ret][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  	return -EINVAL;
>  }
> @@ -278,7 +324,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	int i;
> +	int i, reg;
>  
>  	if (iio_buffer_enabled(indio_dev))
>  		return -EBUSY;
> @@ -306,6 +352,19 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		return mma8452_change_config(data, MMA8452_OFF_X +
>  			chan->scan_index, val);
> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
> +		i = mma8452_get_hp_filter_index(data, val, val2);
> +		if (i < 0)
> +			return -EINVAL;
> +
> +		reg = i2c_smbus_read_byte_data(data->client,
> +						MMA8452_HP_FILTER_CUTOFF);
> +		if (reg < 0)
> +			return reg;
> +		reg &= ~MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
> +		reg |= i;
> +		return mma8452_change_config(data,
> +				MMA8452_HP_FILTER_CUTOFF, reg);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -552,7 +611,8 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  		BIT(IIO_CHAN_INFO_CALIBBIAS), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> -		BIT(IIO_CHAN_INFO_SCALE), \
> +		BIT(IIO_CHAN_INFO_SCALE) | \
> +		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY), \
>  	.scan_index = idx, \
>  	.scan_type = { \
>  		.sign = 's', \
> @@ -575,6 +635,7 @@ static const struct iio_chan_spec mma8452_channels[] = {
>  static struct attribute *mma8452_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_filter_high_pass_3db_frequency_available.dev_attr.attr,
>  	NULL
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
