Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/8] staging:iio: Add ability to allocate private data space to iio_allocate_device
Date: Thu, 17 Mar 2011 23:08:08 +0100
Cc: linux-iio@vger.kernel.org
References: <1300395627-18547-1-git-send-email-jic23@cam.ac.uk> <1300395627-18547-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1300395627-18547-5-git-send-email-jic23@cam.ac.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201103172308.08151.arnd@arndb.de>
List-ID: <linux-iio@vger.kernel.org>

On Thursday 17 March 2011 22:00:23 Jonathan Cameron wrote:
> @@ -264,10 +264,25 @@ static inline void *iio_dev_get_devdata(struct iio_dev *d)
>         return d->dev_data;
>  }
>  
> +
> +/* Can we make this smaller? */
> +#define IIO_ALIGN L1_CACHE_BYTES
>  /**
>   * iio_allocate_device() - allocate an iio_dev from a driver
> + * @sizeof_priv: Space to allocate for private structure.
>   **/
> -struct iio_dev *iio_allocate_device(void);
> +struct iio_dev *iio_allocate_device(int sizeof_priv);
> +
> +static inline void *iio_priv(const struct iio_dev *dev)
> +{
> +       return (char *)dev + ALIGN(sizeof(struct iio_dev), IIO_ALIGN);
> +}
> +
> +static inline struct iio_dev *iio_priv_to_dev(void *priv)
> +{
> +       return (struct iio_dev *)((char *)priv -
> +                                 ALIGN(sizeof(struct iio_dev), IIO_ALIGN));
> +}
>  
>  /**
>   * iio_free_device() - free an iio_dev from a driver

I was actually thinking you'd just assign iio_dev->dev_data to
the private data, but this works, too.

Acked-by: Arnd Bergmann <arnd@arndb.de>
