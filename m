Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196279;
	b=mHqRQh42e7qLEY3IDBJ3HU1iIaqP3uyfJiwV2c4kYtWN72yrLXxnDaIaD0Ii8R4x+VKz
	 GAKyi7Xc8be7VOvdqnZYGJYYD+kWd9SMPR+5At8GNDPtNQJO7AMbMx5vBjBzGsxzLVevk
	 eSkqZbAN4QytvHmryq/zkq0tijTHiQWKYA9v/arEEqrmXHej+HqKOsJqekgJAaiWf270j
	 8eLE8CyALle3pnLMxkgtCSCrSjgHVgIfZEOtv+ORkONOCskJM2f589dMm5tl36CEwTTn1
	 xk3u47PMhN6fUQgE8y0EGy1unqB7+1/YZy4MiQ02vCW467MS5hoSsFxdaxXejeHeDiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196279;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wQw7a5KD+lvlLW/FKesRQ2UDET7CuP00cuxNZsjJY6A=;
	b=ITliNwqT3hSyCtaEoZeFQEUTL2WCWky4NDfd33uxz5jy65vMozSgrZ9Uh0kfFAKEQeuO
	 TK51OYHxNqYU6XYX1v0u6rIAOG/cZslYJBvP78dlgBufkaVY/0PpTyUdj8M47xjgjjF0E
	 00lyH9mEXt7kfgDaBodjMz60qTnKb6i16M2rYuwsqrXPdShZDzQEaQ67xippjRnAaAlC9
	 TivwyFI/3wdPpVfN86PuZZNg8/0zf7wEwRHTM8xXWn7atsAFZQamVTc74xB9ZF4ajJ04J
	 XaqC3zEXqZMy3KXginNuaZA4DEXrcsd84sRojbf66Q8a2FTVLu9Pc8GPGrobfwhg10w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dhi5Dptv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEDE606A320;
	Fri, 20 Nov 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dhi5Dptv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94581F000CF;
	Fri, 20 Nov 2026 17:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196278;
	bh=wQw7a5KD+lvlLW/FKesRQ2UDET7CuP00cuxNZsjJY6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dhi5Dptv/B8q787JJw7fs//I8i+zc6erq7OquEqDJonWjIucS2ds5XZYPJJJdQ0xA
	 Lhen6+jFtmj/3Dod5hTlR05BckqBoxoJR4POBPp2MANbeNtltOcQiq+KHnX/cUNo7u
	 AwWHqZlQnMEd0jMP0NzmoJFm4vGUIxyY/4I2d+9gm3Wy67aVZoJgY0fMpRkZhkbT9a
	 ijvDhFZqlqsBEXbAi534bvNthhZidvVfMgMs0uZ9Jdt90Lv3CKApaNeIhTlzcynhSq
	 +rcqpjMQdQ05smvpZB8kP2aXj67Lq78bwLNtZgAPwInem1unPEFZfiFDDGu6TymkzX
	 goe3u2OARb+3g==
Date: Fri, 20 Nov 2026 17:37:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: Support ROHM BD79111
Message-ID: <20261120-unneeded-rockiness-7225e7368478@spud>
References: <cover.1795009599.git.mazziesaccount@gmail.com>
 <f69b996cc07fad1712871fb8b0436c71abd435b9.1795009599.git.mazziesaccount@gmail.com>
 <20261118-ancient-ominous-4f2a4a37369b@spud>
 <bf0dd82b-e1a5-4ab9-9ab7-1641181d303f@gmail.com>
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
	protocol="application/pgp-signature"; boundary="KhCEy9qpaczk0nKs"
Content-Disposition: inline
In-Reply-To: <bf0dd82b-e1a5-4ab9-9ab7-1641181d303f@gmail.com>

--KhCEy9qpaczk0nKs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 02:01:36PM +0200, Matti Vaittinen wrote:
> On 18/11/2026 19:37, Conor Dooley wrote:
> > On Wed, Nov 18, 2026 at 04:19:11PM +0200, Matti Vaittinen wrote:
> > > From: Matti Vaittinen <mazziesaccount@gmail.com>
> > >=20
> > > ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO device=
s,
> > > where pins can be configured to be either used as GPIO or ADC inputs.
> > > ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being=
 IRQ
> > > sources.
> > >=20
> > > The main difference is amount of channels/GPIOs. The BD79112 has 32 p=
ins
> > > for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
> > > promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  wher=
eas
> > > the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
> > > clock.
> > >=20
> > > Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > >=20
> > > ---
> > >=20
> > > Note, I had to change the 'root-level' additionalProperties: false to
> > > unevaluatedProperties: false in order to allow the properties in the =
new
> > > allOf:
> > >    - if:
> > >       ...
> > >=20
> > > section. It seems to me this is what a few other bindings in IIO do, =
but
> > > I suppose it makes this "less strict". Well, since I am terrible with
> > > writing bindings, I'd better point this out and ask if it's ok, or if
> > > there are better way(s) to handle this?
> >=20
> > I don't think you should have to do that though, since the children are
> > described in the same file.
> > If you instead retained the pattern properties section, and lowered the
> > restriction to channel@<any number> with reg with the max of 31 and in
> > the conditional section constrained reg to a max of 16 does it work
> > without the unevaluatedProperties change? We typically want properties
> > defined at the top level and constrained in conditional sections anyway.
>=20
> Gah. Either I don't know how to do this properly (which is likely), or th=
ere
> is a slight caveat. When I tried to do what you suggest, the binding allo=
wed
> channel@X, where the <X> was is out of the range. Sure thing this was cau=
ght
> by 'reg' being out of the range, but it still allowed odd combination of
>=20
> channel@X, reg =3D <Y>, if Y was in accepted range.
>=20
> I suppose the 'X' and 'Y' in previous example are expected to always be t=
he
> same, but I would still like to catch this type of an error.
>=20
> I am about to spin v2 where I use the BD79112 limits (channels 0 to 31
> allowed) in the pattern properties, and then do:

Yeah, I kinda fucked you a bit here sorry. I just mentioned this way as an
easier way to fiddle around/debug it than having to meddle with the
regexes, with the intention of following up promptly when you replied
saying that what you have done for v2 is how you would implement it in
practice.

>=20
> "^channel@(1[6-9]|2[0-9]|3[01])$": false
> to exclude 16 - 31 from the BD79111.
>=20
> I am not super happy with it, but it seems to work and is still decently
> understandable even for someone yaml -illiterate like myself. :/ (At least
> for as long as we only have ICs which don't increase the amount of default
> channels. That might cause the exclusion regexp on other ICs to become
> ridiculously long or hard to read. Well, I don't have such ICs on sight f=
or
> now.)
>=20
> Well, let's see what people think of it :)
>=20
> Yours,
> 	-- Matti
>=20
> --=20
> Matti Vaittinen
> Linux kernel developer at ROHM Semiconductors
> Oulu Finland
>=20
> ~~ When things go utterly wrong vim users can always type :help! ~~
>=20

--KhCEy9qpaczk0nKs
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawCFcAAKCRB4tDGHoIJi
0qXJAQCt/f1dlG1xM9NeqXhl6z52zsXZVscTXAtq+KBGGQ7oNQD/TyvuEcK5uHbX
auCxt69y6ycAL9UxXLGcpQ7wceubswg=
=vug2
-----END PGP SIGNATURE-----

--KhCEy9qpaczk0nKs--
