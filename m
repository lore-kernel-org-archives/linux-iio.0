Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751892AbeFXNlU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jun 2018 09:41:20 -0400
Date: Sun, 24 Jun 2018 14:41:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Matt Fornero <matt.fornero@mathworks.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: use timespec64 based interfaces for
 iio_get_time_ns()
Message-ID: <20180624144114.1b9887e4@archlinux>
In-Reply-To: <20180618153153.1903178-1-arnd@arndb.de>
References: <20180618153153.1903178-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 18 Jun 2018 17:31:36 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> We have replacements for all the deprecated timespec based interfaces now,
> so this can finally convert iio_get_time_ns() to consistently use the
> nanosecond or timespec64 based interfaces instead, avoiding the y2038
> overflow.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Great!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to sanity check.

Thanks

Jonathan

> ---
>  drivers/iio/industrialio-core.c | 26 +++++++++-----------------
>  1 file changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 19bdf3d2962a..fcbe92c34a3d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -207,35 +207,27 @@ static int iio_device_set_clock(struct iio_dev *indio_dev, clockid_t clock_id)
>   */
>  s64 iio_get_time_ns(const struct iio_dev *indio_dev)
>  {
> -	struct timespec tp;
> +	struct timespec64 tp;
>  
>  	switch (iio_device_get_clock(indio_dev)) {
>  	case CLOCK_REALTIME:
> -		ktime_get_real_ts(&tp);
> -		break;
> +		return ktime_get_real_ns();
>  	case CLOCK_MONOTONIC:
> -		ktime_get_ts(&tp);
> -		break;
> +		return ktime_get_ns();
>  	case CLOCK_MONOTONIC_RAW:
> -		getrawmonotonic(&tp);
> -		break;
> +		return ktime_get_raw_ns();
>  	case CLOCK_REALTIME_COARSE:
> -		tp = current_kernel_time();
> -		break;
> +		return ktime_to_ns(ktime_get_coarse_real());
>  	case CLOCK_MONOTONIC_COARSE:
> -		tp = get_monotonic_coarse();
> -		break;
> +		ktime_get_coarse_ts64(&tp);
> +		return timespec64_to_ns(&tp);
>  	case CLOCK_BOOTTIME:
> -		get_monotonic_boottime(&tp);
> -		break;
> +		return ktime_get_boot_ns();
>  	case CLOCK_TAI:
> -		timekeeping_clocktai(&tp);
> -		break;
> +		return ktime_get_tai_ns();
>  	default:
>  		BUG();
>  	}
> -
> -	return timespec_to_ns(&tp);
>  }
>  EXPORT_SYMBOL(iio_get_time_ns);
>  

