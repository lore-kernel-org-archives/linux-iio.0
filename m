Return-Path: <jic23@kernel.org>
Message-ID: <4ED7EE04.3010308@kernel.org>
Date: Thu, 01 Dec 2011 21:13:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Andreas Ruprecht <rupran@einserver.de>
CC: devel@linuxdriverproject.org, dan.carpenter@oracle.com,
 gregkh@suse.de, jic23@cam.ac.uk, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] Staging: iio/accel: Changed data type of val in store_measurement_mode
 to u8
References: <20111124205657.GL3258@mwanda> <1322432262-16533-1-git-send-email-rupran@einserver.de> <1322432262-16533-3-git-send-email-rupran@einserver.de>
In-Reply-To: <1322432262-16533-3-git-send-email-rupran@einserver.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/27/2011 10:17 PM, Andreas Ruprecht wrote:
> The code in sca3000_store_measurement_mode() uses the variable val to
> do bitwise operations with an int mask and or-s it into st->rx[0] which
> is an entry in a u8 array (see sca3000.h).
> 
> This means up to now values larger than a u8 were silently ignored and
> just the lower 8 bits counted into the value that was written into
> st->rx[0]. This code will return -ERANGE if the value in buf was too
> large to fit into a u8.
Equal arguement holds for the mask being a u8 and for that matter we
should also verify the range is 0-3.

Do both of them and feel free to add Acked-by: Jonathan Cameron
<jic23@kernel.org>

When you get down to it this whole interface is horribly non standard
and will need cleaning up at some point.  Not that it is relevant to
this patch!

Thanks,

Jonathan

> 
> Signed-off-by: Andreas Ruprecht <rupran@einserver.de>
> ---
>  drivers/staging/iio/accel/sca3000_core.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index a44a705..c3f1f6a 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -382,10 +382,10 @@ sca3000_store_measurement_mode(struct device *dev,
>  	struct sca3000_state *st = iio_priv(indio_dev);
>  	int ret;
>  	int mask = 0x03;
> -	long val;
> +	u8 val;
>  
>  	mutex_lock(&st->lock);
> -	ret = strict_strtol(buf, 10, &val);
> +	ret = kstrtou8(buf, 10, &val);
>  	if (ret)
>  		goto error_ret;
>  	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
