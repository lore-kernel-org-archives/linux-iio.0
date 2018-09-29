Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbeI2R7S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Sep 2018 13:59:18 -0400
Date: Sat, 29 Sep 2018 12:31:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Eugen Hristev <eugen.hristev@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
Message-ID: <20180929123107.0d0053e3@archlinux>
In-Reply-To: <20180925131739.2nuoelhqmkszamqo@M43218.corp.atmel.com>
References: <1537775504-7981-1-git-send-email-eugen.hristev@microchip.com>
        <20180925131739.2nuoelhqmkszamqo@M43218.corp.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 25 Sep 2018 15:17:39 +0200
Ludovic Desroches <ludovic.desroches@microchip.com> wrote:

> On Mon, Sep 24, 2018 at 10:51:43AM +0300, Eugen Hristev wrote:
> > When doing simple conversions, the driver did not acknowledge the DRDY irq.
> > If this irq status is not acked, it will be left pending, and as soon as a
> > trigger is enabled, the irq handler will be called, it doesn't know why
> > this status has occurred because no channel is pending, and then it will go
> > int a irq loop and board will hang.
> > To avoid this situation, read the LCDR after a raw conversion is done.
> > 
> > Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>  
> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> 
Applied to the togreg branch of iio.git and marked for stable.

It's been broken long enough that I think it can wait for the merge window
coming in a few weeks time.

Thanks,

Jonathan

> 
> > ---
> > Hello Jonathan,
> > 
> > I moved this LCDR read/acknowledge into the IRQ handler after the conversion
> > value is being read.
> > Sorry about the noise to stable@vger, removed from message.
> > 
> > Thanks,
> > Eugen
> > 
> >  drivers/iio/adc/at91_adc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index 44b5168..e3be88e 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -279,6 +279,8 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
> >  		iio_trigger_poll(idev->trig);
> >  	} else {
> >  		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
> > +		/* Needed to ACK the DRDY interruption */
> > +		at91_adc_readl(st, AT91_ADC_LCDR);
> >  		st->done = true;
> >  		wake_up_interruptible(&st->wq_data_avail);
> >  	}
> > -- 
> > 2.7.4
> >   
