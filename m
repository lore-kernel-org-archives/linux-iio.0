Return-Path: <ludovic.desroches@atmel.com>
Date: Tue, 5 Jan 2016 14:18:05 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>, Jonathan Cameron
	<jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<plagnioj@jcrosoft.com>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/5] iio:adc:at91_adc8xx: introduce new atmel adc driver
Message-ID: <20160105131805.GE2334@odux.rfo.atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
 <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
 <56799798.203@kernel.org>
 <20151223102700.GC2789@odux.rfo.atmel.com>
 <20151223104833.GE2789@odux.rfo.atmel.com>
 <E2C27D1A-1035-4330-AEF3-C72B87C27FEF@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <E2C27D1A-1035-4330-AEF3-C72B87C27FEF@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>

On Wed, Dec 23, 2015 at 05:21:25PM +0000, Jonathan Cameron wrote:
> 
> 
> On 23 December 2015 10:48:33 GMT+00:00, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> >On Wed, Dec 23, 2015 at 11:27:00AM +0100, Ludovic Desroches wrote:
> >> On Tue, Dec 22, 2015 at 06:34:00PM +0000, Jonathan Cameron wrote:
> >> > On 21/12/15 09:24, Ludovic Desroches wrote:
> >> > > This driver supports the new version of the Atmel ADC device
> >introduced
> >> > > with the SAMA5D2 SoC family.
> >> > > 
> >
> >[...]
> >
> >> > > +static irqreturn_t at91_adc_interrupt(int irq, void *private)
> >> > > +{
> >> > > +	struct iio_dev *indio = private;
> >> > > +	struct at91_adc_state *st = iio_priv(indio);
> >> > > +	u32 status = at91_adc_readl(st, ADC_ISR);
> >> > > +
> >> > > +	status &= at91_adc_readl(st, ADC_IMR);
> >> > > +	if (status & 0xFFF) {
> >> > > +		st->last_value = at91_adc_readl(st, st->chan->address);
> >> > If this is a polled read - is there any reason to read this value
> >here
> >> > rather than outside the interrupt?
> >> 
> >> No it can be done outside the interrupt. I have taken some parts from
> >the
> >> previous driver but it was reading a register used by all the
> >channels
> >> when it has been designed. So yes there is probably no more reason to
> >> read it into the interrupt.
> >> 
> >
> >Thinking about it. Is it really useful to move reading outside the
> >interrupt?
> It avoids needing to know the channel in here, hence simplifying the code a bit.

I am not sure it will simplify the code since the interrupt is cleared
when reading the conversion not the interrupt status register.

> >
> >By the way this is not a polled read.
> I meant that it is an individually requested conversion rather than a free running
>  sampling system where the value read might change before it is read out.
> >
> >> > > +		st->done = true;
> >> > > +		wake_up_interruptible(&st->wq_data_available);
> >> > > +	}
> >> > > +
> >> > > +	return IRQ_HANDLED;
> >> > > +}
> >
> >Ludovic
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
