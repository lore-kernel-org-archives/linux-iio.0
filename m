Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37197 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701AbcBIKfS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 05:35:18 -0500
Received: by mail-wm0-f45.google.com with SMTP id g62so17118813wme.0
        for <linux-iio@vger.kernel.org>; Tue, 09 Feb 2016 02:35:17 -0800 (PST)
Date: Tue, 9 Feb 2016 10:35:13 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Denis Carikli <denis@eukrea.com>,
	Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fabio Estevam <festevam@gmail.com>,
	Juergen Borleis <jbe@pengutronix.de>
Subject: Re: [PATCH v10 4/8] mfd: fsl imx25 Touchscreen ADC driver
Message-ID: <20160209103513.GC24522@x1>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de>
 <1450101234-2191-5-git-send-email-mpa@pengutronix.de>
 <20160111065441.GW3331@x1>
 <6151166.y0HMDdqtvF@adelgunde>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <6151166.y0HMDdqtvF@adelgunde>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 02 Feb 2016, Markus Pargmann wrote:

> Hi,
> 
> On Monday, January 11, 2016 06:54:41 AM Lee Jones wrote:
> > On Mon, 14 Dec 2015, Markus Pargmann wrote:
> > 
> > > This is the core driver for imx25 touchscreen/adc driver. The module
> > > has one shared ADC and two different conversion queues which use the
> > > ADC. The two queues are identical. Both can be used for general purpose
> > > ADC but one is meant to be used for touchscreens.
> > > 
> > > This driver is the core which manages the central components and
> > > registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> > > the correct components.
> > > 
> > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > 
> > > [ensure correct ADC clock depending on the IPG clock]
> > > Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> > > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > > ---
> > > 
> > > Notes:
> > >     Changes in v7:
> > >      - Cleanup bit defines in header files to be more readable
> > >      - Fix irq check to return with an error for irq <= 0
> > >      - Add COMPILE_TEST in Kconfig file
> > >     
> > >     Changes in v5:
> > >      - Remove ifdef CONFIG_OF as this driver is only for DT usage
> > >      - Remove module owner
> > >      - Add Kconfig dependencies ARCH_MX25 and OF
> > > 
> > >  drivers/mfd/Kconfig             |   9 ++
> > >  drivers/mfd/Makefile            |   2 +
> > >  drivers/mfd/fsl-imx25-tsadc.c   | 203 ++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/mfd/imx25-tsadc.h | 140 +++++++++++++++++++++++++++
> > >  4 files changed, 354 insertions(+)
> > >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> > >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> > 
> > For my own reference:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > 
> > I will apply this and sent out pull-requests to the relevant
> > maintainers once -rc1 is out.
> 
> Thanks. Do you mean just this patch or the whole series?

I will take all of the /driver patches.  The ARM patches need to go in
through ARM-SoC via the relevant sub-arch maintainer(s).

> Shall I resend the whole series to fix the commit title of the first
> patch?

No, that's fine.  I'll handle that *this time*.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
