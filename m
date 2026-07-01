Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261B643C06F;
	Wed,  1 Jul 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903887; cv=none; b=UByFasq+b2+oJRC3mzxkNHtiHfWPQrSgpxJP1vX5Iz0y+OzN2leV8fzZLXfpvkCwYQskT+HG6hbguLnCn/puYOeQvvNhBYsVxGj1+lljpJhkNujXqPUgaDsvE1zMrkjwNq+qc+A3vs6d5OoLBaTw2+JBJSP1mAXr8yKpO4XbV3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903887; c=relaxed/simple;
	bh=iNoJHRXlCQkKiqMlZrlzGN5KLrGu8DA2/8z4Ei4QI/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bklAYi1QXZ1pffa2gqM46+CpMYRAEmZt59AYEqk5fIwU3XtmecW74tbkDse4qH2jpS7Gq1Eiyakppve2cz3tmKSqJw1wZ5jqUXm8dhrT3/6nuLadVihBnqcOeWCl7NOZm2cKCuBIcIRM/w92kTN5yYJtfbmGHgrV9sxncYJhAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RgF0apzc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RgF0apzc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7721F000E9;
	Wed,  1 Jul 2026 11:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782903883;
	bh=AnOUujFcKX3gpwz4D3fgVf4ygLddSqv9i61Ak3jx5rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RgF0apzc2I8IGgQvXFBNTYGTj/QWPBWdU5Bh6iXatZRH4VqyZx+5vC0kZ0AeRgoD1
	 HIrJbxmsJ/d8btCgzU1jENoUJdZn347X5FUjLieGAxHA7BBwoOUTNJ2erhM/lYZAj/
	 kDldJSP0wW47BO3yL563p/nUT8y7CJQ63ssCuMY+0+CCaC823zHDMbWpWpaOWZEAcK
	 +zeQl9Mg/yc9srbtD6sFr7YUwaA2xThoefpcBJ5uhUIqp8kpBl87731KoZrtnvAtSe
	 tQJZV2J3BcyWH05lvsRFbo2NceNQcewoAeoFdJispYiHIoZAhcAHednAhBvPWLP7WO
	 epwBmjZFpULrw==
Date: Wed, 1 Jul 2026 12:04:37 +0100
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
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: spi: Add spi,device-addr peripheral
 property
Message-ID: <20260701-immodest-carrot-611d255656b5@spud>
References: <20260701-ad5529r-driver-v5-0-ed087900e642@analog.com>
 <20260701-ad5529r-driver-v5-1-ed087900e642@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VqqCijwUkRPHXQ13"
Content-Disposition: inline
In-Reply-To: <20260701-ad5529r-driver-v5-1-ed087900e642@analog.com>

--VqqCijwUkRPHXQ13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 08:40:39AM +0200, Janani Sunil wrote:
> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add a generic spi,device-addr property to document this per-peripheral
> address. This property belongs in channel or sub-device nodes of
> peripherals that use this addressing scheme.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.y=
aml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..3774e8018355 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -142,6 +142,11 @@ properties:
>      minItems: 2
>      maxItems: 4
> =20
> +  spi,device-addr:

To match other generic spi properties, s/,/-/.

However, you don't actually use this as a spi peripheral's property in
your device binding, so you've got your wires crossed here somewhere.

If it's a generic dac channel property (as you use it) it should be in
dac.yaml (or adc.yaml for the other device that I asked you to add it
for as proof of being generic), or it is a spi peripheral property and
needs to go into the dac node itself.

pw-bot: changes-requested

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Device address used when multiple peripherals share a single chip =
select.
> +
>    st,spi-midi-ns:
>      deprecated: true
>      description: |
>=20
> --=20
> 2.43.0
>=20

--VqqCijwUkRPHXQ13
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakT0RQAKCRB4tDGHoIJi
0oAXAQCicLyE78yFQYPOZCjJeHOLd/F4aci3owp0A2ld0WboDAD+PNHYrKK5luFd
0otItNvp4UEA7giSba5VSuOwoQ6lqw4=
=BtpN
-----END PGP SIGNATURE-----

--VqqCijwUkRPHXQ13--
