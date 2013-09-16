Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41548 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab3IPOdr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 10:33:47 -0400
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 16:34:54 +0200
Cc: linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, fabio.estevam@freescale.com,
	jic23@cam.ac.uk, Torokhov <dmitry.torokhov@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	Otavio Salvador <otavio.salvador@gmail.com>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <201309161010.22151.jbe@pengutronix.de> <201309161623.48247.marex@denx.de>
In-Reply-To: <201309161623.48247.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309161634.54603.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Monday 16 September 2013 16:23:48 Marek Vasut wrote:
> > On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
> > > On 09/11/13 09:18, Juergen Beisert wrote:
> > > > For battery driven systems it is a very bad idea to collect the
> > > > touchscreen data within a kernel busy loop.
> > > >
> > > > This change uses the features of the hardware to delay and accumulate
> > > > samples in hardware to avoid a high interrupt and CPU load.
> > > >
> > > > Note: this is only tested on an i.MX23 SoC yet.
> > > >
> > > > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > > > CC: linux-arm-kernel@lists.infradead.org
> > > > CC: devel@driverdev.osuosl.org
> > > > CC: Marek Vasut <marex@denx.de>
> > > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > > CC: Jonathan Cameron <jic23@cam.ac.uk>
> > >
> > > While this driver is placed in IIO within staging at the moment, these
> > > changes are definitely input related.  Hence I have cc'd Dmitry and the
> > > input list.
> > >
> > > I am personaly a little uncomfortable that we have such a complex bit
> > > of input code sat within an IIO driver but such is life.
> >
> > Maybe an MFD for this ADC unit would be a better way to go? Currently I
> > have a different problem with this driver, because the ADC unit monitors
> > the battery as well. And the charging driver from the power subsystem
> > needs these values to charge the battery in a correct manner.
>
> Are you planning to post the power block patches too ?

When they will work: yes. Currently it crashes all the time. The PMIC is a 
beast...

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
