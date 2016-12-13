Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:60106 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbcLMPnu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Dec 2016 10:43:50 -0500
Date: Tue, 13 Dec 2016 16:43:04 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: linux@armlinux.org.uk, wens@csie.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v9 1/3] ARM: sunxi_defconfig: Add CONFIG_THERMAL_OF
Message-ID: <20161213154304.k3v2nwwqinp64puj@lukather>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-2-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s3dopdoodxxlllvk"
In-Reply-To: <20161213143332.24988-2-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--s3dopdoodxxlllvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 03:33:30PM +0100, Quentin Schulz wrote:
> This enables CONFIG_THERMAL_OF by default for sunxi_defconfig. It is
> required to get Allwinner SoCs' temperature from the GPADC driver.
>=20
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. The first four channels can be used
> either for the ADC or the touchscreen and the fifth channel is used for
> the thermal sensor.
>=20
> The thermal sensor requires the IP to be in touchscreen mode to return
> correct values. Therefore, if the user is continuously reading the ADC
> channel(s), the thermal framework in which the thermal sensor is
> registered will switch the IP in touchscreen mode to get a temperature
> value and requires a delay of 100ms (because of the mode switching),
> then the ADC will switch back to ADC mode and requires also a delay of
> 100ms. If the ADC readings are critical to user and the SoC temperature
> is not, the GPADC driver is capable of not registering the thermal
> sensor in the thermal framework and thus, "quicken" the ADC readings. In
> most use cases, the SoC temperature is more critical (for cpu throttling
> for example or activating cooling devices) than ADC readings, thus it is
> now enabled by default.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--s3dopdoodxxlllvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYUBcIAAoJEBx+YmzsjxAgGzYQAKkmmo57VhUSdteqDD/x1+oN
M3xW7i+ZuivV5cR1F/qpufV4C/bhN8eEFlJ14dWrFmcSWAIs9M6gGtgkeXolOno6
ZLgSOUjHcF9a4CjvJFB1uOkTPMPDeRSiNshK+TKeTt2NxLJc48O6Xdf+xHEmculA
Pv7lSbGOP5FYQz+og25wA3QGO0c8sTlCKwdCZkvjDqtdrnFwjCiYmiWeClK4WOEw
ywIbgQG5/F9i8phyBvrlaB0vVGUkA0UfeucUWuDUtPvtkge94mrzumt61ZKzAXgz
zaxGCFhUCi883+3LwwG0zWM7ZNW/v6PHCvrhQ81MbR9/XzRl/LHB0JlRrLrlr3VI
yimYqTdvwfAP2xpc7o+AwueOpdEohQyKBGXVQdPNqRLCQRB04YkWZNF6TXDH2d3R
BMNaUv6RCmmxaqp4IS9ZJfTa7MgPQf+FFOHQVshbB7MHevQjueZVH3maHain/JGT
T1ATMhE/KjiVZp9VS3FACj9YJFufyE0+89o8iQHvJ156NLWSKYa8ZLdkAMeH14zC
SN2NI0Skz9AqDli2kcbpbI7J+Z4cPttEEjhzqw/SN/Cfn6U73+248SxYGPvz+Jqu
B+cNiP+W6sFiXOW55nLhbqWcGAeenWLiTzne8M2qDfm0FN6iIFWHqzlPY1rABMce
LuMpOeUYWkMZn+9tHdol
=zR9B
-----END PGP SIGNATURE-----

--s3dopdoodxxlllvk--
