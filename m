Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57227 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbdIRIbG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 04:31:06 -0400
Date: Mon, 18 Sep 2017 10:30:45 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 1/6] dt-bindings: update the Allwinner GPADC device
 tree binding for H3
Message-ID: <20170918083045.7bfiialtbm7w6i7j@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-2-icenowy@aosc.io>
 <20170918073336.j7finend3g76chsu@flea.lan>
 <310CE549-B8CE-4C0C-95B1-B545E38BDAF5@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="r2zkwavsvf5gwuko"
In-Reply-To: <310CE549-B8CE-4C0C-95B1-B545E38BDAF5@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--r2zkwavsvf5gwuko
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 18, 2017 at 03:36:43PM +0800, Icenowy Zheng wrote:
> =E4=BA=8E 2017=E5=B9=B49=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
3:33:36, Maxime Ripard <maxime.ripard@free-electrons.com> =E5=86=99=E5=88=
=B0:
> >On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
> >> Allwinner H3 features a thermal sensor like the one in A33, but has
> >its
> >> register re-arranged, the clock divider moved to CCU (originally the
> >> clock divider is in ADC) and added a pair of bus clock and reset.
> >>=20
> >> Update the binding document to cover H3.
> >>=20
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> >> ---
> >> Changes in v4:
> >> - Add nvmem calibration data (not yet used by the driver)
> >> Changes in v3:
> >> - Clock name changes.
> >> - Example node name changes.
> >> - Add interupts (not yet used by the driver).
> >>=20
> >>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30
> >++++++++++++++++++++--
> >>  1 file changed, 28 insertions(+), 2 deletions(-)
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> index badff3611a98..6c470d584bf9 100644
> >> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> >> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can also
> >act as a thermal sensor
> >>  and sometimes as a touchscreen controller.
> >> =20
> >>  Required properties:
> >> -  - compatible: "allwinner,sun8i-a33-ths",
> >> +  - compatible: must contain one of the following compatibles:
> >> +		- "allwinner,sun8i-a33-ths"
> >> +		- "allwinner,sun8i-h3-ths"
> >>    - reg: mmio address range of the chip,
> >>    - #thermal-sensor-cells: shall be 0,
> >>    - #io-channel-cells: shall be 0,
> >> =20
> >> -Example:
> >> +Optional properties:
> >> +  - nvmem-cells: A phandle to the calibration data provided by a
> >nvmem device.
> >> +                 If unspecified default values shall be used.
> >> +  - nvmem-cell-names: Should be "calibration-data"
> >
> >I'd prefer to have which sensor it applies to here. It wouldn't change
> >anything for the H3, but it definitely does for example for the A83t
> >that has two sensors, one for each cluster, and one for the GPU, each
> >with calibration data.
> >
> >What about cluster0-calibration?
>=20
> The calibration data is in fact a 2 word (8 bytes) zone,
> which is reserved for 4 sensors on all SoCs, even on H3.
> It's half word per sensor.
>=20
> I prefer to just assume a 2 word cell for every SoC.

You have three different data sources, it should be reprensented as
such.

Otherwise, the client has to get some knowledge of how the data are
stored in the provider, which is an abstraction violation.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--r2zkwavsvf5gwuko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv4Q1AAoJEBx+YmzsjxAgUO4P/iVMlkYAxCvgg+wxUren3sdr
b4o9mVq7XpL0gQbymcivAvlpa/hpGSCyfB9MA+xSgNlYcfu3nhTg7abt2L2sfeuC
HmUBSvNOROUIEQ+xZEXVlb0tz3lVF7GjJtH5S8v5SCikIU3g7hFpBLzGJucmBN8C
3IXTb/xIg5Zh3qqyaaCGUZ/afeGooI5/xGtW5HRdwhaNCsx2CPru3TmQN2gONKFi
CfviU1Ob9cdnfkvNrNAyk2pd6khME0aW8zdbqqcj2jSwxZ8pnA4mpb948Fn5ksYc
2xztacc4KpIl31LYJBe2MxW/vM/bP1uDkc8lHWVp1WEXzuVNm9WOFWGyEZGHkgEo
d3i2N5E2rxc1whP488ljOvWzGEwJpoEBYjkspn0IWFIv1qQZLrwg0SGcIsYb1fQp
OEmh/cFNKOZigA53F8HHXsQNA1rv+e4JKz5u00KyPutGCAvqCsfHGUeUHDlZIaEn
H1KO6h5mIDilz8uPpXYCQEKgUgBxiYsnDrijVmkpjmE3IuLPN3h38OE+q2zmEGpb
4meW5xSqiXnhRS7YGxyXIlggrO6d8oZ01WKVgr4iX8raIUgxF9YLjWULURJXH+he
ncmJCYaQHjTIn9qMj29jdaxPpstZwhHnDyuf8X+4WEcSb9fczKxAPa6wPGn0Sg/s
ZOIAlO9Ep5we4zk3XxGd
=iBHU
-----END PGP SIGNATURE-----

--r2zkwavsvf5gwuko--
