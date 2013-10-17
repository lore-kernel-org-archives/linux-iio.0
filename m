Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57078 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758649Ab3JQVth (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:49:37 -0400
Message-ID: <526069A7.5050105@kernel.org>
Date: Thu, 17 Oct 2013 23:50:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 05/11] staging:iio:hmc5843: Remove ability to change
 operating mode
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net> <1381961954-25596-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/13 23:19, Peter Meerwald wrote:
> only continuous mode is supported for now; the driver could/should
> be switched to single conversion mode
> 
> operating mode should be determined by the way IIO accesses the device
> and not exposed explicitly
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 68 ------------------------------
>  1 file changed, 68 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index aeaea09..5204b9a 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -186,73 +186,6 @@ static int hmc5843_read_measurement(struct hmc5843_data *data,
>  }
>  
>  /*
> - * From the datasheet:
> - * 0 - Continuous-Conversion Mode: In continuous-conversion mode, the
> - *     device continuously performs conversions and places the result in
> - *     the data register.
> - *
> - * 1 - Single-Conversion Mode : Device performs a single measurement,
> - *     sets RDY high and returns to sleep mode.
> - *
> - * 2 - Idle Mode : Device is placed in idle mode.
> - *
> - * 3 - Sleep Mode : Device is placed in sleep mode.
> - *
> - */
> -static ssize_t hmc5843_show_operating_mode(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct hmc5843_data *data = iio_priv(indio_dev);
> -	return sprintf(buf, "%d\n", data->operating_mode);
> -}
> -
> -static ssize_t hmc5843_set_operating_mode(struct device *dev,
> -				struct device_attribute *attr,
> -				const char *buf,
> -				size_t count)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> -	struct hmc5843_data *data = iio_priv(indio_dev);
> -	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	unsigned long operating_mode = 0;
> -	s32 status;
> -	int error;
> -
> -	mutex_lock(&data->lock);
> -	error = kstrtoul(buf, 10, &operating_mode);
> -	if (error) {
> -		count = error;
> -		goto exit;
> -	}
> -	dev_dbg(dev, "set conversion mode to %lu\n", operating_mode);
> -	if (operating_mode > HMC5843_MODE_SLEEP) {
> -		count = -EINVAL;
> -		goto exit;
> -	}
> -
> -	status = i2c_smbus_write_byte_data(client, this_attr->address,
> -					operating_mode);
> -	if (status) {
> -		count = -EINVAL;
> -		goto exit;
> -	}
> -	data->operating_mode = operating_mode;
> -
> -exit:
> -	mutex_unlock(&data->lock);
> -	return count;
> -}
> -
> -static IIO_DEVICE_ATTR(operating_mode,
> -			S_IWUSR | S_IRUGO,
> -			hmc5843_show_operating_mode,
> -			hmc5843_set_operating_mode,
> -			HMC5843_MODE_REG);
> -
> -/*
>   * API for setting the measurement configuration to
>   * Normal, Positive bias and Negative bias
>   *
> @@ -531,7 +464,6 @@ static const struct iio_chan_spec hmc5883_channels[] = {
>  
>  static struct attribute *hmc5843_attributes[] = {
>  	&iio_dev_attr_meas_conf.dev_attr.attr,
> -	&iio_dev_attr_operating_mode.dev_attr.attr,
>  	&iio_dev_attr_scale_available.dev_attr.attr,
>  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL
> 
