Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:34887 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3IPHwh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 03:52:37 -0400
Message-ID: <5236B8BA.5050402@kernel.org>
Date: Mon, 16 Sep 2013 08:52:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>,
	Josh Wu <josh.wu@atmel.com>,
	Denis Ciocca <denis.ciocca@gmail.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Ge Gao <ggao@invensense.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 04/27] iio: Add iio_push_buffers_with_timestamp() helper
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/09/13 17:50, Lars-Peter Clausen wrote:
> Drivers using software buffers often store the timestamp in their data buffer
> before calling iio_push_to_buffers() with that data buffer. Storing the
> timestamp in the buffer usually involves some ugly pointer arithmetic. This
> patch adds a new helper function called iio_push_buffers_with_timestamp() which
> is similar to iio_push_to_buffers but takes an additional timestamp parameter.
> The function will help to hide to uglyness in one central place instead of
> exposing it in every driver. If timestamps are enabled for the IIO device
> iio_push_buffers_with_timestamp() will store the timestamp as the last element
> in buffer, before passing the buffer on to iio_push_buffers(). The buffer needs
> large enough to hold the timestamp in this case. If timestamps are disabled
> iio_push_buffers_with_timestamp() will behave just like iio_push_buffers().
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> Cc: Josh Wu <josh.wu@atmel.com>
> Cc: Denis Ciocca <denis.ciocca@gmail.com>
> Cc: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> Cc: Ge Gao <ggao@invensense.com>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Marek Vasut <marex@denx.de>
Interesting.  Whilst this obviously results in the removal of a lot of 
repeated code, I am nervous about introducing the 'hidden' requirement
that the data buffer passed in must be bigger than is 'apparently' used
in the code calling this. I'm not sure what the right answer is though.
> ---
>   include/linux/iio/buffer.h | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index e5507e9..1ebc382 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -116,12 +116,37 @@ int iio_scan_mask_set(struct iio_dev *indio_dev,
>   		      struct iio_buffer *buffer, int bit);
>
>   /**
> - * iio_push_to_buffers() - push to a registered buffer.
> + * iio_push_to_buffers_with_timestamp() - push to a registered buffer.
>    * @indio_dev:		iio_dev structure for device.
>    * @data:		Full scan.
>    */
>   int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
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
>   int iio_update_demux(struct iio_dev *indio_dev);
>
>   /**
>

