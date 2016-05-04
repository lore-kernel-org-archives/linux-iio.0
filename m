Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35951 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579AbcEDOkz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:40:55 -0400
Subject: Re: [PATCH] iio: mma8452: add support for oversampling ratio
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1461586105-12919-1-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7c324841-e801-f81d-e344-05964d885b1f@kernel.org>
Date: Wed, 4 May 2016 11:47:21 +0100
MIME-Version: 1.0
In-Reply-To: <1461586105-12919-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/04/16 13:08, Martin Kepplinger wrote:
> This adds the following sysfs files according to the iio ABI:
> 
> -rw-r--r--    4096 in_accel_oversampling_ratio
> -r--r--r--    4096 in_accel_oversampling_ratio_available
> 
> Internally, the device knows about 4 different power modes that differ
> in oversampling ratio (and power consumption). We just show the user
> what oversampling ratio(s) is/are available, depending on the current
> frequency.
> 
> The referenced table in the datasheets makes it easier to understand.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Looks good to me - applied to the togreg branch of iio.git which will
sometime before the end of the weekend get pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
> This is meant to get merged for v4.8 to have time for review and possibly
> testing by others.
> 
> thanks,
>                        martin
> 
> 
>  drivers/iio/accel/mma8452.c | 185 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 160 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index e225d3c..458c827 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -76,6 +76,8 @@
>  #define  MMA8452_CTRL_DR_DEFAULT		0x4 /* 50 Hz sample frequency */
>  #define MMA8452_CTRL_REG2			0x2b
>  #define  MMA8452_CTRL_REG2_RST			BIT(6)
> +#define  MMA8452_CTRL_REG2_MODS_SHIFT		3
> +#define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
>  #define MMA8452_CTRL_REG4			0x2d
>  #define MMA8452_CTRL_REG5			0x2e
>  #define MMA8452_OFF_X				0x2f
> @@ -257,20 +259,17 @@ static const int mma8452_samp_freq[8][2] = {
>  	{6, 250000}, {1, 560000}
>  };
>  
> -/* Datasheet table 35  (step time vs sample frequency) */
> -static const int mma8452_transient_time_step_us[8] = {
> -	1250,
> -	2500,
> -	5000,
> -	10000,
> -	20000,
> -	20000,
> -	20000,
> -	20000
> +/* Datasheet table: step time "Relationship with the ODR" (sample frequency) */
> +static const int mma8452_transient_time_step_us[4][8] = {
> +	{ 1250, 2500, 5000, 10000, 20000, 20000, 20000, 20000 },  /* normal */
> +	{ 1250, 2500, 5000, 10000, 20000, 80000, 80000, 80000 },  /* l p l n */
> +	{ 1250, 2500, 2500, 2500, 2500, 2500, 2500, 2500 },	  /* high res*/
> +	{ 1250, 2500, 5000, 10000, 20000, 80000, 160000, 160000 } /* l p */
>  };
>  
> -/* Datasheet table 18 (normal mode) */
> -static const int mma8452_hp_filter_cutoff[8][4][2] = {
> +/* Datasheet table "High-Pass Filter Cutoff Options" */
> +static const int mma8452_hp_filter_cutoff[4][8][4][2] = {
> +	{ /* normal */
>  	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },		/* 800 Hz sample */
>  	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },		/* 400 Hz sample */
>  	{ {8, 0}, {4, 0}, {2, 0}, {1, 0} },		/* 200 Hz sample */
> @@ -279,8 +278,61 @@ static const int mma8452_hp_filter_cutoff[8][4][2] = {
>  	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 12.5 Hz sample */
>  	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },	/* 6.25 Hz sample */
>  	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} }	/* 1.56 Hz sample */
> +	},
> +	{ /* low noise low power */
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {8, 0}, {4, 0}, {2, 0}, {1, 0} },
> +	{ {4, 0}, {2, 0}, {1, 0}, {0, 500000} },
> +	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },
> +	{ {0, 500000}, {0, 250000}, {0, 125000}, {0, 063000} },
> +	{ {0, 500000}, {0, 250000}, {0, 125000}, {0, 063000} },
> +	{ {0, 500000}, {0, 250000}, {0, 125000}, {0, 063000} }
> +	},
> +	{ /* high resolution */
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} }
> +	},
> +	{ /* low power */
> +	{ {16, 0}, {8, 0}, {4, 0}, {2, 0} },
> +	{ {8, 0}, {4, 0}, {2, 0}, {1, 0} },
> +	{ {4, 0}, {2, 0}, {1, 0}, {0, 500000} },
> +	{ {2, 0}, {1, 0}, {0, 500000}, {0, 250000} },
> +	{ {1, 0}, {0, 500000}, {0, 250000}, {0, 125000} },
> +	{ {0, 250000}, {0, 125000}, {0, 063000}, {0, 031000} },
> +	{ {0, 250000}, {0, 125000}, {0, 063000}, {0, 031000} },
> +	{ {0, 250000}, {0, 125000}, {0, 063000}, {0, 031000} }
> +	}
>  };
>  
> +/* Datasheet table "MODS Oversampling modes averaging values at each ODR" */
> +static const u16 mma8452_os_ratio[4][8] = {
> +	/* 800 Hz, 400 Hz, ... , 1.56 Hz */
> +	{ 2, 4, 4, 4, 4, 16, 32, 128 },		/* normal */
> +	{ 2, 4, 4, 4, 4, 4, 8, 32 },		/* low power low noise */
> +	{ 2, 4, 8, 16, 32, 128, 256, 1024 },	/* high resolution */
> +	{ 2, 2, 2, 2, 2, 2, 4, 16 }		/* low power */
> +};
> +
> +static int mma8452_get_power_mode(struct mma8452_data *data)
> +{
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(data->client,
> +				       MMA8452_CTRL_REG2);
> +	if (reg < 0)
> +		return reg;
> +
> +	return ((reg & MMA8452_CTRL_REG2_MODS_MASK) >>
> +		MMA8452_CTRL_REG2_MODS_SHIFT);
> +}
> +
>  static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
>  					    struct device_attribute *attr,
>  					    char *buf)
> @@ -306,10 +358,39 @@ static ssize_t mma8452_show_hp_cutoff_avail(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	int i, j;
> +
> +	i = mma8452_get_odr_index(data);
> +	j = mma8452_get_power_mode(data);
> +	if (j < 0)
> +		return j;
> +
> +	return mma8452_show_int_plus_micros(buf, mma8452_hp_filter_cutoff[j][i],
> +		ARRAY_SIZE(mma8452_hp_filter_cutoff[0][0]));
> +}
> +
> +static ssize_t mma8452_show_os_ratio_avail(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
>  	int i = mma8452_get_odr_index(data);
> +	int j;
> +	u16 val = 0;
> +	size_t len = 0;
> +
> +	for (j = 0; j < ARRAY_SIZE(mma8452_os_ratio); j++) {
> +		if (val == mma8452_os_ratio[j][i])
> +			continue;
> +
> +		val = mma8452_os_ratio[j][i];
> +
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", val);
> +	}
> +	buf[len - 1] = '\n';
>  
> -	return mma8452_show_int_plus_micros(buf, mma8452_hp_filter_cutoff[i],
> -		ARRAY_SIZE(mma8452_hp_filter_cutoff[0]));
> +	return len;
>  }
>  
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mma8452_show_samp_freq_avail);
> @@ -317,6 +398,8 @@ static IIO_DEVICE_ATTR(in_accel_scale_available, S_IRUGO,
>  		       mma8452_show_scale_avail, NULL, 0);
>  static IIO_DEVICE_ATTR(in_accel_filter_high_pass_3db_frequency_available,
>  		       S_IRUGO, mma8452_show_hp_cutoff_avail, NULL, 0);
> +static IIO_DEVICE_ATTR(in_accel_oversampling_ratio_available, S_IRUGO,
> +		       mma8452_show_os_ratio_avail, NULL, 0);
>  
>  static int mma8452_get_samp_freq_index(struct mma8452_data *data,
>  				       int val, int val2)
> @@ -335,24 +418,33 @@ static int mma8452_get_scale_index(struct mma8452_data *data, int val, int val2)
>  static int mma8452_get_hp_filter_index(struct mma8452_data *data,
>  				       int val, int val2)
>  {
> -	int i = mma8452_get_odr_index(data);
> +	int i, j;
> +
> +	i = mma8452_get_odr_index(data);
> +	j = mma8452_get_power_mode(data);
> +	if (j < 0)
> +		return j;
>  
> -	return mma8452_get_int_plus_micros_index(mma8452_hp_filter_cutoff[i],
> -		ARRAY_SIZE(mma8452_hp_filter_cutoff[0]), val, val2);
> +	return mma8452_get_int_plus_micros_index(mma8452_hp_filter_cutoff[j][i],
> +		ARRAY_SIZE(mma8452_hp_filter_cutoff[0][0]), val, val2);
>  }
>  
>  static int mma8452_read_hp_filter(struct mma8452_data *data, int *hz, int *uHz)
>  {
> -	int i, ret;
> +	int j, i, ret;
>  
>  	ret = i2c_smbus_read_byte_data(data->client, MMA8452_HP_FILTER_CUTOFF);
>  	if (ret < 0)
>  		return ret;
>  
>  	i = mma8452_get_odr_index(data);
> +	j = mma8452_get_power_mode(data);
> +	if (j < 0)
> +		return j;
> +
>  	ret &= MMA8452_HP_FILTER_CUTOFF_SEL_MASK;
> -	*hz = mma8452_hp_filter_cutoff[i][ret][0];
> -	*uHz = mma8452_hp_filter_cutoff[i][ret][1];
> +	*hz = mma8452_hp_filter_cutoff[j][i][ret][0];
> +	*uHz = mma8452_hp_filter_cutoff[j][i][ret][1];
>  
>  	return 0;
>  }
> @@ -414,6 +506,15 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  		}
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = mma8452_get_power_mode(data);
> +		if (ret < 0)
> +			return ret;
> +
> +		i = mma8452_get_odr_index(data);
> +
> +		*val = mma8452_os_ratio[ret][i];
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
> @@ -480,6 +581,21 @@ fail:
>  	return ret;
>  }
>  
> +static int mma8452_set_power_mode(struct mma8452_data *data, u8 mode)
> +{
> +	int reg;
> +
> +	reg = i2c_smbus_read_byte_data(data->client,
> +				       MMA8452_CTRL_REG2);
> +	if (reg < 0)
> +		return reg;
> +
> +	reg &= ~MMA8452_CTRL_REG2_MODS_MASK;
> +	reg |= mode << MMA8452_CTRL_REG2_MODS_SHIFT;
> +
> +	return mma8452_change_config(data, MMA8452_CTRL_REG2, reg);
> +}
> +
>  /* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>  {
> @@ -597,6 +713,14 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
>  		return mma8452_change_config(data, MMA8452_DATA_CFG,
>  					     data->data_cfg);
>  
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = mma8452_get_odr_index(data);
> +
> +		for (i = 0; i < ARRAY_SIZE(mma8452_os_ratio); i++) {
> +			if (mma8452_os_ratio[i][ret] == val)
> +				return mma8452_set_power_mode(data, i);
> +		}
> +
>  	default:
>  		return -EINVAL;
>  	}
> @@ -610,7 +734,7 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
>  			       int *val, int *val2)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	int ret, us;
> +	int ret, us, power_mode;
>  
>  	switch (info) {
>  	case IIO_EV_INFO_VALUE:
> @@ -629,7 +753,11 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		us = ret * mma8452_transient_time_step_us[
> +		power_mode = mma8452_get_power_mode(data);
> +		if (power_mode < 0)
> +			return power_mode;
> +
> +		us = ret * mma8452_transient_time_step_us[power_mode][
>  				mma8452_get_odr_index(data)];
>  		*val = us / USEC_PER_SEC;
>  		*val2 = us % USEC_PER_SEC;
> @@ -677,8 +805,12 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
>  					     val);
>  
>  	case IIO_EV_INFO_PERIOD:
> +		ret = mma8452_get_power_mode(data);
> +		if (ret < 0)
> +			return ret;
> +
>  		steps = (val * USEC_PER_SEC + val2) /
> -				mma8452_transient_time_step_us[
> +				mma8452_transient_time_step_us[ret][
>  					mma8452_get_odr_index(data)];
>  
>  		if (steps < 0 || steps > 0xff)
> @@ -978,7 +1110,8 @@ static struct attribute_group mma8452_event_attribute_group = {
>  			      BIT(IIO_CHAN_INFO_CALIBBIAS), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
>  			BIT(IIO_CHAN_INFO_SCALE) | \
> -			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY), \
> +			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) | \
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>  	.scan_index = idx, \
>  	.scan_type = { \
>  		.sign = 's', \
> @@ -998,7 +1131,8 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  		BIT(IIO_CHAN_INFO_CALIBBIAS), \
>  	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> -		BIT(IIO_CHAN_INFO_SCALE), \
> +		BIT(IIO_CHAN_INFO_SCALE) | \
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
>  	.scan_index = idx, \
>  	.scan_type = { \
>  		.sign = 's', \
> @@ -1171,6 +1305,7 @@ static struct attribute *mma8452_attributes[] = {
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
>  	&iio_dev_attr_in_accel_filter_high_pass_3db_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_accel_oversampling_ratio_available.dev_attr.attr,
>  	NULL
>  };
>  
> 

