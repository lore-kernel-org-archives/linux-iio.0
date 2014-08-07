Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38379 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757479AbaHGOlW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 10:41:22 -0400
Message-ID: <53E39011.6060203@kernel.org>
Date: Thu, 07 Aug 2014 15:41:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org
CC: pmeerw@pmeerw.net
Subject: Re: [PATCH V2 4/8] iio: mma8452: Add support for transient event
 debouncing
References: <20140729090128.4618.92936.stgit@localhost> <20140729090137.4618.1472.stgit@localhost>
In-Reply-To: <20140729090137.4618.1472.stgit@localhost>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/07/14 10:01, Martin Fuzzey wrote:
> Allow the debouce counter for transient events to be configured
> using the sysfs attribute events/in_accel_thresh_rising_period
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
Once we have figured out how to describe this event this wants to be done
via the IIO_EV_INFO_PERIOD approach rather than a custom attribute.
> ---
>  drivers/iio/accel/mma8452.c |   77 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 3415b36..1d1e41b 100644
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
> @@ -356,6 +373,54 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
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
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	us = i * USEC_PER_SEC + f;
> +	steps = us / mma8452_transient_time_step_us[
> +				mma8452_get_odr_index(data)];
> +
> +	if (steps > 0xff)
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
> @@ -462,8 +527,16 @@ static const struct iio_event_spec mma8452_transient_event[] = {
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
