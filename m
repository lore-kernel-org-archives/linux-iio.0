Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:53377 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880Ab0IEW2v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Sep 2010 18:28:51 -0400
Message-ID: <4C841ACD.2080809@cam.ac.uk>
Date: Sun, 05 Sep 2010 23:33:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: achew@nvidia.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: Change GAIN macros to SCALE.
References: <1283724326-31998-1-git-send-email-achew@nvidia.com>
In-Reply-To: <1283724326-31998-1-git-send-email-achew@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/10 23:05, achew@nvidia.com wrote:
> From: Andrew Chew <achew@nvidia.com>
> 
> Per email exchange with Jonathan Cameron, GAIN should instead be SCALE, to
> be consistent with documentation.
> 
> Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Please send this one on to Greg KH with your driver
(when that is ready).  That will make it apparent why
these are there at all!

Thanks,

Jonathan
> ---
>  drivers/staging/iio/magnetometer/magnet.h |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/magnet.h b/drivers/staging/iio/magnetometer/magnet.h
> index 6433830..1260eb7 100644
> --- a/drivers/staging/iio/magnetometer/magnet.h
> +++ b/drivers/staging/iio/magnetometer/magnet.h
> @@ -12,14 +12,14 @@
>  #define IIO_DEV_ATTR_MAGN_Z_OFFSET(_mode, _show, _store, _addr)	\
>  	IIO_DEVICE_ATTR(magn_z_offset, _mode, _show, _store, _addr)
>  
> -#define IIO_DEV_ATTR_MAGN_X_GAIN(_mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(magn_x_gain, _mode, _show, _store, _addr)
> +#define IIO_DEV_ATTR_MAGN_X_SCALE(_mode, _show, _store, _addr)		\
> +	IIO_DEVICE_ATTR(magn_x_scale, _mode, _show, _store, _addr)
>  
> -#define IIO_DEV_ATTR_MAGN_Y_GAIN(_mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(magn_y_gain, _mode, _show, _store, _addr)
> +#define IIO_DEV_ATTR_MAGN_Y_SCALE(_mode, _show, _store, _addr)		\
> +	IIO_DEVICE_ATTR(magn_y_scale, _mode, _show, _store, _addr)
>  
> -#define IIO_DEV_ATTR_MAGN_Z_GAIN(_mode, _show, _store, _addr)		\
> -	IIO_DEVICE_ATTR(magn_z_gain, _mode, _show, _store, _addr)
> +#define IIO_DEV_ATTR_MAGN_Z_SCALE(_mode, _show, _store, _addr)		\
> +	IIO_DEVICE_ATTR(magn_z_scale, _mode, _show, _store, _addr)
>  
>  #define IIO_DEV_ATTR_MAGN_X(_show, _addr)				\
>  	IIO_DEVICE_ATTR(magn_x_raw, S_IRUGO, _show, NULL, _addr)

