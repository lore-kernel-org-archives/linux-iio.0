Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57184 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab3DUGhN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Apr 2013 02:37:13 -0400
Date: Sun, 21 Apr 2013 08:37:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Denis Darwish <darwish.d.d@gmail.com>, linux-iio@vger.kernel.org,
	Sascha Hauer <kernel@pengutronix.de>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] iio: basic ADC support for Freescale i.MX25
Message-ID: <20130421063705.GD32299@pengutronix.de>
References: <516FCEBC.7080000@gmail.com>
 <5172CCDA.2020304@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5172CCDA.2020304@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 20, 2013 at 07:14:02PM +0200, Lars-Peter Clausen wrote:
> Hi,
> 
> Looks much better than v1 :) Only a few minor things left
> 
> 
> On 04/18/2013 12:45 PM, Denis Darwish wrote:
> > From: Denis Darwish <darwish.d.d@gmail.com>
> > 
> > This patch adds basic support for Freescale i.MX25 ADC in the IIO Subsystem.
> > 
> > Signed-off-by: Denis Darwish <darwish.d.d@gmail.com>
> > ---
> >  I want to thank Lars-Peter Clausen for a detailed review.
> > 
> >  Functionality tested with linux 3.8.0 and linux-next.
> >  IIO_BUFFER and IIO_TRIGGER unsupported
> >  Changes since v1:
> >  + end of conversion IRQ support
> >  * cleanup debug info messages, vars etc.
> >  * all definitions put into c file
> >  * iio_chan_spec statically initialized
> >  * get resources in modern way (clk, iomem etc)
> > 
> >  arch/arm/mach-imx/clk-imx25.c                  |    2 +-
> >  arch/arm/mach-imx/devices/Kconfig              |    4 +
> >  arch/arm/mach-imx/devices/Makefile             |    1 +
> >  arch/arm/mach-imx/devices/devices-common.h     |    2 +
> >  arch/arm/mach-imx/devices/platform-imx25-adc.c |   27 +

I don't know Shawns take on this, but I think we are beyond the point
where we add new platform devices. New boards should use devicetree
which is sufficiently well supported on i.MX25.

> >  arch/arm/mach-imx/mx25.h                       |    2 +
> >  drivers/iio/adc/Kconfig                        |    7 +
> >  drivers/iio/adc/Makefile                       |    1 +
> >  drivers/iio/adc/imx25_adc.c                    |  639 ++++++++++++++++++++++++
> 
> This should be split into two patch, the first patch adding the IIO driver,
> the second one registering the platform device. Also make sure to put the
> imx maintainers on Cc.

Yes, at least the ARM Linux kernel Mailing List should be on Cc.

> > +			if (!ret)
> > +				return -EBUSY;
> > +
> > +		INIT_COMPLETION(st->completion);
> > +
> > +		imx_adc_set_chanel(st, chan->channel);

Chanel is a fashion and perfume vendor. I think you mean channel.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
