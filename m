Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:32874 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbHSRwk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2015 13:52:40 -0400
Received: by iods203 with SMTP id s203so18057569iod.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2015 10:52:40 -0700 (PDT)
Date: Wed, 19 Aug 2015 12:52:31 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB IIO ADC access not working
Message-ID: <20150819175230.GA29773@deathstar>
References: <20150814234606.GA4286@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42B1@sfamail.SAKURAUS.LOCAL>
 <20150818162851.GA27380@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42C4@sfamail.SAKURAUS.LOCAL>
 <20150818173703.GA5096@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42D8@sfamail.SAKURAUS.LOCAL>
 <20150818181324.GC5096@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4340@sfamail.SAKURAUS.LOCAL>
 <20150818223114.GA1372@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD43DF@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD43DF@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 19, 2015 at 09:27:02AM -0700, Greg Wilson-Lindberg wrote:
>  
> 
> > -----Original Message-----
> > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> > Of Michael Welling
> > Sent: Tuesday, August 18, 2015 3:31 PM
> > To: Greg Wilson-Lindberg
> > Cc: Daniel Baluta; linux-iio@vger.kernel.org
> > Subject: Re: BBB IIO ADC access not working
> > 
> > On Tue, Aug 18, 2015 at 03:11:13PM -0700, Greg Wilson-Lindberg wrote:
> > >  
> > > 
> > > > I found that handling the IRQENB_EOS interrupt in the ADC 
> > is causing 
> > > > an undesired effect. After enabling the ADC buffer mode and 
> > > > disabling it the coordinate readings work but the touch 
> > release is 
> > > > no longer detected.
> > > 
> > > Can we put your code in the touch screen handler? The tsc 
> > code is writing to the IRQSTATUS register, not the IRQCLR register.
> > > 
> > 
> > Actually using the IRQCLR disables the IRQ instead of 
> > clearing it and that was not my intent. This is why the pen 
> > releases where not working, the tsc driver relies on the EOS 
> > interrupt to write the step register because it is using a 
> > one shot hardware mode.
> > 
> > Since the IRQENB_EOS is not used by the ADC driver it can be 
> > disabled when in buffered mode which is triggering faster 
> > than the isr can handle it.
> > 
> > See patch below.
> > 
> > Though it allows for the repeated enabling and disabling of 
> > the buffer the touchscreen gets a bunch of unexpected 
> > releases and the readings are very jittery.
> > 
> > diff --git a/drivers/iio/adc/ti_am335x_adc.c 
> > b/drivers/iio/adc/ti_am335x_adc.c index a0e7161..9945e4a 100644
> > --- a/drivers/iio/adc/ti_am335x_adc.c
> > +++ b/drivers/iio/adc/ti_am335x_adc.c
> > @@ -177,6 +177,7 @@ static int tiadc_buffer_preenable(struct 
> > iio_dev *indio_dev)
> >  				IRQENB_FIFO1OVRRUN |
> >  				IRQENB_FIFO1UNDRFLW));
> >  
> > +	tiadc_writel(adc_dev, REG_IRQCLR, IRQENB_EOS);
> >  	/* Flush FIFO. Needed in corner cases in simultaneous 
> > tsc/adc use */
> >  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
> >  	for (i = 0; i < fifo1count; i++)
> > @@ -213,6 +214,7 @@ static int tiadc_buffer_predisable(struct 
> > iio_dev *indio_dev)
> >  
> >  	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
> >  				IRQENB_FIFO1OVRRUN | 
> > IRQENB_FIFO1UNDRFLW));
> > +	tiadc_writel(adc_dev, REG_IRQENABLE, IRQENB_EOS);
> >  	am335x_tsc_se_clr(adc_dev->mfd_tscadc, 
> > adc_dev->buffer_en_ch_steps);
> >  	adc_dev->buffer_en_ch_steps = 0;
> >  
> > 
> 
> I'm not sure that it's better, but it is different.  The touch screen still locks up, but mouse clicks work.

This is very disappointing.

Have you tried reading the ADCs using one shot mode recently?

IE cat /sys/bus/iio/devices/iio:device0/in_voltageX_raw

> 
> > 
> > 
> > 
