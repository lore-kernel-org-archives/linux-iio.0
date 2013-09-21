Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56793 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab3IULLr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:11:47 -0400
Message-ID: <523D8D17.80509@kernel.org>
Date: Sat, 21 Sep 2013 13:12:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/24] iio:ad7923: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/adc/ad7923.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 7eb4cb5..28732c2 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -174,20 +174,14 @@ static irqreturn_t ad7923_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad7923_state *st = iio_priv(indio_dev);
> -	s64 time_ns = 0;
>  	int b_sent;
>  
>  	b_sent = spi_sync(st->spi, &st->ring_msg);
>  	if (b_sent)
>  		goto done;
>  
> -	if (indio_dev->scan_timestamp) {
> -		time_ns = iio_get_time_ns();
> -		memcpy((u8 *)st->rx_buf + indio_dev->scan_bytes - sizeof(s64),
> -			&time_ns, sizeof(time_ns));
> -	}
> -
> -	iio_push_to_buffers(indio_dev, st->rx_buf);
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
> +		iio_get_time_ns());
>  
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
> 
