Return-Path: <lars@metafoo.de>
Message-ID: <4FFB4EF7.9020803@metafoo.de>
Date: Mon, 09 Jul 2012 23:36:55 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/11] staging:iio:max1363: Do not return error code in
 interrupt handler
References: <1341418173-3217-1-git-send-email-lars@metafoo.de> <1341418173-3217-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/04/2012 06:09 PM, Lars-Peter Clausen wrote:
> The interrupt handler should only ever return one of the three irqreturn_t
> constants and not an error code. Also make sure to always call
> iio_trigger_notify_done before leaving the trigger handler.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Hm, looks like something went wrong here, I actually do have a different
patch in my local tree, this one will introduce a build warning...

> ---
>  drivers/staging/iio/adc/max1363_ring.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index b302013..bf6b0c2 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -64,11 +64,11 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  	 * no harm.
>  	 */
>  	if (numvals == 0)
> -		return IRQ_HANDLED;
> +		goto done;
>  
>  	rxbuf = kmalloc(d_size,	GFP_KERNEL);
>  	if (rxbuf == NULL)
> -		return -ENOMEM;
> +		goto done;
>  	if (st->chip_info->bits != 8)
>  		b_sent = i2c_master_recv(st->client, rxbuf, numvals*2);
>  	else
