Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:40808 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbbETVyy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 May 2015 17:54:54 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Wed, 20 May 2015 14:54:35 -0700
Subject: RE: BBB touch screen and ADC interactions
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D53C@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL>
 <20150513011137.GA23255@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D113@sfamail.SAKURAUS.LOCAL>
 <20150519230932.GA15718@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D46F@sfamail.SAKURAUS.LOCAL>
 <F4A1ABDE-E030-405D-A0BB-A4CD80E9F84F@ieee.org>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D47E@sfamail.SAKURAUS.LOCAL>
 <20150520003435.GA16055@deathray>
In-Reply-To: <20150520003435.GA16055@deathray>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,
I've applied your patch and the mouse clicks now work mostly, and I even saw one touch screen click that worked.

I only need to read the ADC infrequently so I guess I'll set it up to enable when I need to read the ADC and then disable again.

Do you know if I can set up the context, device and channels and then just enable the channels, do the scan, and then disable the channels until I need them again, without tearing down the channels, device and context?

Regards,
Greg


> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Tuesday, May 19, 2015 5:35 PM
> To: Greg Wilson-Lindberg
> Cc: linux-iio@vger.kernel.org
> Subject: Re: BBB touch screen and ADC interactions
> 
> On Tue, May 19, 2015 at 05:16:46PM -0700, Greg Wilson-Lindberg wrote:
> > 
> > I would be happy to test the patch, better than what I was 
> going to try.
> > 
> > -Greg
> 
> Below is the simple workaround patch that I used to eliminate 
> the repeated release events that were occurring without 
> touching the screen.
> 
> See if it helps.
> 
> diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c 
> b/drivers/input/touchscreen/ti_am335x_tsc.c
> index 191a1b8..f876097 100644
> --- a/drivers/input/touchscreen/ti_am335x_tsc.c
> +++ b/drivers/input/touchscreen/ti_am335x_tsc.c
> @@ -281,13 +281,11 @@ static irqreturn_t titsc_irq(int irq, void *dev)
>  	if (status & IRQENB_PENUP) {
>  		fsm = titsc_readl(ts_dev, REG_ADCFSM);
>  		if (fsm == ADCFSM_STEPID) {
> -			ts_dev->pen_down = false;
>  			input_report_key(input_dev, BTN_TOUCH, 0);
>  			input_report_abs(input_dev, ABS_PRESSURE, 0);
>  			input_sync(input_dev);
> -		} else {
> -			ts_dev->pen_down = true;
>  		}
> +		ts_dev->pen_down = false;
>  		irqclr |= IRQENB_PENUP;
>  	}
>  
> 