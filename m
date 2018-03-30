Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeC3KKq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 06:10:46 -0400
Date: Fri, 30 Mar 2018 11:10:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio:buffer: make length types match kfifo types
Message-ID: <20180330111042.701d260e@archlinux>
In-Reply-To: <20180326212752.7321-1-mkelly@xevo.com>
References: <20180326212752.7321-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Mar 2018 14:27:51 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Currently, we use int for buffer length and bytes_per_datum. However,
> kfifo uses unsigned int for length and size_t for element size. We need
> to make sure these matches or we will have bugs related to overflow (in
> the range between INT_MAX and UINT_MAX for length, for example).
> 
> In addition, set_bytes_per_datum uses size_t while bytes_per_datum is an
> int, which would cause bugs for large values of bytes_per_datum.
> 
> Change buffer length to use unsigned int and bytes_per_datum to use
> size_t.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
Good bit of cleanup.

I'm fine to take these but I'm not going to rush them in as fixes
for the obvious reason that it's pretty insane to have a buffer
of anywhere near the sizes where this is going to go wrong.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with them.

Thanks,

Jonathan

> ---
>  drivers/iio/buffer/industrialio-buffer-dma.c | 2 +-
>  drivers/iio/buffer/kfifo_buf.c               | 4 ++--
>  include/linux/iio/buffer_impl.h              | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
> index 05e0c353e089..b32bf57910ca 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dma.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dma.c
> @@ -587,7 +587,7 @@ EXPORT_SYMBOL_GPL(iio_dma_buffer_set_bytes_per_datum);
>   * Should be used as the set_length callback for iio_buffer_access_ops
>   * struct for DMA buffers.
>   */
> -int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length)
> +int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length)
>  {
>  	/* Avoid an invalid state */
>  	if (length < 2)
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index 047fe757ab97..ac622edf2486 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -22,7 +22,7 @@ struct iio_kfifo {
>  #define iio_to_kfifo(r) container_of(r, struct iio_kfifo, buffer)
>  
>  static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
> -				int bytes_per_datum, int length)
> +			size_t bytes_per_datum, unsigned int length)
>  {
>  	if ((length == 0) || (bytes_per_datum == 0))
>  		return -EINVAL;
> @@ -67,7 +67,7 @@ static int iio_set_bytes_per_datum_kfifo(struct iio_buffer *r, size_t bpd)
>  	return 0;
>  }
>  
> -static int iio_set_length_kfifo(struct iio_buffer *r, int length)
> +static int iio_set_length_kfifo(struct iio_buffer *r, unsigned int length)
>  {
>  	/* Avoid an invalid state */
>  	if (length < 2)
> diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
> index b9e22b7e2f28..d1171db23742 100644
> --- a/include/linux/iio/buffer_impl.h
> +++ b/include/linux/iio/buffer_impl.h
> @@ -53,7 +53,7 @@ struct iio_buffer_access_funcs {
>  	int (*request_update)(struct iio_buffer *buffer);
>  
>  	int (*set_bytes_per_datum)(struct iio_buffer *buffer, size_t bpd);
> -	int (*set_length)(struct iio_buffer *buffer, int length);
> +	int (*set_length)(struct iio_buffer *buffer, unsigned int length);
>  
>  	int (*enable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
>  	int (*disable)(struct iio_buffer *buffer, struct iio_dev *indio_dev);
> @@ -72,10 +72,10 @@ struct iio_buffer_access_funcs {
>   */
>  struct iio_buffer {
>  	/** @length: Number of datums in buffer. */
> -	int length;
> +	unsigned int length;
>  
>  	/**  @bytes_per_datum: Size of individual datum including timestamp. */
> -	int bytes_per_datum;
> +	size_t bytes_per_datum;
>  
>  	/**
>  	 * @access: Buffer access functions associated with the

