Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC driver
Date: Tue, 10 Sep 2013 09:36:14 +0200
Cc: Marek Vasut <marex@denx.de>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 fabio.estevam@freescale.com,
 jic23@cam.ac.uk
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de> <1378713801-1182-4-git-send-email-jbe@pengutronix.de> <201309091804.20177.marex@denx.de>
In-Reply-To: <201309091804.20177.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309100936.14562.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Marek,

On Monday 09 September 2013 18:04:19 Marek Vasut wrote:
> > Distinguish i.MX23 and i.MX28 at runtime and do the same for both SoC at
> > least for the 4 wire touchscreen.
> >
> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: devel@driverdev.osuosl.org
> > CC: Marek Vasut <marex@denx.de>
> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > CC: Jonathan Cameron <jic23@cam.ac.uk>
>
> This patch seems to combine two things -- register access rework AND
> adjustment of the driver for MX23 touchscreen.

It reworks the register access to avoid the i.MX23/i.MX28 runtime decision =
all=20
over the code again and again. This is what Dan has recommended in his=20
comment.

> Btw the MX23 ADC was already supported,

No. This patch is the first in this series which brings in the specific=20
register bits, because the ADC units in the i.MX23 and i.MX28 differ.

> so this "add i.MX23 support" commit message is not accurate.

Hmmm, what else do you think should I write?

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
