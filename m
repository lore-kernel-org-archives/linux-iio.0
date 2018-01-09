Return-Path: <SRS0=CXYM=EE=free-electrons.com=maxime.ripard@kernel.org>
Date: Tue, 9 Jan 2018 10:48:46 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
	sre@kernel.org, linux@armlinux.org.uk, lee.jones@linaro.org,
	linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 04/16] ARM: dtsi: axp209: add node for ADC
Message-ID: <20180109094846.fubahuqk5f4yuzrm@flea>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
 <d4de180d7f9555c3851f29a8c34d1f706cafd83e.1515486346.git-series.quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hdj2fkanbsoihfpk"
In-Reply-To: <d4de180d7f9555c3851f29a8c34d1f706cafd83e.1515486346.git-series.quentin.schulz@free-electrons.com>
List-ID: <linux-iio@vger.kernel.org>


--hdj2fkanbsoihfpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2018 at 10:33:35AM +0100, Quentin Schulz wrote:
> This adds a DT node for the ADC of the PMIC so that there can be
> consumers of its IIO channels declaring their consumptions via DT.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
> index 897103e..a2e0052 100644
> --- a/arch/arm/boot/dts/axp209.dtsi
> +++ b/arch/arm/boot/dts/axp209.dtsi
> @@ -58,6 +58,11 @@
>  		status =3D "disabled";
>  	};
> =20
> +	axp_adc: axp-adc {

The node nade should be adc.

> +		compatible =3D "x-powers,axp20x-adc";

And your compatible shouldn't have a wildcard but the first design
that introduced that IP.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--hdj2fkanbsoihfpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpUj/0ACgkQ0rTAlCFN
r3R+UhAAk1Oshtz6Bgg0vv4AScNZY6+QDECm5BpUz09dahVR2j56Oc1u2hvBdWI7
xGuGKoBUa0YIyAeU1RKBj56lkvZVQDDPAO0fUmm3hNuvxT6NE0WbzC4sYFHqVmyz
Szfm4L2t6TSLmnATeyE3s1QynQgpzjv9un5mPnkkfaTIFeXFPo3hM4CE40013M2e
iDUlXDwKJGBEySS0Z0mqc976IPfyFTToKfx9gL6J4xcxVroMgcNEgM4OpRRrH6K0
/xbncAFC+SjKJt0a6YpU+QUKs6CcWxFoisYXjv92tttKHwxz1mjXAEQcgmGjjI8x
PPTgXuWiu7ZEY82KVdl2P4jZPiJdwLmwceW/7XvK+6MKEvlxahJIv/uDjbjR5gWZ
j3UIIAdmveZVvYsRuQb4DA03DZXFuHG3SgJPBud7Z6x4qK6bmthKnVdK8dtrQ49I
3Q51fWb74Jm5V7t+cvF4rgaDU9wLULgnAe57AnbcVtwiwDv3m+aGGZgACDh29dI/
SRlmzamyypiwmKghQcynEWK25RWbrBmaKS9NrLdWRfYCxFKwathH7cWAddtnza6e
qzlVZI52uES8BE091HSSx1aXkiphRNm169SJtX6WlN18HdSK1zFsuEjFJ6oIbjfM
oAQh4WS6b3hVVxDnwKOk/0T+LEZDSjE6kT8b7NrLQ1A84pB3kes=
=BTB/
-----END PGP SIGNATURE-----

--hdj2fkanbsoihfpk--
