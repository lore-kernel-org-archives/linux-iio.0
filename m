Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48176 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752662Ab3FXRrN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 24 Jun 2013 13:47:13 -0400
Date: Mon, 24 Jun 2013 19:47:12 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: add ds1077 programmable oscillator driver
In-Reply-To: <51C87806.5000700@metafoo.de>
Message-ID: <alpine.DEB.2.01.1306241932420.13960@pmeerw.net>
References: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net> <51C87806.5000700@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

> Hm, I wonder where we should draw the line between what should be
> implemented as a IIO driver and what should be implemented as a clk API
> driver. This one looks like it actually belongs into the clk framework.

several IIO drivers have overlap with other kernel subsystems

I think the 'line' depends on the intended use/application of the driver, 
not so much on characteristics of the hardware; why do you think it 
belongs to clk?

the ds1077 is a small, separate chip which can generate a frequency; using 
IIO I can easily control that frequency from userspace

clk seems to be targetted more at integrated clocksources that get 
activated automatically when needed by other components (maybe I am wrong)

regards, p.

> > ---
> >  drivers/iio/frequency/Kconfig        |  10 +
> >  drivers/iio/frequency/Makefile       |   1 +
> >  drivers/iio/frequency/ds1077.c       | 425 +++++++++++++++++++++++++++++++++++
> >  include/linux/iio/frequency/ds1077.h |  22 ++
> >  4 files changed, 458 insertions(+)
> >  create mode 100644 drivers/iio/frequency/ds1077.c
> >  create mode 100644 include/linux/iio/frequency/ds1077.h
> > 
> [...}
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
