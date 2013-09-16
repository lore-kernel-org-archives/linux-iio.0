Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH 25/27] staging:iio:mxs-lradc: Use iio_push_to_buffers_with_timestamp()
Date: Mon, 16 Sep 2013 15:53:34 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 Fabio Estevam <fabio.estevam@freescale.com>
References: <1379263880-18405-1-git-send-email-lars@metafoo.de> <1379263880-18405-25-git-send-email-lars@metafoo.de>
In-Reply-To: <1379263880-18405-25-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201309161553.34371.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Lars-Peter Clausen,

> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Marek Vasut <marex@denx.de>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c
> b/drivers/staging/iio/adc/mxs-lradc.c index 7401230..9da64bf 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -625,13 +625,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq,
> void *p) j++;
>  	}
> 
> -	if (iio->scan_timestamp) {
> -		s64 *timestamp = (s64 *)((u8 *)lradc->buffer +
> -					ALIGN(j, sizeof(s64)));
> -		*timestamp = pf->timestamp;
> -	}
> -
> -	iio_push_to_buffers(iio, lradc->buffer);
> +	iio_push_to_buffers_with_timestamp(iio, lradc->buffer, pf->timestamp);
> 
>  	iio_trigger_notify_done(iio->trig);

Indeed, this stuff was duplicated all around.

Best regards,
Marek Vasut
