Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:52141 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759Ab2GIKDP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jul 2012 06:03:15 -0400
From: Marek Vasut <marex@denx.de>
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Mon, 9 Jul 2012 12:03:09 +0200
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207091119.44952.jbe@pengutronix.de>
In-Reply-To: <201207091119.44952.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201207091203.09371.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Juergen Beisert,

> Hi Marek,
> 
> Marek Vasut wrote:
> > This driver is very basic. It supports userland trigger, buffer and
> > raw access to channels. The support for delay channels is missing
> > altogether.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Wolfgang Denk <wd@denx.de>
> > Cc: Juergen Beisert <jbe@pengutronix.de>
> > ---
> > 
> >  drivers/staging/iio/adc/Kconfig     |   12 +
> >  drivers/staging/iio/adc/Makefile    |    1 +
> >  drivers/staging/iio/adc/mxs-lradc.c |  619
> >  +++++++++++++++++++++++++++++++++++ 3 files changed, 632 insertions(+)
> >  create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
> > 
> > [...]
> 
> sorry for the delay, too much work at the same time.

You tell me.

> When I try to compile
> your code I get:
> 
> drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> linux/iio/triggered_buffer.h: No such file or directory

You need this patches:
    iio:kfifo_buf Take advantage of the fixed record size used in IIO
    iio: kfifo - add poll support.

And use latest -next.

> 
> Regards,
> Juergen

Best regards,
Marek Vasut
