Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:18245
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752118Ab3DUHSX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Apr 2013 03:18:23 -0400
Date: Sun, 21 Apr 2013 15:18:41 +0800
From: Shawn Guo <shawn.guo@linaro.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Denis Darwish <darwish.d.d@gmail.com>,
	<linux-iio@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>
Subject: Re: [PATCH v2] iio: basic ADC support for Freescale i.MX25
Message-ID: <20130421071838.GB10647@S2101-09.ap.freescale.net>
References: <516FCEBC.7080000@gmail.com>
 <5172CCDA.2020304@metafoo.de>
 <20130421063705.GD32299@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20130421063705.GD32299@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Apr 21, 2013 at 08:37:05AM +0200, Sascha Hauer wrote:
> > >  arch/arm/mach-imx/clk-imx25.c                  |    2 +-
> > >  arch/arm/mach-imx/devices/Kconfig              |    4 +
> > >  arch/arm/mach-imx/devices/Makefile             |    1 +
> > >  arch/arm/mach-imx/devices/devices-common.h     |    2 +
> > >  arch/arm/mach-imx/devices/platform-imx25-adc.c |   27 +
> 
> I don't know Shawns take on this, but I think we are beyond the point
> where we add new platform devices. New boards should use devicetree
> which is sufficiently well supported on i.MX25.

I agree that we should stop adding new stuff that will only be used by
board files, since we are killing board files with device tree support.

Shawn

