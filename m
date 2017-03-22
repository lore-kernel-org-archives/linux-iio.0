Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48831 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758523AbdCVHSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 03:18:05 -0400
Date: Wed, 22 Mar 2017 08:17:06 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [PATCH v3 03/11] ARM: dts: sun8i: sina33: add cpu-supply
Message-ID: <20170322071706.kzkw65653ivl4qcd@lukather>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-4-quentin.schulz@free-electrons.com>
 <CAGb2v67mihMMMqEpWSiuXXn6evXcquStGqQHRK2KdQzQ+EubNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ohghizlbmng4de4l"
In-Reply-To: <CAGb2v67mihMMMqEpWSiuXXn6evXcquStGqQHRK2KdQzQ+EubNA@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ohghizlbmng4de4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 11:33:15AM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > This adds the cpu-supply DT property to the cpu0 DT node needed by
> > the board to adapt the regulator voltage depending on the currently used
> > OPP.
> >
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>=20
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ohghizlbmng4de4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY0iTyAAoJEBx+YmzsjxAgqh0QALLq4ukjQHS9igDB6kSZ8qUv
K86oN7MCpND8cI1g9QY1cIZNIhmsJY2RfHWH5Ky5UkJuWv0IchTGfnNxLkZfURLs
UDONWLsHvIuLvk2K5tBQVkZagUWuzjcVSF2Bmf4sfg3KUhVDYVR8CP4xOhEIHT0I
8Njy4rOpTLLDPjWVYR0vjQKHx38NAhZ0NxN58ikqdgqA/cZSzXyU8bGHtWC6/JQ+
WwrkOwPmnX1Y0LIwTJbDq/vzRMjqvoTR4uW7jTWWbmnZRf7uGyV/bEOgLwwOdrFm
SjDWFaSUQTq9JuDzPw3Yi312vrmiyDemzpsdke/QYU8GHCRP0Loi1XCl9wX5t5LE
6+vPEiR3nvBIw35TH56a0myXo7EPdjpGL7CPEiauIsjhz/aT1lCT+O+OWM6nmmh5
dKeHWQt/2bZm4CeHdWRBZ76wXgdeEGNKS4CDl3VRwBd2qnpEnu2p4Nzdpfy1AxbS
rMrltMlacp3gqHkxNqsvhvxcat9CVqVH4gtR8drQOAIoP0vz6mgEP8LDREYwnsKi
89C6mUwTuygNQdk0bS2ol3g3ali/hG0gzH9vQvNp5WoNSPja+cFu8sUkuFHqof7e
XwXxOUHyfHfT2rUvLf+7aAGcuNVu+H9s9kG5auBF53RONuk+JU4xaWVYg/pMqyE1
0zRsoSc1o0OHiEDAGMzP
=4DoB
-----END PGP SIGNATURE-----

--ohghizlbmng4de4l--
