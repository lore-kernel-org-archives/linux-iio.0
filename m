Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53327 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbA3HUf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Jan 2015 02:20:35 -0500
Date: Fri, 30 Jan 2015 08:20:16 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Lothar =?utf-8?Q?Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	linux-iio@vger.kernel.org, Kumar Gala <galak@codeaurora.org>,
	Denis Carikli <denis@eukrea.com>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-input@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 4/8] mfd: fsl imx25 Touchscreen ADC driver
Message-ID: <20150130072016.GA16879@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
 <1422540556-14828-5-git-send-email-mpa@pengutronix.de>
 <20150130074324.3e4d868f@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <20150130074324.3e4d868f@ipc1.ka-ro>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 30, 2015 at 07:43:24AM +0100, Lothar Wa=C3=9Fmann wrote:
> Hi,
>=20
> Markus Pargmann wrote:
> > This is the core driver for imx25 touchscreen/adc driver. The module
> > has one shared ADC and two different conversion queues which use the
> > ADC. The two queues are identical. Both can be used for general purpose
> > ADC but one is meant to be used for touchscreens.
> >=20
> > This driver is the core which manages the central components and
> > registers of the TSC/ADC unit. It manages the IRQs and forwards them to
> > the correct components.
> >=20
> [...]
> > diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsad=
c.c
> > new file mode 100644
> > index 000000000000..8e4013d57500
> > --- /dev/null
> > +++ b/drivers/mfd/fsl-imx25-tsadc.c
> > @@ -0,0 +1,167 @@
> [...]
> > +#define MX25_TGCR_POWERMODE_MASK	(3 << 8)
> > +#define MX25_TGCR_POWERMODE_SAVE	BIT(8)
> > +#define MX25_TGCR_POWERMODE_ON		(2 << 8)
> >
> This looks a bit weird and conceals the fact, that
> MX25_TGCR_POWERMODE_SAVE is in fact one of the possible settings
> of a two bit bitfield. For consistency I would write:
> #define MX25_TGCR_POWERMODE_MASK	(3 << 8)
> #define MX25_TGCR_POWERMODE_SAVE	(1 << 8)
> #define MX25_TGCR_POWERMODE_ON		(2 << 8)
>=20
> [...]
> > +#define MX25_ADCQ_CFG_YPLL_HIGH	0
> > +#define MX25_ADCQ_CFG_YPLL_OFF		BIT(12)
> > +#define MX25_ADCQ_CFG_YPLL_LOW		(3 << 12)
> >
> dto.
>=20
> > +#define MX25_ADCQ_CFG_XNUR_HIGH	0
> > +#define MX25_ADCQ_CFG_XNUR_OFF		BIT(10)
> > +#define MX25_ADCQ_CFG_XNUR_LOW		(3 << 10)
> >
> dto.
>=20
> > +#define MX25_ADCQ_CFG_XPUL_OFF		BIT(9)
> > +#define MX25_ADCQ_CFG_XPUL_HIGH	0
> >
> |#define MX25_ADCQ_CFG_XPUL_OFF		(1 << 9)
> |#define MX25_ADCQ_CFG_XPUL_HIGH	(0 << 9)
> would make it more clear, that these refer to the two states of the same
> bit.
>=20
> > +#define MX25_ADCQ_CFG_REFP(sel)		(sel << 7)
> >
> missing () around macro argument
>=20
> > +#define MX25_ADCQ_CFG_REFP_YP		0
> > +#define MX25_ADCQ_CFG_REFP_XP		(1 << 7)
> > +#define MX25_ADCQ_CFG_REFP_EXT		(2 << 7)
> > +#define MX25_ADCQ_CFG_REFP_INT		(3 << 7)
> > +#define MX25_ADCQ_CFG_REFP_MASK		(3 << 7)
> >
> see my previous comment.
>=20
> > +#define MX25_ADCQ_CFG_IN(sel)		(sel << 4)
> >
> missing () around macro argument
>=20
> > +#define MX25_ADCQ_CFG_IN_XP		0
> > +#define MX25_ADCQ_CFG_IN_YP		(1 << 4)
> > +#define MX25_ADCQ_CFG_IN_XN		(2 << 4)
> > +#define MX25_ADCQ_CFG_IN_YN		(3 << 4)
> >
> see my previous comment.
>=20
> > +#define MX25_ADCQ_CFG_IN_WIPER		(4 << 4)
> > +#define MX25_ADCQ_CFG_IN_AUX0		(5 << 4)
> > +#define MX25_ADCQ_CFG_IN_AUX1		(6 << 4)
> > +#define MX25_ADCQ_CFG_IN_AUX2		(7 << 4)
> > +#define MX25_ADCQ_CFG_REFN(sel)		(sel << 2)
> >
> missing () around macro argument
>=20
> > +#define MX25_ADCQ_CFG_REFN_XN		0
> > +#define MX25_ADCQ_CFG_REFN_YN		(1 << 2)
> > +#define MX25_ADCQ_CFG_REFN_NGND		(2 << 2)
> > +#define MX25_ADCQ_CFG_REFN_NGND2	(3 << 2)
> > +#define MX25_ADCQ_CFG_REFN_MASK		(3 << 2)
> >
> see my previous comment.

Thanks, I fixed all of the comments.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUyzCwAAoJEEpcgKtcEGQQjDcQAJyR49orAP8xApUzluntV75N
neep3670d0phyKYWZCzQblmlO0rMfSJdgEaAznn2bf7KHNQS142sUMkhLcOnez0b
3LoiBAU9v3dPutIal2rgJiZzM7MpXokbeRlwAvhOJJJoTgTtFiwtasgjbwARdpw0
J7F0Ol4T9GLd7TRqRbwjorUkUIMpzSmdXzRvcs0HL/wzjy9U62tMdaeuMD3iryTx
LAUNRFwVI4D2nf5guvCM9r6MuKm1vhHTtbI7ViCmM184GvX46J3FHnJ86/EMU1i+
t0eZsEwj6prRYyVNLPIKfUnNd8zLkVRq2fUzIXhIaiK6Hhv0ULAaFN8wl+rf6w9+
L0Dv5SCGPCRTlOhz/PrbBv/W6uAB4LKxA6otbL3RoAY0zU6sF+zZUelKSc9Os2XB
pc+2BHnh2bAcehQbgeWJezv+4EpLLPHRgGmTZm3PD/iz1rrqEwFTJEShzubU/lW0
Jn+s1xyx4tLOnh2QOmsPBJF59tCb8lJuz0RRnAeE4hkrZa+6uT0C5cRgdTqSu7Rg
ya6mC1Mhpz5TsST18VYtNgqqgjEYHDPNhR+pD8k9ZREwqQ0NAio9RQf3aivc2UEU
hsqJzkAzmioHp9Gm9Y04JJOZq3pbamBt0lC80c4Gpeu/8tfs37tJ0a7k+giYxiIU
ix+E8K7gz19vVZLeL0zc
=ZQcj
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
