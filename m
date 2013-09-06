Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 4/5] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Fri, 6 Sep 2013 14:30:50 +0200
Cc: linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 marex@denx.de,
 fabio.estevam@freescale.com,
 linux-arm-kernel@lists.infradead.org,
 jic23@cam.ac.uk
References: <1378462123-4830-1-git-send-email-jbe@pengutronix.de> <1378462123-4830-5-git-send-email-jbe@pengutronix.de> <20130906122611.GT6329@mwanda>
In-Reply-To: <20130906122611.GT6329@mwanda>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309061430.50736.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>


On Friday 06 September 2013 14:26:11 Dan Carpenter wrote:
> On Fri, Sep 06, 2013 at 12:08:42PM +0200, Juergen Beisert wrote:
> > +static int mxs_lradc_read_ts_channel(struct mxs_lradc *lradc)
> > +{
> > +	u32 reg;
> > +	int val;
> > +
> > +	reg =3D readl(lradc->base + LRADC_CTRL1);
> > +
> > +	/* only channels 3 to 5 are of interest here */
> > +	if (reg & LRADC_CTRL1_LRADC_IRQ(TS_CH_YP)) {
> > +		pr_devel("!3");
>
> Gar.  I meant to comment on this the first time this patch was sent.
>
> Please remove the pr_devel() calls.  They are nonsense.

They are very helpful for development to monitor the statemachine... :) But=
 you=20
are right, I will remove them.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
