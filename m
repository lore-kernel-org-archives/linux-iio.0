Return-Path: <pmeerw@pmeerw.net>
Date: Wed, 23 Jul 2014 20:20:31 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Martin Fuzzey <mfuzzey@parkeon.com>
cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/8] iio: mma8452: Add support for transient event
 debouncing
In-Reply-To: <20140723171727.22067.61322.stgit@localhost>
Message-ID: <alpine.DEB.2.01.1407232016350.21518@pmeerw.net>
References: <20140723171719.22067.79447.stgit@localhost> <20140723171727.22067.61322.stgit@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Allow the debouce counter for transient events to be configured
> using the sysfs attribute events/in_accel_thresh_rising_period

comments inline
 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/iio/accel/mma8452.c |   75 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 8129c0b..7e0c29c 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -129,6 +129,12 @@ static int mma8452_get_int_plus_micros_index(const int (*vals)[2], int n,
>  	return -EINVAL;
>  }
>  
> +static int mma8452_get_odr_index(struct mma8452_data *data)
> +{
> +	return (data->ctrl_reg1 & MMA8452_CTRL_DR_MASK) >>
> +			MMA8452_CTRL_DR_SHIFT;
> +}
> +
>  static const int mma8452_samp_freq[8][2] = {
>  	{800, 0}, {400, 0}, {200, 0}, {100, 0}, {50, 0}, {12, 500000},
>  	{6, 250000}, {1, 560000}
> @@ -144,6 +150,18 @@ static const int mma8452_scales[3][2] = {
>  	{0, 9577}, {0, 19154}, {0, 38307}
>  };
>  
> +/* Datasheet table 35  (step time vs sample frequency) */
> +static const int mma8452_transient_time_step_us[8] = {
> +	1250,
> +	2500,
> +	5000,
> +	10000,
> +	20000,
> +	20000,
> +	20000,
> +	20000
> +};
> +
>  static ssize_t mma8452_show_samp_freq_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -203,8 +221,7 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  		*val2 = mma8452_scales[i][1];
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		i = (data->ctrl_reg1 & MMA8452_CTRL_DR_MASK) >>
> -			MMA8452_CTRL_DR_SHIFT;
> +		i = mma8452_get_odr_index(data);
>  		*val = mma8452_samp_freq[i][0];
>  		*val2 = mma8452_samp_freq[i][1];
>  		return IIO_VAL_INT_PLUS_MICRO;
> @@ -356,6 +373,52 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  	return mma8452_change_config(data, MMA8452_TRANSIENT_CFG, val);
>  }
>  
> +static ssize_t mma8452_query_transient_period(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int us, steps;
> +
> +	steps = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_COUNT);
> +	if (steps < 0)
> +		return steps;
> +
> +	us = mma8452_transient_time_step_us[mma8452_get_odr_index(data)]
> +								* steps;
> +
> +	return sprintf(buf, "%ld.%06ld\n",
> +			us / USEC_PER_SEC, us % USEC_PER_SEC);
> +}
> +
> +static ssize_t mma8452_set_transient_period(struct device *dev,
> +						struct device_attribute *attr,
> +						const char *buf,
> +						size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int i, f, us, steps, ret;
> +
> +	ret = iio_str_to_fixpoint(buf, USEC_PER_SEC / 10, &i, &f);
> +	if (ret)
> +		return ret;
> +
> +	us = i * USEC_PER_SEC + f;
> +	steps = us / mma8452_transient_time_step_us[
> +				mma8452_get_odr_index(data)];
> +
> +	if (steps < 0 || steps > 0xFF)

perhaps do the check for negative i earlier; use lowercase hex-values

> +		return -EINVAL;
> +
> +	ret = mma8452_change_config(data, MMA8452_TRANSIENT_COUNT, steps);
> +	if (ret)
> +		return ret;
> +
> +	return len;
> +}
> +
>  static void mma8452_push_transient_event(struct iio_dev *indio_dev,
>  						int chan, u64 ts)
>  {
> @@ -464,8 +527,16 @@ static const struct iio_event_spec mma8452_transient_event[] = {
>   */
>  static IIO_CONST_ATTR_NAMED(accel_transient_scale, in_accel_scale, "0.617742");
>  
> +static IIO_DEVICE_ATTR_NAMED(accel_transient_period,
> +			     in_accel_thresh_rising_period,
> +			     S_IRUGO | S_IWUSR,
> +			     mma8452_query_transient_period,
> +			     mma8452_set_transient_period,
> +			     0);
> +
>  static struct attribute *mma8452_event_attributes[] = {
>  	&iio_const_attr_accel_transient_scale.dev_attr.attr,
> +	&iio_dev_attr_accel_transient_period.dev_attr.attr,
>  	NULL,
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
