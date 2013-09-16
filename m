Return-Path: <jbe@pengutronix.de>
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/6] Staging/iio/adc/touchscreen/MXS: simplify register access
Date: Mon, 16 Sep 2013 10:17:31 +0200
Cc: Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org,
 marex@denx.de,
 fabio.estevam@freescale.com,
 jic23@cam.ac.uk
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <1378887511-24530-4-git-send-email-jbe@pengutronix.de> <52358D71.2040905@kernel.org>
In-Reply-To: <52358D71.2040905@kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309161017.31846.jbe@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sunday 15 September 2013 12:35:29 Jonathan Cameron wrote:
> [...]
> > +static void mxs_lradc_reg_set(struct mxs_lradc *lradc, u32 val, u32 re=
g)
> > +{
> > +	writel(val, lradc->base + reg + STMP_OFFSET_REG_SET);
> > +}
> > +
> > +static void mxs_lradc_reg_clear(struct mxs_lradc *lradc, u32 val, u32 =
reg)
> > +{=20
> > +	writel(val, lradc->base + reg + STMP_OFFSET_REG_CLR);
> > +}
> > +
>
> mxs_lradc_reg_write might be clearer?

I would prefer the shorter name. Due to long macro names and long function=
=20
names the lines in the code below needs more and more line breaks which is=
=20
IMHO less helpfull to read the code.

Regards,
Juergen

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengutroni=
x.de/  |
