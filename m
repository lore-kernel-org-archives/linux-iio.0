Return-Path: <pmeerw@pmeerw.net>
Date: Sun, 15 Sep 2013 19:44:49 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
    Josh Wu <josh.wu@atmel.com>, Denis Ciocca <denis.ciocca@gmail.com>,
    Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
    Ge Gao <ggao@invensense.com>, Jacek Anaszewski <j.anaszewski@samsung.com>,
    Fabio Estevam <fabio.estevam@freescale.com>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 04/27] iio: Add iio_push_buffers_with_timestamp()
 helper
In-Reply-To: <1379263880-18405-4-git-send-email-lars@metafoo.de>
Message-ID: <alpine.DEB.2.01.1309151934000.22469@pmeerw.net>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-4-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


I like!

> in buffer, before passing the buffer on to iio_push_buffers(). The buffer needs
> large enough to hold the timestamp in this case. If timestamps are disabled
> iio_push_buffers_with_timestamp() will behave just like iio_push_buffers().

computation of the buffer size is the remaining piece of ugliness; 
indio_dev->scan_bytes in not available at probe time

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Cc: Josh Wu <josh.wu@atmel.com>
> Cc: Denis Ciocca <denis.ciocca@gmail.com>
> Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Cc: Ge Gao <ggao@invensense.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>

twice, so honoured :)

nitpick below

> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index e5507e9..1ebc382 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -116,12 +116,37 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
>  		      struct iio_buffer *buffer, int bit);
>  
>  /**
> - * iio_push_to_buffers() - push to a registered buffer.
> + * iio_push_to_buffers_with_timestamp() - push to a registered buffer.

should still be iio_push_to_buffers() here

>   * @indio_dev:		iio_dev structure for device.
>   * @data:		Full scan.
>   */
>  int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
>  
> +/*
> + * iio_push_to_buffers_with_timestamp() - push data and timestamp to buffers
> + * @indio_dev:		iio_dev structure for device.
> + * @data:		sample data
> + * @timestamp:		timestamp for the sample data
> + *
> + * Pushes data to the IIO device's buffers. If timestamps are enabled for the
> + * device the function will store the supplied timestamp as the last element in
> + * the sample data buffer before pushing it to the device buffers. The sample
> + * data buffer needs to be large enough to hold the additional timestamp
> + * (usually the buffer should be indio->scan_bytes bytes large).
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
> +	void *data, int64_t timestamp)
> +{
> +	if (indio_dev->scan_timestamp) {
> +		size_t ts_offset = indio_dev->scan_bytes / sizeof(int64_t) - 1;
> +		((int64_t *)data)[ts_offset] = timestamp;
> +	}
> +
> +	return iio_push_to_buffers(indio_dev, data);
> +}
> +
>  int iio_update_demux(struct iio_dev *indio_dev);
>  
>  /**
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
