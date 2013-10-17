Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57138 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762872Ab3JQVvx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:51:53 -0400
Message-ID: <52606A30.7010402@kernel.org>
Date: Thu, 17 Oct 2013 23:52:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 09/11] staging:iio:hmc5843: Introduce _set_range_gain()
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net> <1381961954-25596-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-10-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/13 23:19, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied.
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index a91d302..c819b8e 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -303,6 +303,20 @@ static int hmc5843_get_samp_freq_index(struct hmc5843_data *data,
>  	return -EINVAL;
>  }
>  
> +static int hmc5843_set_range_gain(struct hmc5843_data *data, u8 range)
> +{
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
> +		range << HMC5843_RANGE_GAIN_OFFSET);
> +	if (ret >= 0)
> +		data->range = range;
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
> +
>  static ssize_t hmc5843_show_scale_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf)
>  {
> @@ -364,7 +378,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
>  			     int val, int val2, long mask)
>  {
>  	struct hmc5843_data *data = iio_priv(indio_dev);
> -	int ret, rate, range;
> +	int rate, range;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -378,15 +392,7 @@ static int hmc5843_write_raw(struct iio_dev *indio_dev,
>  		if (range < 0)
>  			return -EINVAL;
>  
> -		range <<= HMC5843_RANGE_GAIN_OFFSET;
> -		mutex_lock(&data->lock);
> -		ret = i2c_smbus_write_byte_data(data->client,
> -			HMC5843_CONFIG_REG_B, range);
> -		if (ret >= 0)
> -			data->range = range;
> -		mutex_unlock(&data->lock);
> -
> -		return ret;
> +		return hmc5843_set_range_gain(data, range);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -495,9 +501,8 @@ static void hmc5843_init(struct hmc5843_data *data)
>  {
>  	hmc5843_set_meas_conf(data, HMC5843_MEAS_CONF_NORMAL);
>  	hmc5843_set_samp_freq(data, HMC5843_RATE_DEFAULT);
> +	hmc5843_set_range_gain(data, HMC5843_RANGE_GAIN_DEFAULT);
>  	hmc5843_set_mode(data, HMC5843_MODE_CONVERSION_CONTINUOUS);
> -	i2c_smbus_write_byte_data(data->client, HMC5843_CONFIG_REG_B,
> -		HMC5843_RANGE_GAIN_DEFAULT);
>  }
>  
>  static const struct iio_info hmc5843_info = {
> 
