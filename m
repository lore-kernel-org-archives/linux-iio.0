Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49481 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbcIRKkY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Sep 2016 06:40:24 -0400
Subject: Re: [PATCH] iio: accel: sca3000_core: implemented
 IIO_CHAN_INFO_SAMP_FREQ
To: Ico Doornekamp <ico@pruts.nl>
References: <99ce25ac-2330-ad53-151d-f580226906eb@kernel.org>
 <20160913191414.3381-1-ico@pruts.nl>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4bd42421-5d11-7512-3e24-3c4e1ad56ed2@kernel.org>
Date: Sun, 18 Sep 2016 11:40:22 +0100
MIME-Version: 1.0
In-Reply-To: <20160913191414.3381-1-ico@pruts.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/09/16 20:14, Ico Doornekamp wrote:
> Moved functionality from IIO_DEV_ATTR_SAMP_FREQ attribute into
> IIO_CHAN_INFO_SAMP_FREQ handlers. Added sca3000_write_raw() to allow
> writing the element as well.
> 
> Signed-off-by: Ico Doornekamp <ico@pruts.nl>
Applied to the togreg branch of iio.git.  Not sure if it will make it
through in time for the upcoming merge window (Greg takes pull requests
up until one week before the merge window opens - that might be today
depending on what sort of hints Linus drops about and rc8 for the
current cycle.)

