Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49110 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab3K3MGR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Nov 2013 07:06:17 -0500
Message-ID: <5299D4B8.3050701@kernel.org>
Date: Sat, 30 Nov 2013 12:06:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: Add data_available callback for buffers
References: <1385391404-3112-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1385391404-3112-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/25/13 14:56, Lars-Peter Clausen wrote:
> This patch adds a new data_available() callback to the iio_buffer_access_funcs
> struct. The callback is used to indicate whether data is available in the buffer
> for reading. It is meant to replace the stufftoread flag from the iio_buffer
> struct. The reasoning for this is that the buffer implementation usually can
> determine whether data is available rather easily based on its state, on the
> other hand it can be rather tricky to update the stufftoread flag in a race free
> way.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

A sensible change - applied to the togreg branch of iio.git.

> ---
>  drivers/iio/industrialio-buffer.c | 10 +++++++++-
>  include/linux/iio/buffer.h        |  3 +++
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 7f9152c..4dcc3a0 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -37,6 +37,14 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
>  	return !list_empty(&buf->buffer_list);
>  }
>  
> +static bool iio_buffer_data_available(struct iio_buffer *buf)
> +{
> +	if (buf->access->data_available)
> +		return buf->access->data_available(buf);
> +
> +	return buf->stufftoread;
> +}
> +
>  /**
>   * iio_buffer_read_first_n_outer() - chrdev read for buffer access
>   *
> @@ -70,7 +78,7 @@ unsigned int iio_buffer_poll(struct file *filp,
>  		return -ENODEV;
>  
>  	poll_wait(filp, &rb->pollq, wait);
> -	if (rb->stufftoread)
> +	if (iio_buffer_data_available(rb))
>  		return POLLIN | POLLRDNORM;
>  	/* need a way of knowing if there may be enough data... */
>  	return 0;
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 15607b4..5193927 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -21,6 +21,8 @@ struct iio_buffer;
>   * struct iio_buffer_access_funcs - access functions for buffers.
>   * @store_to:		actually store stuff to the buffer
>   * @read_first_n:	try to get a specified number of bytes (must exist)
> + * @data_available:	indicates whether data for reading from the buffer is
> + *			available.
>   * @request_update:	if a parameter change has been marked, update underlying
>   *			storage.
>   * @get_bytes_per_datum:get current bytes per datum
> @@ -43,6 +45,7 @@ struct iio_buffer_access_funcs {
>  	int (*read_first_n)(struct iio_buffer *buffer,
>  			    size_t n,
>  			    char __user *buf);
> +	bool (*data_available)(struct iio_buffer *buffer);
>  
>  	int (*request_update)(struct iio_buffer *buffer);
>  
> 
