Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:49908 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab3GERjY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 13:39:24 -0400
From: Marek Vasut <marex@denx.de>
To: "Lars-Peter Clausen" <lars@metafoo.de>
Subject: Re: [PATCH 2/4] iio: mxs-lradc: add scale attribute to channels
Date: Fri, 5 Jul 2013 19:39:21 +0200
Cc: Hector Palacios <hector.palacios@digi.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <201307051859.01095.marex@denx.de> <51D6FDA7.5010301@metafoo.de>
In-Reply-To: <51D6FDA7.5010301@metafoo.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201307051939.21455.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Lars-Peter Clausen,

> On 07/05/2013 06:59 PM, Marek Vasut wrote:
> [...]
> 
> >>> Should the above not be in DT ?
> >> 
> >> Do you mean for example:
> >> 	lradc@80050000 {
> >> 	
> >> 		compatible = "fsl,imx28-lradc";
> >> 		reg = <0x80050000 0x2000>;
> >> 		interrupts = <10 14 15 16 17 18 19
> >> 		
> >> 				20 21 22 23 24 25>;
> >> 		
> >> 		vref = <1850 1850 1850 1850
> >> 		
> >> 			1850 1850 1850 7400
> >> 			1850 1850 3700 1850
> >> 			3700 1850 1850 7400>
> >> 	
> >> 	};
> >> 
> >> I'm ok with it, but are there other examples of driver using a similar
> >> 
> >> approach? I see for example the spear-adc which reads:
> >> 	Optional properties:
> >> 	- vref-external: External voltage reference in milli-volts. If omitted
> >> 	
> >> 	  the internal voltage reference will be used.
> >> 
> >> which makes me believe the 'internal voltage reference' is hardcoded in
> >> the driver. More opinions?
> > 
> > I'd duke this one out on devicetree-discuss@ list. In general, I'd use
> > something like fsl,vref prop, but this really better be discussed in a
> > separate thread.
> > 
> > On the other hand, I'd hate to keep these patches here waiting , so maybe
> > we should apply them as-is and remove this part from the driver in a
> > subsequent patch? What do you say, Lars ?
> 
> I'd leave it as it is. I don't see much point in putting them into the
> devicetree, it would have made sense if the scales were board specific.

They are CPU specific, therefore if we have a new CPU with different scale setup 
(again), we will need to add another table here. That's why I'd vouch for having 
them in DT. As we already saw in the past, FSL did merge some MX23/28 components 
into MX53 and MX6Q.

Best regards,
Marek Vasut
