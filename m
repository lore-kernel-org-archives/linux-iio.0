Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46885 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab2GJKpY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jul 2012 06:45:24 -0400
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Tue, 10 Jul 2012 12:45:22 +0200
Cc: linux-arm-kernel@lists.infradead.org,
	"Lars-Peter Clausen" <lars@metafoo.de>, linux-iio@vger.kernel.org
References: <1341368129-20468-1-git-send-email-marex@denx.de> <4FFC056B.7020106@metafoo.de> <201207101241.24151.jbe@pengutronix.de>
In-Reply-To: <201207101241.24151.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201207101245.23047.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Juergen Beisert,

[...]

> > >> But wait, you're getting interrupts on channel 0. Doesn't seem quite
> > >> right. Did you happen to poke into the code and see where the issue
> > >> might be?
> > > 
> > > No yet. But if you think this is not the intended behaviour of your
> > > driver I will do a deeper look.
> > 
> > I don't know the hardware, but from what I've seen in the driver this
> > behavior looks correct. When reading a physical channel the channel will
> > be mapped to the first free virtual channel, afterward it is unmapped
> > again.
> 
> Makes sense.
> 
> > So if you are only reading a single channel it will always be mapped to
> > first virtual channel. If you'd be using buffered mode and read multiple
> > channels at once you'll probably get multiple interrupts on different
> > virtual channels.
> 
> So, the driver's behaviour is intended. Sorry for the noise.

Heh, my own driver confused me. I really better get back to this thing, I even 
have the touchscreen part in the works. Sorry for the confusion.

> Regards,
> Juergen

Best regards,
Marek Vasut
