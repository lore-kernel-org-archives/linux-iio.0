Return-Path: <SRS0=/4Xl=7X=gmail.com=thierry.reding@kernel.org>
Date: Mon, 21 Aug 2017 09:01:52 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: lee.jones@linaro.org, benjamin.gaignard@linaro.org, jic23@kernel.org,
	robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
	mcoquelin.stm32@gmail.com, benjamin.gaignard@st.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 4/9] pwm: Add STM32 LPTimer PWM driver
Message-ID: <20170821070152.GJ18996@ulmo>
References: <1499445068-7037-1-git-send-email-fabrice.gasnier@st.com>
 <1499445068-7037-5-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yr/DzoowOgTDcSCF"
In-Reply-To: <1499445068-7037-5-git-send-email-fabrice.gasnier@st.com>
List-ID: <linux-iio@vger.kernel.org>


--yr/DzoowOgTDcSCF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 07, 2017 at 06:31:03PM +0200, Fabrice Gasnier wrote:
> Add support for single PWM channel on Low-Power Timer, that can be
> found on some STM32 platforms.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v3:
> - remove prescalers[] array, use power-of-2 presc directly
> - Update following Thierry's comments:
> - fix issue using FIELD_GET() macro
> - Add get_state() callback
> - remove some checks in probe
> - slight rework 'reenable' flag
> - use more common method to disable pwm in remove()
>=20
> Changes in v2:
> - s/Low Power/Low-Power
> - update few comment lines
> ---
>  drivers/pwm/Kconfig        |  10 ++
>  drivers/pwm/Makefile       |   1 +
>  drivers/pwm/pwm-stm32-lp.c | 246 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 257 insertions(+)
>  create mode 100644 drivers/pwm/pwm-stm32-lp.c

Sorry, this fell through the cracks: changes in v3 look good to me:

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--yr/DzoowOgTDcSCF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlmahWAACgkQ3SOs138+
s6FpSA/+M1LOfcDighjGNT30Mg2BweHOjofGflgkNv2iFm2fP2ywvZW8+2GqwBII
+X0DK4YnzywZANeyO3QtH+p5PoNB4PZsFVfkgoLFYR2Rry16EllckT1SuFQHvcb9
sj7msnrir26TEK3r8uAFpm+4K30RldFiGkrNfND+Ai1IUIjwCW2TJ27x164vVT1Z
a8J8tkyLoLpevUem6p7nOvPjLhauG38y4ldQl5WuWBF2y/fGNuVHWongYGmdJJwY
jpxXyMqNg/H4tHrcFqVOiSblBfRr+DA6xB3KJqrds/iPCAyHDTdpGq3QLxmZljf+
RAH+Z0Qav69lH4T7xuzcBbZmp5Jihs44xvJx9RVgRxYnMlx3hrX6MNbwoPsl3Gjj
7uYB3IWuGpKWLG/dMmCRBn2ejp6+bMBhDc5x0Bs88V8sE3r99j30DBOWa5uoOKQ4
1j2ggJ6KEd1GE5Als55XbpUylAr3Y76xkncQH9YQRKeex8JAqcIsoAjB3LBCy1Az
dauV34lZZ81CbNU0l82NlE7DCJOuCdr6dzsnhe47mOaipxpffwdWGkjxHPJatYr0
aDWY85wubH0TALSj9XlYFapLKtn3q8dOLtbwvkwU5QWe85hR2OQCyoI1BYfGIxTc
96Xiyj49I2QGa6V9cNz2ZCuyPHL2qCrcdlU0+vL9Byj9fdCqnh4=
=xq8L
-----END PGP SIGNATURE-----

--yr/DzoowOgTDcSCF--
