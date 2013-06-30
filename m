Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:35744 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab3F3FsS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 30 Jun 2013 01:48:18 -0400
Date: Sun, 30 Jun 2013 07:48:14 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add ds1077 programmable oscillator driver
In-Reply-To: <51CEACD8.7070804@kernel.org>
Message-ID: <alpine.DEB.2.01.1306291659180.5368@pmeerw.net>
References: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net> <51C87806.5000700@metafoo.de> <alpine.DEB.2.01.1306241932420.13960@pmeerw.net> <51C8887D.4080406@metafoo.de> <51CEACD8.7070804@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> > But the usecase might differ from board to board and that's when you get a
> > problem. One user wants a clk driver another a IIO driver.

so because eventually someone might want a clk driver it is preferrable to 
have no driver at all?

> >> the ds1077 is a small, separate chip which can generate a frequency; using 
> >> IIO I can easily control that frequency from userspace
> >>
> >> clk seems to be targetted more at integrated clocksources that get 
> >> activated automatically when needed by other components (maybe I am wrong)

> > I think there is a userspace consumer for the clk API in the making.

are you referring to this? https://patchwork.kernel.org/patch/2551831/
I'm trying to figure out the status...

> Just to jump on the end of this conversation, sorry Peter but this one definitely
> looks to me like it belongs clk rather than IIO. If there wasn't a userspace
> API in the making, I'd suggest now was the time to propose one as you
> clearly have an application for one.

fine; so far no reasons were given
does that mean iio frequency is deprecated?
is there a fundamental difference between hardware supported in iio 
frequency and the ds1077?

thanks, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
