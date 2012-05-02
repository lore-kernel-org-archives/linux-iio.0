Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:60762 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755482Ab2EBI7h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 May 2012 04:59:37 -0400
Message-ID: <4FA0F7A4.4000907@metafoo.de>
Date: Wed, 02 May 2012 11:00:20 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, marek.belisko@open-nandra.com,
	jic23@kernel.org
Subject: Re: [PATCH] iio: add support for HMC5883/HMC5883L to HMC5843 driver
References: <1335913035-27623-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335913035-27623-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/2012 12:57 AM, Peter Meerwald wrote:
> this patch aims at adding support for the HMC5883/HMC5883L magnetometer 
> to the HMC5843 driver; the devices are pretty similar, so the existing driver
> is extended (see also http://www.spinics.net/lists/linux-iio/msg04778.html)
> 
> the patch is big; 
> * some of the changes are cleanup/preparation
> * there are bug fixes along the line of 62d2feb9803f18c4e3c8a1a2c7e30a54df8a1d72 
>   (i2c_get_clientdata(client) points to iio_dev, not hmc5843_data)
> * and finally the code to suppor the new devices
> 
> I'd appreciate to get feedback on the general approach to extend the driver; if 
> necessary I can try to split up the patch, starting with fixes

I think the changes in this driver look good, but yes this should definitely be
split up into multiple patches. Having it in multiple patches also makes
reviewing easier.

A few comments inline.

> 
> I only have a HMC5883L, so I cannot test if the HMC5843 code still works
> 
> ---
>  endmenu
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index e7cc9e0..019c631 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> [...]
>  
>  /* Return the measurement value from the specified channel */
> @@ -152,32 +255,31 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
>  	s32 result;
>  
>  	mutex_lock(&data->lock);
> -	result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
> -	while (!(result & DATA_READY))
> -		result = i2c_smbus_read_byte_data(client, HMC5843_STATUS_REG);
> +	result = i2c_smbus_read_byte_data(client, HMC58X3_STATUS_REG);
> +	while (!(result & HMC58X3_DATA_READY))
> +		result = i2c_smbus_read_byte_data(client, HMC58X3_STATUS_REG);

This is not a problem with your patch, but it would be good if you could
address it in a separate patch. We need some kind of a timeout here, maybe also
change it to a do {} while loop.

>  
>  	result = i2c_smbus_read_word_data(client, address);
>  	mutex_unlock(&data->lock);
>  	if (result < 0)
>  		return -EINVAL;
>  
> -	*val	= (s16)swab16((u16)result);
> +	*val = (s16)swab16((u16)result);
>  	return IIO_VAL_INT;
>  }
>  
> [...]
> - */
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
> +static ssize_t hmc5843_show_sampling_frequencies_available(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
> +
> +	char str[128] = "";
> +	int i;
> +
> +	for (i = 0; i < HMC58X3_RATE_NOT_USED; i++) {
> +		strcat(str, data->regval_to_sample_freq[i]);
> +		strcat(str, " ");
> +	}

I think you can do without the temp buffer here. Maybe something like:
	n = sprintf(buf, "%s ", data->regval_to_sample_freq[i]);
	buf += n;


> +	return sprintf(buf, "%s", str);
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(hmc5843_show_sampling_frequencies_available);
>  
>  static s32 hmc5843_set_rate(struct i2c_client *client,
>  				u8 rate)
>  {
> -	struct hmc5843_data *data = i2c_get_clientdata(client);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct hmc5843_data *data = iio_priv(indio_dev);
>  	u8 reg_val;
>  
> -	reg_val = (data->meas_conf) |  (rate << RATE_OFFSET);
> -	if (rate >= RATE_NOT_USED) {
> +	if (rate >= HMC58X3_RATE_NOT_USED) {
>  		dev_err(&client->dev,
> -			"This data output rate is not supported\n");
> +			"data output rate is not supported\n");
>  		return -EINVAL;
>  	}
> -	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
> +	reg_val = data->meas_conf | (rate << HMC58X3_RATE_OFFSET);
> +	return i2c_smbus_write_byte_data(client, HMC58X3_CONFIG_REG_A, reg_val);
>  }
>  
> -static ssize_t set_sampling_frequency(struct device *dev,
> +static int hmc5843_check_sampling_frequency(struct hmc5843_data *data,
> +						const char *buf)
> +{
> +	const char * const *samp_freq = data->regval_to_sample_freq;
> +	int i;
> +
> +	for (i = 0; i < HMC58X3_RATE_NOT_USED; i++) {
> +		if (strncmp(buf, samp_freq[i],
> +			strlen(samp_freq[i])) == 0)

This should use sysfs_streq. sysfs_streq will ignore trailing newlines when
comparing the two strings.

> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> [...]
