Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:32852 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbbETARF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2015 20:17:05 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: "mwelling@ieee.org" <mwelling@ieee.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 19 May 2015 17:16:46 -0700
Subject: RE: BBB touch screen and ADC interactions
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D47E@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87CFA4@sfamail.SAKURAUS.LOCAL>
 <20150513011137.GA23255@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D113@sfamail.SAKURAUS.LOCAL>
 <20150519230932.GA15718@deathray>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3C87D46F@sfamail.SAKURAUS.LOCAL>
 <F4A1ABDE-E030-405D-A0BB-A4CD80E9F84F@ieee.org>
In-Reply-To: <F4A1ABDE-E030-405D-A0BB-A4CD80E9F84F@ieee.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Michael,

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of mwelling@ieee.org
> Sent: Tuesday, May 19, 2015 5:14 PM
> To: Greg Wilson-Lindberg
> Cc: linux-iio@vger.kernel.org
> Subject: RE: BBB touch screen and ADC interactions
> 
> 
> 
> On May 19, 2015 6:56:37 PM CDT, Greg Wilson-Lindberg 
> <GWilson@sakuraus.com> wrote:
> >Hi Michael,
> >
> >> -----Original Message-----
> >> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of 
> >> Michael Welling
> >> Sent: Tuesday, May 19, 2015 4:30 PM
> >> To: Greg Wilson-Lindberg
> >> Cc: linux-iio@vger.kernel.org
> >> Subject: Re: BBB touch screen and ADC interactions
> >> 
> >> On Thu, May 14, 2015 at 10:00:14AM -0700, Greg 
> Wilson-Lindberg wrote:
> >> > 
> >> > I'll try out a new (4.0 - 4.1) kernel, but we are using QT
> >> to generate a GUI and I don't know if the graphics that we 
> need have 
> >> been ported to the mainline yet.  I guess I'll find out 
> the hard way.
> >> >
> >> 
> >> Have you had any luck getting the new kernel to work?
> >> 
> >> I would like to know if you are experiencing the unexpected 
> >> release events that I experienced with the touchscreen.
> >> 
> >
> >I just got  the 4.1 kernel working today. Our application is running
> >just fine, so all of the QT stuff is working.
> >
> >I found that when running my IIO ADC read program on the 4.1 kernel,
> >not only do I lose the touch screen, but mouse clicks stop 
> working, and
> >the cursor periodically jumps.
> 
> This seems to be the same issue that I was experiencing.
> 
> I can forward the workaround patch when I get back to my PC.
> 
> >
> >I also figured out that I wasn't disabling the channels when my ADC
> >program exited. When I got it to properly exit and disable 
> the IIO ADC
> >channels, the mouse started working again.
> >
> >I then booted back to a 3.14 kernel and while the touch screen stops
> >working while I am reading the ADC channels, the mouse still works
> >normally, and the touch screen starts working again when the IIO
> >program exits.
> >
> >It appears, for me at least, that the 4.1 kernel is not an 
> improvement.
> >
> >I don't need fast reads on the ADC, I may be able to get away with
> >enabling the ADC channels, reading some values, and disabling them
> >again every once in a while.  I guess I'll have to try that.
> 
> I have been working on a qt demo that reads the adc and 
> displays a graph while the touchscreen is enabled. The 
> workaround patch must be necessary. 
> 
> Would you like to the workaround patch?

I would be happy to test the patch, better than what I was going to try.

-Greg
> 
> We can make a formal patch if it works for you.
> 
> >
> >- Greg
> >
> >> -Michael
> >>  
> >> > Thanks for the information,
> >> > 
> >> > Greg
> >> 
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
> 