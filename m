Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39889 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbdCTIqD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 04:46:03 -0400
Date: Mon, 20 Mar 2017 09:45:27 +0100
From: "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wens@csie.org" <wens@csie.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "stefan.mavrodiev@gmail.com" <stefan.mavrodiev@gmail.com>,
        "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 05/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
Message-ID: <20170320084527.7cah2g7doas7ykyf@lukather>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-6-quentin.schulz@free-electrons.com>
 <5798131489173902@web12o.yandex.ru>
 <6d997cc1-585e-e25c-a53f-d7b28613dfbb@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w3ydkscm76ah7w4j"
In-Reply-To: <6d997cc1-585e-e25c-a53f-d7b28613dfbb@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--w3ydkscm76ah7w4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 11, 2017 at 03:07:55PM +0100, Quentin Schulz wrote:
> Hi Icenowy,
>=20
> On 10/03/2017 20:25, Icenowy Zheng wrote:
> >=20
> >=20
> > 10.03.2017, 18:56, "Quentin Schulz" <quentin.schulz@free-electrons.com>:
> >> This patch adds documentation for the A33 GPADC binding.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >> ---
> >>
> >> added in v2
> >>
> >>  .../devicetree/bindings/mfd/sun4i-gpadc.txt | 59 ++++++++++++++++++++=
++
> >>  1 file changed, 59 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.=
txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/D=
ocumentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> new file mode 100644
> >> index 0000000..17242c8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> @@ -0,0 +1,59 @@
> >> +Allwinner SoCs' GPADC Device Tree bindings
> >> +------------------------------------------
> >> +The Allwinner SoCs all have an ADC that can also act as a thermal sen=
sor
> >> +and sometimes as a touchscreen controller.
> >> +
> >> +Required properties:
> >> + - compatible: "sun8i-a33-gpadc-iio",
> >> + - reg: mmio address range of the chip,
> >> + - #thermal-sensor-cells: shall be 0,
> >> + - #io-channel-cells: shall be 0,
> >> +
> >> +Example:
> >> + rtp: rtp@01c25000 {
> >=20
> > I think we'd better call it ths.
>=20
> To match the datasheet, I agree.

I agree too.

> > And can you make thermal-sensor-cells become 1?
> >=20
> > Maxime Ripard wants to base H3/H5/A64 thermal driver on this patchset, =
and
> > for H5/A64 there's 2/3 thermal sensors.
>=20
> Yes, that'll require a specific DT node for those thermal sensors. Then
> since we would update the possible compatibles in the documentation
> anyway, that would be a good idea to update to say that
> thermal-sensor-cells could be different from 0 too.
>=20
> That was my mindset to set thermal-sensor-cells to 0, since we only
> support SoC which has only one thermal sensor at the moment.

And I agree here as well.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--w3ydkscm76ah7w4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYz5ahAAoJEBx+YmzsjxAgoM4P/0eW2dKsk4DpvnRGNloSU2V2
+jb3pnx8kH5Ew38ZKZ0ysCx7dSlXLAmIqJKXWhbS3dCKsz2BIDvSvEWoerWASl7q
uzNbOCgmEg4Qm9j0n+RQZavOnn/CGc8cX3hoLP6+GZvaMg7qVzU4rbHfvrk23aGI
sb17D4PM3HVqwb6ryIKzKUry77TLxbJl8Gj1CIJC/ip9V7QSdCX6OgpkShurejJK
l4NrP5w8z59fo42njWBuzngtOmDgtrUdJ0PrPkHtqIAJq9lXKvRP9tGblmVhryfY
8mc3Dh3nhdCcEEmTAscEl5AyzHqMuOG2OdThDn0s+wZd+q4bitWluIVnupY+jtql
isrGTAvKkgDOFYz+Bi7NtxNIqCYptxMplHJl59Q5Kfc9aW/JwG2YcxlTCOzI9rW1
/CsrbtWmQs4kXBNcc6HLi2ZORd9GB1H6mv3KVY2Hf/vsCeHMiaGYFhDExcXwDbjL
97hYz98BwwT7GhyA1LawenuDjopMfDUoW9czd1gP7DIpFOWY5XqFGTwpi0v1xllu
IVbYhDG0QP/Q4hNnp/1ocops1h2fOhY8Rqq5Do93i6bZKW7af884Cb8tCCB+8tzk
pqgYHOHak5q0EEDB81jaG0xkwwNDF6BOvMcf/SJaQ1yNZKNbrFSFr1u2LJLQY/Uj
2PebjfOesrkbH01/9FZs
=8TEk
-----END PGP SIGNATURE-----

--w3ydkscm76ah7w4j--
