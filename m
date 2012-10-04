Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41766 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755643Ab2JDL7g (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Oct 2012 07:59:36 -0400
Message-ID: <506D7A1E.8080303@free-electrons.com>
Date: Thu, 04 Oct 2012 13:59:26 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: use iio_push_to_buffer() in at91 driver
References: <1348875157-7793-1-git-send-email-pmeerw@pmeerw.net> <1348875157-7793-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1348875157-7793-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

You can add my
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Le 29/09/2012 01:32, Peter Meerwald a écrit :
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: maxime.ripard@free-electrons.com
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


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
