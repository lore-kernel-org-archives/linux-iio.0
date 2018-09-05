Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:53074 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbeIET3o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 5 Sep 2018 15:29:44 -0400
Date: Wed, 5 Sep 2018 16:58:58 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Philipp Rossak <embed3d@gmail.com>, mark.rutland@arm.com,
        geert+renesas@glider.be, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, linux-sunxi@googlegroups.com,
        clabbe.montjoie@gmail.com, pmeerw@pmeerw.net, lee.jones@linaro.org,
        lars@metafoo.de, quentin.schulz@bootlin.com, linux@armlinux.org.uk,
        wens@csie.org, devicetree@vger.kernel.org, arnd@arndb.de,
        vilhelm.gray@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org,
        arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
        lukas@wunner.de, knaack.h@gmx.de, eugen.hristev@microchip.com,
        jic23@kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio:
 add support for H3 thermal sensor
Message-ID: <20180905145858.4ny5c7xojn7aiwlv@flea>
References: <20180830154518.29507-1-embed3d@gmail.com>
 <20180830154518.29507-22-embed3d@gmail.com>
 <20180831091137.wkbbipssyd6mqfbt@flea>
 <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io>
 <20180903102022.fkxfkxadkt4vpbmb@flea>
 <AFDFF5AB-8BF6-4461-A5C2-D628A2F22E2E@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7e64gxu5f4lvrtxz"
In-Reply-To: <AFDFF5AB-8BF6-4461-A5C2-D628A2F22E2E@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--7e64gxu5f4lvrtxz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2018 at 07:01:47PM +0800, Icenowy Zheng wrote:
> =E4=BA=8E 2018=E5=B9=B49=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=886=
:20:22, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Fri, Aug 31, 2018 at 05:51:41PM +0800, Icenowy Zheng wrote:
> >> Personally I suggest to leave out all SID or calibration related
> >> patches here.
> >>=20
> >> Currently we seems to be wrongly converting SID to big endian,
> >however,
> >> the orgnization of the THS calibration data on H6 shows that it's
> >> surely little endian:
> >>=20
> >> It consists a temperature value in 1/10 celsuis as unit, and some
> >> thermal register readout values, which are the values read out at the
> >> given temperature, and every value here (the temperature and the
> >> readout) are all half word length.
> >>=20
> >> Let the temperature value be AABB, the two readout values be XXYY and
> >> ZZWW, the oragnization is:
> >> BB AA YY XX WW ZZ ** ** .
> >>=20
> >> When converting the SID to big endian, it becomes:
> >> XX YY AA BB ** ** ZZ WW ,
> >> which is non-sense, and not able to do sub-word cell addressing.
> >>=20
> >> Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
> >> whether it will break compatibility.)
> >
> >This is exposed to the userspace, so no.
>=20
> Please note the LE2BE totally breaks the SID addressing.

On which SoCs?

> Without it dropped all cells must be referenced with 4 byte word as
> unit, and half word addressing of SID is thus not possible. The
> driver will also need then to split the half words if needed.
>=20
> I think this is kind of hardware misbehavior, and not a simple
> UAPI change, so the UAPI stability shouldn't affect this change.

How would you feel having your files on your filesystem suddenly not
in the same endianness and having all the bytes reordered? This is
definitely about the userspace ABI.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7e64gxu5f4lvrtxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluP7zEACgkQ0rTAlCFN
r3R3rBAAgLt3ujbBaes4sdzA2oKzSgMlaAi03PkyocmXMXjUdf+H6gKfQsevsOnZ
LGan/UQaWN2eie7+bR4+60QYUJMingr+x/rTXUciUGu++UIX9Y25Zj5pckNHk3EB
bNmJtIwda1xzs3ShPC9KCnD6wTNHxHYmOBz5/9KhfnDdCa7MyMrpnKlUE5bb1i5q
JumaFSCn9fj1Xk+3keAlNUUV6n5q7eONANYawI66elG/7pshzja1BZluBlPqNhqa
w/R/BAUKunThRsmfYb0QpxIV8M1fO5yVqYGGy8Hd/bHZVwotmkjtSVBMVDq2+K+C
hHnjnKrw//U//wCQ8FiRIwvuL8yZKLDUQNe/XW7RR167BPp92FxgRSKdIhAJD3Ro
3Orii3LRnU7afKNc4X1zx+MxImc2DehSM3lgZWRRpgaRCFUBS/wZAxZoi8KyTreN
5Dr5S/Y5+Fq2xRwIR56awt4Ej8oy0kcs9jElU7zs8m/yj7Q47qpa+GUC6R1tyZt7
cufj2wBJ+XjA7Z5YxpT7IzWs+qO4NLSWwEXUg8kTT18+YEXlV+WSyQku9bxKOhRN
H+CSMsAj6UNEidmSyHGtARlIZ1V8dynrPogwsxR4YImxPqtd1ia0an8Uty8Ed8Ua
CvHNsf1mabKDrEoVK/zI3ZISIAEVV0nm0mMq96YZiPTpJ9uFmg0=
=NYwv
-----END PGP SIGNATURE-----

--7e64gxu5f4lvrtxz--
