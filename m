Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196776;
	b=1hnyJ3W0j25t0+RNCsJN80EOnuYZ4EAEB7lO2kq6PLn6L0dk0/2yBSsFv8T+s9m3V5sA
	 nqLb8tnz+kQbt/NADFQ17I0UaY8c2ApJt4LyFF1ZYdrtdPKlbCY6P3WbBLd6CtrF4OENb
	 QM6rfF1D52plcHFaKFjLguJoZ84PSIlSKfZQQJsi4WbEUSzCAQP8OmOaI3koPyuQ7kzuS
	 Rv3E8zSMsqG0tA5u5L3qPOVIsPQKp1HZb84RNAIPS89EKPhagj3F96RsjqAKZrWQhTDKt
	 7JUEpJDWbnWSd5gdeTfR/br9XtkNlXRaMvnuX67Wn9H7WFn84QrnLP7QN+yRk7DKg4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196776;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jLgQOuzTKOXqp5iPO/5XjN5oSy2mWLZ0jeyaHOSnxyo=;
	b=vnt/L3k+ll5qXOhw2yv5idiqbEEjHXl6jKyEvIAOf2gagxcYx3UxelI9ZUV3FjO59V+R
	 2ypxh6Ss0Tq/UV/ZpCn+LtRGYbgbx1dOWmWKGUrUVI651SAEseykK/bpC3PtZN/8ga4Pk
	 BdEcynNHzVJOaS2jMn0mCZrgMrERrJSoTfGSxBIbyCi5/2FyE4zP8WC37+1rwLhH5faFX
	 bTcWejQ2vsjVI2xAp/PIuDMrDnam3FA21R+/7/y9uSg3Rt+NDd281omvRE9jLJAZzwfOx
	 6JQK0dLCYPru+Y11bYpStB7OcSnUbdtxuSktCUnkNdYK3hkSeaSc4QtItbpxOB/HLUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTb9HuJj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02CD60A2630;
	Fri, 20 Nov 2026 17:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTb9HuJj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AD671F000C6;
	Fri, 20 Nov 2026 17:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196775;
	bh=jLgQOuzTKOXqp5iPO/5XjN5oSy2mWLZ0jeyaHOSnxyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FTb9HuJjiPkK4UeHqIuVDBi1+/V48U+AElO1VDy1tiF/TR0NFYzfHGriTeA3NLBcs
	 1WKPL2q9NALIbFLgTsD0Y7KgY14G81OTu6f5vbMbzrPY/b67S/E8BdZw8EZ3StFa6C
	 gxcX3uxeuShuJHjPJ9gO7+IRLNrzji+UVfjEtj/jR0I3ZGk7aP4if8YAP+JeSyKFxn
	 cylS16CGP88MqQtce+sAGGnK1s29puLKerw8xmtpQbVu98T/YcGSeLFwbIDkZcSqng
	 8ufRayIzgXBJZafHaxhwGbluQYsNxbQoPnmpU1xDDsLy6+zCrkUxyx10HDqRLHtojS
	 RkHLgEAjXeoHQ==
Date: Fri, 20 Nov 2026 17:46:10 +0000
From: Conor Dooley <conor@kernel.org>
To: ilyas.nhasse@skf.com
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adi,ad7124: make interrupts
 optional
Message-ID: <20261120-deflator-purifier-c746b2f9bba6@spud>
References: <20261120-ad7124-no-irq-v1-0-7826c5c3fd25@skf.com>
 <20261120-ad7124-no-irq-v1-1-7826c5c3fd25@skf.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ssy/PeTYiItMv06N"
Content-Disposition: inline
In-Reply-To: <20261120-ad7124-no-irq-v1-1-7826c5c3fd25@skf.com>

--Ssy/PeTYiItMv06N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 12:26:47PM +0100, ILYAS NHASSE via B4 Relay wrote:
> From: ILYAS NHASSE <ilyas.nhasse@skf.com>
>=20
> The AD7124 signals the end of a conversion on its DOUT/RDY pin, which is
> also the SPI MISO line. Using it as an interrupt requires the board to
> route that pin to an interrupt-capable input as well, which is not always
> possible, e.g. when the ADC sits behind a digital isolator that only
> carries the SPI signals.

What does this actually mean? Does the isolator only permit data
transmission when CS is active?

>=20
> The end of a conversion can also be read from the RDY bit of the status
> register, so the interrupt is not needed to operate the device. Drop it
> from the required properties.
>=20
> Signed-off-by: ILYAS NHASSE <ilyas.nhasse@skf.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> index 2e3f84db6..875f46477 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
> @@ -76,7 +76,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> =20
>  # Can't have both clock input and output at the same time.
>  not:
>=20
> --=20
> 2.43.0
>=20
>=20

--Ssy/PeTYiItMv06N
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawCHYgAKCRB4tDGHoIJi
0g3CAP0Zp14QyKNTagalhSAa0XQLh7NGvKG9uqTL3oEst42lcAD/c8+7CG9Z1unB
ph8qDUtGAdNJ+QJdr8Q9M7IANw090wM=
=L0aO
-----END PGP SIGNATURE-----

--Ssy/PeTYiItMv06N--
