Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56991 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3IULUA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:20:00 -0400
Message-ID: <523D8F04.3060104@kernel.org>
Date: Sat, 21 Sep 2013 13:20:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 24/24] staging:iio:ade7758: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-24-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-24-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 14:00, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/staging/iio/meter/ade7758_ring.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7758_ring.c b/drivers/staging/iio/meter/ade7758_ring.c
> index 3d8bc2d..4080995 100644
> --- a/drivers/staging/iio/meter/ade7758_ring.c
> +++ b/drivers/staging/iio/meter/ade7758_ring.c
> @@ -69,11 +69,7 @@ static irqreturn_t ade7758_trigger_handler(int irq, void *p)
>  		if (ade7758_spi_read_burst(indio_dev) >= 0)
>  			*dat32 = get_unaligned_be32(&st->rx_buf[5]) & 0xFFFFFF;
>  
> -	/* Guaranteed to be aligned with 8 byte boundary */
> -	if (indio_dev->scan_timestamp)
> -		dat64[1] = pf->timestamp;
> -
> -	iio_push_to_buffers(indio_dev, dat64);
> +	iio_push_to_buffers_with_timestamp(indio_dev, dat64, pf->timestamp);
>  
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
