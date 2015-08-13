Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:51188 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbbHMXAQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2015 19:00:16 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 13 Aug 2015 16:00:08 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4046@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
 <CAEnQRZAwD+s0C4et9OTeWrwaq3ZDy3+g0YT_KKMUst_PM31DyA@mail.gmail.com>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB09132@sfamail.SAKURAUS.LOCAL>
 <20150806180730.GA1360@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB0937F@sfamail.SAKURAUS.LOCAL>
 <20150810223338.GA23548@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DB3@sfamail.SAKURAUS.LOCAL>
 <20150811170233.GA1872@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DD8@sfamail.SAKURAUS.LOCAL>
 <20150811174347.GA7777@deathstar>
In-Reply-To: <20150811174347.GA7777@deathstar>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Michael, 

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Tuesday, August 11, 2015 10:44 AM
> To: Greg Wilson-Lindberg
> Cc: Michael Welling; Daniel Baluta; linux-iio@vger.kernel.org
> Subject: Re: BBB IIO ADC access not working
> 
> On Tue, Aug 11, 2015 at 10:08:39AM -0700, Greg Wilson-Lindberg wrote:
> > Hi Michael,
> > 
> > > -----Original Message-----
> > > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of 
> > > Michael Welling
> > > Sent: Tuesday, August 11, 2015 10:03 AM
> > > To: Greg Wilson-Lindberg
> > > Cc: Michael Welling; Daniel Baluta; linux-iio@vger.kernel.org
> > > Subject: Re: BBB IIO ADC access not working
> > > 
> > > On Tue, Aug 11, 2015 at 09:00:21AM -0700, Greg 
> Wilson-Lindberg wrote:
> > > > Hello Michael,
> > > > 
> > > > .....
> > > > > Try increasing the charge-delay and see if you can 
> find a value 
> > > > > where it stops happening.
> > > > > 
> > > > > Something tells me that it won't fix the issue.
> > > > > 
> > > > > Where is the source tree for this kernel?
> > > > > Which dtb are you using?
> > > > >  
> > > > 
> > > > I increased the charge-delay to 0x10000 and left the system
> > > over night
> > > > with no user interaction and it was locked up this morning, I 
> > > > think I'm going to have to agree that changing that to a larger
> > > number will not fix the problem.
> > > > 
> > > > Here is a link to the dts that we use:
> > > > http://pastebin.com/5nU27sML
> > > > I did not include the standard dtsi files that we 
> include from the 
> > > > linux source tree, just the files that we built ourselves
> > > or that we modified.
> > > 
> > > I do not see the modification that you made to the touchscreen 
> > > registration.
> > 
> > We haven't modified the touch screen registration, we use 
> xinput_calibrator for the calibration.
> > > 
> > > Guessing you modified this file for the charge-delay:
> > > https://github.com/beagleboard/linux/blob/3.14.40-ti-r62/arch/
> > > arm/boot/dts/am335x-bone-ti-tscadc-4-wire.dtsi
> > 
> > And you are correct, I forgot that I had added the charge-delay 
> > parameter to the am335x-bone-ti-tscadc-4-wire.dtsi file, sorry.
> > 
> > > 
> > > > 
> > > > RCN replied thusly to my request for the source tree:
> > > >    Here's the kernel source, the config we use is 
> "bb.org_defconfig"
> > > >    https://github.com/beagleboard/linux/tree/3.14.40-ti-r62
> > > > 
> > > > Thanks for your help in tracking down this problem.
> > > 
> > > I will compare the drivers in this kernel to the latest 
> work in the 
> > > mainline.
> 
> Looking at the commit logs, I see no mention of this type of 
> behavior in either kernel.
> 
> 
> Here is something that never landed in the mainline kernel:
> https://github.com/beagleboard/linux/commit/e655e2f723a4e78a47
> 868f766e4c141deca5e234
> 
> Have you tried a more recent kernel release to see if this 
> behavior is still occurring?

I tried a current debian release from RCN with kernel 4.1, touch screen
and mouse still locked up.

Regards,
Greg

> 
> > > 
> > > > 
> > > > Regards,
> > > > Greg
> > > 
> 