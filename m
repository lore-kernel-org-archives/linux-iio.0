Return-Path: <ludovic.desroches@atmel.com>
Date: Wed, 10 Sep 2014 13:53:29 +0200
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<jic23@kernel.org>, <alexandre.belloni@free-electrons.com>,
	<josh.wu@atmel.com>, <nicolas.ferre@atmel.com>,
	<maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2] iio: adc: at91: don't use the last converted data
 register
Message-ID: <20140910115329.GO4434@ldesroches-Latitude-E6320>
References: <1410165631-8688-1-git-send-email-ludovic.desroches@atmel.com>
 <540F771D.5040106@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <540F771D.5040106@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

On Tue, Sep 09, 2014 at 11:54:37PM +0200, Hartmut Knaack wrote:
> Ludovic Desroches schrieb, Am 08.09.2014 10:40:
> > If touchscreen mode is enabled and a conversion is requested on another
> > channel, the result in the last converted data register can be a
> > touchscreen relative value. Starting a conversion involves to do a
> > conversion for all active channel. It starts with ADC channels and ends
> > with touchscreen channels. Then if ADC_LCD register is not read quickly,
> > its content may be a touchscreen conversion.
> > To remove this temporal constraint, the conversion value is taken from
> > the channel data register.
> > 
> > Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > 
> > Changes from v1:
> > - use GENMASK and BIT macros
> > 
> >  drivers/iio/adc/at91_adc.c |   12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 3b5bacd..1812d12 100644
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
> > @@ -351,7 +352,7 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
> >  	unsigned int reg;
> >  
> >  	status &= at91_adc_readl(st, AT91_ADC_IMR);
> > -	if (status & st->registers->drdy_mask)
> > +	if (status & GENMASK(st->num_channels, 0))
> You need to use st->num_channels - 1, since GENMASK starts counting from bit position 0.

Right, thanks to catch it, I was thinking channel number instead of
number of channels when writing it...

> >  		handle_adc_eoc_trigger(irq, idev);
> >  
> >  	if (status & AT91RL_ADC_IER_PEN) {
> > @@ -418,7 +419,7 @@ static irqreturn_t at91_adc_9x5_interrupt(int irq, void *private)
> >  		AT91_ADC_IER_YRDY |
> >  		AT91_ADC_IER_PRDY;
> >  
> > -	if (status & st->registers->drdy_mask)
> > +	if (status & GENMASK(st->num_channels, 0))
> Same here.
> >  		handle_adc_eoc_trigger(irq, idev);
> >  
> >  	if (status & AT91_ADC_IER_PEN) {
> > @@ -689,9 +690,10 @@ static int at91_adc_read_raw(struct iio_dev *idev,
> >  	case IIO_CHAN_INFO_RAW:
> >  		mutex_lock(&st->lock);
> >  
> > +		st->chnb = chan->channel;
> >  		at91_adc_writel(st, AT91_ADC_CHER,
> >  				AT91_ADC_CH(chan->channel));
> > -		at91_adc_writel(st, AT91_ADC_IER, st->registers->drdy_mask);
> > +		at91_adc_writel(st, AT91_ADC_IER, BIT(chan->channel));
> >  		at91_adc_writel(st, AT91_ADC_CR, AT91_ADC_START);
> >  
> >  		ret = wait_event_interruptible_timeout(st->wq_data_avail,
> > @@ -708,7 +710,7 @@ static int at91_adc_read_raw(struct iio_dev *idev,
> >  
> >  		at91_adc_writel(st, AT91_ADC_CHDR,
> >  				AT91_ADC_CH(chan->channel));
> > -		at91_adc_writel(st, AT91_ADC_IDR, st->registers->drdy_mask);
> > +		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
> >  
> >  		st->last_value = 0;
> >  		st->done = false;
> > 
> 
