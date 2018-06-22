Return-Path: <SRS0=vNwF=JI=electromag.com.au=preid@kernel.org>
Subject: Re: [PATCH] iio:buffer: fix iio_dma_buffer_set_length() prototype
 mismatch
To: Alexandru Ardelean <alexandru.ardelean@analog.com>,
  linux-iio@vger.kernel.org
Cc: jic23@kernel.org
References: <20180622085942.24253-1-alexandru.ardelean@analog.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <f836cf4b-96fe-a088-e13e-1b4545c0e5e8@electromag.com.au>
Date: Fri, 22 Jun 2018 17:15:03 +0800
MIME-Version: 1.0
In-Reply-To: <20180622085942.24253-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 22/06/2018 16:59, Alexandru Ardelean wrote:
> Fixes commit c043ec1ca5ba ("iio:buffer: make length types match kfifo
> types").
> When the length parameter's type was updated in the
> `iio_dma_buffer_set_length()` function, the prototype was omitted in the
> `include/linux/iio/buffer-dma.h` header.
> 
> This causes a build error when running certain CFLAGS configurations that
> are a bit more pedantic.

G'day Alexandru,

I recently submitted a patch for the same issue.
see: https://patchwork.kernel.org/patch/10447649/

Jonathan was holding of for a couple of weeks due to ordering issues.



> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>   include/linux/iio/buffer-dma.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 767467d886de..67c75372b691 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -141,7 +141,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>   	char __user *user_buffer);
>   size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
>   int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
> -int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length);
> +int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
>   int iio_dma_buffer_request_update(struct iio_buffer *buffer);
>   
>   int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,
> 


-- 
Regards
Phil
