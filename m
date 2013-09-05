Return-Path: <marex@denx.de>
From: Marek Vasut <marex@denx.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/5] Staging/iio/adc/touchscreen/MXS: add i.MX23 support to the LRADC driver
Date: Thu, 5 Sep 2013 12:51:39 +0200
Cc: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org,
 devel@driverdev.osuosl.org,
 Fabio Estevam <fabio.estevam@freescale.com>,
 linux-iio@vger.kernel.org,
 Jonathan Cameron <jic23@cam.ac.uk>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de> <201309051216.18305.jbe@pengutronix.de> <20130905104256.GK6329@mwanda>
In-Reply-To: <20130905104256.GK6329@mwanda>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309051251.39877.marex@denx.de>
List-ID: <linux-iio@vger.kernel.org>

Dear Dan Carpenter,

> On Thu, Sep 05, 2013 at 12:16:18PM +0200, J=FCrgen Beisert wrote:
> > I like this simplification, but all the other drivers for the MXS series
> > of SoCs don't use such a method. Do you think this "new style" will be
> > accepted?
>=20
> My lradc_plate_mask() is basically the same idea as what Marek said
> about putting the logic into the define.
>=20
> LRADC....IRQ_MASK(id) (((id) =3D=3D MX23) ? 0x1ff : 0x1fff)
>=20
> I don't know why Marek is complaining about churn though.  This is
> linux!  We love churn!  And especially in staging, it's our favorite
> thing.  :P

About time to move this driver out of staging then ;-)

Best regards,
Marek Vasut
