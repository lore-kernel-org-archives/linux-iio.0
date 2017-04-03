Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53629 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbdDCJP0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 05:15:26 -0400
Date: Mon, 3 Apr 2017 11:15:23 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: update the Allwinner GPADC
 device tree binding for H3
Message-ID: <20170403091523.6atl7nq4m2qkpn3d@lukather>
References: <20170402133304.56824-1-icenowy@aosc.io>
 <20170402133304.56824-2-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vh5pm2scqdolestx"
In-Reply-To: <20170402133304.56824-2-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--vh5pm2scqdolestx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 02, 2017 at 09:33:01PM +0800, Icenowy Zheng wrote:
> Allwinner H3 features a thermal sensor like the one in A33, but has its
> register re-arranged, the clock divider moved to CCU (originally the
> clock divider is in ADC) and added a pair of bus clock and reset.
>=20
> Update the binding document to cover H3.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 23 ++++++++++++++++=
++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Docu=
mentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> index badff3611a98..7753133ca0ff 100644
> --- a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -4,12 +4,20 @@ The Allwinner SoCs all have an ADC that can also act as=
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
> +Required properties for the following compatibles:
> +		- "allwinner,sun8i-h3-ths"
> +  - clocks: the bus clock and the input clock of the ADC,
> +  - clock-names: should be "bus" and "ths",

I guess mod instead of ths would be more consistent.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--vh5pm2scqdolestx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY4hKrAAoJEBx+YmzsjxAgL2kQAIKtQ5W8t3bLAZ9L8zMuBMzc
jXaXvRaPMMPCydqGbXTYgcPwfSnyCMunoBccnTvot8tqnWEGEtZULWYppGjJnjqn
lH4PM2d5gTKA1XpVaYcD5hLZ6mPHChW+Q5+4mfElmGbpIeY5Q7snuQ5iX5mFOgoQ
9W/Z6tHJm9ao2AR/5S0Bsa/vpCwR0+dQ+ivAzgIVziBaQcSZia20fxDCtxGAFbPK
WFdMIqdQMtYVtALHdlWEjT9XCIvIbe8oyiVvlpYtLr8MHFZafcXYzeAw0gwCzhzY
u4zaMpTT/OJXCZyN0E2LsGSGoErty5IlpL5rFaLrdXfJVb38fZ46CuO00PutdyO0
tCQHDrs3OqTcs8QZ4hroKXKFII3y8ZUrik5yg9BJAnip6BxRbRWne7sPBT8sY7gF
GAMfXbI0qnUEq2w4Rwdp6AIyGWop7fVwLDDS37HrzxZj16v/CtFSlm3YmjX0+Wuc
iCxslcORip/HnsAKj/f7oQvuO4QBiq8qTzglq7+KYrdcQaAxHQ6KLwo3cYrDIZXw
xms3ssq0mc6I0HkTD6fQvmFkhx1TM9y0dorhCrgZ9QYT0+2W2YgVMY5IQ6s3RCs1
B/qjkpLiDpPbCfCI4t0t1kjGOEjo2F2UQkGKh5yE4prVY1bQoEBYJ+/ZOgx+7h4m
sNzG76xwtxH1jPzPqvdX
=Z18I
-----END PGP SIGNATURE-----

--vh5pm2scqdolestx--
