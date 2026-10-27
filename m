Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793133786;
	b=vad87G1Z64d+YGaePVg4OBaxgXRLzp4OdP1y+KTKO3qep9Ojy7hMh3e6QPTVpG5XQiDE
	 SnJyM/EmAOe/tVhHrWba+YTSyI6+6P39DAwzB35nQfAk2PNy0W8x/W90oEuCyFnjsCmEu
	 EVEnOUrQYzrRtLSE7g+Wb0Q4eJzKVXfbE2UmrRhq6JSai9006X0a5DbXHAoK9x93M5ntB
	 +Hvfq54zCfq8zAia5ScmfRGfAvuXYmtWRMEugnj8+2lL0y/Wjk5cA7XSl9aySlH/YlZPt
	 ARAbmAKIzwUfnaPTWRD9DGZXuA5qWp5dxPQEnAwd3wzxUzvVnZM/yFuJmW/FCfIwo7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793133786;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=f+BR3OM0F+HKfZEptGCURxUQqOvEQP7ahROv0C46Za4=;
	b=tL4cpQfnEm/G55k2ILWg4Y+VKeHYHb8MlxIvP7qD/NvF8W+/DxunNUOFUtlBTCbiHVDo
	 myJg/Ql2Cfc5VbG37piNTtRAJwDofnqSofgzCFsmAaqZJmK+LQRmceyMhMk9hkasL7nMw
	 CfuEwhmBXKJKu5pBaSRvuosDNBLP+UxDXRd9iU4kzsRp2hxlLl8zEuvuxowL4OS0z1WCV
	 qZer+y6+jD1ccQ/EaoN0oa4Kn2ri3V1u7jKkX/lRcKfFEnPnUyM0s4beXTaxVcxA1bUpk
	 Z8qMXC7be1Y0zdtXUZlcUSrzSSip2WDmOnJtL9aOj/e6IdhnGhLOJgMefpb4P8jhFBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlwwTbvw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC31606A31E;
	Tue, 27 Oct 2026 20:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlwwTbvw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DCF1F01825;
	Tue, 27 Oct 2026 20:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793133785;
	bh=f+BR3OM0F+HKfZEptGCURxUQqOvEQP7ahROv0C46Za4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VlwwTbvwhxRU0UFrnu3m/RTRfm6xYnQQ9H2mIUFOMvIfBtk2gJBKkcABTFJub/8FM
	 ZGe/3h1D0UkVAj+qwRU/ATs2TE9A7CeTGxqxF/hdSBhNTWj7pNEbQ7sv4H/5ATipB3
	 D8EjN+A+mvfxX8wshDWMmSaOPTemRbUfOSXtm37rh0+W4wFP5xZJl9EtqQ7sbGxfR3
	 e7vmEY1yrG3oUbZ23c00sV0jXembhzsFixqU9q8U5L1til6ecfrtZ4rSMbEQKlaCBw
	 qMcY97lQnCpGncGwt83BG7D7L8qYGWSUvINZxrO8ZnRJRzS60czEtG7VTawhjgsATK
	 WTljcChfNdWhA==
Date: Tue, 27 Oct 2026 20:43:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux@analog.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com,
	dlechner@baylibre.com, andriy.shevchenko@intel.com
Subject: Re: [PATCH v4 1/9] spi: dt-bindings: Add spi-cs-composite property
Message-ID: <20261027-colonize-primer-f994b88171a6@spud>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <e9308680e7b45ecf9ef2b6b2a752ffdd4d23b80c.1792435248.git.Jonathan.Santos@analog.com>
 <20261026020003.3f3fbe86@jic23-hlaptop>
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
	protocol="application/pgp-signature"; boundary="8RvJR8qKFINmKJHV"
Content-Disposition: inline
In-Reply-To: <20261026020003.3f3fbe86@jic23-hlaptop>

--8RvJR8qKFINmKJHV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 02:00:03AM +0000, Jonathan Cameron wrote:
> On Tue, 20 Oct 2026 22:56:41 -0300
> Jonathan Santos <Jonathan.Santos@analog.com> wrote:
>=20
> > Some setups combine several SPI devices into one logical device, with
> > each chip on its own CS line. All of those CS lines must be asserted at
> > the same time, so that one transfer reaches every chip.
> >=20
> > Add the 'spi-cs-composite' boolean property. When it is set, every chip
> > select listed in 'reg' is asserted together on each transfer.
>=20
> To me it feels inevitable that we will see a device / combination of
> devices that want groups of CS lines together and others independent.
>=20
> Seems less likely we'll see more than one set of composite entrees.
> Maybe this should be an array of values that match with specific
> entrees in reg?
>=20
> I'm not sure though.  Conor, Kryzsztof or Rob, any thoughts on this
> or similar things that have arisen elsewhere?

Why does the property actually exist in the first place? Does the device
driver not know how each CS should be treated?

>=20
> The most general case would (subject to it not working) smell like
>=20
> reg =3D < <0x1 0x4 0x5> <0x2> >
>=20
> Where intent is that 1 4 and 5 are meant to switch together and
> 2 is separate.

I would expect that for this kind of device, the driver should know that
the first 3 CS are switched together and the 4th is not. I'm not really
sure what the internal representation should be, because if someone can
make a device like this, they could surely also make a device where (to
borrow your format) it behaves like

| reg =3D < <0x1 0x4> <0x5 0x2> >

and so on. But if those devices don't actually exist at the moment, and
everything is either all together or all seperate, the API for this
stuff in the SPI core doesn't have to solve that until a device actually
shows up.

Worst case is something where there's a variable grouping of chip
selects, e.g.

| reg =3D < <0x1 0x4 0x5> <0x2> >

or

| reg =3D < <0x1 0x4> <0x2> >

but maybe if that happens the thing to do is permit reg-names for that
device, and again store the relationships in the driver rather than
try to convey it via DT.

Cheers,
Conor.

>=20
> How to do lookup on something like this is another question.
>=20
> Jonathan
>=20
>=20
> >=20
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > Changes in v4:
> > * New patch. This has been included because without an explicit propert=
y,
> >   every device with more than one 'reg' entry would have all its chip
> >   selects asserted together. That breaks devices that use ancillary
> >   devices for the extra CS lines, so the composite behavior is now opt-=
in.
> > ---
> >  .../devicetree/bindings/spi/spi-peripheral-props.yaml     | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props=
=2Eyaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > index 4894196c8f9c..456cb9095632 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> > @@ -60,6 +60,14 @@ properties:
> >        Delay in nanoseconds to be introduced by the controller after CS=
 is
> >        de-asserted.
> > =20
> > +  spi-cs-composite:
> > +    description: Some SPI devices can be aggregated into a single logi=
cal
> > +      device by asserting all their chip selects simultaneously. When =
this
> > +      property is present, all chip selects listed in the 'reg' proper=
ty are
> > +      asserted together on every transfer, treating the group as one c=
omposite
> > +      device.
> > +    type: boolean
> > +
> >    spi-rx-bus-width:
> >      description:
> >        Bus width to the SPI bus used for read transfers.
>=20

--8RvJR8qKFINmKJHV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauEM1AAKCRB4tDGHoIJi
0taJAQDxWUdJTEyrBBQwwB+5pQJE1sGp/SQvIm4Rog0nramvvQD7Bl95EY8505PG
qnhSurVHW18xxr9nxFNb2pEmo9W7uAA=
=TzEb
-----END PGP SIGNATURE-----

--8RvJR8qKFINmKJHV--
