Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55590 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3JPRRG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:17:06 -0400
Message-ID: <525ED848.1090407@kernel.org>
Date: Wed, 16 Oct 2013 19:17:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 17/17] iio: Remove unused iio_sw_buffer_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-17-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-17-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The functionality implemented by iio_sw_buffer_preenable() is now done directly
> in the IIO core and previous users of iio_sw_buffer_preenable() have all been
> updated to not use it anymore. It is unused now and can be remove.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks for the series.


> ---
>  drivers/iio/industrialio-buffer.c | 18 ------------------
>  include/linux/iio/buffer.h        |  2 --
>  2 files changed, 20 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 186f501..d7ab258 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -749,24 +749,6 @@ done:
>  }
>  EXPORT_SYMBOL(iio_buffer_store_enable);
>  
> -int iio_sw_buffer_preenable(struct iio_dev *indio_dev)
> -{
> -	struct iio_buffer *buffer;
> -	unsigned bytes;
> -	dev_dbg(&indio_dev->dev, "%s\n", __func__);
> -
> -	list_for_each_entry(buffer, &indio_dev->buffer_list, buffer_list)
> -		if (buffer->access->set_bytes_per_datum) {
> -			bytes = iio_compute_scan_bytes(indio_dev,
> -						       buffer->scan_mask,
> -						       buffer->scan_timestamp);
> -
> -			buffer->access->set_bytes_per_datum(buffer, bytes);
> -		}
> -	return 0;
> -}
> -EXPORT_SYMBOL(iio_sw_buffer_preenable);
> -
>  /**
>   * iio_validate_scan_mask_onehot() - Validates that exactly one channel is selected
>   * @indio_dev: the iio device
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 6e428d9..15607b4 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -206,8 +206,6 @@ ssize_t iio_buffer_show_enable(struct device *dev,
>  					   iio_buffer_show_enable,	\
>  					   iio_buffer_store_enable)
>  
> -int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
> -
>  bool iio_validate_scan_mask_onehot(struct iio_dev *indio_dev,
>  	const unsigned long *mask);
>  
> 
