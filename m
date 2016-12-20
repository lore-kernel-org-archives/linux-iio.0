Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:39872 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933093AbcLTOZ5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2016 09:25:57 -0500
Date: Tue, 20 Dec 2016 15:25:54 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 1/7] Documentation: DT: bindings: iio: adc: add
 documentation for Allwinner SoCs' GPADC driver
Message-ID: <20161220142554.rcocnculfehiwhpn@lukather>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
 <20161220102709.9504-2-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gnfzxbx72j2i2qmt"
In-Reply-To: <20161220102709.9504-2-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--gnfzxbx72j2i2qmt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2016 at 11:27:03AM +0100, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> and sometimes as a touchscreen controller. If there is a touchscreen
> controller, the first four channels can be used either for the ADC or
> the touchscreen and the fifth channel is used for the thermal sensor.
> If there is not a touchscreen controller, the one and only channel is
> used for the thermal sensor.
>=20
> This patch adds the documentation for the driver of the Allwinner SoCs'
> GPADC.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  .../bindings/iio/adc/sun4i-gpadc-iio.txt           | 57 ++++++++++++++++=
++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/sun4i-gpadc=
-iio.txt
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.tx=
t b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
> new file mode 100644
> index 0000000..aab768d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/sun4i-gpadc-iio.txt
> @@ -0,0 +1,57 @@
> +Allwinner SoCs' GPADC Device Tree bindings
> +------------------------------------------
> +
> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor=
 and
> +sometimes as a touchscreen controller. If there is a touchscreen control=
ler, the
> +first four channels can be used either for the ADC or the touchscreen an=
d the
> +fifth channel is used for the thermal sensor.
> +If there is not a touchscreen controller, the one and only channel is us=
ed for
> +the thermal sensor.
> +
> +Currently, the touchscreen controller does not have a driver using this =
ADC
> +driver. The touchscreen controller is currently driven only by
> +input/touchscreen/sun4i-ts.c which is absolutely incompatible with this =
driver.
> +
> +The Allwinner A10, A13 and A31 SoCs already have a DT binding for the
> +aforementioned input driver, thus an MFD driver matches the existing DT =
binding
> +(mfd/sun4i-gpadc.c) and replaces the input driver. No DT binding is requ=
ired for
> +these SoCs' ADC, everything is handled by the MFD which is matching the =
existing
> +DT binding for input/touchscreen/sun4i-ts.c.
> +
> +The Allwinner A33 GPADC only have a thermal sensor and have a proper DT =
binding
> +for this driver unlike the previously mentioned SoCs.

The DT bindings should be agnostic from the OS. You can remove all
mention of the implementations details in Linux.

(and you should wrap at 72 characters).

But we already have a binding document for that controller, so you
shouldn't create a new one, reuse the old one that is already there.

> +Required properties:
> + - compatible: "allwinner,sun8i-a33-gpadc-iio"

IIO is an implementation detail. The IP is called GPADC.
You're also missing reg.

> +
> +Optional properties:
> +(for use with thermal framework for CPU thermal throttling for example, =
and/or
> + IIO consumers)
> + - #thermal-sensor-cells =3D <0>; (see
> +Documentation/devicetree/bindings/thermal/thermal.txt)
> + - #io-channel-cells =3D <0>; (see
> +Documentation/devicetree/bindings/iio/iio-bindings.txt)

I wouldn't list that as optional.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--gnfzxbx72j2i2qmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYWT9uAAoJEBx+YmzsjxAg+tQP/3e2k/BlVCL9/mkVYNlQULjK
XphCMh005NeFjmXDKAwFZNpOT4zGI5466rmtJRRbbb0TKG4VzRYeSZJGSprTnFuu
CTCxLE2bbrKIKhMzeV+JyUmMfyCvVrBbbuE0mt3muvbr9sFru5sx6rC07u79ciMA
jzHo5naLVNoAL5O/KG9Sh1qGRTH60r0RiTckbBsbHcEz4WMxcqnqlPuiPIwGeLxI
A9TMONWWMZOoOnp9UuPrELT8olMTHs779M3lXLmHtXRrZP2kt0Gyo2CUM3zASnL4
3U+KLD5Pf8ABaC/epObua5KbC3WXkHKv8KsfCnkZh4VVW0gU+GvohinJW5UkXlO6
so+t36LDK7Kx9LC4akL443j3i1PpcKistpqTfyi5OYgT/HCozf/kVjy+T6DYccS9
URmgP5pyYjbcIn5gZrkjdiU5/uZuKvkJRSiudmoaBokXilDJ6mZ/lkL3NRMOwkZs
C/0hjG2xz6WLp3Qf5N0mr2LBZiw3ING10yK4v+4/9aGdMobUTW7hudASi6eVCtWw
PGzK9sRqlnJ6D93LGN7Dj5eNjK4WpgBxz7ZbeRPVl4Fzl5gG729uTMf0Ls5HTw6M
6FySqbQlhJRYv4JwHEjpERihwvslvISQemOJsE+4v08kEiSKCXWVdEBBzDlJnDEK
B6lfFcPuTxPJMH7byBo5
=32I7
-----END PGP SIGNATURE-----

--gnfzxbx72j2i2qmt--
