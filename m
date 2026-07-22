Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFB5466AF8;
	Wed, 22 Jul 2026 16:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738405; cv=none; b=WxxKW1uCFmwRbarmkEUQn8Xn37foE7MYE7oUz3PseABfKZH8T8FnO/jVv+ActGMm88W2A1xX8mdtGBnE7H4UWmboDN5OHihXhJEjbJz7Q72JXISlUDYdALALOL4sZcH/1d3cgLjMLq/PefrRZ3dw5xpwoU8fO5PmlvwERKs/9c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738405; c=relaxed/simple;
	bh=tE5uM9Z1EPzh76wbbn21PvunRuLJBSUhKmpqsQ+B6/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe+9ohA8dicmBhN8eGmxhdgi3Lsd1al1pDyN0oY/Lx6uIvZodaEjXbyA+X1sCNkHYmyMWDyw50rL/53IbdGRD82M1BNM6wLxfDjPryg0Y9okpwXDaFAy6iLKGSijqN60FjGa7hO1fbdtUrkQetXDrZAl9P1DqWq9J9JGn9Mq6LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+95murp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+95murp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637201F000E9;
	Wed, 22 Jul 2026 16:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738399;
	bh=X3wo9eXamq5zyVmvp9/n/58jybhQeC5d9jc3qnkFcbg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c+95murpuwGwp2CsQKEyTrAUOIDyJA2NAT6A1dSC+SyNs2VypkhigBoq0tUe4ll4L
	 Gk6gRQtnifGHPSYfiZEUhFfIsijwB8LXYL820jQoXYl/JL0HTwdhDCjWgPKPTIjlN/
	 bb3agJqpYMhPV8vsJ4xyKN+q4DzRcvhPNfUPyOCmM2/Ex+E8Z/Rm7MrvW5hSrCqUZ2
	 NsjXhJkrt3Xu91kc8MnuCYklsHvhVDMW0aKNXyf0MXn5JjvyB+ml4qqWvoh4IJ/Ke8
	 EntdAM6QrdZKnfgMvmrqfAVjWdy1o9xVTdmlldWa382TvwAOlcXVYAJpPddwHW4nwW
	 GOqmaLH7Jf1zQ==
Date: Wed, 22 Jul 2026 17:39:53 +0100
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
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <20260722-shoptalk-sublevel-35d09e42e31d@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DggL9MJQ1qQLOaWj"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>

--DggL9MJQ1qQLOaWj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:13AM +0200, Janani Sunil wrote:
> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add the generic spi-device-addr property for describing these hardware
> addresses. The property is placed on the SPI peripheral node and may
> contain multiple addresses.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> ---
>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 7 ++++=
+++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.y=
aml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..b59d047cf117 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -142,6 +142,13 @@ properties:
>      minItems: 2
>      maxItems: 4
> =20
> +  spi-device-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Device addresses used when multiple peripherals share a single chip
> +      select. The array allows one logical peripheral to comprise multip=
le
> +      physical devices, with one address per device.
> +
>    st,spi-midi-ns:
>      deprecated: true
>      description: |
>=20
> --=20
> 2.43.0
>=20

--DggL9MJQ1qQLOaWj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDyWQAKCRB4tDGHoIJi
0h1KAQDTB46Bc6YjeSV2N2juSvJr6KG9K0sx4I+eKl05TCSsxgEA5czT1f+Ss4nr
0J8oujhpbbCD7B4mj5u+r5JKdsC7ZQE=
=Jbch
-----END PGP SIGNATURE-----

--DggL9MJQ1qQLOaWj--
