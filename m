Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46761 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdITHwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 20 Sep 2017 03:52:24 -0400
Date: Wed, 20 Sep 2017 09:52:23 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: icenowy@aosc.io
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [linux-sunxi] Re: [PATCH v4 1/6] dt-bindings: update the
 Allwinner GPADC device tree binding for H3
Message-ID: <20170920075223.jaeswlhcqgu4yhse@flea.home>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-2-icenowy@aosc.io>
 <20170918073336.j7finend3g76chsu@flea.lan>
 <310CE549-B8CE-4C0C-95B1-B545E38BDAF5@aosc.io>
 <20170918083045.7bfiialtbm7w6i7j@flea.lan>
 <e73ead447af89031749e85207cac1e69@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="j6c5m4fcyye26ziz"
In-Reply-To: <e73ead447af89031749e85207cac1e69@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--j6c5m4fcyye26ziz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 03:47:25PM +0000, icenowy@aosc.io wrote:
> =E5=9C=A8 2017-09-18 16:30=EF=BC=8CMaxime Ripard =E5=86=99=E9=81=93=EF=BC=
=9A
> > On Mon, Sep 18, 2017 at 03:36:43PM +0800, Icenowy Zheng wrote:
> > > =E4=BA=8E 2017=E5=B9=B49=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=
=8D=883:33:36, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> =E5=86=99=E5=88=B0:
> > > >On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
> > > >> Allwinner H3 features a thermal sensor like the one in A33, but has
> > > >its
> > > >> register re-arranged, the clock divider moved to CCU (originally t=
he
> > > >> clock divider is in ADC) and added a pair of bus clock and reset.
> > > >>
> > > >> Update the binding document to cover H3.
> > > >>
> > > >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > > >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > >> ---
> > > >> Changes in v4:
> > > >> - Add nvmem calibration data (not yet used by the driver)
> > > >> Changes in v3:
> > > >> - Clock name changes.
> > > >> - Example node name changes.
> > > >> - Add interupts (not yet used by the driver).
> > > >>
> > > >>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30
> > > >++++++++++++++++++++--
> > > >>  1 file changed, 28 insertions(+), 2 deletions(-)
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > >b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > >> index badff3611a98..6c470d584bf9 100644
> > > >> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> > > >> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can also
> > > >act as a thermal sensor
> > > >>  and sometimes as a touchscreen controller.
> > > >>
> > > >>  Required properties:
> > > >> -  - compatible: "allwinner,sun8i-a33-ths",
> > > >> +  - compatible: must contain one of the following compatibles:
> > > >> +		- "allwinner,sun8i-a33-ths"
> > > >> +		- "allwinner,sun8i-h3-ths"
> > > >>    - reg: mmio address range of the chip,
> > > >>    - #thermal-sensor-cells: shall be 0,
> > > >>    - #io-channel-cells: shall be 0,
> > > >>
> > > >> -Example:
> > > >> +Optional properties:
> > > >> +  - nvmem-cells: A phandle to the calibration data provided by a
> > > >nvmem device.
> > > >> +                 If unspecified default values shall be used.
> > > >> +  - nvmem-cell-names: Should be "calibration-data"
> > > >
> > > >I'd prefer to have which sensor it applies to here. It wouldn't chan=
ge
> > > >anything for the H3, but it definitely does for example for the A83t
> > > >that has two sensors, one for each cluster, and one for the GPU, each
> > > >with calibration data.
> > > >
> > > >What about cluster0-calibration?
>=20
> I prefer sensor0-calibration to sensor3-calibration now.
> (Theortically the new generation THS can support up to 4 sensors)

The mapping that explains what sensor0 means can change in the
future. It's better to be explicit here, and just say upfront what
it's about.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--j6c5m4fcyye26ziz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZwh43AAoJEBx+YmzsjxAg6coQAJhmcNGdIUCdL6g5L/2GIVnR
VU2BrHYsmzIhV6p6K0Bh41Nj6vzoL3s8EbJgOKT1zCkmi439nAsEhwJZJicfodz1
6axkC+mzw5pVapG+ooihuFdIFKj8X139EQta5t9kuyOy3OUhHrwqDNqq4Y6UEVrl
0lLYMq9O01mLhXtN8WDwAnqP5Q/lR+CHX4tF+IpNIq2yj1muSXbu0h5+ZLtoS96b
bH0679EuiULHCQ8JYjz+CxoK/wvoSfOmHqnEzcE6ZmtED5CchegUilHpzhxlrmLI
zinIQExlQHP3O1pa6sEQ51cplXyJes87QcTo2lY6LgWsKPCTx1CoBaIkGvs8Mv43
53WwQhJOBv6OaZx3grCzUxu0DlmnEjr4RKaVrgI1OR7r/ZGkGt9/j8qCn9J/N2Kn
gGd8TSt6nobVYWMc+1txdUf4XhsSvpckFm/WsLrZkX+sSdBDY3PBnx6HwtTt0IPN
YmkEUs6Jx7rKZwBLAMtBSJ5MBFZjuqgVgdi+EILlCFxe+lg9wkUSGRlIxUYPRN5E
iQFQUy12peGDVZjusGGmHrEJL5ygKCGEVvK00YiujkGXWNiRYKncz/BfeRwBXLns
opuuCs7wXfwI5buNmakpYc+VRlWwa4bEn09/GY4+gDiZsMgA8E2fuVIZVXJMXjTr
asat+94Ttiohg2ryCW6D
=bUAz
-----END PGP SIGNATURE-----

--j6c5m4fcyye26ziz--
