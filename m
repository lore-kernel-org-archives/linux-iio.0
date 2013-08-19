Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52849 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab3HSSCU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 14:02:20 -0400
Message-ID: <52126BBC.40505@kernel.org>
Date: Mon, 19 Aug 2013 20:02:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: Remove unnecessary _write_raw_get_fmt() in several
 hid-sensor drivers
References: <1376831236-4219-1-git-send-email-pmeerw@pmeerw.net> <4FA419E87744DF4DAECD5BCE1214B7A9382CE537@ORSMSX109.amr.corp.intel.com>
In-Reply-To: <4FA419E87744DF4DAECD5BCE1214B7A9382CE537@ORSMSX109.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/19/13 16:15, Pandruvada, Srinivas wrote:
> If IIO_VAL_INT_PLUS_MICRO is by default, then this patch is fine.
It is, so I'll take that as an Acked-by.

Applied to the togreg branch of iio.git

Thanks,

Jonathan

> 
> -----Original Message-----
> From: Peter Meerwald [mailto:pmeerw@pmeerw.net] 
> Sent: Sunday, August 18, 2013 6:07 AM
> To: linux-iio@vger.kernel.org
> Cc: Peter Meerwald; Pandruvada, Srinivas
> Subject: [PATCH] iio: Remove unnecessary _write_raw_get_fmt() in several hid-sensor drivers
> 
> IIO_VAL_INT_PLUS_MICRO is the default, no need to return it explicitly
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c       | 8 --------
>  drivers/iio/gyro/hid-sensor-gyro-3d.c         | 8 --------
>  drivers/iio/light/hid-sensor-als.c            | 8 --------
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 8 --------
>  4 files changed, 32 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 68df341..46d22f3 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -175,18 +175,10 @@ static int accel_3d_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int accel_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       long mask)
> -{
> -	return IIO_VAL_INT_PLUS_MICRO;
> -}
> -
>  static const struct iio_info accel_3d_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &accel_3d_read_raw,
>  	.write_raw = &accel_3d_write_raw,
> -	.write_raw_get_fmt = &accel_3d_write_raw_get_fmt,
>  };
>  
>  /* Function to push data to buffer */
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 9cc8aa1..be95179 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -175,18 +175,10 @@ static int gyro_3d_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int gyro_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       long mask)
> -{
> -	return IIO_VAL_INT_PLUS_MICRO;
> -}
> -
>  static const struct iio_info gyro_3d_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &gyro_3d_read_raw,
>  	.write_raw = &gyro_3d_write_raw,
> -	.write_raw_get_fmt = &gyro_3d_write_raw_get_fmt,
>  };
>  
>  /* Function to push data to buffer */
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 84cf004..e59d00c 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -154,18 +154,10 @@ static int als_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int als_write_raw_get_fmt(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       long mask)
> -{
> -	return IIO_VAL_INT_PLUS_MICRO;
> -}
> -
>  static const struct iio_info als_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &als_read_raw,
>  	.write_raw = &als_write_raw,
> -	.write_raw_get_fmt = &als_write_raw_get_fmt,
>  };
>  
>  /* Function to push data to buffer */
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index 5a6162d..a98460b 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -176,18 +176,10 @@ static int magn_3d_write_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> -static int magn_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
> -			       struct iio_chan_spec const *chan,
> -			       long mask)
> -{
> -	return IIO_VAL_INT_PLUS_MICRO;
> -}
> -
>  static const struct iio_info magn_3d_info = {
>  	.driver_module = THIS_MODULE,
>  	.read_raw = &magn_3d_read_raw,
>  	.write_raw = &magn_3d_write_raw,
> -	.write_raw_get_fmt = &magn_3d_write_raw_get_fmt,
>  };
>  
>  /* Function to push data to buffer */
> 
