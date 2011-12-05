Return-Path: <lars@metafoo.de>
Message-ID: <4EDC97D8.5080401@metafoo.de>
Date: Mon, 05 Dec 2011 11:07:20 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/5] staging;iio: move iio data return types into types.h
 for use by inkern
References: <1322399642-22924-1-git-send-email-jic23@kernel.org> <1322399642-22924-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399642-22924-5-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 11/27/2011 02:14 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> In kernel interfaces need these, so make them available.
> 
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio.h |    6 ------
>  1 files changed, 0 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 4650a2b..e30d33d 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -197,12 +197,6 @@ static inline s64 iio_get_time_ns(void)
>  #define INDIO_ALL_BUFFER_MODES					\
>  	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
>  
> -/* Vast majority of this is set by the industrialio subsystem on a
> - * call to iio_device_register. */
> -#define IIO_VAL_INT 1
> -#define IIO_VAL_INT_PLUS_MICRO 2
> -#define IIO_VAL_INT_PLUS_NANO 3
> -
>  struct iio_trigger; /* forward declaration */
>  struct iio_dev;
>  

The second part of this patch which adds the here removed defines to types.h
seems to have slipped into patch 5.
