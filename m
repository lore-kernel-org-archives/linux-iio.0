Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43239 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab3IJM5N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2013 08:57:13 -0400
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC driver
Date: Tue, 10 Sep 2013 14:58:27 +0200
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, fabio.estevam@freescale.com,
	jic23@cam.ac.uk
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de> <201309100936.14562.jbe@pengutronix.de> <201309101022.36637.marex@denx.de>
In-Reply-To: <201309101022.36637.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309101458.27604.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Tuesday 10 September 2013 10:22:36 Marek Vasut wrote:
> > On Monday 09 September 2013 18:04:19 Marek Vasut wrote:
> > > > Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC
> > > > at least for the 4 wire touchscreen.
> > > >
> > > > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > > > CC: linux-arm-kernel@lists.infradead.org
> > > > CC: devel@driverdev.osuosl.org
> > > > CC: Marek Vasut <marex@denx.de>
> > > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > > CC: Jonathan Cameron <jic23@cam.ac.uk>
> > >
> > > This patch seems to combine two things -- register access rework AND
> > > adjustment of the driver for MX23 touchscreen.
> >
> > It reworks the register access to avoid the i.MX23/i.MX28 runtime
> > decision all over the code again and again. This is what Dan has
> > recommended in his comment.
>
> Sure, but this change should be separated from fixing the touchscreen
> support then.

Hmm, but there is no need to rework the register access until the i.MX23 
touchscreen support is added. So this patch does both at the same time.

> > > Btw the MX23 ADC was already supported,
> >
> > No. This patch is the first in this series which brings in the specific
> > register bits, because the ADC units in the i.MX23 and i.MX28 differ.
> >
> > > so this "add i.MX23 support" commit message is not accurate.
> >
> > Hmmm, what else do you think should I write?
>
> You're just correcting the touchscreen support, no ?

Okay, will change the subject.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
