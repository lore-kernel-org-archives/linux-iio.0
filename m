Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43419 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756993AbcJ3SEW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 14:04:22 -0400
Subject: Re: [PATCH 06/10] staging: iio: tsl2583: convert to use iio_chan_spec
 and {read,write}_raw
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
 <1477648821-3786-7-git-send-email-masneyb@onstation.org>
From: Jonathan Cameron <jic23@kernel.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com,
        Jon Brenner <Jon.Brenner@ams.com>
Message-ID: <87bbfb44-ae09-9a51-e0cc-32ee6aeec2ee@kernel.org>
Date: Sun, 30 Oct 2016 18:04:19 +0000
MIME-Version: 1.0
In-Reply-To: <1477648821-3786-7-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/16 11:00, Brian Masney wrote:
> The tsl2583 driver directly creates sysfs attributes that should instead
> be created by the IIO core on behalf of the driver. This patch adds the
> iio_chan_spec array, the relevant info_mask elements and the read_raw()
> and write_raw() functions to take advantage of features provided by the
> IIO core. These sysfs attributes were migrated with this patch:
> illuminance0_input, illuminance0_calibbias,
> illuminance0_integration_time. This also exposes the raw values read
> from the two channels on the sensor.
> 
> With this change, these four sysfs entries have their prefix changed
> from illuminance0_ to in_illuminance_. This is deemed to be acceptable
> since none of the IIO light drivers in mainline use the illuminance0_
> prefix, however 8 of the IIO light drivers in mainline use the
> in_illuminance_ prefix.
Yeah, ABI was previously broken.  We made this change a long time ago
before anything actually moved out of staging.  Possible we'll break
some userspace code, but that's the advantage of being in staging
- no guarantees on ABI remaining the same!

Hmm... I think you also fixed the units of integration time which we
should probably mention.

I'll add a note - applied to the togreg branch of iio.git and pushed out
as testing. Jon if you get a chance, this is the first one with major
changes.

Thanks,

