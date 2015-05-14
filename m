Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:54279 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbbENRAh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 May 2015 13:00:37 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 14 May 2015 10:00:14 -0700
Subject: RE: BBB touch screen and ADC interactions
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D113@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL>
 <20150513011137.GA23255@deathray>
In-Reply-To: <20150513011137.GA23255@deathray>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,

Sorry for the slow response to this email, I'm fighting with our IT on an email filtering system that is not delivering linux-iio emails to me. 

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Tuesday, May 12, 2015 6:12 PM
> To: Greg Wilson-Lindberg
> Cc: linux-iio@vger.kernel.org
> Subject: Re: BBB touch screen and ADC interactions
> 
> On Tue, May 12, 2015 at 04:23:43PM -0700, Greg Wilson-Lindberg wrote:
> > Hello all,
> > I've got a problem with the BeagleBone Black ti_am335x_tsc, 
> ti_am335x_adc & ti_am335x_tsadc drivers, and Jonathan Cameron 
> suggested that I reach out to this list to see if any one 
> here has any insight to my problem.
> >  
> > I'm using a BBB running a Debian Jessie build with the 
> 3.14.40 ti kernel by Robert C. Nelson. I've got it hooked up 
> to a touch screen and I would like to also be able to use 
> some of the remaining adc channels.
> >  
> > As soon as I try to read any of the remaining channels the 
> touch screen locks up. I've tried catting them from 
> /sys/bus/iio/devices/iio:device0/in_voltageX_raw, using the 
> generic_buffer program provided by the kernel, and using the 
> Analog Devices libiio library. In all cases, I get the same 
> results, adc values that look reasonable, but the touch 
> screen stops responding.
> >
> 
> Does the touchscreen freeze indefinitely or does it come back 
> after ADC sampling is stopped?

It is freezing indefinitely.
>   
> > I've asked on the TI support forum if they could help with 
> this problem, but their response was that they only supported 
> the TI SDK.
> >  
> > Can any of you tell me if the current iio subsystem will 
> work correctly with the ti touch screen and adc drivers? 
> >
> 
> I have been working on porting Linux to a device that uses 
> the AM335x and have noticed that the drivers has undergone 
> many changes recently. I am now using a 4.0 kernel and am 
> able to sample the ADC and use the touchscreen simultaneously.
> 
> When sampling the ADC you will notice that the touchscreen is 
> less responsive but it does not freeze. The responsiveness 
> comes back when ADC sampling stops.
> 
> One thing that I have noticed recently is that when using 
> ts_calibrate or ts_test the screen will register touch 
> releases repeatedly without touching the screen.
> 
> I have a workaround patch but have not attempted to push it 
> upstream yet.
> 
> So it won't freeze the touchscreen completely after sampling 
> ADCs but you still may notice some quirks.
> 
> The best way to find out is building the new kernel and trying it out.

I'll try out a new (4.0 - 4.1) kernel, but we are using QT to generate a GUI and I don't know if the graphics that we need have been ported to the mainline yet.  I guess I'll find out the hard way.

Thanks for the information,

Greg
> 
> > Greg Wilson-Lindberg
> > Sakura Finetek
> > 310-783-5075
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-iio" 
> > in the body of a message to majordomo@vger.kernel.org More 
> majordomo 
> > info at  http://vger.kernel.org/majordomo-info.html
> 
> 