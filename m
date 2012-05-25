Return-Path: <lars@metafoo.de>
Message-ID: <4FBFB365.2020209@metafoo.de>
Date: Fri, 25 May 2012 18:29:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Add iio_device_get()
References: <1337588514-23938-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1337588514-23938-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/21/2012 10:21 AM, Lars-Peter Clausen wrote:
> This patch add the iio_device_get() function, which increases the reference
> count of a iio device. The matching function to decrease the reference count -
> iio_device_put() - already exists.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Hi Jonathan,

Are you OK with these two patches?

Thanks,
- Lars

> ---
>  include/linux/iio/iio.h |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 3a4f6a3..3238fa3 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -438,6 +438,17 @@ static inline struct iio_dev *dev_to_iio_dev(struct device *dev)
>  	return container_of(dev, struct iio_dev, dev);
>  }
>  
> +/**
> + * iio_device_get() - increment reference count for the device
> + * @indio_dev: IIO device structure
> + *
> + * Returns: The passed IIO device
> + **/
> +static inline struct iio_dev *iio_device_get(struct iio_dev *indio_dev)
> +{
> +	return indio_dev ? dev_to_iio_dev(get_device(&indio_dev->dev)) : NULL;
> +}
> +
>  /* Can we make this smaller? */
>  #define IIO_ALIGN L1_CACHE_BYTES
>  /**
