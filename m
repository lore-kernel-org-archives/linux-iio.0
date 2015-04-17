Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:53120 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752176AbbDQVrq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 17 Apr 2015 17:47:46 -0400
Message-ID: <55317F75.6010908@gmx.de>
Date: Fri, 17 Apr 2015 23:47:33 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Martin Fuzzey <mfuzzey@parkeon.com>, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6/9] iio: mma8452: Add support for transient event
 debouncing
References: <20150219141553.27001.18825.stgit@localhost> <20150219141606.27001.12648.stgit@localhost>
In-Reply-To: <20150219141606.27001.12648.stgit@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Martin Fuzzey schrieb am 19.02.2015 um 15:16:
> Allow the debouce counter for transient events to be configured
> using the sysfs attribute events/in_accel_thresh_rising_period
> 

The same issue about parameter alignment applies here as well. Besides, I put
some comments inline.

> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> ---
>  drivers/iio/accel/mma8452.c |   74 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 64 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index d44044f..b7f13dd 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -129,6 +129,12 @@ static int mma8452_get_int_plus_micros_index(const int (*vals)[2], int n,
>  	return -EINVAL;
>  }
>  
> +static int mma8452_get_odr_index(struct mma8452_data *data)
What about u8 as return type, since data->ctrl_reg1 is u8, too?

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
This could be unsigned.

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
> @@ -300,15 +317,33 @@ static int mma8452_read_thresh(struct iio_dev *indio_dev,
>  	int *val2)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	int ret;
> +	int ret, us;
>  
> -	ret = i2c_smbus_read_byte_data(data->client, MMA8452_TRANSIENT_THS);
> -	if (ret < 0)
> -		return ret;
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		ret = i2c_smbus_read_byte_data(data->client,
> +						MMA8452_TRANSIENT_THS);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret & 0x7f;
> +		return IIO_VAL_INT;
>  
> -	*val = ret & 0x7f;
> +	case IIO_EV_INFO_PERIOD:
> +		ret = i2c_smbus_read_byte_data(data->client,
> +						MMA8452_TRANSIENT_COUNT);
> +		if (ret < 0)
> +			return ret;
> +
> +		us = ret * mma8452_transient_time_step_us[
> +				mma8452_get_odr_index(data)];
> +		*val = us / USEC_PER_SEC;
> +		*val2 = us % USEC_PER_SEC;
> +		return IIO_VAL_INT_PLUS_MICRO;
You could make use of core calculations and also make us obsolete:
		*val = ret * mma8452_transient_time_step_us[
						mma8452_get_odr_index(data)];
		*val2 = USEC_PER_SEC;
		return IIO_VAL_FRACTIONAL;

>  
> -	return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static int mma8452_write_thresh(struct iio_dev *indio_dev,
> @@ -317,8 +352,26 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
>  	int val2)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	int steps;
>  
> -	return mma8452_change_config(data, MMA8452_TRANSIENT_THS, val & 0x7f);
> +	switch (info) {
> +	case IIO_EV_INFO_VALUE:
> +		return mma8452_change_config(data,
> +			MMA8452_TRANSIENT_THS, val & 0x7f);
Instead of masking val into the right range, better do a boundary check and
report an error on failure?

> +
> +	case IIO_EV_INFO_PERIOD:
> +		steps = (val * USEC_PER_SEC + val2) /
> +				mma8452_transient_time_step_us[
> +					mma8452_get_odr_index(data)];
> +
> +		if (steps > 0xff)
Use something like MMA8452_TRANSIENT_COUNT_MASK instead of magic number?

> +			return -EINVAL;
> +
> +		return mma8452_change_config(data,
> +				MMA8452_TRANSIENT_COUNT, steps);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static int mma8452_read_event_config(struct iio_dev *indio_dev,
> @@ -457,7 +510,8 @@ static const struct iio_event_spec mma8452_transient_event[] = {
>  		.dir = IIO_EV_DIR_RISING,
>  		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
>  		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
> -					BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB),
> +					BIT(IIO_EV_INFO_HIGH_PASS_FILTER_3DB) |
> +					BIT(IIO_EV_INFO_PERIOD),
>  	},
>  };
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

