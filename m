Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbeIYCEv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Sep 2018 22:04:51 -0400
Date: Mon, 24 Sep 2018 21:00:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: adc: at91: fix acking DRDY irq on simple
 conversions
Message-ID: <20180924210056.2cae9439@archlinux>
In-Reply-To: <9846e106-8baf-b491-29ca-8306be9527ee@microchip.com>
References: <1537447238-18674-1-git-send-email-eugen.hristev@microchip.com>
        <20180922113123.2c8da044@archlinux>
        <9846e106-8baf-b491-29ca-8306be9527ee@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 24 Sep 2018 09:19:43 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> On 22.09.2018 13:31, Jonathan Cameron wrote:
> > On Thu, 20 Sep 2018 15:40:37 +0300
> > Eugen Hristev <eugen.hristev@microchip.com> wrote:
> >   
> >> When doing simple conversions, the driver did not acknowledge the DRDY irq.
> >> If this irq is not acked, it will be left pending, and as soon as a trigger
> >> is enabled, the irq handler will be called, it doesn't know why this irq
> >> has occurred because no channel is pending, and then we will have irq loop
> >> and board will hang.
> >>
> >> Fixes 0e589d5fb ("ARM: AT91: IIO: Add AT91 ADC driver.")
> >> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >> ---
> >>   drivers/iio/adc/at91_adc.c | 5 +++++
> >>   1 file changed, 5 insertions(+)
> >>
> >> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> >> index 44b5168..e85f859 100644
> >> --- a/drivers/iio/adc/at91_adc.c
> >> +++ b/drivers/iio/adc/at91_adc.c
> >> @@ -712,6 +712,11 @@ static int at91_adc_read_raw(struct iio_dev *idev,
> >>   		at91_adc_writel(st, AT91_ADC_CHDR,
> >>   				AT91_ADC_CH(chan->channel));
> >>   		at91_adc_writel(st, AT91_ADC_IDR, BIT(chan->channel));
> >> +		/*
> >> +		 * we need to ack the DRDY irq, otherwise it will be
> >> +		 * left pending and irq handler will be confused
> >> +		 */
> >> +		at91_adc_readl(st, AT91_ADC_LCDR);  
> > 
> > I'm curious as to how things were working before.  Does this only occur
> > if we do a raw_read whilst the buffer is enabled?  
> 
> No. The situation is that the read raw does not properly cleans itself 
> up after it's done.
> The DRDY bit is cleared only when LCDR (last converted data ) is being read.
> Even if we read the per channel conversion data, the LCDR still needs to 
> be read to clear this irq status.
> The driver does not use the DRDY irq but this irq status is still being 
> set in the status register.

Hmm. That is somewhat nasty if it results in false interrupts when you
then enable them.

> 
> > 
> > I would have assumed when it's not enabled, the irq would be masked and
> > never generated in the first place...
> > 
> > It may be that what we actually need to do is to prevent read_raw accesses
> > when the buffer is enabled (like lots of other drivers do precisely to
> > avoid this sort of condition). The problem there comes if we have
> > existing applications doing this combination as we are then breaking
> > userspace. If that's the case we'll need to be a bit more clever.
> > 
> > Hammering down an irq state in a non irq handling path isn't a good
> > solution.  
> 
> Ok, I will move the clearing of the DRDY (LCDR read) in the irq path 
> then, and send a v2.

If that can be done cleanly, let us go with that approach. If not
what you have here with the addition of a comments saying that the
interrupt status is not masked, merely the interrupt and as a result needs
clearing for when you later enabled the interrupt, is fine.

This definitely sounds like one of those bits of hardware that
you can write software to use safely but they certainly didn't make
it easy to do so!

Jonathan
> 
> 
> > 
> > Jonathan
> >   
> >>   
> >>   		st->last_value = 0;
> >>   		st->done = false;  
> >   
