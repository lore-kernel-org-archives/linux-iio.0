Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753713AbeFJNfV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Jun 2018 09:35:21 -0400
Date: Sun, 10 Jun 2018 14:35:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: buffer: fix the function signature to match
 implementation
Message-ID: <20180610143516.66739628@archlinux>
In-Reply-To: <1528179310-10753-1-git-send-email-preid@electromag.com.au>
References: <1528179310-10753-1-git-send-email-preid@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  5 Jun 2018 14:15:10 +0800
Phil Reid <preid@electromag.com.au> wrote:

> linux/iio/buffer-dma.h was not updated to when length was changed to
> unsigned int.
> 
> Fixes: c043ec1ca5ba ("iio:buffer: make length types match kfifo types")
> Signed-off-by: Phil Reid <preid@electromag.com.au>
Thanks, but I'll need to hold this for a few weeks due to some
ordering issues with some fixes that are queued up in my fixes branch
for after the merge window closes.

Give me a poke if I seem to have forgotten it in perhaps 2 weeks time.

Thanks,

Jonathan

> ---
>  include/linux/iio/buffer-dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/iio/buffer-dma.h b/include/linux/iio/buffer-dma.h
> index 9182d4e..fbe053d 100644
> --- a/include/linux/iio/buffer-dma.h
> +++ b/include/linux/iio/buffer-dma.h
> @@ -141,7 +141,7 @@ int iio_dma_buffer_read(struct iio_buffer *buffer, size_t n,
>  	char __user *user_buffer);
>  size_t iio_dma_buffer_data_available(struct iio_buffer *buffer);
>  int iio_dma_buffer_set_bytes_per_datum(struct iio_buffer *buffer, size_t bpd);
> -int iio_dma_buffer_set_length(struct iio_buffer *buffer, int length);
> +int iio_dma_buffer_set_length(struct iio_buffer *buffer, unsigned int length);
>  int iio_dma_buffer_request_update(struct iio_buffer *buffer);
>  
>  int iio_dma_buffer_init(struct iio_dma_buffer_queue *queue,

