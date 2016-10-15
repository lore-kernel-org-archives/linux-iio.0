Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49210 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbcJOQ7H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 12:59:07 -0400
Subject: Re: [PATCH 08/18] staging:iio:accel:sca3000 use a 'fake' channel to
 handle freefall event registration.
To: linux-iio@vger.kernel.org
References: <20161008163918.18758-1-jic23@kernel.org>
 <20161008163918.18758-9-jic23@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <af0e98f1-9975-7aa2-5300-143786a96179@kernel.org>
Date: Sat, 15 Oct 2016 17:59:03 +0100
MIME-Version: 1.0
In-Reply-To: <20161008163918.18758-9-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 17:39, Jonathan Cameron wrote:
> This is an approach used in some newer drivers as it exposes the
> compound channel events to the core rather than hiding their control
> in sysfs attributes entirely via the driver.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
oops. the sca3000_mode_mask (which gets replaced in the next patch).
doesn't actually exist.

I've added it during the apply and will take it out when applying the
next patch so that bisection works fine across this one.

Applied with that tweak. 

Jonathan
> ---
>  drivers/staging/iio/accel/sca3000.c | 302 ++++++++++++++++++------------------
>  1 file changed, 154 insertions(+), 148 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
> index 21428a4a3ec4..15adb24ddbfd 100644
> --- a/drivers/staging/iio/accel/sca3000.c
> +++ b/drivers/staging/iio/accel/sca3000.c
> @@ -593,10 +593,25 @@ static const struct iio_event_spec sca3000_event = {
>  		.num_event_specs = 1,				\
>  	}
>  
> +static const struct iio_event_spec sca3000_freefall_event_spec = {
> +	.type = IIO_EV_TYPE_MAG,
> +	.dir = IIO_EV_DIR_FALLING,
> +	.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +		BIT(IIO_EV_INFO_PERIOD),
> +};
> +
>  static const struct iio_chan_spec sca3000_channels[] = {
>  	SCA3000_CHAN(0, IIO_MOD_X),
>  	SCA3000_CHAN(1, IIO_MOD_Y),
>  	SCA3000_CHAN(2, IIO_MOD_Z),
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
> +		.scan_index = -1, /* Fake channel */
> +		.event_spec = &sca3000_freefall_event_spec,
> +		.num_event_specs = 1,
> +	},
>  };
>  
>  static const struct iio_chan_spec sca3000_channels_with_temp[] = {
> @@ -611,6 +626,14 @@ static const struct iio_chan_spec sca3000_channels_with_temp[] = {
>  		/* No buffer support */
>  		.scan_index = -1,
>  	},
> +	{
> +		.type = IIO_ACCEL,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
> +		.scan_index = -1, /* Fake channel */
> +		.event_spec = &sca3000_freefall_event_spec,
> +		.num_event_specs = 1,
> +	},
>  };
>  
>  static u8 sca3000_addresses[3][3] = {
> @@ -854,46 +877,54 @@ error_ret:
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sca3000_read_av_freq);
>  
>  /**
> - * sca3000_read_thresh() - query of a threshold
> + * sca3000_read_event_value() - query of a threshold or period
>   **/
> -static int sca3000_read_thresh(struct iio_dev *indio_dev,
> -			       const struct iio_chan_spec *chan,
> -			       enum iio_event_type type,
> -			       enum iio_event_direction dir,
> -			       enum iio_event_info info,
> -			       int *val, int *val2)
> +static int sca3000_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
>  {
>  	int ret, i;
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int num = chan->channel2;
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		mutex_lock(&st->lock);
> +		ret = sca3000_read_ctrl_reg(st, sca3000_addresses[num][1]);
> +		mutex_unlock(&st->lock);
> +		if (ret < 0)
> +			return ret;
> +		*val = 0;
> +		if (num == 1)
> +			for_each_set_bit(i, (unsigned long *)&ret,
> +					 ARRAY_SIZE(st->info->mot_det_mult_y))
> +				*val += st->info->mot_det_mult_y[i];
> +		else
> +			for_each_set_bit(i, (unsigned long *)&ret,
> +					 ARRAY_SIZE(st->info->mot_det_mult_xz))
> +				*val += st->info->mot_det_mult_xz[i];
>  
> -	mutex_lock(&st->lock);
> -	ret = sca3000_read_ctrl_reg(st, sca3000_addresses[num][1]);
> -	mutex_unlock(&st->lock);
> -	if (ret < 0)
> -		return ret;
> -	*val = 0;
> -	if (num == 1)
> -		for_each_set_bit(i, (unsigned long *)&ret,
> -				 ARRAY_SIZE(st->info->mot_det_mult_y))
> -			*val += st->info->mot_det_mult_y[i];
> -	else
> -		for_each_set_bit(i, (unsigned long *)&ret,
> -				 ARRAY_SIZE(st->info->mot_det_mult_xz))
> -			*val += st->info->mot_det_mult_xz[i];
> -
> -	return IIO_VAL_INT;
> +		return IIO_VAL_INT;
> +	case IIO_EV_INFO_PERIOD:
> +		*val = 0;
> +		*val2 = 226000;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  /**
> - * sca3000_write_thresh() control of threshold
> + * sca3000_write_value() control of threshold and period
>   **/
> -static int sca3000_write_thresh(struct iio_dev *indio_dev,
> -				const struct iio_chan_spec *chan,
> -				enum iio_event_type type,
> -				enum iio_event_direction dir,
> -				enum iio_event_info info,
> -				int val, int val2)
> +static int sca3000_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
>  {
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int num = chan->channel2;
> @@ -901,7 +932,7 @@ static int sca3000_write_thresh(struct iio_dev *indio_dev,
>  	int i;
>  	u8 nonlinear = 0;
>  
> -	if (num == 1) {
> +	if (num == IIO_MOD_Y) {
>  		i = ARRAY_SIZE(st->info->mot_det_mult_y);
>  		while (i > 0)
>  			if (val >= st->info->mot_det_mult_y[--i]) {
> @@ -1088,180 +1119,156 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
>  
>  	/* read current value of mode register */
>  	mutex_lock(&st->lock);
> +
>  	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
>  	if (ret)
>  		goto error_ret;
>  
> -	if ((st->rx[0] & protect_mask) != SCA3000_MEAS_MODE_MOT_DET) {
> -		ret = 0;
> -	} else {
> -		ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
> -		if (ret < 0)
> -			goto error_ret;
> -		/* only supporting logical or's for now */
> -		ret = !!(ret & sca3000_addresses[num][2]);
> +	switch (chan->channel2) {
> +	case IIO_MOD_X_AND_Y_AND_Z:
> +		ret = !!(st->rx[0] & SCA3000_FREE_FALL_DETECT);
> +		break;
> +	case IIO_MOD_X:
> +	case IIO_MOD_Y:
> +	case IIO_MOD_Z:
> +		/*
> +		 * Motion detection mode cannot run at the same time as
> +		 * acceleration data being read.
> +		 */
> +		if ((st->rx[0] & protect_mask) != SCA3000_MEAS_MODE_MOT_DET) {
> +			ret = 0;
> +		} else {
> +			ret = sca3000_read_ctrl_reg(st,
> +						SCA3000_REG_CTRL_SEL_MD_CTRL);
> +			if (ret < 0)
> +				goto error_ret;
> +			/* only supporting logical or's for now */
> +			ret = !!(ret & sca3000_addresses[num][2]);
> +		}
> +		break;
> +	default:
> +		ret = -EINVAL;
>  	}
> +
>  error_ret:
>  	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
>  
> -/**
> - * sca3000_query_free_fall_mode() is free fall mode enabled
> - **/
> -static ssize_t sca3000_query_free_fall_mode(struct device *dev,
> -					    struct device_attribute *attr,
> -					    char *buf)
> +static int sca3000_freefall_set_state(struct iio_dev *indio_dev, int state)
>  {
> -	int ret;
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct sca3000_state *st = iio_priv(indio_dev);
> -	int val;
> -
> -	mutex_lock(&st->lock);
> -	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
> -	val = st->rx[0];
> -	mutex_unlock(&st->lock);
> -	if (ret < 0)
> -		return ret;
> -	return sprintf(buf, "%d\n", !!(val & SCA3000_FREE_FALL_DETECT));
> -}
> -
> -/**
> - * sca3000_set_free_fall_mode() simple on off control for free fall int
> - *
> - * In these chips the free fall detector should send an interrupt if
> - * the device falls more than 25cm.  This has not been tested due
> - * to fragile wiring.
> - **/
> -static ssize_t sca3000_set_free_fall_mode(struct device *dev,
> -					  struct device_attribute *attr,
> -					  const char *buf,
> -					  size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct sca3000_state *st = iio_priv(indio_dev);
> -	u8 val;
>  	int ret;
> -	u8 protect_mask = SCA3000_FREE_FALL_DETECT;
> -
> -	mutex_lock(&st->lock);
> -	ret = kstrtou8(buf, 10, &val);
> -	if (ret)
> -		goto error_ret;
>  
>  	/* read current value of mode register */
>  	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
>  	if (ret)
> -		goto error_ret;
> +		return ret;
>  
>  	/* if off and should be on */
> -	if (val && !(st->rx[0] & protect_mask))
> -		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> -					(st->rx[0] | SCA3000_FREE_FALL_DETECT));
> +	if (state && !(st->rx[0] & SCA3000_FREE_FALL_DETECT))
> +		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> +					 st->rx[0] | SCA3000_FREE_FALL_DETECT);
>  	/* if on and should be off */
> -	else if (!val && (st->rx[0] & protect_mask))
> -		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> -					(st->rx[0] & ~protect_mask));
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret ? ret : len;
> +	else if (!state && (st->rx[0] & SCA3000_FREE_FALL_DETECT))
> +		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> +					 st->rx[0] & ~SCA3000_FREE_FALL_DETECT);
> +	else
> +		return 0;
>  }
>  
> -/**
> - * sca3000_write_event_config() simple on off control for motion detector
> - *
> - * This is a per axis control, but enabling any will result in the
> - * motion detector unit being enabled.
> - * N.B. enabling motion detector stops normal data acquisition.
> - * There is a complexity in knowing which mode to return to when
> - * this mode is disabled.  Currently normal mode is assumed.
> - **/
> -static int sca3000_write_event_config(struct iio_dev *indio_dev,
> -				      const struct iio_chan_spec *chan,
> -				      enum iio_event_type type,
> -				      enum iio_event_direction dir,
> -				      int state)
> +static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
> +					   int state)
>  {
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret, ctrlval;
> -	u8 protect_mask = 0x03;
> -	int num = chan->channel2;
>  
> -	mutex_lock(&st->lock);
>  	/*
>  	 * First read the motion detector config to find out if
>  	 * this axis is on
>  	 */
>  	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_MD_CTRL);
>  	if (ret < 0)
> -		goto exit_point;
> +		return ret;
>  	ctrlval = ret;
>  	/* if off and should be on */
> -	if (state && !(ctrlval & sca3000_addresses[num][2])) {
> +	if (state && !(ctrlval & sca3000_addresses[axis][2])) {
>  		ret = sca3000_write_ctrl_reg(st,
>  					     SCA3000_REG_CTRL_SEL_MD_CTRL,
>  					     ctrlval |
> -					     sca3000_addresses[num][2]);
> +					     sca3000_addresses[axis][2]);
>  		if (ret)
> -			goto exit_point;
> +			return ret;
>  		st->mo_det_use_count++;
> -	} else if (!state && (ctrlval & sca3000_addresses[num][2])) {
> +	} else if (!state && (ctrlval & sca3000_addresses[axis][2])) {
>  		ret = sca3000_write_ctrl_reg(st,
>  					     SCA3000_REG_CTRL_SEL_MD_CTRL,
>  					     ctrlval &
> -					     ~(sca3000_addresses[num][2]));
> +					     ~(sca3000_addresses[axis][2]));
>  		if (ret)
> -			goto exit_point;
> +			return ret;
>  		st->mo_det_use_count--;
>  	}
>  
>  	/* read current value of mode register */
>  	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
>  	if (ret)
> -		goto exit_point;
> +		return ret;
>  	/* if off and should be on */
>  	if ((st->mo_det_use_count) &&
> -	    ((st->rx[0] & protect_mask) != SCA3000_MEAS_MODE_MOT_DET))
> -		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> -					(st->rx[0] & ~protect_mask)
> +	    ((st->rx[0] & SCA3000_MODE_MASK) != SCA3000_MEAS_MODE_MOT_DET))
> +		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> +					(st->rx[0] & ~SCA3000_MODE_MASK)
>  					| SCA3000_MEAS_MODE_MOT_DET);
>  	/* if on and should be off */
>  	else if (!(st->mo_det_use_count) &&
> -		 ((st->rx[0] & protect_mask) == SCA3000_MEAS_MODE_MOT_DET))
> -		ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> -					(st->rx[0] & ~protect_mask));
> -exit_point:
> +		 ((st->rx[0] & SCA3000_MODE_MASK) == SCA3000_MEAS_MODE_MOT_DET))
> +		return sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
> +					st->rx[0] & SCA3000_MODE_MASK);
> +	else
> +		return 0;
> +}
> +
> +/**
> + * sca3000_write_event_config() simple on off control for motion detector
> + *
> + * This is a per axis control, but enabling any will result in the
> + * motion detector unit being enabled.
> + * N.B. enabling motion detector stops normal data acquisition.
> + * There is a complexity in knowing which mode to return to when
> + * this mode is disabled.  Currently normal mode is assumed.
> + **/
> +static int sca3000_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      int state)
> +{
> +	struct sca3000_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	switch (chan->channel2) {
> +	case IIO_MOD_X_AND_Y_AND_Z:
> +		ret = sca3000_freefall_set_state(indio_dev, state);
> +		break;
> +
> +	case IIO_MOD_X:
> +	case IIO_MOD_Y:
> +	case IIO_MOD_Z:
> +		ret = sca3000_motion_detect_set_state(indio_dev, chan->channel2,
> +						      state);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
>  	mutex_unlock(&st->lock);
>  
>  	return ret;
>  }
>  
> -/* Free fall detector related event attribute */
> -static IIO_DEVICE_ATTR_NAMED(accel_xayaz_mag_falling_en,
> -			     in_accel_x & y & z_mag_falling_en,
> -			     S_IRUGO | S_IWUSR,
> -			     sca3000_query_free_fall_mode,
> -			     sca3000_set_free_fall_mode,
> -			     0);
> -
> -static IIO_CONST_ATTR_NAMED(accel_xayaz_mag_falling_period,
> -			    in_accel_x & y & z_mag_falling_period,
> -			    "0.226");
> -
> -static struct attribute *sca3000_event_attributes[] = {
> -	&iio_dev_attr_accel_xayaz_mag_falling_en.dev_attr.attr,
> -	&iio_const_attr_accel_xayaz_mag_falling_period.dev_attr.attr,
> -	NULL,
> -};
> -
> -static struct attribute_group sca3000_event_attribute_group = {
> -	.attrs = sca3000_event_attributes,
> -	.name = "events",
> -};
> -
>  static int sca3000_configure_ring(struct iio_dev *indio_dev)
>  {
>  	struct iio_buffer *buffer;
> @@ -1436,9 +1443,8 @@ static const struct iio_info sca3000_info = {
>  	.attrs = &sca3000_attribute_group,
>  	.read_raw = &sca3000_read_raw,
>  	.write_raw = &sca3000_write_raw,
> -	.event_attrs = &sca3000_event_attribute_group,
> -	.read_event_value = &sca3000_read_thresh,
> -	.write_event_value = &sca3000_write_thresh,
> +	.read_event_value = &sca3000_read_event_value,
> +	.write_event_value = &sca3000_write_event_value,
>  	.read_event_config = &sca3000_read_event_config,
>  	.write_event_config = &sca3000_write_event_config,
>  	.driver_module = THIS_MODULE,
> 

