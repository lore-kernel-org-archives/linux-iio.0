Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751835AbeEFSHt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 14:07:49 -0400
Date: Sun, 6 May 2018 19:06:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 04/11] staging: iio: tsl2x7x: move
 calibscale_available attribute to IIO_INTENSITY channel
Message-ID: <20180506190603.4cafa992@archlinux>
In-Reply-To: <20180504025319.28953-5-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
        <20180504025319.28953-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  3 May 2018 22:53:12 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The calibscale_available attribute is currently associated with the
> IIO_LIGHT channel but should be associated with the IIO_INTENSITY
> channel. This patch corrects that association and it also corrects
> lines that were unnecessarily split for the
> in_intensity0_integration_time sysfs attribute.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied,

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 7e8db5178a2c..9aee04fb4168 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -777,9 +777,9 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  }
>  
>  static ssize_t
> -in_illuminance0_calibscale_available_show(struct device *dev,
> -					  struct device_attribute *attr,
> -					  char *buf)
> +in_intensity0_calibscale_available_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  
> @@ -1247,7 +1247,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static DEVICE_ATTR_RO(in_illuminance0_calibscale_available);
> +static DEVICE_ATTR_RO(in_intensity0_calibscale_available);
>  
>  static DEVICE_ATTR_RW(in_illuminance0_target_input);
>  
> @@ -1321,9 +1321,8 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  }
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> -	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available
> -		.dev_attr.attr,
> +	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1336,9 +1335,8 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> -	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available
> -		.dev_attr.attr,
> +	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,
> @@ -1352,9 +1350,8 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> -	&dev_attr_in_illuminance0_calibscale_available.attr,
> -	&iio_const_attr_in_intensity0_integration_time_available
> -		.dev_attr.attr,
> +	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
>  	&dev_attr_in_illuminance0_lux_table.attr,

