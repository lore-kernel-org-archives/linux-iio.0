Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56775 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3IULLJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:11:09 -0400
Message-ID: <523D8CF1.80003@kernel.org>
Date: Sat, 21 Sep 2013 13:11:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 05/24] iio:ad7476: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/adc/ad7476.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 6d2b1d8..8d808b9 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -64,19 +64,14 @@ static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad7476_state *st = iio_priv(indio_dev);
> -	s64 time_ns;
>  	int b_sent;
>  
>  	b_sent = spi_sync(st->spi, &st->msg);
>  	if (b_sent < 0)
>  		goto done;
>  
> -	time_ns = iio_get_time_ns();
> -
> -	if (indio_dev->scan_timestamp)
> -		((s64 *)st->data)[1] = time_ns;
> -
> -	iio_push_to_buffers(indio_dev, st->data);
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +		iio_get_time_ns());
>  done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
