Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbdASJRg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 04:17:36 -0500
Date: Thu, 19 Jan 2017 10:08:41 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        alexandre.torgue@st.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        gerald.baeza@st.com, arnaud.pouliquen@st.com,
        linaro-kernel@lists.linaro.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v8 4/8] PWM: add PWM driver for STM32 plaftorm
Message-ID: <20170119090841.GB28834@ulmo.ba.sec>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
 <1484749251-14445-5-git-send-email-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
In-Reply-To: <1484749251-14445-5-git-send-email-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2017 at 03:20:47PM +0100, Benjamin Gaignard wrote:
> This driver adds support for PWM driver on STM32 platform.
> The SoC have multiple instances of the hardware IP and each
> of them could have small differences: number of channels,
> complementary output, auto reload register size...
>=20
> version 8:
> - fix comments done by Thierry on version 7
>=20
> version 6:
> - change st,breakinput parameter to make it usuable for stm32f7 too.
>=20
> version 4:
> - detect at probe time hardware capabilities
> - fix comments done on v2 and v3
> - use PWM atomic ops
>=20
> version 2:
> - only keep one comptatible
> - use DT parameters to discover hardware block configuration
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/pwm/Kconfig     |   9 ++
>  drivers/pwm/Makefile    |   1 +
>  drivers/pwm/pwm-stm32.c | 398 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 408 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stm32.c

Similar nit than for 3/8. The canonical prefix for PWM subsystem patches
is "pwm: ". One other thing that I had missed earlier...

> +MODULE_ALIAS("platform: stm32-pwm");

I don't think there should be a space after ':'.

With those two fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliAghgACgkQ3SOs138+
s6HtrRAAnZsOmpLalY/26FajdGsIFN/HQeU/UWWSbSkKYOca08Vbs1/D/Vjt8rx5
U5Z6mYrJ7RUiH/Lx5A5HXK+0hw/wb2YD8uhU9e3bizwYcIi+n0tmLkHHjCEKy4U/
pSOKbZvC2ExOWECvA0Fkyek9iTpKm2kPRO1wYplrZjQD22Cxyl5ylUS7T/0FpFE1
3phI/pIyCTo70d12XfVGJnhbnuvSQhVuRSCwCCOvAlacKbjVgEE9tX3IiKC42TMH
RBHivUiV9bhA1X1j9+nG+CuVpCzT0QeNxS/SBrjwEVapMuwd2Zs/bn/Sh+sfN+kr
xV7RTX1isYVuktDQQ3nKVidbbr0cgnUwAreeV9zoDeY/wLuUwUufz3I1Q4UnArrD
CN+K88aOio2u1p9/aBe+6G0vAfIKrr7W/UB+NKyX0YdsZfQeteZIgHt0UaCYy261
BxmuwY3LtE8uHLdMM8ZbVmFmOOhd2IFCUxl933jUIVNURQiKGFfgA7BamX5iXMHw
N4bZIphSckfNzwQeHgO7Ik+hzI1ZwH+EM1sVDvx+3QYv1ks9CadhPriiSlXbamhv
PUHYgXji1h+m6sM1MLHMcx12OzWe/7axSGDfRlwnV9/cLMwOY3vusOt4eRJTmmlj
sWjoFq84eWGlQ3Z+epanWtJsJYCU7qgTOBmcvOMwjl/8RbtcWWA=
=yxku
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
