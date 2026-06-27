Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C61C5D72;
	Sat, 27 Jun 2026 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782569015; cv=none; b=HpICElIx240lX2oRSvhHYGHJC9ETloJ7lnO08QkPYMEqWkqS8xm3BFSV/u/gMoANvm2rnGG/x3YZE0m4CqhHSA6fvlA0V+mmWfeptoO5WvWZsfUiTBfTOfyX274GZWY1cFaSHRtkaoec2srM8al+qOjhX6W/8CRTLVmar/bexHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782569015; c=relaxed/simple;
	bh=2jp4dUgNN7qxpz2GlUubMNn0MTODUMmhv6mJ1wohE0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEDdE7F2t9mbQehCz2dgy84ocEp8d3V6jqQ0wzh6EZ26qdRqZPBEQCcGBtycQH15Bz3fi7qnHfL/2V/zTUDx5ZXnhZ2lvHr4HCNsIL2zq3zmtwBnR99rhPEmln5tTeHP8aGjgt92DyaYkeAw2PLpU/lraWFNK3GdfiCrCzUHVxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igug3ZAI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igug3ZAI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C381F000E9;
	Sat, 27 Jun 2026 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782569014;
	bh=9mCDnmGglO2sIeCdvnxemRXH84TvTrXTDYrvwilcTY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=igug3ZAIsoMLorqrCWKf6R3eZ6aVNgYxZIs6W4ojHX0Hps5V/wB3ef52NoUDS4Bfs
	 sHeL9YnpsVALScg+Norm49emNg1gr5W8PJeDxsr/pdQNy6d++j4CbfQqbpM8aVDnoR
	 A9J7GOeYtYc8Ooo1L59GRbfVih0XY8nCy9e1MQvDd+eCu1lrhnfYSakZ0/bbhb4VRd
	 8PMnXm9ptN5oRKI+NwnbWD2mCTktqjrPO57O+bq48VRXa/ID40zG3N8ioKJqtfObuB
	 vfxh7RVDDlRrshc4aAq+ghcUBn5cQRmBhajoTfZa/XMsCuz0yjsb4j48oVnSz+d8UL
	 VNKAjSAL2sQJw==
Date: Sat, 27 Jun 2026 15:03:29 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260627-corridor-word-0fbe89fd2294@spud>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-5-ceb9b0b561cb@baylibre.com>
 <20260626-rising-legged-dea08bb68bfe@spud>
 <82294468-c4cf-4003-93f1-31a113c79979@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cPC/5N2jzs1o5Frl"
Content-Disposition: inline
In-Reply-To: <82294468-c4cf-4003-93f1-31a113c79979@baylibre.com>

--cPC/5N2jzs1o5Frl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 01:35:22PM -0500, David Lechner wrote:

> >> +required:
> >> +  - compatible
> >=20
> > reg?
>=20
> I thought reg being required by i2c-controller.yaml was already good enou=
gh.
>=20
> https://github.com/devicetree-org/dt-schema/blob/2203c1720f4ebeebd7f8d10e=
9dc1812993482fab/dtschema/schemas/i2c/i2c-controller.yaml#L219

Nothing mandates that this is a device on a bus at all without requiring
reg, since that's a schema applied by the parent.
It's unlikely that that will actually occur, but I think properties
mandated by schema that are not referenced in a binding should be
required by the binding.

>=20
> >=20
> >> +  - avdd-supply
> >> +  - dvdd-supply
> >> +
> >> +dependencies:
> >> +  refn-supply: [ refp-supply ]
> >> +
> >> +oneOf:
> >> +  - required: [ refp-supply ]
> >> +  - required: [ "ti,refp-refn-resistor-ohms" ]
> >> +  - properties:
> >> +      refp-supply: false
> >> +      refn-supply: false
> >> +      ti,refp-refn-resistor-ohms: false
> >=20
> > I assume you've tested this to make sure it enforces the behaviour that
> > you want?
>=20
>=20
> yes

:)=20

--cPC/5N2jzs1o5Frl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj/YMQAKCRB4tDGHoIJi
0hkDAP0fT+KcpXeoZEwFJKmE0QbRfiO7M+R1m+EzEjRU5i4NegD/StMTfqxIlFFQ
QfFYwRqT3ot3StMAeHG4I9X2WnKIsg0=
=NIhp
-----END PGP SIGNATURE-----

--cPC/5N2jzs1o5Frl--
