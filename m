Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36751 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1EaQEv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 31 May 2011 12:04:51 -0400
Message-ID: <4DE51381.80204@cam.ac.uk>
Date: Tue, 31 May 2011 17:12:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: industrialio-core: introduce IIO_VAL_INT_PLUS_NANO
References: <1306504304-19379-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1306504304-19379-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/27/11 14:51, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
As discussed, handling the writing case is more tricky, but as our
only user is read only we can tackle that in the future.
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio.h               |    1 +
>  drivers/staging/iio/industrialio-core.c |    5 +++++
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 38f1425..78a0927 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -202,6 +202,7 @@ static inline s64 iio_get_time_ns(void)
>   * call to iio_device_register. */
>  #define IIO_VAL_INT 1
>  #define IIO_VAL_INT_PLUS_MICRO 2
> +#define IIO_VAL_INT_PLUS_NANO 3
>  
>  /**
>   * struct iio_info - constant information about device
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index 94d3bfa..e5a7663 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -396,6 +396,11 @@ static ssize_t iio_read_channel_info(struct device *dev,
>  			return sprintf(buf, "-%d.%06u\n", val, -val2);
>  		else
>  			return sprintf(buf, "%d.%06u\n", val, val2);
> +	} else if (ret == IIO_VAL_INT_PLUS_NANO) {
> +		if (val2 < 0)
> +			return sprintf(buf, "-%d.%09u\n", val, -val2);
> +		else
> +			return sprintf(buf, "%d.%09u\n", val, val2);
>  	} else
>  		return 0;
>  }

