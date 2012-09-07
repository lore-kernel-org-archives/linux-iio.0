Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-233.synserver.de ([212.40.185.233]:1047 "EHLO
	smtp-out-233.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758104Ab2IGJLm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Sep 2012 05:11:42 -0400
Message-ID: <5049BA6C.1050309@metafoo.de>
Date: Fri, 07 Sep 2012 11:12:12 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, srinivas.pandruvada@intel.com
Subject: Re: [PATCH] staging:iio: hid-sensors Use iio_push_to_buffer
References: <1346966403-14517-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1346966403-14517-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/06/2012 11:20 PM, Jonathan Cameron wrote:
> Consistently use iio_push_to_buffer instead of manually calling the buffers
> store_to callback.
> 
> These crossed with Lars-Peter's patch set doing every other case.

Actually I only did this for drivers/staging/iio, the at91_adc driver in
drivers/iio still uses the store_to callback as well, might make sense to
convert it as well in this patch.

> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 2 +-
>  drivers/iio/light/hid-sensor-als.c            | 2 +-
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 33aa97c..c593eb23 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -212,7 +212,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
>  				datum_sz);
>  		return;
>  	}
> -	buffer->access->store_to(buffer, (u8 *)data, timestamp);
> +	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
>  }
>  
>  /* Callback handler to send event after all samples are received and captured */
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 50ec09b..94a4740 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -212,7 +212,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
>  				datum_sz);
>  		return;
>  	}
> -	buffer->access->store_to(buffer, (u8 *)data, timestamp);
> +	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
>  }
>  
>  /* Callback handler to send event after all samples are received and captured */
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 2cff7d5..b3c8e91 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -191,7 +191,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
>  				datum_sz);
>  		return;
>  	}
> -	buffer->access->store_to(buffer, (u8 *)data, timestamp);
> +	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
>  }
>  
>  /* Callback handler to send event after all samples are received and captured */
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index 07591f4..397704e 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -213,7 +213,7 @@ static void hid_sensor_push_data(struct iio_dev *indio_dev, u8 *data, int len)
>  				datum_sz);
>  		return;
>  	}
> -	buffer->access->store_to(buffer, (u8 *)data, timestamp);
> +	iio_push_to_buffer(buffer, (u8 *)data, timestamp);
>  }
>  
>  /* Callback handler to send event after all samples are received and captured */

