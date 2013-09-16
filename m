Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 10:10:22 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 marex@denx.de,
 fabio.estevam@freescale.com,
 jic23@cam.ac.uk,
 Torokhov <dmitry.torokhov@gmail.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-6-git-send-email-jbe@pengutronix.de> <52359259.8010202@kernel.org>
In-Reply-To: <52359259.8010202@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309161010.22151.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
> On 09/11/13 09:18, Juergen Beisert wrote:
> > For battery driven systems it is a very bad idea to collect the
> > touchscreen data within a kernel busy loop.
> >
> > This change uses the features of the hardware to delay and accumulate
> > samples in hardware to avoid a high interrupt and CPU load.
> >
> > Note: this is only tested on an i.MX23 SoC yet.
> >
> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > CC: linux-arm-kernel@lists.infradead.org
> > CC: devel@driverdev.osuosl.org
> > CC: Marek Vasut <marex@denx.de>
> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > CC: Jonathan Cameron <jic23@cam.ac.uk>
>
> While this driver is placed in IIO within staging at the moment, these
> changes are definitely input related.  Hence I have cc'd Dmitry and the
> input list.
>
> I am personaly a little uncomfortable that we have such a complex bit of
> input code sat within an IIO driver but such is life.

Maybe an MFD for this ADC unit would be a better way to go? Currently I hav=
e a=20
different problem with this driver, because the ADC unit monitors the batte=
ry=20
as well. And the charging driver from the power subsystem needs these value=
s=20
to charge the battery in a correct manner.

> [...]

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
