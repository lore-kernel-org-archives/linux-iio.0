Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:43794 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752419AbaICIfK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Sep 2014 04:35:10 -0400
Date: Wed, 3 Sep 2014 10:35:06 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	jic23@kernel.org, josh.wu@atmel.com, nicolas.ferre@atmel.com,
	maxime.ripard@free-electrons.com
Subject: Re: [RESEND PATCH] iio: adc: at91: don't use the last converted data
 register
Message-ID: <20140903083506.GF10093@piout.net>
References: <1409726069-13054-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409726069-13054-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/2014 at 08:34:29 +0200, Ludovic Desroches wrote :
> If touchscreen mode is enabled and a conversion is requested on another
> channel, the result in the last converted data register can be a
> touchscreen relative value. Starting a conversion involves to do a
> conversion for all active channel. It starts with ADC channels and ends
> with touchscreen channels. Then if ADC_LCD register is not read quickly,
> its content may be a touchscreen conversion.
> To remove this temporal constraint, the conversion value is taken from
> the channel data register.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

I wondering whether we should get rid of drdy in the trigger path too.
Maybe this can be done in a follow-up patch. Else,

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
> 
> Sorry for the noise, there was a typo in the CC list.
> 
>  drivers/iio/adc/at91_adc.c |   14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 3b5bacd..dde22cb 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -196,6 +196,7 @@ struct at91_adc_state {
>  	bool			done;
>  	int			irq;
>  	u16			last_value;
> +	int			chnb;
>  	struct mutex		lock;
>  	u8			num_channels;
>  	void __iomem		*reg_base;
> @@ -274,7 +275,7 @@ void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
>  		disable_irq_nosync(irq);
>  		iio_trigger_poll(idev->trig, iio_get_time_ns());
>  	} else {
> -		st->last_value = at91_adc_readl(st, AT91_ADC_LCDR);
> +		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
>  		st->done = true;
>  		wake_up_interruptible(&st->wq_data_avail);
>  	}
> @@ -348,10 +349,11 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
>  	struct iio_dev *idev = private;
>  	struct at91_adc_state *st = iio_priv(idev);
>  	u32 status = at91_adc_readl(st, st->registers->status_register);
> +	const u32 eoc_mask = (1 << st->num_channels) - 1;
>  	unsigned int reg;
>  
>  	status &= at91_adc_readl(st, AT91_ADC_IMR);
> -	if (status & st->registers->drdy_mask)
> +	if (status & eoc_mask)
>  		handle_adc_eoc_trigger(irq, idev);
>  
>  	if (status & AT91RL_ADC_IER_PEN) {
> @@ -413,12 +415,13 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
>  	struct iio_dev *idev = private;
>  	struct at91_adc_state *st = iio_priv(idev);
>  	u32 status = at91_adc_readl(st, st->registers->status_register);
> +	const u32 eoc_mask = (1 << st->num_channels) - 1;
>  	const uint32_t ts_data_irq_mask =
>  		AT91_ADC_IER_XRDY |
>  		AT91_ADC_IER_YRDY |
>  		AT91_ADC_IER_PRDY;
>  
> -	if (status & st->registers->drdy_mask)
> +	if (status & eoc_mask)
>  		handle_adc_eoc_trigger(irq, idev);
>  
>  	if (status & AT91_ADC_IER_PEN) {
> @@ -689,9 +692,10 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&st->lock);
>  
> +		st->chnb = chan->channel;
>  		at91_adc_writel(st, AT91_ADC_CHER,
>  				AT91_ADC_CH(chan->channel));
> -		at91_adc_writel(st, AT91_ADC_IER, st->registers->drdy_mask);
> +		at91_adc_writel(st, AT91_ADC_IER, 1 << chan->channel);
>  		at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_START);
>  
>  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
> @@ -708,7 +712,7 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  
>  		at91_adc_writel(st, AT91_ADC_CHDR,
>  				AT91_ADC_CH(chan->channel));
> -		at91_adc_writel(st, AT91_ADC_IDR, st->registers->drdy_mask);
> +		at91_adc_writel(st, AT91_ADC_IDR, 1 << chan->channel);
>  
>  		st->last_value = 0;
>  		st->done = false;
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
