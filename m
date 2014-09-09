Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:65222 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508AbaIIVy4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 9 Sep 2014 17:54:56 -0400
Message-ID: <540F771D.5040106@gmx.de>
Date: Tue, 09 Sep 2014 23:54:37 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Ludovic Desroches <ludovic.desroches@atmel.com>,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
CC: jic23@kernel.org, alexandre.belloni@free-electrons.com,
	josh.wu@atmel.com, nicolas.ferre@atmel.com,
	maxime.ripard@free-electrons.com
Subject: Re: [PATCH v2] iio: adc: at91: don't use the last converted data
 register
References: <1410165631-8688-1-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1410165631-8688-1-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Ludovic Desroches schrieb, Am 08.09.2014 10:40:
> If touchscreen mode is enabled and a conversion is requested on another
> channel, the result in the last converted data register can be a
> touchscreen relative value. Starting a conversion involves to do a
> conversion for all active channel. It starts with ADC channels and ends
> with touchscreen channels. Then if ADC_LCD register is not read quickly,
> its content may be a touchscreen conversion.
> To remove this temporal constraint, the conversion value is taken from
> the channel data register.
> 
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
> 
> Changes from v1:
> - use GENMASK and BIT macros
> 
>  drivers/iio/adc/at91_adc.c |   12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 3b5bacd..1812d12 100644
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
> @@ -351,7 +352,7 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
>  	unsigned int reg;
>  
>  	status &= at91_adc_readl(st, AT91_ADC_IMR);
> -	if (status & st->registers->drdy_mask)
> +	if (status & GENMASK(st->num_channels, 0))
You need to use st->num_channels - 1, since GENMASK starts counting from bit position 0.
>  		handle_adc_eoc_trigger(irq, idev);
>  
>  	if (status & AT91RL_ADC_IER_PEN) {
> @@ -418,7 +419,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
>  		AT91_ADC_IER_YRDY |
>  		AT91_ADC_IER_PRDY;
>  
> -	if (status & st->registers->drdy_mask)
> +	if (status & GENMASK(st->num_channels, 0))
Same here.
>  		handle_adc_eoc_trigger(irq, idev);
>  
>  	if (status & AT91_ADC_IER_PEN) {
> @@ -689,9 +690,10 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&st->lock);
>  
> +		st->chnb = chan->channel;
>  		at91_adc_writel(st, AT91_ADC_CHER,
>  				AT91_ADC_CH(chan->channel));
> -		at91_adc_writel(st, AT91_ADC_IER, st->registers->drdy_mask);
> +		at91_adc_writel(st, AT91_ADC_IER, BIT(chan->channel));
>  		at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_START);
>  
>  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
> @@ -708,7 +710,7 @@ static int at91_adc_read_raw(struct iio_dev *idev,
>  
>  		at91_adc_writel(st, AT91_ADC_CHDR,
>  				AT91_ADC_CH(chan->channel));
> -		at91_adc_writel(st, AT91_ADC_IDR, st->registers->drdy_mask);
> +		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
>  
>  		st->last_value = 0;
>  		st->done = false;
> 

