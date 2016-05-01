Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48826 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbcEAV0U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:20 -0400
Subject: Re: [PATCH 3/3] imu: bmi160: Add avail frequency and scale attributes
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
 <1461930155-13871-4-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9818bbd9-7f83-570d-77b5-ec50e4b8ef4f@kernel.org>
Date: Sun, 1 May 2016 20:01:26 +0100
MIME-Version: 1.0
In-Reply-To: <1461930155-13871-4-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/16 12:42, Daniel Baluta wrote:
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
These are not strictly 'required' so will have to be next cycle now...

Again, poke me if I haven't  picked this up in a week or so...
Jonathan
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index b8a290e..97928d5 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -20,6 +20,7 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/sysfs.h>
>  
>  #include "bmi160.h"
>  
> @@ -466,10 +467,36 @@ static int bmi160_write_raw(struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> +static
> +IIO_CONST_ATTR(in_accel_sampling_frequency_available,
> +	       "0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600");
> +static
> +IIO_CONST_ATTR(in_anglvel_sampling_frequency_available,
> +	       "25 50 100 200 400 800 1600 3200");
> +static
> +IIO_CONST_ATTR(in_accel_scale_available,
> +	       "0.000598 0.001197 0.002394 0.004788");
> +static
> +IIO_CONST_ATTR(in_anglvel_scale_available,
> +	       "0.001065 0.000532 0.000266 0.000133 0.000066");
> +
> +static struct attribute *bmi160_attrs[] = {
> +	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_anglvel_sampling_frequency_available.dev_attr.attr,
> +	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
> +	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bmi160_attrs_group = {
> +	.attrs = bmi160_attrs,
> +};
> +
>  static const struct iio_info bmi160_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = bmi160_read_raw,
>  	.write_raw = bmi160_write_raw,
> +	.attrs = &bmi160_attrs_group,
>  };
>  
>  static const char *bmi160_match_acpi_device(struct device *dev)
> 