Jonathan
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2583.c | 236 ++++++++++++++++++++++--------------
>  1 file changed, 143 insertions(+), 93 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index e975bba..6a61a86 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -211,28 +211,23 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  	u32 ch0lux = 0;
>  	u32 ch1lux = 0;
>  
> -	if (mutex_trylock(&chip->als_mutex) == 0) {
> -		dev_info(&chip->client->dev, "taos_get_lux device is busy\n");
> -		return chip->als_cur_info.lux; /* busy, so return LAST VALUE */
> -	}
> -
>  	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
>  		/* device is not enabled */
>  		dev_err(&chip->client->dev, "taos_get_lux device is not enabled\n");
>  		ret = -EBUSY;
> -		goto out_unlock;
> +		goto done;
>  	}
>  
>  	ret = taos_i2c_read(chip->client, (TSL258X_CMD_REG), &buf[0], 1);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev, "taos_get_lux failed to read CMD_REG\n");
> -		goto out_unlock;
> +		goto done;
>  	}
>  	/* is data new & valid */
>  	if (!(buf[0] & TSL258X_STA_ADC_INTR)) {
>  		dev_err(&chip->client->dev, "taos_get_lux data not valid\n");
>  		ret = chip->als_cur_info.lux; /* return LAST VALUE */
> -		goto out_unlock;
> +		goto done;
>  	}
>  
>  	for (i = 0; i < 4; i++) {
> @@ -243,7 +238,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  			dev_err(&chip->client->dev,
>  				"taos_get_lux failed to read register %x\n",
>  				reg);
> -			goto out_unlock;
> +			goto done;
>  		}
>  	}
>  
> @@ -259,7 +254,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  		dev_err(&chip->client->dev,
>  			"taos_i2c_write_command failed in taos_get_lux, err = %d\n",
>  			ret);
> -		goto out_unlock; /* have no data, so return failure */
> +		goto done; /* have no data, so return failure */
>  	}
>  
>  	/* extract ALS/lux data */
> @@ -276,7 +271,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  		/* have no data, so return LAST VALUE */
>  		ret = 0;
>  		chip->als_cur_info.lux = 0;
> -		goto out_unlock;
> +		goto done;
>  	}
>  	/* calculate ratio */
>  	ratio = (ch1 << 15) / ch0;
> @@ -302,7 +297,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  		dev_dbg(&chip->client->dev, "No Data - Return last value\n");
>  		ret = 0;
>  		chip->als_cur_info.lux = 0;
> -		goto out_unlock;
> +		goto done;
>  	}
>  
>  	/* adjust for active time scale */
> @@ -334,8 +329,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  	chip->als_cur_info.lux = lux;
>  	ret = lux;
>  
> -out_unlock:
> -	mutex_unlock(&chip->als_mutex);
> +done:
>  	return ret;
>  }
>  
> @@ -575,69 +569,12 @@ static ssize_t taos_gain_available_show(struct device *dev,
>  	return sprintf(buf, "%s\n", "1 8 16 111");
>  }
>  
> -static ssize_t taos_als_time_show(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%d\n", chip->taos_settings.als_time);
> -}
> -
> -static ssize_t taos_als_time_store(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int value;
> -
> -	if (kstrtoint(buf, 0, &value))
> -		return -EINVAL;
> -
> -	if ((value < 50) || (value > 650))
> -		return -EINVAL;
> -
> -	if (value % 50)
> -		return -EINVAL;
> -
> -	chip->taos_settings.als_time = value;
> -
> -	return len;
> -}
> -
>  static ssize_t taos_als_time_available_show(struct device *dev,
>  					    struct device_attribute *attr,
>  					    char *buf)
>  {
>  	return sprintf(buf, "%s\n",
> -		"50 100 150 200 250 300 350 400 450 500 550 600 650");
> -}
> -
> -static ssize_t taos_als_trim_show(struct device *dev,
> -				  struct device_attribute *attr, char *buf)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -
> -	return sprintf(buf, "%d\n", chip->taos_settings.als_gain_trim);
> -}
> -
> -static ssize_t taos_als_trim_store(struct device *dev,
> -				   struct device_attribute *attr,
> -				   const char *buf, size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	struct tsl2583_chip *chip = iio_priv(indio_dev);
> -	int value;
> -
> -	if (kstrtoint(buf, 0, &value))
> -		return -EINVAL;
> -
> -	if (value)
> -		chip->taos_settings.als_gain_trim = value;
> -
> -	return len;
> +		"0.000050 0.000100 0.000150 0.000200 0.000250 0.000300 0.000350 0.000400 0.000450 0.000500 0.000550 0.000600 0.000650");
>  }
>  
>  static ssize_t taos_als_cal_target_show(struct device *dev,
> @@ -667,18 +604,6 @@ static ssize_t taos_als_cal_target_store(struct device *dev,
>  	return len;
>  }
>  
> -static ssize_t taos_lux_show(struct device *dev, struct device_attribute *attr,
> -			     char *buf)
> -{
> -	int ret;
> -
> -	ret = taos_get_lux(dev_to_iio_dev(dev));
> -	if (ret < 0)
> -		return ret;
> -
> -	return sprintf(buf, "%d\n", ret);
> -}
> -
>  static ssize_t taos_do_calibrate(struct device *dev,
>  				 struct device_attribute *attr,
>  				 const char *buf, size_t len)
> @@ -771,18 +696,12 @@ static DEVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,
>  static DEVICE_ATTR(illuminance0_calibscale_available, S_IRUGO,
>  		taos_gain_available_show, NULL);
>  
> -static DEVICE_ATTR(illuminance0_integration_time, S_IRUGO | S_IWUSR,
> -		taos_als_time_show, taos_als_time_store);
>  static DEVICE_ATTR(illuminance0_integration_time_available, S_IRUGO,
>  		taos_als_time_available_show, NULL);
>  
> -static DEVICE_ATTR(illuminance0_calibbias, S_IRUGO | S_IWUSR,
> -		taos_als_trim_show, taos_als_trim_store);
> -
>  static DEVICE_ATTR(illuminance0_input_target, S_IRUGO | S_IWUSR,
>  		taos_als_cal_target_show, taos_als_cal_target_store);
>  
> -static DEVICE_ATTR(illuminance0_input, S_IRUGO, taos_lux_show, NULL);
>  static DEVICE_ATTR(illuminance0_calibrate, S_IWUSR, NULL, taos_do_calibrate);
>  static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
>  		taos_luxtable_show, taos_luxtable_store);
> @@ -790,11 +709,8 @@ static DEVICE_ATTR(illuminance0_lux_table, S_IRUGO | S_IWUSR,
>  static struct attribute *sysfs_attrs_ctrl[] = {
>  	&dev_attr_illuminance0_calibscale.attr,			/* Gain  */
>  	&dev_attr_illuminance0_calibscale_available.attr,
> -	&dev_attr_illuminance0_integration_time.attr,	/* I time*/
>  	&dev_attr_illuminance0_integration_time_available.attr,
> -	&dev_attr_illuminance0_calibbias.attr,			/* trim  */
>  	&dev_attr_illuminance0_input_target.attr,
> -	&dev_attr_illuminance0_input.attr,
>  	&dev_attr_illuminance0_calibrate.attr,
>  	&dev_attr_illuminance0_lux_table.attr,
>  	NULL
> @@ -810,9 +726,141 @@ static int taos_tsl258x_device(unsigned char *bufp)
>  	return ((bufp[TSL258X_CHIPID] & 0xf0) == 0x90);
>  }
>  
> +static const struct iio_chan_spec tsl2583_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_BOTH,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME),
> +	},
> +};
> +
> +static int tsl2583_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct tsl2583_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> + 	
> +	mutex_lock(&chip->als_mutex);
> +
> +	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> +		ret = -EBUSY;
> +		goto read_done;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (chan->type == IIO_LIGHT) {
> +			ret = taos_get_lux(indio_dev);
> +			if (ret < 0)
> +				goto read_done;
> +
> +			/*
> +			 * From page 20 of the TSL2581, TSL2583 data
> +			 * sheet (TAOS134 − MARCH 2011):
> +			 *
> +			 * One of the photodiodes (channel 0) is
> +			 * sensitive to both visible and infrared light,
> +			 * while the second photodiode (channel 1) is
> +			 * sensitive primarily to infrared light.
> +			 */
> +			if (chan->channel2 == IIO_MOD_LIGHT_BOTH)
> +				*val = chip->als_cur_info.als_ch0;
> +			else
> +				*val = chip->als_cur_info.als_ch1;
> +
> +			ret = IIO_VAL_INT;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		if (chan->type == IIO_LIGHT) {
> +			ret = taos_get_lux(indio_dev);
> +			if (ret < 0)
> +				goto read_done;
> +
> +			*val = ret;
> +			ret = IIO_VAL_INT;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (chan->type == IIO_LIGHT) {
> +			*val = chip->taos_settings.als_gain_trim;
> +			ret = IIO_VAL_INT;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (chan->type == IIO_LIGHT) {
> +			*val = 0;
> +			*val2 = chip->taos_settings.als_time;
> +			ret = IIO_VAL_INT_PLUS_MICRO;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +read_done:
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
> +static int tsl2583_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct tsl2583_chip *chip = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&chip->als_mutex);
> +
> +	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
> +		ret = -EBUSY;
> +		goto write_done;
> +	}
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (chan->type == IIO_LIGHT) {
> +			chip->taos_settings.als_gain_trim = val;
> +			ret = 0;
> +		}
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (chan->type == IIO_LIGHT && !val && val2 >= 50 &&
> +		    val2 <= 650 && !(val2 % 50)) {
> +			chip->taos_settings.als_time = val2;
> +			ret = 0;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +write_done:
> +	mutex_unlock(&chip->als_mutex);
> +
> +	return ret;
> +}
> +
>  static const struct iio_info tsl2583_info = {
>  	.attrs = &tsl2583_attribute_group,
>  	.driver_module = THIS_MODULE,
> +	.read_raw = tsl2583_read_raw,
> +	.write_raw = tsl2583_write_raw,
>  };
>  
>  /*
> @@ -878,6 +926,8 @@ static int taos_probe(struct i2c_client *clientp,
>  	}
>  
>  	indio_dev->info = &tsl2583_info;
> +	indio_dev->channels = tsl2583_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(tsl2583_channels);
>  	indio_dev->dev.parent = &clientp->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->name = chip->client->name;
> 

