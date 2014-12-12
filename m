Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47156 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965528AbaLLLNe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 06:13:34 -0500
Message-ID: <548ACDDC.1050700@kernel.org>
Date: Fri, 12 Dec 2014 11:13:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/11] iio: buffer: Drop get_length callback
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-12-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-12-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/11/14 17:55, Lars-Peter Clausen wrote:
> We already do have the length field in the struct iio_buffer which is
> expected to be in sync with the current size of the buffer. And currently
> all implementations of the get_length callback either return this field or a
> constant number.
> 
> This patch removes the get_length callback and replaces all occurrences in
> the IIO core with directly accessing the length field of the buffer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied.  Thanks for this series - all good stuff.
I'm looking forward to the dma stuff (though perhaps not reviewing it ;)
> ---
>  drivers/iio/industrialio-buffer.c          | 11 +++--------
>  drivers/iio/kfifo_buf.c                    |  6 ------
>  drivers/staging/iio/Documentation/ring.txt |  4 ++--
>  drivers/staging/iio/accel/sca3000_ring.c   |  8 +-------
>  include/linux/iio/buffer.h                 |  2 --
>  5 files changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 3e0c3a9..6a97b38 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -389,11 +389,7 @@ static ssize_t iio_buffer_read_length(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_buffer *buffer = indio_dev->buffer;
>  
> -	if (buffer->access->get_length)
> -		return sprintf(buf, "%d\n",
> -			       buffer->access->get_length(buffer));
> -
> -	return 0;
> +	return sprintf(buf, "%d\n", buffer->length);
>  }
>  
>  static ssize_t iio_buffer_write_length(struct device *dev,
> @@ -408,9 +404,8 @@ static ssize_t iio_buffer_write_length(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (buffer->access->get_length)
> -		if (val == buffer->access->get_length(buffer))
> -			return len;
> +	if (val == buffer->length)
> +		return len;
>  
>  	mutex_lock(&indio_dev->mlock);
>  	if (iio_buffer_is_active(indio_dev->buffer)) {
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index 3b0a3bc..b20a9cf 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -47,11 +47,6 @@ static int iio_request_update_kfifo(struct iio_buffer *r)
>  	return ret;
>  }
>  
> -static int iio_get_length_kfifo(struct iio_buffer *r)
> -{
> -	return r->length;
> -}
> -
>  static int iio_mark_update_needed_kfifo(struct iio_buffer *r)
>  {
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
> @@ -141,7 +136,6 @@ static const struct iio_buffer_access_funcs kfifo_access_funcs = {
>  	.data_available = iio_kfifo_buf_data_available,
>  	.request_update = &iio_request_update_kfifo,
>  	.set_bytes_per_datum = &iio_set_bytes_per_datum_kfifo,
> -	.get_length = &iio_get_length_kfifo,
>  	.set_length = &iio_set_length_kfifo,
>  	.release = &iio_kfifo_buffer_release,
>  };
> diff --git a/drivers/staging/iio/Documentation/ring.txt b/drivers/staging/iio/Documentation/ring.txt
> index 434d63a..18718fc 100644
> --- a/drivers/staging/iio/Documentation/ring.txt
> +++ b/drivers/staging/iio/Documentation/ring.txt
> @@ -42,6 +42,6 @@ request_update
>  set_bytes_per_datum
>    Set the number of bytes for a complete scan. (All samples + timestamp)
>  
> -get_length / set_length
> -  Get/set the number of complete scans that may be held by the buffer.
> +set_length
> +  Set the number of complete scans that may be held by the buffer.
>  
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index f2f260e..f76a268 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -129,12 +129,6 @@ error_ret:
>  	return ret ? ret : num_read;
>  }
>  
> -/* This is only valid with all 3 elements enabled */
> -static int sca3000_ring_get_length(struct iio_buffer *r)
> -{
> -	return 64;
> -}
> -
>  static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
>  {
>  	return r->stufftoread;
> @@ -248,6 +242,7 @@ static struct iio_buffer *sca3000_rb_allocate(struct iio_dev *indio_dev)
>  	ring->private = indio_dev;
>  	buf = &ring->buf;
>  	buf->stufftoread = 0;
> +	buf->length = 64;
>  	buf->attrs = sca3000_ring_attributes;
>  	iio_buffer_init(buf);
>  
> @@ -261,7 +256,6 @@ static void sca3000_ring_release(struct iio_buffer *r)
>  
>  static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
>  	.read_first_n = &sca3000_read_first_n_hw_rb,
> -	.get_length = &sca3000_ring_get_length,
>  	.data_available = sca3000_ring_buf_data_available,
>  	.release = sca3000_ring_release,
>  };
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 16b7663..b65850a 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -26,7 +26,6 @@ struct iio_buffer;
>   * @request_update:	if a parameter change has been marked, update underlying
>   *			storage.
>   * @set_bytes_per_datum:set number of bytes per datum
> - * @get_length:		get number of datums in buffer
>   * @set_length:		set number of datums in buffer
>   * @release:		called when the last reference to the buffer is dropped,
>   *			should free all resources allocated by the buffer.
> @@ -49,7 +48,6 @@ struct iio_buffer_access_funcs {
>  	int (*request_update)(struct iio_buffer *buffer);
>  
>  	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
> -	int (*get_length)(struct iio_buffer *buffer);
>  	int (*set_length)(struct iio_buffer *buffer, int length);
>  
>  	void (*release)(struct iio_buffer *buffer);
> 

