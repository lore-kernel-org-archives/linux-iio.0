Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1707466B0E;
	Wed, 22 Jul 2026 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738435; cv=none; b=g/+9D19/wANh1eIx7gN/d8A9H8nYq+ITkDdHBwFy5aCr8SELaUNjBeOs+1hGLubpb3uyOUDLmjJz7pPb0Oe2Uqb7qVPUd6mIfh4DACJA5VP37f/cEoCxvVSIFN5rn70qhfe9rxobJb2edjK6lWMCwn+JS4lcbpxYEdsV8KqwdEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738435; c=relaxed/simple;
	bh=OekAiUpw0fJgbiqQhrZUSIHYNvvzrJ89XJUT7a1/GEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIBH31Js1tMB2mJabrYPd9496Dkjyl5Vpbenw6MlcN1RKCLIsiZauqxhlD2s75F3zcJD9J768mreVOoFjslxg+ARA+t0rzPstrDv5c816vBOWsZ11IH3i1JMbf8yhxmIyJtWIdArZC81iELC/H4oHO3GpDR7TJk5LUZhK3P1+0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEVzDLkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEVzDLkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D6741F000E9;
	Wed, 22 Jul 2026 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738424;
	bh=tnU32CBkKmVKgN/5E636r1zskIwNaBl0pj98lS0BHvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OEVzDLkcZHUGab8gs2blUBMZAkbsHYyj3HKrpsadJ+rFDWWwG8WZsRo7Uu4UoCOrx
	 7UjOg/mMeYKNaGpsYdsL1YE/KtzJzmTe5MF7bVUTGZP8JEvAlZ0pNLzaL4eiU8GCa/
	 QD4hQSMYNY7pufqt1Et5xmIlUBSl7yMD+IALW7i1P0yqlg62MaAkB260TAe972xM43
	 fJ5Ir2dPOqJRPFvH6x/pLtQ85hjBdWcn6ApUdJIlcvBf8fxxMqvMYB+rCCWcHUEyh9
	 CT0cs19HfqevaW68fdlPRPtsT51aVQwOoUQQn1GC80JtdDUyA7cp6rwW/D/39eA4Xv
	 zLZu37zcu22KA==
Date: Wed, 22 Jul 2026 17:40:18 +0100
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
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260722-ricotta-dork-a7090c154adf@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TMbcBYokcPZCFi8R"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>

--TMbcBYokcPZCFi8R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:14AM +0200, Janani Sunil wrote:
> Add the generic spi-device-addr property to the binding and deprecate
> the existing vendor specific microchip,hw-device-address property.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++=
++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> index 675319276197..de1ea289e7f5 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> @@ -80,6 +80,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 3
> +    deprecated: true
>      description:
>        The address is set on a per-device basis by fuses in the factory,
>        configured on request. If not requested, the fuses are set for 0x1.
> @@ -91,6 +92,12 @@ properties:
>        clocking of the device address (BITS[7:6] - top two bits of COMMAN=
D BYTE
>        which is first one on the wire).
> =20
> +  spi-device-addr:
> +    maxItems: 1
> +    items:
> +      enum: [0, 1, 2, 3]
> +    default: [1]
> +
>    "#io-channel-cells":
>      const: 1
> =20
> @@ -123,7 +130,6 @@ dependencies:
>  required:
>    - compatible
>    - reg
> -  - microchip,hw-device-address
>    - spi-max-frequency
> =20
>  allOf:
> @@ -159,7 +165,7 @@ examples:
>              spi-cpha;
>              spi-cpol;
>              spi-max-frequency =3D <10000000>;
> -            microchip,hw-device-address =3D <1>;
> +            spi-device-addr =3D <1>;
> =20
>              #address-cells =3D <1>;
>              #size-cells =3D <0>;
>=20
> --=20
> 2.43.0
>=20

--TMbcBYokcPZCFi8R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDycgAKCRB4tDGHoIJi
0nxvAQCgF6OFY5W8jDQpZfJntEW5+7fueUAf3uWzLbH6DN7WhQEArqLCeLu0HnVx
ogACk0pweJO51Nl1tN3dMGcxNGQa5Q0=
=j4UJ
-----END PGP SIGNATURE-----

--TMbcBYokcPZCFi8R--
