Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9553D324B06;
	Wed, 28 Jan 2026 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619615; cv=none; b=Se8tuudGdJ314qC9XIpYOYiGTxzE2nY4dyB6vVKRptiS2h4ITvjjDFb0uU2FH7/tZj+DW8JQWsBxpr3nNwjeOQ1lKLnqnOG3rnr2/mnxD1RxFSciewNlOJkiRwVHQlWcduIhQIW0dCKN/btCzVxm3IIQKC63hLcoLVLwWYjwkxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619615; c=relaxed/simple;
	bh=vyPijSiORLrhf1vw8XfUJJuj6sjnbOIb/14ClasAikU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDEHtno64N72zkv9QDL4dEfhqkLvj8wI6Aa1UFUAD0mMGqkiJYe11KatTYAjD/xLRfdis9wNDX9hz8AxuJ9c9aMdEKbh8WzJYKg2LJirsyP65PxXO0CuYrTyLXu1E70mgNmJpRhsgumq4ecPR/MPeaAK0yGGo9QKWwFa4CWk020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owcsb6Gn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owcsb6Gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEB7C4CEF1;
	Wed, 28 Jan 2026 17:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619615;
	bh=vyPijSiORLrhf1vw8XfUJJuj6sjnbOIb/14ClasAikU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Owcsb6GnWtzfdY6z+v3eDATFep3K4bF0Hd09BiEFyNsjArbt0ODIFhX8PGXxVk512
	 ur6ESHMAcEleL5EI9g+t2zk9+qQz8VCtfWYLXAmT+7EhJeDmvDJp7h6yhngrAWxKpW
	 7ohPXYtLV2pntprsn4K1JNEW2fM3rUCEvXgV5wIThTMCKd31eebu3o35oLFzaOqVnp
	 MNVcSqwd8kDlUBSdM0vqiSEkF/RONY28vulehojAOuwVQb7rbkjdkSVeT8asvQ0Usr
	 EKEs+H9G4oB6Jzm3zJ4ZivRXUn2zWlUxBzjNicLjnxEIAIOL8wpSCgMwigI13Atpzo
	 eRdkeLmp4XUBg==
Date: Wed, 28 Jan 2026 17:00:10 +0000
From: Conor Dooley <conor@kernel.org>
To: David Jander <david@protonic.nl>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260128-omit-bubbling-9224777f4071@spud>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-3-o.rempel@pengutronix.de>
 <20260127-consonant-vividness-13707c7cf8f6@spud>
 <20260127-rockiness-finalize-e0b50b9d823f@spud>
 <20260128090118.5c1d7906@erd003.prtnl>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m6BRV1LwaCRhnwbk"
Content-Disposition: inline
In-Reply-To: <20260128090118.5c1d7906@erd003.prtnl>


--m6BRV1LwaCRhnwbk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 09:01:18AM +0100, David Jander wrote:
> On Tue, 27 Jan 2026 19:55:26 +0000
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Jan 27, 2026 at 07:49:20PM +0000, Conor Dooley wrote:
> > > On Tue, Jan 27, 2026 at 07:09:33AM +0100, Oleksij Rempel wrote: =20
> > > > The Maxim DS4422/DS4424 and DS4402/DS4404 current DACs determine th=
eir
> > > > full-scale output current via external resistors (Rfs) connected to=
 the
> > > > FSx pins. Without knowing these values, the full-scale range of the
> > > > hardware is undefined.
> > > >=20
> > > > Add the 'maxim,rfs-ohms' property to describe these physical compon=
ents.
> > > > This property is required to provide a complete description of the
> > > > hardware configuration.
> > > >=20
> > > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > > ---
> > > > changes v2:
> > > > - make maxim,rfs-ohms a required property as the hardware range is =
undefined
> > > >   without external resistors.
> > > > - add allOf constraints to enforce 2 vs 4 items in maxim,rfs-ohms b=
ased on
> > > >   compatible string.
> > > > - drop explicit $ref for maxim,rfs-ohms to fix dt_binding_check war=
ning.
> > > > - update example in binding to include the new required property.
> > > > ---
> > > >  .../bindings/iio/dac/maxim,ds4424.yaml        | 36 +++++++++++++++=
++++
> > > >  1 file changed, 36 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424=
=2Eyaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > > > index efe63e6cb55d..400afd8771aa 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> > > > @@ -27,9 +27,44 @@ properties:
> > > > =20
> > > >    vcc-supply: true
> > > > =20
> > > > +  maxim,rfs-ohms:
> > > > +    description: |
> > > > +      Array of resistance values in Ohms for the external Rfs resi=
stors
> > > > +      connected to the FS pins.
> > > > +      - For DS44x2 (2 channels): 2 values required.
> > > > +      - For DS44x4 (4 channels): 4 values required.
> > > > +      Typical values range from 40000 (40 kOhm) to 160000 (160 kOh=
m). =20
> > >=20
> > > Add here
> > > maxItems: 4
> > > minItems: 2
> > >=20
> > > Are 40kOhm and 160kOhm actual max/min values, or just a suggested ran=
ge? =20
> >=20
> > Datasheet for the ds4424 seems to imply they're actual max/min values:
> > "Input resistors (RFS) must be between the speciifed values to ensure t=
he
> > device meets its accuracy and linearity specifications."
> > In that case, consider also adding something like:
> >     items:
> >       maximum: 40000
> >       minimum: 160000
> >=20
> > Although, that would complain about the 5100 Ohms you're using. How come
> > the example lies outside of the "typical" range?
>=20
> Sorry to chime in here out of nowhere with this, but 2 things:

No no, don't apologise - that's good info and makes sense. Thanks.

> 1. Rfs for DS4402/4 has a different "typical" range than DS4424 (different
> Vref and different output current range).
> 2. "Typical" or "recommended" ranges should not translate to a hard limit=
 in
> the driver. IMHO, no max or min value should be enforced here.

--m6BRV1LwaCRhnwbk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXpAmgAKCRB4tDGHoIJi
0mjLAP42bZ+VfG5ssTl5dKm/yhQ90F96Jm0tk+aXu3nH3zl9/wD/SvHoYPb9PnMC
BRCG/zHPh2OhiMc1AYSKeIwdz0E4Zgk=
=uaEK
-----END PGP SIGNATURE-----

--m6BRV1LwaCRhnwbk--
