Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93971371CE4;
	Thu, 23 Jul 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824736; cv=none; b=O6MemCyj+CBk+eGLNefM510I1xPguu06WrRNtcZQtHr5wmzt941L8fU3CVa3B9NFj1i3RRnb85J/qpJ0mVzcFPEvTsLlK4UlctO0GuukXP9hAxY/XdAKSOAaXRh7mHSvPfHgXSqiqxoCZ7oTmAq9Qh8COZRFKNkwpi6u9Zz8tJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824736; c=relaxed/simple;
	bh=xqqmSrRj/8M3QJ7me4FICAL2kOegeBKLIy00ouuDChU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXElbPumSA55x1caEAITtSAM55RbOfHRKdDAKrVqGFHQdACfdCHocORvy2+JXuPogaa976cNLS7dYxtqxAk03VjIb+KoF0QYJu9geXyAdH/ccpNnXl4i4ihTHVr7QpJ4deOTDLBBdEYHMfqmiHimUqg9bDQQtnv5Q3pT4X3Atmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLPtuQC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLPtuQC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB3B1F000E9;
	Thu, 23 Jul 2026 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784824724;
	bh=NUtbrgiCB08tz19aytzvpoUCv+z9s+ZLAxUmFQ6krgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZLPtuQC5Bigx97ytIiev94l0CERbAch37EYc7klKH1w2Id35kHPHgU0FEIj3N03qk
	 liIuMxCvmXxCGHYlvvmJa30vZNDzFrBSZbMByAY6FhkYgs5LBFYM4pQwHljGpwUJLc
	 Pd926CCNxxfYoUJFBYbGIDfDBxLE34xCXQh/qIsoXEXL2oJLLjAQTlS1/WaZo4Mhxk
	 6Df4KlDfqWgIxYYbpRHbT8uZ25qAKCuzg3fnt6dgNmDNX7UBOgc16vLLjsJagJNG3R
	 80YJ26Twl6aqYr+wjRFCTKGt3rxbHzrbPaYDKJWFVWmQUZdpePdGvrAALf45lMk4cG
	 WbuQemIE31VGA==
Date: Thu, 23 Jul 2026 17:38:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: add support for MCP48FEB02 SPI
Message-ID: <20260723-festive-genetics-3645c8e0b318@spud>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
 <20260723-mcp47feb02_refactor-v1-2-ee59e63672bc@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3jW5PaZU2LYiWYtP"
Content-Disposition: inline
In-Reply-To: <20260723-mcp47feb02_refactor-v1-2-ee59e63672bc@microchip.com>

--3jW5PaZU2LYiWYtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 04:43:11PM +0300, Ariana Lazar wrote:
> Add the SPI MCP48FxBy1/2/4/8 part numbers, the spi-max-frequency property
> and a devicetree example for SPI usage to the existing binding.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

This is actually a v2, right? This was submitted before using a bit of a
different approach IIRC?
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            pattern: "^microchip,mcp48f[ev]b[0-2][1248]$"
> +    then:
> +      $ref: /schemas/spi/spi-peripheral-props.yaml#
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp47feb01
> +              - microchip,mcp47feb02
> +              - microchip,mcp47feb04
> +              - microchip,mcp47feb08
> +              - microchip,mcp47feb11
> +              - microchip,mcp47feb12
> +              - microchip,mcp47feb14
> +              - microchip,mcp47feb18
> +              - microchip,mcp47feb21
> +              - microchip,mcp47feb22
> +              - microchip,mcp47feb24
> +              - microchip,mcp47feb28
> +              - microchip,mcp47fvb01
> +              - microchip,mcp47fvb02
> +              - microchip,mcp47fvb04
> +              - microchip,mcp47fvb08
> +              - microchip,mcp47fvb11
> +              - microchip,mcp47fvb12
> +              - microchip,mcp47fvb14
> +              - microchip,mcp47fvb18
> +              - microchip,mcp47fvb21
> +              - microchip,mcp47fvb22
> +              - microchip,mcp47fvb24
> +              - microchip,mcp47fvb28
> +    then:
> +      properties:
> +        spi-max-frequency: false

I think these should be squashed into one conditional, since you can
just do "else: spi-max-frequency: false".

pw-bot: changes-requested

Cheers,
Conor.

--3jW5PaZU2LYiWYtP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamJDjwAKCRB4tDGHoIJi
0gFeAP9Q3VXIpqXoEHAO2ZimnIKQw161ZDmWK40BJ7bFZ4IqsQEAxXtAk/dRqjwo
vnTViJ9BSNDwb/ZZomTpx80CrIeByw8=
=1RmV
-----END PGP SIGNATURE-----

--3jW5PaZU2LYiWYtP--
