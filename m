Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2630FC1C;
	Fri, 20 Mar 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027677; cv=none; b=R8gM6RYZsAArzhmDoDxwyJfjjoZxUUxAht259bDYANsd9+csTTTkccDsW2VvmDrIvFx9vkHYLujkctlwN/QCADHR4KvKn/qO18hEhHpaFFofA1pRNVpHvtBw6e2ZTT0v9MfZgKlWs29e4Dg+C9i9cyR5jF9gTPccdrXNyUoDq9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027677; c=relaxed/simple;
	bh=4KSg/mC1Brq/I+O4ot7PUWTxjBi4Xx24ieXRdYK/7uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7sMAqlBQTq5y3OPaT/wKZSTdS3zUdZ2AAq6D+7ti4fbVKRTKyWSwDcooDghH6f2rEsN1qaQXmLFblG/LK92V/U1V/vY8AQ027nCRfRzqgBKHRAMUxgYOEG9ybpOVXKevV2T2QFuwJffLLxQaHqFOiELlrbvrYRq13tCKKtlafc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcrTVr39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcrTVr39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD80DC4CEF7;
	Fri, 20 Mar 2026 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774027676;
	bh=4KSg/mC1Brq/I+O4ot7PUWTxjBi4Xx24ieXRdYK/7uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gcrTVr39IEuoDLv9cc+djsdLX82oSClS8vjfMsOJU7nxgRGIJjgNEwC6TS6h2MmFg
	 hAsrPvfTyEAx9Y/zgKacHNIAeiXVdN8cXeQDsTu20wR3JfAqkHPgoaMmMzL3M/ZRrq
	 C5zZmoLDYhi40uYZd0lljGLuW8+B0IzQ4PlJZ5HGnZpKnYS2uFO5XfZ7ifEa7VunB3
	 G8u4nFwTokvptCkyuc+cirMrfKczqZui9GqUOv4fY3qwZIWBMFd3iPgznZj8nOGVv0
	 ibW3j/7ZNfMqcOl9EZzPIlZ368xolHAfEmSp14I1MniN/KUQaS5qkj+cdQO3TFy5Ap
	 iyCd5FUBeagpA==
Date: Fri, 20 Mar 2026 17:27:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Carlos Jones Jr <carlosjr.jones@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Liam Beguin <liambeguin@gmail.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Jorge Marques <jorge.marques@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2305
 support
Message-ID: <20260320-garnish-tremor-0892abd6ae86@spud>
References: <20260320140819.191700-1-carlosjr.jones@analog.com>
 <20260320140819.191700-3-carlosjr.jones@analog.com>
 <20260320-popper-uncurled-723c68d33554@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="95/NI02zBvZZV7RD"
Content-Disposition: inline
In-Reply-To: <20260320-popper-uncurled-723c68d33554@spud>


--95/NI02zBvZZV7RD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 05:27:11PM +0000, Conor Dooley wrote:
> On Fri, Mar 20, 2026 at 10:08:18PM +0800, Carlos Jones Jr wrote:
> > Add support for the LTC2305 2-channel, 12-bit ADC to the existing
> > LTC2497 device tree bindings.
>=20
> > The LTC2305 is compatible with the
> > LTC2309 driver implementation.
>=20
> Clearly this is not true, given the driver patches in the series.

Additionally, this is a binding so talk about hardware not drivers.

> pw-bot: changes-requested
>=20
> Cheers,
> Conor.
>=20
> >=20
> > Signed-off-by: Carlos Jones Jr <carlosjr.jones@analog.com>
> > ---
> >  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml        | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yam=
l b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> > index 5cc6a9684077..b246d492950e 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> > @@ -4,13 +4,19 @@
> >  $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > =20
> > -title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
> > +title: Linear Technology / Analog Devices LTC2497 and similar ADCs
> > =20
> >  maintainers:
> >    - Michael Hennerich <michael.hennerich@analog.com>
> >    - Liam Beguin <liambeguin@gmail.com>
> > =20
> >  description: |
> > +  LTC2305:
> > +    low noise, low power, 2-channel, 12-bit successive approximation A=
DC with an
> > +    I2C compatible serial interface.
> > +
> > +    https://www.analog.com/media/en/technical-documentation/data-sheet=
s/2305fa.pdf
> > +
> >    LTC2309:
> >      low noise, low power, 8-channel, 12-bit successive approximation A=
DC with an
> >      I2C compatible serial interface.
> > @@ -28,6 +34,7 @@ description: |
> >  properties:
> >    compatible:
> >      enum:
> > +      - lltc,ltc2305
> >        - lltc,ltc2309
> >        - lltc,ltc2497
> >        - lltc,ltc2499
> > --=20
> > 2.43.0
> >=20



--95/NI02zBvZZV7RD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCab2DlwAKCRB4tDGHoIJi
0jIwAQC2V8BHg756vepgumUxWqlTkZSQhPTbnugu9rdcZSq4lgD/WlvvyCXFPcq3
GxFYDZJu66O1PWUoRJp+UF5/miafxwg=
=9Jud
-----END PGP SIGNATURE-----

--95/NI02zBvZZV7RD--
