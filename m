Return-Path: <jic23@kernel.org>
Message-ID: <4FAEB166.80204@kernel.org>
Date: Sat, 12 May 2012 19:52:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio:dac: Remove dac.h
References: <1336755862-24184-1-git-send-email-lars@metafoo.de> <1336755862-24184-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1336755862-24184-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 06:04 PM, Lars-Peter Clausen wrote:
> Now that all drivers have been converted to channel spec, we can finally remove
> the dac.h file since it is no longer used.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/dac.h |    6 ------
>  1 file changed, 6 deletions(-)
>  delete mode 100644 drivers/staging/iio/dac/dac.h
> 
> diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
> deleted file mode 100644
> index 0754d71..0000000
> --- a/drivers/staging/iio/dac/dac.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -/*
> - * dac.h - sysfs attributes associated with DACs
> - */
> -
> -#define IIO_DEV_ATTR_OUT_RAW(_num, _store, _addr)				\
> -	IIO_DEVICE_ATTR(out_voltage##_num##_raw, S_IWUSR, NULL, _store, _addr)
