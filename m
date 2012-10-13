Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45658 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2JMJkw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 05:40:52 -0400
Message-ID: <50793724.5020408@kernel.org>
Date: Sat, 13 Oct 2012 10:40:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: use iio_push_to_buffer() in at91 driver
References: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net> <1350115595-7107-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1350115595-7107-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/13/2012 09:06 AM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Ate this up in the multiple buffers patch series, but cleaner history to
do it with this patch then change it again.

Added to togreg branch of iio.git
> ---
>  drivers/iio/adc/at91_adc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index b3ba8af..2e2c9a8 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -81,7 +81,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  		*timestamp = pf->timestamp;
>  	}
>  
> -	buffer->access->store_to(buffer, (u8 *)st->buffer);
> +	iio_push_to_buffer(buffer, st->buffer);
>  
>  	iio_trigger_notify_done(idev->trig);
>  
> 
