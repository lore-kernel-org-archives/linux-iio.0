Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54162 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751751AbdIRHdi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 03:33:38 -0400
Date: Mon, 18 Sep 2017 09:33:36 +0200
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
Message-ID: <20170918073336.j7finend3g76chsu@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="45wuklk6dqzrqgab"
In-Reply-To: <20170914145251.21784-2-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--45wuklk6dqzrqgab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 10:52:46PM +0800, Icenowy Zheng wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
>=20
> Update the binding document to cover H3.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v4:
> - Add nvmem calibration data (not yet used by the driver)
> Changes in v3:
> - Clock name changes.
> - Example node name changes.
> - Add interupts (not yet used by the driver).
>=20
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 30 ++++++++++++++++=
++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Docu=
mentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index badff3611a98..6c470d584bf9 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -4,12 +4,26 @@ The Allwinner SoCs all have an ADC that can also act as=
 a thermal sensor
>  and sometimes as a touchscreen controller.
> =20
>  Required properties:
> -  - compatible: "allwinner,sun8i-a33-ths",
> +  - compatible: must contain one of the following compatibles:
> +		- "allwinner,sun8i-a33-ths"
> +		- "allwinner,sun8i-h3-ths"
>    - reg: mmio address range of the chip,
>    - #thermal-sensor-cells: shall be 0,
>    - #io-channel-cells: shall be 0,
> =20
> -Example:
> +Optional properties:
> +  - nvmem-cells: A phandle to the calibration data provided by a nvmem d=
evice.
> +                 If unspecified default values shall be used.
> +  - nvmem-cell-names: Should be "calibration-data"

I'd prefer to have which sensor it applies to here. It wouldn't change
anything for the H3, but it definitely does for example for the A83t
that has two sensors, one for each cluster, and one for the GPU, each
with calibration data.

What about cluster0-calibration?

> +
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - clocks: the bus clock and the input clock of the ADC,
> +  - clock-names: should be "bus" and "mod",
> +  - resets: the bus reset of the ADC,
> +  - interrupts: the sampling interrupt of the ADC,

For resets and interrupts, you should list all of them. If there's
only one, then there's no point telling which one it is.


Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--45wuklk6dqzrqgab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv3bQAAoJEBx+YmzsjxAgFrAP/R5W5CAWuPA+M8y8TTi2QjrE
LcVqwRs5UBPOVXSSheN4WDWMM/DNqsOpW7oMVlSAYOT8ggGCoJP8jWLZmkR8eNSz
d43zKMD06AxgEmYW8/wtvVFw5kaG2RqukxeDQ4esGGugtuDiIjP8Wzy1y9s2gjix
KPxVZFOT41Ev0iGGC+XdNB63Z7XjvgPIvA0rA7Ti+84Z1s6MTdUIArSEX3mEhj4b
Bhe3+AlwCJVfDeOYLngqJ1XVuLqaMXT4H5lkgmKN8KxE7lklKK5qyrGe1TSsHOBe
vwzTViDMJZVoaqIwVXlTYZbZ0uV8ibO0X5FeJ55kWhDVGFkG48ncUWzi7aZGYa2a
IdL349yPqZbSl2SOCxhpqsR6TnBsgOsWuDiE7lOZBJvvxbTRPs/c6hSyk+R4u6eF
j11waQMstloEBfIz3yTIacURrLKgpcak1fDHm66If8phi3jGodutPpaDam9/bdOs
EOKCg/tCYypxLI3qjqHocUrucFEmwLhvT/166T1DhFMc8H4TmQ/sJAvTPlgx+YJz
AHnN4fGJBS9FUodu/FrzzwpeJ2W7k1YvnrpML6T9SV+VgOsl20usFPyLCGtz9l81
VStTGQAs3rL3eLzi4AU2moxpmv/k0BiQtVOj3ebPh1OqRx3WeJlUyQlczRo9P30V
mWjBkg/WIFLmpGSHOFFc
=cPuE
-----END PGP SIGNATURE-----

--45wuklk6dqzrqgab--
