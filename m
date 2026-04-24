Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B37D3E123E;
	Fri, 24 Apr 2026 17:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050618; cv=none; b=KA1wvFzQNgcCnmwvkqxGiinanWDcB6U/IanhFz+YazJuTWPhwBRGNUmtfomV+BENxI8cLylfVODsNsbsSzONSDj52TGjstlh0+l15JN0FG7WTbuwIEfEgIpdAqYjWYixb6aXvxNjesEc6/mRypHKgUdG3d5PZ8qPnU2mtH75MW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050618; c=relaxed/simple;
	bh=pZTKz0r3FnQTUYi2TaeztC9J9FgJpRDBffiIPoBkYY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsJ7SZNtvyoq9JVB7Qhrm9tK2Jsdlk8x5iXAQfP5pRhNJxVwCMzbfq+QdTkZM6yifJApjX6twaktq2aa94P37oaMKv5TOFMG1qrDKX8sTNaGmQ0u8FQDkW7YoLmoH9ndtp1OM+AuwLQhkw6INfSvdRkrphuiI2V8JSBu6h7+rsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fS9D98lJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fS9D98lJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0D3C19425;
	Fri, 24 Apr 2026 17:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777050618;
	bh=pZTKz0r3FnQTUYi2TaeztC9J9FgJpRDBffiIPoBkYY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fS9D98lJIQIyTXmqy3F952YYTBx2qdbzdY/mJcg5SxDv4CRMwqrynvL3acboQOhG3
	 X61HWNPv0P0pXMScNf0GkZxLbjDvTBcqYeX7FWo1QY/ZjvCp1FIF5KQBqtGE4LUrRX
	 DCTj2Lt88Fs9vpV2/JDSw/Mr9+favwN5ez6ZENebE5evBL8hEkyX3l6ARwKd7VVFGR
	 0+HAxGlU0suln8u2RtaBFdAjxRogPXkjdhkKlfd4QWyW9lAp5genxjr51taT6VzBIs
	 lUSezKOEms3Dwpu0SItXU+ogM0IC9WNk4H1KW0UciRMURDWjKujV1bB/prKb1u0N1L
	 KEDrmPmCRf+rg==
Date: Fri, 24 Apr 2026 18:10:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 06/22] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Message-ID: <20260424-likeness-landmine-9ad041b89f0d@spud>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-6-ed7dca001d1b@analog.com>
 <20260423-revenue-sensation-c62f759e457a@spud>
 <p76mchyeawpgqghojx6ww4yrw3fxxv7u32clkn4wwa7hzb3yx4@52ivn6p5hxu2>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kLD5DQfEhrGS6/qD"
Content-Disposition: inline
In-Reply-To: <p76mchyeawpgqghojx6ww4yrw3fxxv7u32clkn4wwa7hzb3yx4@52ivn6p5hxu2>


--kLD5DQfEhrGS6/qD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 08:35:51AM +0100, Rodrigo Alencar wrote:
> On 26/04/23 06:32PM, Conor Dooley wrote:
> > On Wed, Apr 22, 2026 at 03:45:40PM +0100, Rodrigo Alencar via B4 Relay =
wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-sup=
ply
> > > property is deprecated. Certain devices require vref-supply to be
> >=20
> > Why is it deprecated? Is the naming incorrect?
>=20
> Yes, vcc does not exist. It is also misleading as it may sound as the inp=
ut
> power supply, but in fact it is being used a voltage reference for the DA=
C output,
> which has a proper name, vref.

Please put this information in the commit message.

> =20
> > > available once an internal reference voltage is absent. Still, this p=
atch
> > > does not add those as 'required' so that the ABI is not broken.
>=20
> ...
>=20
> > > +  vref-supply:
> > > +    description:
> > > +      Reference voltage supply. If not supplied the internal referen=
ce is used.
> > > +
> > >    vcc-supply:
> > > -    description: If not supplied the internal reference is used.
> > > +    deprecated: true
> > > +    description: Use vref-supply instead.
>=20
> --=20
> Kind regards,
>=20
> Rodrigo Alencar

--kLD5DQfEhrGS6/qD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeuj9AAKCRB4tDGHoIJi
0oJPAP0eDmdwnjHlvlMEp/TYr271yOQnfMMZ5TtbJamut7L1FwD/cEB9xyDwmbA5
Xn8j/91iIqgx4INknarYTPw0unanVwM=
=tMNn
-----END PGP SIGNATURE-----

--kLD5DQfEhrGS6/qD--
