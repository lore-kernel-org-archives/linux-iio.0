Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/5] Staging/iio/adc/touchscreen/MXS: separate i.MX28 specific register bits
Date: Thu, 5 Sep 2013 09:13:13 +0200
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 Marek Vasut <marex@denx.de>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 Jonathan Cameron <jic23@cam.ac.uk>
References: <1378299706-6742-1-git-send-email-jbe@pengutronix.de> <1378299706-6742-3-git-send-email-jbe@pengutronix.de> <20130904143624.GI6329@mwanda>
In-Reply-To: <20130904143624.GI6329@mwanda>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309050913.13349.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Dan,

On Wednesday 04 September 2013 16:36:24 Dan Carpenter wrote:
> On Wed, Sep 04, 2013 at 03:01:43PM +0200, Juergen Beisert wrote:
> > +#define	LRADC_CTRL0_MX28_PLATE_MASK \
> > +		LRADC_CTRL0_MX28_YNNSW | LRADC_CTRL0_MX28_YPNSW | \
> > +		LRADC_CTRL0_MX28_YPPSW | LRADC_CTRL0_MX28_XNNSW | \
> > +		LRADC_CTRL0_MX28_XNPSW | LRADC_CTRL0_MX28_XPPSW
>
> Put parenthesis are this macro.

Good catch. Thanks.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
