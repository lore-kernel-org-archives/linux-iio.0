Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34336 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbeHDIyd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Aug 2018 04:54:33 -0400
Date: Sat, 4 Aug 2018 08:55:06 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio: adc: add support for mcp3911
Message-ID: <20180804065506.GB1727@gmail.com>
References: <20180802191554.20176-1-marcus.folkesson@gmail.com>
 <CAHp75Vf8kMLsoFN_EK150yW_FvH8XfgjiETYAtvW63et5NNurw@mail.gmail.com>
 <20180803230922.22d628fc@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
In-Reply-To: <20180803230922.22d628fc@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andy and Jonathan,


On Fri, Aug 03, 2018 at 11:09:22PM +0100, Jonathan Cameron wrote:
> On Thu, 2 Aug 2018 22:52:00 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>=20
> > On Thu, Aug 2, 2018 at 10:15 PM, Marcus Folkesson
> > <marcus.folkesson@gmail.com> wrote:
> > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).
> > >
> > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com> =20
> >=20
> > > Signed-off-by: Kent Gustavsson <kent@minoris.se> =20
> >=20
> > What is this? Why it's here (presense and location in the message)?
> To clarify... If Kent wrote the patch and you are simply acting
> as gatekeeper / upstreamer you should set the mail to be from Kent
> and put your own Signed-off after his to basically act as a submaintainer
> certifying you believe his sign off and all that entails.
>=20
> If it is a bit of a joint effort then that's fine but for copyright
> purposes there should be some indication of the split.

First, thank you Andy for noticing.

I actually intended to use Co-Developed-by (a pretty new tag)
in combination with Signed-off-by.
But the tag must have disappeared in some preparation stage..

=46rom Documentation/process/submitting-patches.rst ::

	A Co-Developed-by: states that the patch was also created by another devel=
oper
	along with the original author.  This is useful at times when multiple peo=
ple
	work on a single patch.  Note, this person also needs to have a Signed-off=
-by:
	line in the patch as well.

I will switch order and add the Co-Developed-by-tag.
Is this correct?

Co-Developed-by: Kent Gustavsson <kent@minoris.se>  =20
Signed-off-by: Kent Gustavsson <kent@minoris.se> =20
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com> =20

