Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC driver
Date: Wed, 11 Sep 2013 09:06:57 +0200
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 Marek Vasut <marex@denx.de>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 fabio.estevam@freescale.com,
 jic23@cam.ac.uk
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de> <201309100936.14562.jbe@pengutronix.de> <20130910205444.GB6329@mwanda>
In-Reply-To: <20130910205444.GB6329@mwanda>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309110906.57373.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>


On Tuesday 10 September 2013 22:54:44 Dan Carpenter wrote:
> On Tue, Sep 10, 2013 at 09:36:14AM +0200, J=FCrgen Beisert wrote:
> > > This patch seems to combine two things -- register access rework AND
> > > adjustment of the driver for MX23 touchscreen.
> >
> > It reworks the register access to avoid the i.MX23/i.MX28 runtime
> > decision all over the code again and again. This is what Dan has
> > recommended in his comment.
>
> I thought the same as Marek that it would be better as two patches like
> the one I sent, but I was also willing to let it slide if no one else
> complained.

Okay, new (re-worked) patch series will follow.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
