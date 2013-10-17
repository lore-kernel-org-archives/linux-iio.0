Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57019 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762344Ab3JQVrR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:47:17 -0400
Message-ID: <52606912.7050109@kernel.org>
Date: Thu, 17 Oct 2013 23:47:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 02/11] staging:iio:hmc5843: Rename _check_samp_freq
 to get_samp_freq_index
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net> <1381961954-25596-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/13 23:19, Peter Meerwald wrote:
> and drop/inline helper functions _check_int_plus_micros() and
> _show_int_plus_micros()
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Technically this is addressing two different things so should really
have been two patches.


> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 47 ++++++++++--------------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index c56db41..749b0b6 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -309,15 +309,17 @@ static IIO_DEVICE_ATTR(meas_conf,
>  			hmc5843_set_measurement_configuration,
>  			0);
>  
> -static ssize_t hmc5843_show_int_plus_micros(char *buf,
> -	const int (*vals)[2], int n)
> +static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
> +				struct device_attribute *attr, char *buf)
>  {
> +	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
>  	size_t len = 0;
>  	int i;
>  
> -	for (i = 0; i < n; i++)
> +	for (i = 0; i < HMC5843_RATE_NOT_USED; i++)
>  		len += scnprintf(buf + len, PAGE_SIZE - len,
> -			"%d.%d ", vals[i][0], vals[i][1]);
> +			"%d.%d ", data->variant->regval_to_samp_freq[i][0],
> +			data->variant->regval_to_samp_freq[i][1]);
>  
>  	/* replace trailing space by newline */
>  	buf[len - 1] = '\n';
> @@ -325,28 +327,6 @@ static ssize_t hmc5843_show_int_plus_micros(char *buf,
>  	return len;
>  }
>  
> -static int hmc5843_check_int_plus_micros(const int (*vals)[2], int n,
> -					int val, int val2)
> -{
> -	int i;
> -
> -	for (i = 0; i < n; i++) {
> -		if (val == vals[i][0] && val2 == vals[i][1])
> -			return i;
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static ssize_t hmc5843_show_samp_freq_avail(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> -{
> -	struct hmc5843_data *data = iio_priv(dev_to_iio_dev(dev));
> -
> -	return hmc5843_show_int_plus_micros(buf,
> -		data->variant->regval_to_samp_freq, HMC5843_RATE_NOT_USED);
> -}
> -
>  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_samp_freq_avail);
>  
>  static s32 hmc5843_set_rate(struct hmc5843_data *data, u8 rate)
> @@ -357,12 +337,17 @@ static s32 hmc5843_set_rate(struct hmc5843_data *data, u8 rate)
>  		reg_val);
>  }
>  
> -static int hmc5843_check_samp_freq(struct hmc5843_data *data,
> +static int hmc5843_get_samp_freq_index(struct hmc5843_data *data,
>  				   int val, int val2)
>  {
> -	return hmc5843_check_int_plus_micros(
> -		data->variant->regval_to_samp_freq, HMC5843_RATE_NOT_USED,
> -		val, val2);
> +	int i;
> +
> +	for (i = 0; i < HMC5843_RATE_NOT_USED; i++)
> +		if (val == data->variant->regval_to_samp_freq[i][0] &&
> +			val2 == data->variant->regval_to_samp_freq[i][1])
> +			return i;
> +
> +	return -EINVAL;
>  }
>  
>  static ssize_t hmc5843_show_scale_avail(struct device *dev,
> @@ -430,7 +415,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		rate = hmc5843_check_samp_freq(data, val, val2);
> +		rate = hmc5843_get_samp_freq_index(data, val, val2);
>  		if (rate < 0)
>  			return -EINVAL;
>  
> 
