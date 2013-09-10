Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC driver
Date: Tue, 10 Sep 2013 23:21:16 +0200
Cc: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 fabio.estevam@freescale.com,
 jic23@cam.ac.uk
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de> <201309100936.14562.jbe@pengutronix.de> <20130910205444.GB6329@mwanda>
In-Reply-To: <20130910205444.GB6329@mwanda>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309102321.16382.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Dan Carpenter,

> On Tue, Sep 10, 2013 at 09:36:14AM +0200, J=FCrgen Beisert wrote:
> > > This patch seems to combine two things -- register access rework AND
> > > adjustment of the driver for MX23 touchscreen.
> >=20
> > It reworks the register access to avoid the i.MX23/i.MX28 runtime
> > decision all over the code again and again. This is what Dan has
> > recommended in his comment.
>=20
> I thought the same as Marek that it would be better as two patches like
> the one I sent, but I was also willing to let it slide if no one else
> complained.

Looks like Jurgen can now start cursing me ;-)

Best regards,
Marek Vasut
