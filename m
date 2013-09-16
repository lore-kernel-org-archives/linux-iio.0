Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:59852 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518Ab3IPOXw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Sep 2013 10:23:52 -0400
From: Marek Vasut <marex@denx.de>
To: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 16:23:48 +0200
Cc: linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, fabio.estevam@freescale.com,
	jic23@cam.ac.uk, Torokhov <dmitry.torokhov@gmail.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	Otavio Salvador <otavio.salvador@gmail.com>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org> <201309161010.22151.jbe@pengutronix.de>
In-Reply-To: <201309161010.22151.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309161623.48247.marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Jürgen Beisert,

> Hi Jonathan,
> 
> On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
> > On 09/11/13 09:18, Juergen Beisert wrote:
> > > For battery driven systems it is a very bad idea to collect the
> > > touchscreen data within a kernel busy loop.
> > > 
> > > This change uses the features of the hardware to delay and accumulate
> > > samples in hardware to avoid a high interrupt and CPU load.
> > > 
> > > Note: this is only tested on an i.MX23 SoC yet.
> > > 
> > > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > > CC: linux-arm-kernel@lists.infradead.org
> > > CC: devel@driverdev.osuosl.org
> > > CC: Marek Vasut <marex@denx.de>
> > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > CC: Jonathan Cameron <jic23@cam.ac.uk>
> > 
> > While this driver is placed in IIO within staging at the moment, these
> > changes are definitely input related.  Hence I have cc'd Dmitry and the
> > input list.
> > 
> > I am personaly a little uncomfortable that we have such a complex bit of
> > input code sat within an IIO driver but such is life.
> 
> Maybe an MFD for this ADC unit would be a better way to go? Currently I
> have a different problem with this driver, because the ADC unit monitors
> the battery as well. And the charging driver from the power subsystem
> needs these values to charge the battery in a correct manner.

Are you planning to post the power block patches too ?

Best regards,
Marek Vasut
