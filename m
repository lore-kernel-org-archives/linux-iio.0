Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35142 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbETXEQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2015 19:04:16 -0400
Received: by igbyr2 with SMTP id yr2so115418463igb.0
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2015 16:04:16 -0700 (PDT)
Date: Wed, 20 May 2015 18:04:09 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB touch screen and ADC interactions
Message-ID: <20150520230409.GA21360@deathray>
References: <20150513011137.GA23255@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D113@sfamail.SAKURAUS.LOCAL>
 <20150519230932.GA15718@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D46F@sfamail.SAKURAUS.LOCAL>
 <F4A1ABDE-E030-405D-A0BB-A4CD80E9F84F@ieee.org>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D47E@sfamail.SAKURAUS.LOCAL>
 <20150520003435.GA16055@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D53C@sfamail.SAKURAUS.LOCAL>
 <20150520221417.GA21017@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D549@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D549@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 20, 2015 at 03:41:03PM -0700, Greg Wilson-Lindberg wrote:
> Hi Michael, 
> 
> > -----Original Message-----
> > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> > Of Michael Welling
> > Sent: Wednesday, May 20, 2015 3:14 PM
> > To: Greg Wilson-Lindberg
> > Cc: linux-iio@vger.kernel.org
> > Subject: Re: BBB touch screen and ADC interactions
> > 
> > On Wed, May 20, 2015 at 02:54:35PM -0700, Greg Wilson-Lindberg wrote:
> > > Hi Michael,
> > > I've applied your patch and the mouse clicks now work 
> > mostly, and I even saw one touch screen click that worked.
> > > 
> > 
> > This is not promising. Perhaps you are accessing the ADC to 
> > quickly for it to be available for the touchscreen.
> 
> I'm setting up a buffer of 1024 elements, and I'm currently reading it every second in my test code. There isn't any way that I see of changing the update frequency, would using a smaller buffer decrease the update rate?
>

The buffer size does not effect the frequency the trigger does.
 
> > 
> > > I only need to read the ADC infrequently so I guess I'll 
> > set it up to enable when I need to read the ADC and then 
> > disable again.
> > > 
> > > Do you know if I can set up the context, device and 
> > channels and then just enable the channels, do the scan, and 
> > then disable the channels until I need them again, without 
> > tearing down the channels, device and context?
> > >
> > 
> > I think you can just enable and disable the buffer.
> > 
> > To disable:
> > echo 0 > /sys/bus/iio/devices/iio:device0/buffer/disable

It should be /sys/bus/iio/devices/iio:device0/buffer/enable above.

Sorry about that.

> > or
> > http://lxr.free-electrons.com/source/drivers/staging/iio/Docum
> entation/generic_buffer.c#L337
> > 
> > To enable:
> > echo 1 > /sys/bus/iio/devices/iio:device0/buffer/enable
> > or
> > http://lxr.free-electrons.com/source/drivers/staging/iio/Docum
> entation/generic_buffer.c#L280
> 
> I'll try this and see if it works.

It should.

> 
> -Greg
> > 
> > > Regards,
> > > Greg
> > > 
> > > 
> > > > -----Original Message-----
> > > > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of 
> > > > Michael Welling
> > > > Sent: Tuesday, May 19, 2015 5:35 PM
> > > > To: Greg Wilson-Lindberg
> > > > Cc: linux-iio@vger.kernel.org
> > > > Subject: Re: BBB touch screen and ADC interactions
> > > > 
> > > > On Tue, May 19, 2015 at 05:16:46PM -0700, Greg 
> > Wilson-Lindberg wrote:
> > > > > 
> > > > > I would be happy to test the patch, better than what I was
> > > > going to try.
> > > > > 
> > > > > -Greg
> > > > 
> > > > Below is the simple workaround patch that I used to eliminate the 
> > > > repeated release events that were occurring without touching the 
> > > > screen.
> > > > 
> > > > See if it helps.
> > > > 
> > > > diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > b/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > index 191a1b8..f876097 100644
> > > > --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> > > > @@ -281,13 +281,11 @@ static irqreturn_t titsc_irq(int 
> > irq, void *dev)
> > > >  	if (status & IRQENB_PENUP) {
> > > >  		fsm = titsc_readl(ts_dev, REG_ADCFSM);
> > > >  		if (fsm == ADCFSM_STEPID) {
> > > > -			ts_dev->pen_down = false;
> > > >  			input_report_key(input_dev, BTN_TOUCH, 0);
> > > >  			input_report_abs(input_dev, ABS_PRESSURE, 0);
> > > >  			input_sync(input_dev);
> > > > -		} else {
> > > > -			ts_dev->pen_down = true;
> > > >  		}
> > > > +		ts_dev->pen_down = false;
> > > >  		irqclr |= IRQENB_PENUP;
> > > >  	}
> > > >  
> > > > 
> > 
