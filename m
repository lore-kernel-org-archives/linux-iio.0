Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6/9] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Tue, 1 Oct 2013 11:28:38 +0200
Cc: linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 marex@denx.de,
 fabio.estevam@freescale.com,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 jic23@cam.ac.uk,
 linux-input@vger.kernel.org
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-7-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1379946998-23041-7-git-send-email-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201310011128.38928.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Tuesday 01 October 2013 11:25:46 Jonathan Cameron wrote:
> a couple of the patch descriptions say that they are untested on i.MX28.

On Monday 23 September 2013 16:36:35 Juergen Beisert wrote:
> For battery driven systems it is a very bad idea to collect the touchscre=
en
> data within a kernel busy loop.
>
> This change uses the features of the hardware to delay and accumulate
> samples in hardware to avoid a high interrupt and CPU load.
>
> Note: this is only tested on an i.MX23 SoC yet.

This note is no longer true. Marek tested it on his M28EVK, Lothar on his T=
X28=20
and myself also on an i.MX28EVK.

=46or the IIO part of the driver I tested on my i.MX23 based ChumbyOne and =
some=20
customer hardware and it seems still to work (I can only guess if the value=
s I=20
read from the sysfs entries are correct, sorry).

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
