Return-Path: <jic23@kernel.org>
Message-ID: <4FF85A07.3030704@kernel.org>
Date: Sat, 07 Jul 2012 16:47:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/11] staging:iio:ad7298: Do not return error code in
 interrupt handler
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/04/2012 05:09 PM, Lars-Peter Clausen wrote:
> The interrupt handler should only ever return one of the three irqreturn_t
> constants and not an error code. Also make sure to always call
> iio_trigger_notify_done before leaving the trigger handler.
> 
merged all. Thanks.
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/adc/ad7298_ring.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
> index cd3e9cb..fd1d855 100644
> --- a/drivers/staging/iio/adc/ad7298_ring.c
> +++ b/drivers/staging/iio/adc/ad7298_ring.c
> @@ -82,7 +82,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  
>  	b_sent = spi_sync(st->spi, &st->ring_msg);
>  	if (b_sent)
> -		return b_sent;
> +		goto done;
>  
>  	if (indio_dev->scan_timestamp) {
>  		time_ns = iio_get_time_ns();
> @@ -95,6 +95,8 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  		buf[i] = be16_to_cpu(st->rx_buf[i]);
>  
>  	indio_dev->buffer->access->store_to(ring, (u8 *)buf, time_ns);
> +
> +done:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
>  	return IRQ_HANDLED;
> 
