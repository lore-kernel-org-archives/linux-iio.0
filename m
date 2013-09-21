Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56973 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255Ab3IULTM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:19:12 -0400
Message-ID: <523D8ED4.3060607@kernel.org>
Date: Sat, 21 Sep 2013 13:19:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH 22/24] staging:iio:mxs-lradc: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-22-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-22-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/adc/mxs-lradc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 7401230..9da64bf 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -625,13 +625,7 @@ static irqreturn_t mxs_lradc_trigger_handler(int irq, void *p)
>  		j++;
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
>  
> 
