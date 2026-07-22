Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3325C471CE6;
	Wed, 22 Jul 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738480; cv=none; b=m93MpvZuLKZpGGTVYgjsilX695+yEW7aj4SNpP1RZaYVMNZn2m3nAIoxxV2cgFuvkJDMFM1NwnJxoCwEXGuAAFIdyHPHAoc97ifOp87QHvFkxopkCp4utscWq4/sqn0RALHSB1hSAXQzCRXM0CIqrXL1POV9geBoGKcb29NQd28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738480; c=relaxed/simple;
	bh=wW0tlLmRKB3yn1pEjfqWKuREEjSG02ZA3bsa+Rxgndg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaCBoTaTDZyB6fyU1dtD0KGtB4sG0lhJ9OzyOYnuKo+Q+WYk0STS1AtvoiTWTzHgaMOYE4xRG2vGpWeY0Tc3JLiWnSBG8bdJD51FW3/ly6+DhuxCtXveEV2fzpO5sLBb42vHKFgUjLI1ZNKuNUjz7iCKRXq7mp+K9MJUz7IcRf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H15YIsFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H15YIsFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757E61F000E9;
	Wed, 22 Jul 2026 16:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738466;
	bh=i0W5hyfkCvqAR+XZ/dux08wP67JWfLwl7kFwlt6wDss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H15YIsFKaY3eiipW45Nfys2Y1vXJbGIcEjrEIhN6VsTypcqAYQKtjxVbq2LStkOH1
	 JI4fb8/hmuRI0uI9Esyr32/V6brHeo/fvS231q5OW119RLdHeX7oCSP9ZQWj+9zsGD
	 KrdadXD8ns0cDb7Yjv4088u8RBnSfUpWoT+9ZNwi2Gg76idAlw5Zkle4L0Qwbeafwp
	 GB5uFreAHScMCrVbo2lbtglEzQ7f1F5vOuth/EO7KPe2ux4FGNxQY5Sg+4+CGciBeT
	 MbNV7ztgiaFE+KB3KspjoBthc7r94F1pv+tg/FHi/3oF045rti8p8mQnvmchHOrPxA
	 TfPdF8G7djYDA==
Date: Wed, 22 Jul 2026 17:41:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 4/7] dt-bindings: iio: adc: microchip,mcp3911: Add
 spi-device-addr
Message-ID: <20260722-geologist-dormitory-6fee62af4999@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-4-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ukFgPAeoGqrC8m6y"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-4-7781cd74ad75@analog.com>

--ukFgPAeoGqrC8m6y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:16AM +0200, Janani Sunil wrote:
> Add the generic spi-device-addr property to the binding and deprecate
> the existing vendor specific microchip,device-addr property
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml | 9 +++=
+++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> index 3a69ec60edb9..36da2bee1db2 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> @@ -57,6 +57,13 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [0, 1, 2, 3]
>      default: 0
> +    deprecated: true
> +
> +  spi-device-addr:
> +    maxItems: 1
> +    items:
> +      enum: [0, 1, 2, 3]
> +    default: [0]

On all patches with a default, the [] are not needed around it.
Only change that if you respin.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> =20
>    vref-supply:
>      description: |
> @@ -86,7 +93,7 @@ examples:
>          interrupts =3D <15 2>;
>          reset-gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>;
>          spi-max-frequency =3D <20000000>;
> -        microchip,device-addr =3D <0>;
> +        spi-device-addr =3D <0>;
>          vref-supply =3D <&vref_reg>;
>          clocks =3D <&xtal>;
>        };
>=20
> --=20
> 2.43.0
>=20

--ukFgPAeoGqrC8m6y
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDynAAKCRB4tDGHoIJi
0ospAQDI7M30KPyev07laV/t1aDkGWNVyamrGRyB+JiG54geYwEApkaAzoZZ/Dfy
sHj1xxNZt/eI509IOF4RbOiiNOqFwwA=
=84Cf
-----END PGP SIGNATURE-----

--ukFgPAeoGqrC8m6y--
