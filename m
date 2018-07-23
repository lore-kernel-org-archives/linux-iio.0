Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42545 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387972AbeGWJgO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jul 2018 05:36:14 -0400
Date: Mon, 23 Jul 2018 10:36:13 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kent Gustavsson <kent@minoris.se>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: add bindings for mcp3911
Message-ID: <20180723083613.GA13016@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
 <20180721195923.7610-2-marcus.folkesson@gmail.com>
 <20180722091111.6c55602f@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
In-Reply-To: <20180722091111.6c55602f@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sun, Jul 22, 2018 at 09:11:11AM +0100, Jonathan Cameron wrote:
> On Sat, 21 Jul 2018 21:59:22 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20

[snip]

> > +Optional properties:
> > + - device-addr: Device address when multiple MCP3911 chips are present=
 on the
> > +	same SPI bus. Valid values are 0-3. Defaults to 0.
> > + - external-clock: Use external clock instead of crystal oscillator.
> As mentioned, in the code, can we use the standard fixed clock bindings h=
ere.
> We don't actually care what the value is, but it might be nice to be able=
 to
> power down the clock if we are suspending or something..
>=20
> > + - external-vref: Use external voltage reference
> > + - vref-supply:	Phandle to the external reference voltage supply. (onl=
y valid in combination with `external-vref`)
>=20
> Just use the optional regulator stuff and get rid of the bool.
>=20
> > + - ch0-width: width for channel0. Valid widths are 16 and 24bits.
> > + - ch1-width: width for channel1. Valid widths are 16 and 24bits.
>=20
> As I asked in the code, are these a function of the wiring etc or are
> they something we should really be leaving up to userspace (with a sensib=
le
> default).
>=20


I agree with all of your comments.
I will remove the channel width properties and fix the regulator/clock
bindings.

Thanks,

Best regards
Marcus Folkesson

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltVk3gACgkQiIBOb1ld
UjKoRg/9EfioKOruahSRmFCbX8GMzfRfNv2zyqdbKgaOCYSvBex1mYdNRbvmWCyA
pGFmyXsrrXhB0t0UY/tsRdio92vxhfdhUgcYtVbt6dcwLXd9tTESeQ7sjsLTkm+i
OxnmgKLwXX5VfS31rq4nZPExvY0XI0Qiz6gaVn9tmp0ioJZZ1MM0EO6rlSNhAdGT
3nVlyhWqfNe8KRjEMSUGsdvFZYIlMMoDxqkRMid8WkqnLi5WkW+h3cZ7645ROARz
161w8Dx2HJDdfNMFCzkKcYtVt/tPYCkImNsbDQ2DR6USNmnwMDlwtKEw/uRBRnYz
y7Vl4CYX295uIN3bmSnHRo4DMrSnBstn1w0fCfbx8bZk0mX5GvIHitWSwCRvuuOc
3gJSJtuk1mDufvceUhf4ZayOvzla3/o+NiCBxr4DhHPWVBfPdEHPUMVHISidw+bG
hP17n9qy/L1xGIVKNcY958M3EB2H7oy7FGAkZsGOSuEYD8mtP0O2aJrVbIope0lz
ty/huysyVoTb2LQj3FVXdfQCO46JxyoIqqDeA1v1hc8pGgUuaROIKdsJxkolaNSg
DxMmIcMyHx8B51Avn8fQhr+WQZmaLkKSInotpvm/dz9fcLH34xYkMSUaTLohb9/P
PRsLexWLC4noPMrCIJrNm7EFZH6GoDl6sUeJKgN6u+0G+Q9Ms58=
=Wv8b
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
