Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752317AbdGIR0l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 9 Jul 2017 13:26:41 -0400
Date: Sun, 9 Jul 2017 18:26:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH v2 3/9] staging: iio: tsl2x7x: remove redundant
 power_state sysfs attribute
Message-ID: <20170709182640.2ae26c50@kernel.org>
In-Reply-To: <20170706225626.6716-4-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
        <20170706225626.6716-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  6 Jul 2017 18:56:20 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The TSL2X7X driver has a custom power_state sysfs attribute. Remove this
> attribute since the runtime power management code provides a sysfs
> attribute to control the power state of the device.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 34 ----------------------------------
>  1 file changed, 34 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 8148986..95ed7cc6 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -915,33 +915,6 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  		tsl2x7x_chip_on(indio_dev);
>  }
>  
> -static ssize_t power_state_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> -
> -	return snprintf(buf, PAGE_SIZE, "%d\n", chip->tsl2x7x_chip_status);
> -}
> -
> -static ssize_t power_state_store(struct device *dev,
> -					 struct device_attribute *attr,
> -					 const char *buf, size_t len)
> -{
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> -	bool value;
> -
> -	if (strtobool(buf, &value))
> -		return -EINVAL;
> -
> -	if (value)
> -		tsl2x7x_chip_on(indio_dev);
> -	else
> -		tsl2x7x_chip_off(indio_dev);
> -
> -	return len;
> -}
> -
>  static ssize_t in_illuminance0_calibscale_available_show(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
> @@ -1494,8 +1467,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static DEVICE_ATTR_RW(power_state);
> -
>  static DEVICE_ATTR_RO(in_proximity0_calibscale_available);
>  
>  static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
> @@ -1580,7 +1551,6 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  }
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> -	&dev_attr_power_state.attr,
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
>  	&dev_attr_in_illuminance0_integration_time.attr,
>  	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> @@ -1591,13 +1561,11 @@ static struct attribute *tsl2x7x_ALS_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_PRX_device_attrs[] = {
> -	&dev_attr_power_state.attr,
>  	&dev_attr_in_proximity0_calibrate.attr,
>  	NULL
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> -	&dev_attr_power_state.attr,
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
>  	&dev_attr_in_illuminance0_integration_time.attr,
>  	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,
> @@ -1609,14 +1577,12 @@ static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
> -	&dev_attr_power_state.attr,
>  	&dev_attr_in_proximity0_calibrate.attr,
>  	&dev_attr_in_proximity0_calibscale_available.attr,
>  	NULL
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> -	&dev_attr_power_state.attr,
>  	&dev_attr_in_illuminance0_calibscale_available.attr,
>  	&dev_attr_in_illuminance0_integration_time.attr,
>  	&iio_const_attr_in_illuminance0_integration_time_available.dev_attr.attr,

