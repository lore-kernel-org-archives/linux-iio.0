Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964633E9C20;
	Fri,  5 Jun 2026 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675732; cv=none; b=FAdpsCaL6RnNNrMWd48FsnaccCy4mMRz3azFZGSW3LpvkOKjJT2y4Uev1r/VsqOfE4Wn9LiqgiPTvfcWfhwq1FsqMof/mUag3pHkMeHd3jHFxqEzrEq5b35N5SLJrAYOfeUtlzJnwxsy83OtbxUKAiHKMWUgdiaQNOYMDkIll7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675732; c=relaxed/simple;
	bh=XbSLzl6pFA6xif0oF4cItIdSkrqZNz1RLZfiCrG+VdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGg++FldgFtThXbv0S3NRkh+qG4aIuEq+b7Ogl1W/kIKnvwO4Yv8uIoymLgMZeI3iZGnsLZLGF6r8aPiLE+TxvwjNZVNnnW0NLgHvvcl3P1mipuufhMDkdPi9whvBwm4C8fTsatXd0PSfAXDS0f5xidlmNjypBmzpcz12kqDak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAAq858e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAAq858e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9FC1F00893;
	Fri,  5 Jun 2026 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780675728;
	bh=ul59WN0i4zJBKGXUt+eg5WQ5bQFYMrNYUeOZS+6MSHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EAAq858eJY7pY/eOqy18LoQRrVQo/djYiU3nxsrN9i8tqISNcQu+7lDEpmFGd6SZO
	 ZFZ7ewhzr8JL2Pm7t+qTXb3WsfRLwAW+5YyTDnITDYO5D3QpMb4Swnl5ZtDsXerHYM
	 qWldzCs+xtN9F6hyPpMdShTUStFzuTqGjLMb5UG1/7lBGABOMlDExMXakHMFBX8Fgg
	 P8Xm2Xk+Cx0ULi+orvVLXK+wSbZnTuAz5rxbXVdisDIbYIqTfbt+8+kUdpCMwVlT9g
	 m7HAaQRoF2m7h3H8SP/Wd/mxvIGlHG1zYmWqN4kPnasI/Jl6tkKRE32UfCdfSxWAeC
	 fnIXQ5Nu5cKaw==
Date: Fri, 5 Jun 2026 17:08:43 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Romain Gantois <romain.gantois@bootlin.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: ti,tmp117: add binding for the
 TMP119
Message-ID: <20260605-renovator-rented-a9451c8a277e@spud>
References: <20260605-tmp119-v1-0-349f45f17d12@bootlin.com>
 <20260605-tmp119-v1-1-349f45f17d12@bootlin.com>
 <20260605125332.151b92f8@jic23-huawei>
 <ft-705oeTSiaftSGNjv94A@bootlin.com>
 <20260605152005.4d888f6b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mQkYtBxmYAF/CHp+"
Content-Disposition: inline
In-Reply-To: <20260605152005.4d888f6b@jic23-huawei>


--mQkYtBxmYAF/CHp+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 03:20:05PM +0100, Jonathan Cameron wrote:
> On Fri, 05 Jun 2026 14:24:45 +0200
> Romain Gantois <romain.gantois@bootlin.com> wrote:
>=20
> > Hi Jonathan,
> >=20
> > On Friday, 5 June 2026 13:53:32 CEST Jonathan Cameron wrote:
> > > On Fri, 05 Jun 2026 11:01:35 +0200
> > >=20
> > > Romain Gantois <romain.gantois@bootlin.com> wrote: =20
> > > > The TMP119 has the same register layout as the TMP117, and a better=
 local
> > > > sensor accuracy. =20
> > >=20
> > > Sounds like (and the driver changes pretty much confirm) that this co=
uld
> > > use a fallback compatible to the tmp117.
> > >  =20
> >=20
> > What do you mean by "fallback compatible" in this case? Do you mean we =
should=20
> > do something like this in the bindings:
> >=20
> > ```
> > enum:
> >        - ti,tmp116
> >        - ti,tmp119
> > const:
> >        - ti,tmp117
> > ```
> Something like (I can never remember the syntax so this is modified from
> another binding doc and untested)
>=20
>     oneOf:
>       - enum:
>           - ti,tmp116
>           - ti,tmp117
>       - items:
>           - enum:  #enum here because once we have one we tend to get mor=
e ;)
>               - ti,tmp119
>           - const: ti,tmp117

Other than the cheeky comment, this looks okay.

>=20
> >=20
> > But wouldn't this invalidate existing device trees which only have:
> >=20
> > `compatible =3D "ti,tmp116";`
> >=20
> > > The second patch then just resolves the print that would happen on ol=
der
> > > kernels using that fallback due to ID mismatch.  That's fine but nice
> > > if older kernels can work with this part. =20
> >=20
> > Sorry I don't quite understand: since this is a feature patch, I don't =
expect=20
> > it would get backported onto older kernels. Therefore why would the sec=
ond=20
> > patch resolve the print happening on older kernels?
> >=20
> The point of a fallback compatible is that we don't have to backport anyt=
hing.
> New device tree comes along that lists
>=20
> compatible =3D "ti,tmp119", "ti,tmp117"
>=20
> will just work. Older kernel will think it has a tmp117 which is fine as =
they
> are register interface compatible.  It will print a message to say that it
> found an unknown ID but then assume it is what the firmware told it, here=
 the
> tmp117 fallback.  With your second patch in place, that harmless message =
will
> disappear for new kernels.
>=20
> Jonathan
>=20
>=20
> > Thanks,
> >=20
>=20

--mQkYtBxmYAF/CHp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiL0iwAKCRB4tDGHoIJi
0vqiAP41wvuLVWQwE1+pZFoQuNQ0JC0TT8y9lrCoyDvt8jsY4gEAxgqz/UPDTIMu
HDdqUOdV7QK8mDi8RbIrVYkfMOFWGAo=
=TA/d
-----END PGP SIGNATURE-----

--mQkYtBxmYAF/CHp+--
