Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [12.26.104.5] ([12.26.104.5]:25711 "EHLO sfamail.SAKURAUS.LOCAL"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752305AbbHSQcO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Aug 2015 12:32:14 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 19 Aug 2015 09:27:02 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD43DF@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD40FB@sfamail.SAKURAUS.LOCAL>
 <20150814204016.GA7070@deathstar> <20150814234606.GA4286@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42B1@sfamail.SAKURAUS.LOCAL>
 <20150818162851.GA27380@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42C4@sfamail.SAKURAUS.LOCAL>
 <20150818173703.GA5096@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42D8@sfamail.SAKURAUS.LOCAL>
 <20150818181324.GC5096@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4340@sfamail.SAKURAUS.LOCAL>
 <20150818223114.GA1372@deathstar>
In-Reply-To: <20150818223114.GA1372@deathstar>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Tuesday, August 18, 2015 3:31 PM
> To: Greg Wilson-Lindberg
> Cc: Daniel Baluta; linux-iio@vger.kernel.org
> Subject: Re: BBB IIO ADC access not working
> 
> On Tue, Aug 18, 2015 at 03:11:13PM -0700, Greg Wilson-Lindberg wrote:
> >  
> > 
> > > I found that handling the IRQENB_EOS interrupt in the ADC 
> is causing 
> > > an undesired effect. After enabling the ADC buffer mode and 
> > > disabling it the coordinate readings work but the touch 
> release is 
> > > no longer detected.
> > 
> > Can we put your code in the touch screen handler? The tsc 
> code is writing to the IRQSTATUS register, not the IRQCLR register.
> > 
> 
> Actually using the IRQCLR disables the IRQ instead of 
> clearing it and that was not my intent. This is why the pen 
> releases where not working, the tsc driver relies on the EOS 
> interrupt to write the step register because it is using a 
> one shot hardware mode.
> 
> Since the IRQENB_EOS is not used by the ADC driver it can be 
> disabled when in buffered mode which is triggering faster 
> than the isr can handle it.
> 
> See patch below.
> 
> Though it allows for the repeated enabling and disabling of 
> the buffer the touchscreen gets a bunch of unexpected 
> releases and the readings are very jittery.
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c 
> b/drivers/iio/adc/ti_am335x_adc.c index a0e7161..9945e4a 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -177,6 +177,7 @@ static int tiadc_buffer_preenable(struct 
> iio_dev *indio_dev)
>  				IRQENB_FIFO1OVRRUN |
>  				IRQENB_FIFO1UNDRFLW));
>  
> +	tiadc_writel(adc_dev, REG_IRQCLR, IRQENB_EOS);
>  	/* Flush FIFO. Needed in corner cases in simultaneous 
> tsc/adc use */
>  	fifo1count = tiadc_readl(adc_dev, REG_FIFO1CNT);
>  	for (i = 0; i < fifo1count; i++)
> @@ -213,6 +214,7 @@ static int tiadc_buffer_predisable(struct 
> iio_dev *indio_dev)
>  
>  	tiadc_writel(adc_dev, REG_IRQCLR, (IRQENB_FIFO1THRES |
>  				IRQENB_FIFO1OVRRUN | 
> IRQENB_FIFO1UNDRFLW));
> +	tiadc_writel(adc_dev, REG_IRQENABLE, IRQENB_EOS);
>  	am335x_tsc_se_clr(adc_dev->mfd_tscadc, 
> adc_dev->buffer_en_ch_steps);
>  	adc_dev->buffer_en_ch_steps = 0;
>  
> 

I'm not sure that it's better, but it is different.  The touch screen still locks up, but mouse clicks work.

> 
> 
> 