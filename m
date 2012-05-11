Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:40456 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418Ab2EKM2E (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 May 2012 08:28:04 -0400
Message-ID: <4FAD05D3.2020709@cam.ac.uk>
Date: Fri, 11 May 2012 13:28:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: Remove unused iio_device_put()
References: <1336736816-15678-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1336736816-15678-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 5/11/2012 12:46 PM, Lars-Peter Clausen wrote:
> This function is currently unused and we do not have a matching iio_device_get()
> function either, so just remove it.
>
> Signed-off-by: Lars-Peter Clausen<lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>   include/linux/iio/iio.h |   10 ----------
>   1 file changed, 10 deletions(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 6fdbdb8..eff2a39 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -412,16 +412,6 @@ int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>
>   extern struct bus_type iio_bus_type;
>
> -/**
> - * iio_device_put() - reference counted deallocation of struct device
> - * @dev: the iio_device containing the device
> - **/
> -static inline void iio_device_put(struct iio_dev *indio_dev)
> -{
> -	if (indio_dev)
> -		put_device(&indio_dev->dev);
> -};
> -
>   /* Can we make this smaller? */
>   #define IIO_ALIGN L1_CACHE_BYTES
>   /**

