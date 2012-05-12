Return-Path: <jic23@kernel.org>
Message-ID: <4FAE2878.6070900@kernel.org>
Date: Sat, 12 May 2012 10:08:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/24] iio: Add dev_to_iio_dev() helper function
References: <1336741127-29552-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1336741127-29552-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/11/2012 01:58 PM, Lars-Peter Clausen wrote:
> This patch adds a helper function for retriving a iio_dev struct from a device
> struct. Currently we open-code this in two different ways. One is using
> dev_get_drvdata on the device and the other is using container_of. The new
> helper function uses the container_of solution as it creates slightly smaller
> code and also will eventually free up the drvdata pointer for usage by invidual
> drivers.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  include/linux/iio/iio.h |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index eff2a39..38baea5 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -412,6 +412,17 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  
>  extern struct bus_type iio_bus_type;
>  
> +/**
> + * dev_to_iio_dev() - Get IIO device struct from a device struct
> + * @dev: The device embedded in the IIO device
> + *
> + * Note: The device must be a IIO device, otherwise the result is undefined.
> + */
> +static inline struct iio_dev *dev_to_iio_dev(struct device *dev)
> +{
> +	return container_of(dev, struct iio_dev, dev);
> +}
> +
>  /* Can we make this smaller? */
>  #define IIO_ALIGN L1_CACHE_BYTES
>  /**
