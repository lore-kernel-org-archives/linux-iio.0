Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33570 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab2KJKHK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Nov 2012 05:07:10 -0500
Message-ID: <509E2749.2000709@kernel.org>
Date: Sat, 10 Nov 2012 10:07:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	drivers@analog.com
Subject: Re: [PATCH 1/7] staging:iio:ad7887: Preallocate sample buffer
References: <1352109406-7206-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1352109406-7206-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/05/2012 09:56 AM, Lars-Peter Clausen wrote:
> We know that the sample buffer will at most need to hold two 16 bit samples and
> the 64 bit aligned 64 bit timestamp. Preallocate a buffer large enough to hold
> this instead of allocating and freeing it each time a sample is read.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
All 7 applied to togreg branch.

A nice series and good to get this one out of staging as it's
been pretty much clean for an awful long time!

Jonathan

p.s. I thought I had sent this the other day but it appears not!
> ---
>  drivers/staging/iio/adc/ad7887.h      |  6 ++++--
>  drivers/staging/iio/adc/ad7887_ring.c | 15 ++-------------
>  2 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7887.h b/drivers/staging/iio/adc/ad7887.h
> index 2e09e54..71e5092 100644
> --- a/drivers/staging/iio/adc/ad7887.h
> +++ b/drivers/staging/iio/adc/ad7887.h
> @@ -72,9 +72,11 @@ struct ad7887_state {
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> +	 * Buffer needs to be large enough to hold two 16 bit samples and a
> +	 * 64 bit aligned 64 bit timestamp.
>  	 */
> -
> -	unsigned char			data[4] ____cacheline_aligned;
> +	unsigned char data[ALIGN(4, sizeof(s64)) + sizeof(s64)]
> +		____cacheline_aligned;
>  };
>  
>  enum ad7887_supported_device_ids {
> diff --git a/drivers/staging/iio/adc/ad7887_ring.c b/drivers/staging/iio/adc/ad7887_ring.c
> index b39923b..f11925e 100644
> --- a/drivers/staging/iio/adc/ad7887_ring.c
> +++ b/drivers/staging/iio/adc/ad7887_ring.c
> @@ -73,31 +73,20 @@ static irqreturn_t ad7887_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad7887_state *st = iio_priv(indio_dev);
>  	s64 time_ns;
> -	__u8 *buf;
>  	int b_sent;
>  
> -	unsigned int bytes = bitmap_weight(indio_dev->active_scan_mask,
> -					   indio_dev->masklength) *
> -		st->chip_info->channel[0].scan_type.storagebits / 8;
> -
> -	buf = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> -	if (buf == NULL)
> -		goto done;
> -
>  	b_sent = spi_sync(st->spi, st->ring_msg);
>  	if (b_sent)
>  		goto done;
>  
>  	time_ns = iio_get_time_ns();
>  
> -	memcpy(buf, st->data, bytes);
>  	if (indio_dev->scan_timestamp)
> -		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
> +		memcpy(st->data + indio_dev->scan_bytes - sizeof(s64),
>  		       &time_ns, sizeof(time_ns));
>  
> -	iio_push_to_buffer(indio_dev->buffer, buf);
> +	iio_push_to_buffer(indio_dev->buffer, st->data);
>  done:
> -	kfree(buf);
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
