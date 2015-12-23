Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:56084 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbbLWKtQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Dec 2015 05:49:16 -0500
Date: Wed, 23 Dec 2015 11:48:33 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Jonathan Cameron <jic23@kernel.org>, <nicolas.ferre@atmel.com>,
	<alexandre.belloni@free-electrons.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <plagnioj@jcrosoft.com>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/5] iio:adc:at91_adc8xx: introduce new atmel adc driver
Message-ID: <20151223104833.GE2789@odux.rfo.atmel.com>
References: <1450689852-22763-1-git-send-email-ludovic.desroches@atmel.com>
 <1450689852-22763-2-git-send-email-ludovic.desroches@atmel.com>
 <56799798.203@kernel.org>
 <20151223102700.GC2789@odux.rfo.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20151223102700.GC2789@odux.rfo.atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Dec 23, 2015 at 11:27:00AM +0100, Ludovic Desroches wrote:
> On Tue, Dec 22, 2015 at 06:34:00PM +0000, Jonathan Cameron wrote:
> > On 21/12/15 09:24, Ludovic Desroches wrote:
> > > This driver supports the new version of the Atmel ADC device introduced
> > > with the SAMA5D2 SoC family.
> > > 

[...]

> > > +static irqreturn_t at91_adc_interrupt(int irq, void *private)
> > > +{
> > > +	struct iio_dev *indio = private;
> > > +	struct at91_adc_state *st = iio_priv(indio);
> > > +	u32 status = at91_adc_readl(st, ADC_ISR);
> > > +
> > > +	status &= at91_adc_readl(st, ADC_IMR);
> > > +	if (status & 0xFFF) {
> > > +		st->last_value = at91_adc_readl(st, st->chan->address);
> > If this is a polled read - is there any reason to read this value here
> > rather than outside the interrupt?
> 
> No it can be done outside the interrupt. I have taken some parts from the
> previous driver but it was reading a register used by all the channels
> when it has been designed. So yes there is probably no more reason to
> read it into the interrupt.
> 

Thinking about it. Is it really useful to move reading outside the
interrupt?

By the way this is not a polled read.

> > > +		st->done = true;
> > > +		wake_up_interruptible(&st->wq_data_available);
> > > +	}
> > > +
> > > +	return IRQ_HANDLED;
> > > +}

Ludovic
