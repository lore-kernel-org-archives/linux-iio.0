Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeEFSHw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 14:07:52 -0400
Date: Sun, 6 May 2018 19:07:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        drew.paterson@ams.com
Subject: Re: [PATCH v2 05/11] staging: iio: tsl2x7x: use IIO_CONST_ATTR for
 calibscale_available
Message-ID: <20180506190736.7c2d0ac7@archlinux>
In-Reply-To: <20180504025319.28953-6-masneyb@onstation.org>
References: <20180504025319.28953-1-masneyb@onstation.org>
        <20180504025319.28953-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  3 May 2018 22:53:13 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The in_intensity0_calibscale_available sysfs attribute has code that
> checks the device type to determine which calibration scales are
> available. This check is not necessary since all of the supported
> ALS device types use the scales 1 8 16 120. This patch converts the
> sysfs attribute to use IIO_CONST_ATTR. The following device datasheets
> were checked: tsl2571, tsl2771, tmd2771, tsl2572, tsl2772, tmd2772.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with.

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 46 ++++---------------------------------
>  1 file changed, 4 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 9aee04fb4168..cf582a2e3633 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -776,24 +776,7 @@ static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static ssize_t
> -in_intensity0_calibscale_available_show(struct device *dev,
> -					struct device_attribute *attr,
> -					char *buf)
> -{
> -	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
> -
> -	switch (chip->id) {
> -	case tsl2571:
> -	case tsl2671:
> -	case tmd2671:
> -	case tsl2771:
> -	case tmd2771:
> -		return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 128");
> -	}
> -
> -	return snprintf(buf, PAGE_SIZE, "%s\n", "1 8 16 120");
> -}
> +static IIO_CONST_ATTR(in_intensity0_calibscale_available, "1 8 16 120");
>  
>  static IIO_CONST_ATTR(in_proximity0_calibscale_available, "1 2 4 8");
>  
> @@ -1190,25 +1173,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  				chip->settings.als_gain = 2;
>  				break;
>  			case 120:
> -				switch (chip->id) {
> -				case tsl2572:
> -				case tsl2672:
> -				case tmd2672:
> -				case tsl2772:
> -				case tmd2772:
> -					return -EINVAL;
> -				}
> -				chip->settings.als_gain = 3;
> -				break;
> -			case 128:
> -				switch (chip->id) {
> -				case tsl2571:
> -				case tsl2671:
> -				case tmd2671:
> -				case tsl2771:
> -				case tmd2771:
> -					return -EINVAL;
> -				}
>  				chip->settings.als_gain = 3;
>  				break;
>  			default:
> @@ -1247,8 +1211,6 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
> -static DEVICE_ATTR_RO(in_intensity0_calibscale_available);
> -
>  static DEVICE_ATTR_RW(in_illuminance0_target_input);
>  
>  static DEVICE_ATTR_WO(in_illuminance0_calibrate);
> @@ -1321,7 +1283,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  }
>  
>  static struct attribute *tsl2x7x_ALS_device_attrs[] = {
> -	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
> @@ -1335,7 +1297,7 @@ static struct attribute *tsl2x7x_PRX_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX_device_attrs[] = {
> -	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,
> @@ -1350,7 +1312,7 @@ static struct attribute *tsl2x7x_PRX2_device_attrs[] = {
>  };
>  
>  static struct attribute *tsl2x7x_ALSPRX2_device_attrs[] = {
> -	&dev_attr_in_intensity0_calibscale_available.attr,
> +	&iio_const_attr_in_intensity0_calibscale_available.dev_attr.attr,
>  	&iio_const_attr_in_intensity0_integration_time_available.dev_attr.attr,
>  	&dev_attr_in_illuminance0_target_input.attr,
>  	&dev_attr_in_illuminance0_calibrate.attr,