>=20
>=20
> >=20
> > > + * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se> =20
> >=20
> > > + * =20
> >=20
> > Redundant.
> >=20
> > > +static int mcp3911_read(struct mcp3911 *adc, u8 reg, u32 *val, u8 le=
n)
> > > +{
> > > +       int ret;
> > > +
> > > +       reg =3D MCP3911_REG_READ(reg, adc->dev_addr);
> > > +       ret =3D spi_write_then_read(adc->spi, &reg, 1, val, len);
> > > +       if (ret < 0)
> > > +               return ret;
> > > +
> > > +       be32_to_cpus(val);
> > > +       *val >>=3D ((4 - len) * 8);
> > > +       dev_dbg(&adc->spi->dev, "reading 0x%x from register 0x%x\n", =
*val,
> > > +                       reg>>1);
> > > +       return ret;
> > > +}
> > > +
> > > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 le=
n)
> > > +{
> > > +       dev_dbg(&adc->spi->dev, "writing 0x%x to register 0x%x\n", va=
l, reg);
> > > +
> > > +       val <<=3D (3 - len) * 8;
> > > +       cpu_to_be32s(&val);
> > > +       val |=3D MCP3911_REG_WRITE(reg, adc->dev_addr);
> > > +
> > > +       return spi_write(adc->spi, &val, len + 1);
> > > +} =20
> >=20
> > Can't you use REGMAP_SPI ?
> My instinct is not really. The magic device-addr doesn't help.
> You could work around it but it's not that nice and you'd have
> to create the regmap mapping on the fly or carry static ones
> for each value of htat.
>=20
>=20
>=20
> >=20
> > > +       of_property_read_u32(of_node, "device-addr", &adc->dev_addr);
> > > +       if (adc->dev_addr > 3) {
> > > +               dev_err(&adc->spi->dev,
> > > +                               "invalid device address (%i). Must be=
 in range 0-3.\n",
> > > +                               adc->dev_addr);
> > > +               return -EINVAL;
> > > +       }
> > > +       dev_dbg(&adc->spi->dev, "use device address %i\n", adc->dev_a=
ddr); =20
> >=20
> > Isn't what we called CS (chip select)?
> Nope. We went around this in an earlier revision. It's an address transmi=
tted
> in the control byte to allow you to 'share' a chip select line between mu=
ltiple
> chips (crazy but true).
>=20
> >=20
> > > +       if (IS_ERR(adc->vref)) { =20
> >=20
> > > + =20
> >=20
> > Redundant.
> >=20
> > > +       if (adc->clki) =20
> >=20
> > Seems to be redundant if clock is optional (it should be NULL and API
> > is NULL-aware).
> >=20
> > > +               clk_disable_unprepare(adc->clki); =20
> >=20
> > > +       if (adc->clki)
> > > +               clk_disable_unprepare(adc->clki); =20
> >=20
> > Ditto.
> >=20
> > > +#if defined(CONFIG_OF) =20
> >=20
> > This prevents playing with the device on ACPI enabled platforms.

I will remove the defined(CONFIG_OF) and not use the of_match_ptr()
macro.=20

> Yeah, that trickery is still little known (and I forget about it from
> time to time).
>=20
> The upshot for those who have missed this is you can use a magic
> acpi device to instantiate based on device tree bindings :)
>=20
> So we need to strip all this 'obvious' protection stuff out of drivers.

Jonathan,
Do you want me to do the same changes for drivers in iio/ ?
I'm probably not the only one looking at other drivers when writing my
own, so I guess this is a rather frequent issue for new drivers?


>=20
> >=20
> > > +               .of_match_table =3D of_match_ptr(mcp3911_dt_ids), =20
> >=20
> > Ditto for macro.
> >=20
>=20

Best regards,
Marcus Folkesson

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltlTcQACgkQiIBOb1ld
UjKPFw/+NeiGz6rfi628o/DAMpQDQbDHkK/2DmBcJIPpZv1oRuPFbrTFx6ju30/v
dfed1gAcphELG90jVf6nUI7VFie0xUyA9dpZL1orhuS4hl0djUJY+PAztAsckM1a
U6xVGtd7r2zA1uY7Ggf89Gb1VWEpcKQX7HbnI/x41jA7CZExkky43MK6GcdVhOzS
LboSdr+KkEOxq1SvtYkhWST/WOHTmUfL5nobnR0qxhaJpeIskamhtmC4ek8+11kP
N4fjFUIexXxAWnxXkm0hGCxmET5rfl5/+kSaVOprNQ+wm6AmMiUiLY6ujPh0z68L
8tZWMS1XzPUrRd4asb2G3uwCAgKDKVHgwTb3j3l4O5bTXPcHRLdveiykpjNfB5pV
QAvina6KAJ4RLyad/OhTWGB/QWU4YgoL4Ksgf8ZQxqYBjErqutzD0gHOWB9Pst9k
h75Ca2jLrWLxWu+3t+9h25IbiGf0IklgNfKL2GmmtKpjTl1HxBJ3p9S9CClvx4GB
A+Y3LaurPWFT4cIaX1FWW8pnuFoLkDap/Pw3Cd2qZMnRuqkcVWlaPpQIBtcCuGrW
CprEPppwMWRCok2oF4MRyEcBFPPuvNJzUBjVAgtKlVCVvsTkzxKKvjQC3ThGX/On
3NY8XwiPjGWLW9OhCy2J+YvPqIU/1d6kbrK+AVVVz9aamm/xAv8=
=8cpx
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
