Return-Path: <jbe@pengutronix.de>
From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Thu, 19 Sep 2013 14:49:37 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 marex@denx.de,
 fabio.estevam@freescale.com,
 jic23@cam.ac.uk,
 Torokhov <dmitry.torokhov@gmail.com>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <201309161010.22151.jbe@pengutronix.de> <0fb59809-c835-49b0-bd82-e791db1a9db7@email.android.com>
In-Reply-To: <0fb59809-c835-49b0-bd82-e791db1a9db7@email.android.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201309191449.37274.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Monday 16 September 2013 17:30:32 Jonathan Cameron wrote:
> >On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
> >> On 09/11/13 09:18, Juergen Beisert wrote:
> >> > For battery driven systems it is a very bad idea to collect the
> >> > touchscreen data within a kernel busy loop.
> >> >
> >> > This change uses the features of the hardware to delay and
> >> > accumulate samples in hardware to avoid a high interrupt and CPU loa=
d.
> >> >
> >> > Note: this is only tested on an i.MX23 SoC yet.
> >> >
> >> > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> >> > CC: linux-arm-kernel@lists.infradead.org
> >> > CC: devel@driverdev.osuosl.org
> >> > CC: Marek Vasut <marex@denx.de>
> >> > CC: Fabio Estevam <fabio.estevam@freescale.com>
> >> > CC: Jonathan Cameron <jic23@cam.ac.uk>
> >>
> >> While this driver is placed in IIO within staging at the moment,
> >> these changes are definitely input related.  Hence I have cc'd Dmitry =
and
> >> the input list.
> >>
> >> I am personaly a little uncomfortable that we have such a complex bit
> >> of input code sat within an IIO driver but such is life.
> >
> > Maybe an MFD for this ADC unit would be a better way to go?
>
> That would be great and is definitely the preferred method.

Cannot continue to convert the driver into an MFD device. The project does =
not=20
give me the time to do so.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Beisert =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Linux Solutions for Science and Industry =C2=A0 =C2=A0 =C2=A0| http://www.p=
engutronix.de/  |
