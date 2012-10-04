Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41592 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab2JDLvk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Oct 2012 07:51:40 -0400
Message-ID: <506D783F.5040509@free-electrons.com>
Date: Thu, 04 Oct 2012 13:51:27 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: remove useless irq_enabled variable in at91
References: <1348875157-7793-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1348875157-7793-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

You can add my
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Le 29/09/2012 01:32, Peter Meerwald a écrit :
> irq_enabled is only set, but never read
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: maxime.ripard@free-electrons.com
> ---
>  drivers/iio/adc/at91_adc.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 3ed94bf..b3ba8af 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -46,7 +46,6 @@ struct at91_adc_state {
>  	struct clk		*clk;
>  	bool			done;
>  	int			irq;
> -	bool			irq_enabled;
>  	u16			last_value;
>  	struct mutex		lock;
>  	u8			num_channels;
> @@ -85,7 +84,6 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  	buffer->access->store_to(buffer, (u8 *)st->buffer);
>  
>  	iio_trigger_notify_done(idev->trig);
> -	st->irq_enabled = true;
>  
>  	/* Needed to ACK the DRDY interruption */
>  	at91_adc_readl(st, AT91_ADC_LCDR);
> @@ -106,7 +104,6 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
>  
>  	if (iio_buffer_enabled(idev)) {
>  		disable_irq_nosync(irq);
> -		st->irq_enabled = false;
>  		iio_trigger_poll(idev->trig, iio_get_time_ns());
>  	} else {
>  		st->last_value = at91_adc_readl(st, AT91_ADC_LCDR);
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
