Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-234.synserver.de ([212.40.185.234]:1158 "EHLO
	smtp-out-233.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754580Ab2IGQgf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Sep 2012 12:36:35 -0400
Message-ID: <504A22AD.2050403@metafoo.de>
Date: Fri, 07 Sep 2012 18:37:01 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 03/10] staging:iio:ad7476: Avoid alloc/free for each sample
 in buffered mode
References: <1347021872-7885-1-git-send-email-lars@metafoo.de> <1347021872-7885-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1347021872-7885-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/07/2012 02:44 PM, Lars-Peter Clausen wrote:
> The ad7476 driver has only support for 1 channel ADCs. So the upper limit for
> the buffer size is the size of one sample plus the size of the timestamp.
> Preallocate a buffer large enough to hold this to avoid having to allocate and
> free a new buffer for each sample being captured.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/ad7476.h      |    5 ++++-
>  drivers/staging/iio/adc/ad7476_ring.c |   13 +++----------
>  2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476.h b/drivers/staging/iio/adc/ad7476.h
> index 6085fad..c4f1150 100644
> --- a/drivers/staging/iio/adc/ad7476.h
> +++ b/drivers/staging/iio/adc/ad7476.h
> @@ -33,8 +33,11 @@ struct ad7476_state {
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> +	 * Make the buffer large enough for one 16 bit sample and one 64 bit
> +	 * aligned 64 bit timestamp.
>  	 */
> -	unsigned char			data[2] ____cacheline_aligned;
> +	unsigned char data[ALIGN(2, sizeof(s64)) + sizeof(s64)]
> +			____cacheline_aligned;
>  };
>  
>  enum ad7476_supported_device_ids {
> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
> index 940681f..185cfde 100644
> --- a/drivers/staging/iio/adc/ad7476_ring.c
> +++ b/drivers/staging/iio/adc/ad7476_ring.c
> @@ -26,14 +26,9 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad7476_state *st = iio_priv(indio_dev);
>  	s64 time_ns;
> -	__u8 *rxbuf;
>  	int b_sent;
>  
> -	rxbuf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (rxbuf == NULL)
> -		goto done;
> -
> -	b_sent = spi_read(st->spi, rxbuf,
> +	b_sent = spi_read(st->spi, st->data,
>  			  st->chip_info->channel[0].scan_type.storagebits / 8);

I just noticed this can even more be simplified by using the prepared SPI
message. Unfortunately this will require regeneration of a few more patches.
I'll resend the whole series next week, after it had some exposure to review.

>  	if (b_sent < 0)
>  		goto done;
> @@ -41,13 +36,11 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	time_ns = iio_get_time_ns();
>  
>  	if (indio_dev->scan_timestamp)
> -		memcpy(rxbuf + indio_dev->scan_bytes - sizeof(s64),
> -			&time_ns, sizeof(time_ns));
> +		((s64 *)st->data)[1] = time_ns;
>  
> -	iio_push_to_buffer(indio_dev->buffer, rxbuf);
> +	iio_push_to_buffer(indio_dev->buffer, st->data);
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> -	kfree(rxbuf);
>  
>  	return IRQ_HANDLED;
>  }

