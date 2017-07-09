Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752407AbdGIRrd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 13:47:33 -0400
Date: Sun, 9 Jul 2017 18:47:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH v2 9/9] staging: iio: tsl2x7x: check return value from
 tsl2x7x_invoke_change()
Message-ID: <20170709184728.0e6bf560@kernel.org>
In-Reply-To: <20170706225626.6716-10-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
        <20170706225626.6716-10-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  6 Jul 2017 18:56:26 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The return value from tsl2x7x_invoke_change() was not checked in most
> places in the driver. This patch adds the proper error checks. The
> return values inside tsl2x7x_invoke_change() are now checked by
> this patch as well.
> 
> Previously, if there was an error turning the chip back on, then the
> driver would attempt to turn the chip off and incorrectly return
> success. The code to power off the chip is removed by this patch
> since we should fail fast.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
This went on cleanly even without patch 8 so:

Applied to the togreg branch of iio.git and pushed out as testing.

Another good set Brian, looking forward to the next one!

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 55 +++++++++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 033468d..c00278d 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -771,22 +771,24 @@ int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	int device_status = chip->tsl2x7x_chip_status;
> +	int ret;
>  
>  	mutex_lock(&chip->als_mutex);
>  	mutex_lock(&chip->prox_mutex);
>  
> -	if (device_status == TSL2X7X_CHIP_WORKING)
> -		tsl2x7x_chip_off(indio_dev);
> -
> -	tsl2x7x_chip_on(indio_dev);
> +	if (device_status == TSL2X7X_CHIP_WORKING) {
> +		ret = tsl2x7x_chip_off(indio_dev);
> +		if (ret < 0)
> +			goto unlock;
> +	}
>  
> -	if (device_status != TSL2X7X_CHIP_WORKING)
> -		tsl2x7x_chip_off(indio_dev);
> +	ret = tsl2x7x_chip_on(indio_dev);
>  
> +unlock:
>  	mutex_unlock(&chip->prox_mutex);
>  	mutex_unlock(&chip->als_mutex);
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static
> @@ -925,6 +927,7 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	unsigned long value;
> +	int ret;
>  
>  	if (kstrtoul(buf, 0, &value))
>  		return -EINVAL;
> @@ -932,7 +935,9 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  	if (value)
>  		chip->tsl2x7x_settings.als_cal_target = value;
>  
> -	tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	return len;
>  }
> @@ -981,7 +986,9 @@ static ssize_t in_intensity0_thresh_period_store(struct device *dev,
>  	dev_info(&chip->client->dev, "%s: als persistence = %d",
>  		 __func__, filter_delay);
>  
> -	tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }
> @@ -1029,7 +1036,10 @@ static ssize_t in_proximity0_thresh_period_store(struct device *dev,
>  	dev_info(&chip->client->dev, "%s: prox persistence = %d",
>  		 __func__, filter_delay);
>  
> -	tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
> +
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
>  }
> @@ -1040,6 +1050,7 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	bool value;
> +	int ret;
>  
>  	if (strtobool(buf, &value))
>  		return -EINVAL;
> @@ -1047,7 +1058,9 @@ static ssize_t in_illuminance0_calibrate_store(struct device *dev,
>  	if (value)
>  		tsl2x7x_als_calibrate(indio_dev);
>  
> -	tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	return len;
>  }
> @@ -1087,7 +1100,7 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
>  	int value[ARRAY_SIZE(chip->tsl2x7x_device_lux) * 3 + 1];
> -	int n;
> +	int n, ret;
>  
>  	get_options(buf, ARRAY_SIZE(value), value);
>  
> @@ -1115,7 +1128,9 @@ static ssize_t in_illuminance0_lux_table_store(struct device *dev,
>  	memset(chip->tsl2x7x_device_lux, 0, sizeof(chip->tsl2x7x_device_lux));
>  	memcpy(chip->tsl2x7x_device_lux, &value[1], (value[0] * 4));
>  
> -	tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	return len;
>  }
> @@ -1126,6 +1141,7 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	bool value;
> +	int ret;
>  
>  	if (strtobool(buf, &value))
>  		return -EINVAL;
> @@ -1133,7 +1149,9 @@ static ssize_t in_proximity0_calibrate_store(struct device *dev,
>  	if (value)
>  		tsl2x7x_prox_cal(indio_dev);
>  
> -	tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	return len;
>  }
> @@ -1161,6 +1179,7 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
>  					  int val)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> +	int ret;
>  
>  	if (chan->type == IIO_INTENSITY) {
>  		if (val)
> @@ -1174,7 +1193,9 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
>  			chip->tsl2x7x_settings.interrupts_en &= 0x10;
>  	}
>  
> -	tsl2x7x_invoke_change(indio_dev);
> +	ret = tsl2x7x_invoke_change(indio_dev);
> +	if (ret < 0)
> +		return ret;
>  
>  	return 0;
>  }
> @@ -1422,9 +1443,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		return -EINVAL;
>  	}
>  
> -	tsl2x7x_invoke_change(indio_dev);
> -
> -	return 0;
> +	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
>  static DEVICE_ATTR_RO(in_proximity0_calibscale_available);