Will be pushed out as testing initially to let the autobuilders play
with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/accel/sca3000.h      |   1 +
>  drivers/staging/iio/accel/sca3000_core.c | 242 +++++++++++++++----------------
>  2 files changed, 121 insertions(+), 122 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
> index 9c8a958..4dcc857 100644
> --- a/drivers/staging/iio/accel/sca3000.h
> +++ b/drivers/staging/iio/accel/sca3000.h
> @@ -113,6 +113,7 @@
>  #define SCA3000_OUT_CTRL_BUF_X_EN		0x10
>  #define SCA3000_OUT_CTRL_BUF_Y_EN		0x08
>  #define SCA3000_OUT_CTRL_BUF_Z_EN		0x04
> +#define SCA3000_OUT_CTRL_BUF_DIV_MASK		0x03
>  #define SCA3000_OUT_CTRL_BUF_DIV_4		0x02
>  #define SCA3000_OUT_CTRL_BUF_DIV_2		0x01
>  
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 61f3241..d626125 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -402,6 +402,7 @@ static const struct iio_event_spec sca3000_event = {
>  		.channel2 = mod,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
>  		.address = index,				\
>  		.scan_index = index,				\
>  		.scan_type = {					\
> @@ -443,6 +444,97 @@ static u8 sca3000_addresses[3][3] = {
>  	       SCA3000_MD_CTRL_OR_Z},
>  };
>  
> +/**
> + * __sca3000_get_base_freq() obtain mode specific base frequency
> + *
> + * lock must be held
> + **/
> +static inline int __sca3000_get_base_freq(struct sca3000_state *st,
> +					  const struct sca3000_chip_info *info,
> +					  int *base_freq)
> +{
> +	int ret;
> +
> +	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
> +	if (ret)
> +		goto error_ret;
> +	switch (0x03 & st->rx[0]) {
> +	case SCA3000_MEAS_MODE_NORMAL:
> +		*base_freq = info->measurement_mode_freq;
> +		break;
> +	case SCA3000_MEAS_MODE_OP_1:
> +		*base_freq = info->option_mode_1_freq;
> +		break;
> +	case SCA3000_MEAS_MODE_OP_2:
> +		*base_freq = info->option_mode_2_freq;
> +		break;
> +	}
> +error_ret:
> +	return ret;
> +}
> +
> +/**
> + * read_raw handler for IIO_CHAN_INFO_SAMP_FREQ
> + *
> + * lock must be held
> + **/
> +static int read_raw_samp_freq(struct sca3000_state *st, int *val)
> +{
> +	int ret;
> +
> +	ret = __sca3000_get_base_freq(st, st->info, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (*val > 0) {
> +		ret &= SCA3000_OUT_CTRL_BUF_DIV_MASK;
> +		switch (ret) {
> +		case SCA3000_OUT_CTRL_BUF_DIV_2:
> +			*val /= 2;
> +			break;
> +		case SCA3000_OUT_CTRL_BUF_DIV_4:
> +			*val /= 4;
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * write_raw handler for IIO_CHAN_INFO_SAMP_FREQ
> + *
> + * lock must be held
> + **/
> +static int write_raw_samp_freq(struct sca3000_state *st, int val)
> +{
> +	int ret, base_freq, ctrlval;
> +
> +	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
> +	if (ret)
> +		return ret;
> +
> +	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ctrlval = ret & ~SCA3000_OUT_CTRL_BUF_DIV_MASK;
> +
> +	if (val == base_freq / 2)
> +		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_2;
> +	if (val == base_freq / 4)
> +		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_4;
> +	else if (val != base_freq)
> +		return -EINVAL;
> +
> +	return sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
> +				     ctrlval);
> +}
> +
>  static int sca3000_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val,
> @@ -495,11 +587,38 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
>  		*val = -214;
>  		*val2 = 600000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(&st->lock);
> +		ret = read_raw_samp_freq(st, val);
> +		mutex_unlock(&st->lock);
> +		return ret ? ret : IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
>  }
>  
> +static int sca3000_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct sca3000_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val2)
> +			return -EINVAL;
> +		mutex_lock(&st->lock);
> +		ret = write_raw_samp_freq(st, val);
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  /**
>   * sca3000_read_av_freq() sysfs function to get available frequencies
>   *
> @@ -548,133 +667,12 @@ error_ret:
>  	return ret;
>  }
>  
> -/**
> - * __sca3000_get_base_freq() obtain mode specific base frequency
> - *
> - * lock must be held
> - **/
> -static inline int __sca3000_get_base_freq(struct sca3000_state *st,
> -					  const struct sca3000_chip_info *info,
> -					  int *base_freq)
> -{
> -	int ret;
> -
> -	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
> -	if (ret)
> -		goto error_ret;
> -	switch (0x03 & st->rx[0]) {
> -	case SCA3000_MEAS_MODE_NORMAL:
> -		*base_freq = info->measurement_mode_freq;
> -		break;
> -	case SCA3000_MEAS_MODE_OP_1:
> -		*base_freq = info->option_mode_1_freq;
> -		break;
> -	case SCA3000_MEAS_MODE_OP_2:
> -		*base_freq = info->option_mode_2_freq;
> -		break;
> -	}
> -error_ret:
> -	return ret;
> -}
> -
> -/**
> - * sca3000_read_frequency() sysfs interface to get the current frequency
> - **/
> -static ssize_t sca3000_read_frequency(struct device *dev,
> -				      struct device_attribute *attr,
> -				      char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct sca3000_state *st = iio_priv(indio_dev);
> -	int ret, len = 0, base_freq = 0, val;
> -
> -	mutex_lock(&st->lock);
> -	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
> -	if (ret)
> -		goto error_ret_mut;
> -	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
> -	mutex_unlock(&st->lock);
> -	if (ret < 0)
> -		goto error_ret;
> -	val = ret;
> -	if (base_freq > 0)
> -		switch (val & 0x03) {
> -		case 0x00:
> -		case 0x03:
> -			len = sprintf(buf, "%d\n", base_freq);
> -			break;
> -		case 0x01:
> -			len = sprintf(buf, "%d\n", base_freq / 2);
> -			break;
> -		case 0x02:
> -			len = sprintf(buf, "%d\n", base_freq / 4);
> -			break;
> -	}
> -
> -	return len;
> -error_ret_mut:
> -	mutex_unlock(&st->lock);
> -error_ret:
> -	return ret;
> -}
> -
> -/**
> - * sca3000_set_frequency() sysfs interface to set the current frequency
> - **/
> -static ssize_t sca3000_set_frequency(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct sca3000_state *st = iio_priv(indio_dev);
> -	int ret, base_freq = 0;
> -	int ctrlval;
> -	int val;
> -
> -	ret = kstrtoint(buf, 10, &val);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&st->lock);
> -	/* What mode are we in? */
> -	ret = __sca3000_get_base_freq(st, st->info, &base_freq);
> -	if (ret)
> -		goto error_free_lock;
> -
> -	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
> -	if (ret < 0)
> -		goto error_free_lock;
> -	ctrlval = ret;
> -	/* clear the bits */
> -	ctrlval &= ~0x03;
> -
> -	if (val == base_freq / 2) {
> -		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_2;
> -	} else if (val == base_freq / 4) {
> -		ctrlval |= SCA3000_OUT_CTRL_BUF_DIV_4;
> -	} else if (val != base_freq) {
> -		ret = -EINVAL;
> -		goto error_free_lock;
> -	}
> -	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
> -				     ctrlval);
> -error_free_lock:
> -	mutex_unlock(&st->lock);
> -
> -	return ret ? ret : len;
> -}
> -
>  /*
>   * Should only really be registered if ring buffer support is compiled in.
>   * Does no harm however and doing it right would add a fair bit of complexity
>   */
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sca3000_read_av_freq);
>  
> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> -			      sca3000_read_frequency,
> -			      sca3000_set_frequency);
> -
>  /**
>   * sca3000_read_thresh() - query of a threshold
>   **/
> @@ -751,7 +749,6 @@ static struct attribute *sca3000_attributes[] = {
>  	&iio_dev_attr_measurement_mode_available.dev_attr.attr,
>  	&iio_dev_attr_measurement_mode.dev_attr.attr,
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> -	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -1086,6 +1083,7 @@ error_ret:
>  static const struct iio_info sca3000_info = {
>  	.attrs = &sca3000_attribute_group,
>  	.read_raw = &sca3000_read_raw,
> +	.write_raw = &sca3000_write_raw,
>  	.event_attrs = &sca3000_event_attribute_group,
>  	.read_event_value = &sca3000_read_thresh,
>  	.write_event_value = &sca3000_write_thresh,
> 

