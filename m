Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6F5391838;
	Tue, 11 Aug 2026 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786467420; cv=none; b=DWiw1WjNpmRxLGFPAxDX8FizzUoMC+KwoTQpA0W+tksjVA9b0F+XhQvRxpSxLjdJ4den4XkuvwtGkUucBoSR3rgvoSj3f11q7Ngk9rm6MsA+6KsRFvFFk1UIFPX2WJ5dl3GR0FjLcnmIcCicfmTIF4nLUA6bjBMJNgU5NHCd6Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786467420; c=relaxed/simple;
	bh=B/1R3Za+bYlnS2jc27vTpTe8B0MpnGypuWRrb9vlQN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlAXxBWxOCebO3D/mBwCDWzM9Z80EtA8MxZR6XTfVmP5x5hv1LMRaWaTElg1c13JvdG4zx9nj8hyhVtAnxtSQJGMoqveebNLyrGQaLk+XfH/zx9e4jgBtcdHZAc7EN8RBfq2wKVv5BRq2u/ctR3U1NxTetboyj1Wbf0uuf4nqIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXia/w/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXia/w/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C441F00A3A;
	Tue, 11 Aug 2026 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786467418;
	bh=u7Ga2u3WJeJkmGEXpgxW++RoKSByICNL0O8971tEMjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RXia/w/Taz4o6r+cjZqJeQ7uDzObNSqHijN5V9TjXh0BF4hYv7cXUjvonx8QACZjq
	 8Y6t7mkApuf2U07mUywRnUPdowKBc2qv0RsGxJrQf/XRzo8QgBoUHc/57TbIxMennG
	 TYpJkQtVdoB46nhtOiGRpCd9Z/p1gnYRcP6C/sbZ64wOfcinqY5Gr2j9H8iqozioQI
	 yO8hdlfOxWLGP5Am+tWnSuDVgA3djnsV5W/EYMaW8gDHR5frOL9Si/RI3hBZtvb0oC
	 +6u2FTcZspnub5sB3kSLksy9JhrsOCxzFqKZWcIbmrG7GjnKl0BvdVF5kv9Ee3XaRe
	 6l/rckFsxaGPw==
Date: Tue, 11 Aug 2026 17:56:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
Message-ID: <20260811-union-editor-1d475c5f32cc@spud>
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-1-ae704ac17241@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZsMcRRs1xLRlXNye"
Content-Disposition: inline
In-Reply-To: <20260811-ti-ads112c04-driver-v4-1-ae704ac17241@gmail.com>

--ZsMcRRs1xLRlXNye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:48:37AM +0800, Kyle Hsieh wrote:
> Add device tree binding documentation for Texas Instruments ADS112C04
> I2C Analog-to-Digital Converters.
>=20
> These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> interrupt output.
>=20
> The binding uses child nodes to dynamically define the connected
> single-ended or differential channels.
>=20
> Excitation current, burn-out current, and reference source properties
> are also included to fully describe the chip's hardware capabilities,
> aligned with the ti,ads112c14 binding conventions.
>=20
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>

> +patternProperties:
> +  "^channel@[0-9a-b]$":
> +    $ref: adc.yaml
> +    unevaluatedProperties: false
> +    properties:
> +      reg:
> +        items:
> +          - maximum: 11
> +
> +      single-channel:
> +        maximum: 3

Can someone explain to me please why the maximum for this is 3 when reg
goes up to 11? What do the additional reg entries beyond 3 represent?

> +
> +      diff-channels:
> +        items:
> +          maximum: 3
> +
> +      excitation-channels:
> +        maxItems: 2
> +        items:
> +          maximum: 5
> +        description:
> +          Additionally to AIN0-AIN3, IDAC1/IDAC2 can also be routed to
> +          REFP0 (4) and REFN0 (5).

--ZsMcRRs1xLRlXNye
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCantUUAAKCRB4tDGHoIJi
0uXNAP419etxKcz2HNSl4Awhxc7uZQe4W1I+bCRflNZ0CuWUKQD7BheSUA08mAxh
T26a4flDWaeTxbKoYczMndukD7peyQg=
=Khh5
-----END PGP SIGNATURE-----

--ZsMcRRs1xLRlXNye--
