Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44611 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbcBIVHX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 16:07:23 -0500
Subject: Re: [PATCH] iio: buffer-dmaengine: Use dmaengine_terminate_sync()
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1454953918-1004-1-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56BA5509.7030404@kernel.org>
Date: Tue, 9 Feb 2016 21:07:21 +0000
MIME-Version: 1.0
In-Reply-To: <1454953918-1004-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/16 17:51, Lars-Peter Clausen wrote:
> The DMAengine framework gained support for synchronized transfer
> termination. Use the new dmaengine_terminate_sync() function instead of
> dmaengine_terminate_all(), this avoids a potential race condition when
> disabling the buffer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied - thanks,

Jonathan
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index ebdb838..9fabed4 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -93,12 +93,7 @@ static void iio_dmaengine_buffer_abort(struct iio_dma_buffer_queue *queue)
>  	struct dmaengine_buffer *dmaengine_buffer =
>  		iio_buffer_to_dmaengine_buffer(&queue->buffer);
>  
> -	dmaengine_terminate_all(dmaengine_buffer->chan);
> -	/* FIXME: There is a slight chance of a race condition here.
> -	 * dmaengine_terminate_all() does not guarantee that all transfer
> -	 * callbacks have finished running. Need to introduce a
> -	 * dmaengine_terminate_all_sync().
> -	 */
> +	dmaengine_terminate_sync(dmaengine_buffer->chan);
>  	iio_dma_buffer_block_list_abort(queue, &dmaengine_buffer->active);
>  }
>  
> 

