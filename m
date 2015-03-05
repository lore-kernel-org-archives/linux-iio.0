Return-Path: <mpa@pengutronix.de>
Date: Thu, 5 Mar 2015 08:12:52 +0100
From: Markus Pargmann <mpa@pengutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>,
	Eric =?utf-8?Q?B=C3=A9nard?= <eric@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Lee Jones <lee.jones@linaro.org>, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
Message-ID: <20150305071252.GA8062@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
 <2620642.Qp1W4O8uh6@wuerfel>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
In-Reply-To: <2620642.Qp1W4O8uh6@wuerfel>
List-ID: <linux-iio@vger.kernel.org>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 03, 2015 at 10:02:12AM +0100, Arnd Bergmann wrote:
> On Tuesday 03 March 2015 08:58:11 Markus Pargmann wrote:
> > +Example:
> > +       tscadc: tscadc@50030000 {
> > +               compatible =3D "fsl,imx25-tsadc";
> > +               reg =3D <0x50030000 0xc>;
> > +               interrupts =3D <46>;
> > +               clocks =3D <&clks 119>;
> > +               clock-names =3D "ipg";
> > +               interrupt-controller;
> > +               #interrupt-cells =3D <1>;
> > +               #address-cells =3D <1>;
> > +               #size-cells =3D <1>;
> > +               ranges;
> > +
> > +               tsc: tcq@50030400 {
> > +                       compatible =3D "fsl,imx25-tcq";
> > +                       reg =3D <0x50030400 0x60>;
> > +                       ...
> > +               };
> > +
> > +               adc: gcq@50030800 {
> > +                       compatible =3D "fsl,imx25-gcq";
> > +                       reg =3D <0x50030800 0x60>;
> > +                       ...
> > +               };
> > +       };
> >=20
>=20
> I wonder if we should just treat this MFD as a single IIO device
> that also registers to the input layer.
>=20
> Are there any other registers in the 0x50030000-0x50031000
> range, or could the fsl,imx25-tcq and fsl,imx25-gcq devices
> be reused outside of a fsl,imx25-tsadc device?

There are no other registers in this range. The tcq and gcq devices can
not be used outside of the tsadc. gcq and tcq are identical units so it
may work to use both of them as gcq for example but nothing else.

It may work to have this as single IIO device. However this would be a
major rework of this series. There are a lot less users of imx25 than
imx6 for example. And of these users barely anyone uses this unit at
all. I really would like to get these drivers mainline so others can use
it. But after 1 year and 7 versions of this series I don't want to put
a lot of work into these drivers. I think there are other components in
the kernel where the time is better used.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU+AH0AAoJEEpcgKtcEGQQQCIP/2qrkPHgsuNjeS3sV8jt0r4b
CQ6EkzSZnFelrjZGcw05rV07oGA7WCx8WNNwGI9CI4yq4C2SIbC3bNIl9B6+SSS+
SaFOp7inDsw297oCSQMnaiyltHlAI1efhVOawNmJt6gjslMy7172EmpTEpRsgly9
t+vT4oYng6r/GBxYNZSMbaju75/D6T23OvFPvXPDqWb+kESffngRHmrnQf0htfuD
CWaUeFi4yPp9kzNRIxkDMcDtEFC113OtOozRaLQktrXevDs+1qc+L1rke5ZubIbY
UvNdaQjOiADylaqW/DCNedRlq9sRKDy+SMDHKy12JIACvMeLMYotvlSSBWblc/t0
2OLrtt5+4QUkkSUKNcJfsKOhRKYTVruj8GqkYkC7uRMKXIxIjxNAooLG7L54oEdB
jmg/uTzqkGWLz+xnom9T4nG3M5DrpZL0JK95cH02JhaY2w7XOpR9llTAuSf6WRdS
nY8ammXBc5SdFPU1fJlYUV8FZHRB5yB7mNpedxcP90M9n1qZrbnwAW31rIeAU9xG
7I66J4b0jNzMX3cZ3EoPNpLrc9xXUV+D7MRp0VYxyUiVFPr2AhqMyCuZPfOL0GfX
yYo2eeCd7wpazq2TQm0/MrOdu+SCZu2dMAFyNW1zYxLjp5smm488FXtWK3AUiOE6
c0x1YT3OZcMUu2PCzTvj
=jOYu
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
