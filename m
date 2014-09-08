Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:59044 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaIHG5G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Sep 2014 02:57:06 -0400
Date: Mon, 8 Sep 2014 08:57:24 +0200
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>, <jic23@kernel.org>,
	<alexandre.belloni@free-electrons.com>, <josh.wu@atmel.com>,
	<nicolas.ferre@atmel.com>, <maxime.ripard@free-electrons.com>
Subject: Re: [RESEND PATCH] iio: adc: at91: don't use the last converted data
 register
Message-ID: <20140908065724.GE4434@ldesroches-Latitude-E6320>
References: <1409726069-13054-1-git-send-email-ludovic.desroches@atmel.com>
 <540B5470.2030404@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <540B5470.2030404@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Sep 06, 2014 at 08:37:36PM +0200, Hartmut Knaack wrote:
> Ludovic Desroches schrieb:
> > If touchscreen mode is enabled and a conversion is requested on another
> > channel, the result in the last converted data register can be a
> > touchscreen relative value. Starting a conversion involves to do a
> > conversion for all active channel. It starts with ADC channels and ends
> > with touchscreen channels. Then if ADC_LCD register is not read quickly,
> > its content may be a touchscreen conversion.
> > To remove this temporal constraint, the conversion value is taken from
> > the channel data register.
> I would recommend to drop eoc_mask and use GENMASK instead. Also, using BIT(chan->channel) would be a good idea.

Thanks for your advice, I'll use these macros for v2.

> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> >
> > Sorry for the noise, there was a typo in the CC list.
> >
> >  drivers/iio/adc/at91_adc.c |   14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 3b5bacd..dde22cb 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -196,6 +196,7 @@ struct at91_adc_state {
> >  	bool			done;
> >  	int			irq;
> >  	u16			last_value;
> > +	int			chnb;
> >  	struct mutex		lock;
> >  	u8			num_channels;
> >  	void __iomem		*reg_base;
> > @@ -274,7 +275,7 @@ void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
> >  		disable_irq_nosync(irq);
> >  		iio_trigger_poll(idev->trig, iio_get_time_ns());
> >  	} else {
> > -		st->last_value = at91_adc_readl(st, AT91_ADC_LCDR);
> > +		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
> >  		st->done = true;
> >  		wake_up_interruptible(&st->wq_data_avail);
> >  	}
> > @@ -348,10 +349,11 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
> >  	struct iio_dev *idev = private;
> >  	struct at91_adc_state *st = iio_priv(idev);
> >  	u32 status = at91_adc_readl(st, st->registers->status_register);
> > +	const u32 eoc_mask = (1 << st->num_channels) - 1;
> >  	unsigned int reg;
> >  
> >  	status &= at91_adc_readl(st, AT91_ADC_IMR);
> > -	if (status & st->registers->drdy_mask)
> > +	if (status & eoc_mask)
> >  		handle_adc_eoc_trigger(irq, idev);
> >  
> >  	if (status & AT91RL_ADC_IER_PEN) {
> > @@ -413,12 +415,13 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
> >  	struct iio_dev *idev = private;
> >  	struct at91_adc_state *st = iio_priv(idev);
> >  	u32 status = at91_adc_readl(st, st->registers->status_register);
> > +	const u32 eoc_mask = (1 << st->num_channels) - 1;
> >  	const uint32_t ts_data_irq_mask =
> >  		AT91_ADC_IER_XRDY |
> >  		AT91_ADC_IER_YRDY |
> >  		AT91_ADC_IER_PRDY;
> >  
> > -	if (status & st->registers->drdy_mask)
> > +	if (status & eoc_mask)
> >  		handle_adc_eoc_trigger(irq, idev);
> >  
> >  	if (status & AT91_ADC_IER_PEN) {
> > @@ -689,9 +692,10 @@ static int at91_adc_read_raw(struct iio_dev *idev,
> >  	case IIO_CHAN_INFO_RAW:
> >  		mutex_lock(&st->lock);
> >  
> > +		st->chnb = chan->channel;
> >  		at91_adc_writel(st, AT91_ADC_CHER,
> >  				AT91_ADC_CH(chan->channel));
> > -		at91_adc_writel(st, AT91_ADC_IER, st->registers->drdy_mask);
> > +		at91_adc_writel(st, AT91_ADC_IER, 1 << chan->channel);
> >  		at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_START);
> >  
> >  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
> > @@ -708,7 +712,7 @@ static int at91_adc_read_raw(struct iio_dev *idev,
> >  
> >  		at91_adc_writel(st, AT91_ADC_CHDR,
> >  				AT91_ADC_CH(chan->channel));
> > -		at91_adc_writel(st, AT91_ADC_IDR, st->registers->drdy_mask);
> > +		at91_adc_writel(st, AT91_ADC_IDR, 1 << chan->channel);
> >  
> >  		st->last_value = 0;
> >  		st->done = false;
> 
