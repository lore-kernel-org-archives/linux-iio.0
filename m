Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51201 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab2FZTCV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jun 2012 15:02:21 -0400
Received: by weyu7 with SMTP id u7so173766wey.19
        for <linux-iio@vger.kernel.org>; Tue, 26 Jun 2012 12:02:20 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
To: Juergen Beisert <jbe@pengutronix.de>, linux-iio@vger.kernel.org
Subject: Re: i.MX28 die temperature
Date: Tue, 26 Jun 2012 21:02:15 +0200
Cc: linux-arm-kernel@lists.infradead.org
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201206221919.57485.marek.vasut@gmail.com> <201206261012.13620.jbe@pengutronix.de>
In-Reply-To: <201206261012.13620.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201206262102.15698.marek.vasut@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Juergen Beisert,

> Hi Marek,
> 
> Marek Vasut wrote:
> > [...]
> > 
> > > > Take a look at: http://www.spinics.net/lists/linux-iio/msg04345.html
> > > 
> > > Any progress here with inclusion in some git tree?
> > 
> > Well ... I recently raised from the dead. It's on the schedule, obviously
> > help is welcome.
> 
> I tried a little bit with your driver. The disadvantage I see is, its
> claims all the free AD channels. But a few of them can also act as a
> touchscreen controller. Shouldn't be the driver handle the channel usage
> dynamically?

I wonder, I'd rather see this driver behave as a composite driver, what do you 
think?

> Also this AD module on the SoC can measure the die
> temperature, battery voltage and some other power supplies.
> I see more than one framework this driver should connect to: simple ADC
> (IIO), touchscreen controller (INPUT), die temp (POWER?), various voltages
> (POWER? REGULATOR?). Should it be a multi function device?

Correct, making it a MFD device with common channel-management logic is the way 
to go. And it's gonna be a few resends of this driver, that's for certain. I'm 
not confident I'll be able to make it right at the first try ;-)

INPUT -- touchscreen
IIO -- die temp and LRADC (maybe random voltages?)
POWER -- battery

But all this MFD goo is quite simple, the hard part is the channel management 
logic. From the top of my head, there're 16 channels, 8 can be sampled at the 
same time and there are 4 configuration triggers. Making it one hell of a 
complex hardware.

I'll fix the remnants of SPI and start on this beast tonight or tomorrow. Since 
there was some progress in the IIO, I believe I'll have to rework it a bit.

> Juergen

Best regards,
Marek Vasut
