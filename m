Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D1C381E86;
	Tue,  1 Sep 2026 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284757; cv=none; b=NFjEI6aquEOKEF5kyXbBz/1F44kmxM7nkmzPSviVwAmDAsb1Lr59SgawDiFK7hg8oNQVNFZWhyBP53z2qsbNTLhPB7kE9HxtgIb8I1YZXxxv8D6geoRSSAdOlKI8zG3YyamXIWMeDLBt9cemZGo6pvMSIwzjyUb2gTeEGwDoAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284757; c=relaxed/simple;
	bh=VlqLdlBjZsCvP/SqKVD99VktAZVRkGdOgEx2DPutAzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+gFk7CZIkLuzx+n/mqf7dkyz5a+cnCGcy9V2Nh67SKMw+9vsC7/Gki4z2x4dxeQQsZnLtrXEhu8MvzzhhQAnuGINdXEEtpDn2FfvBXpS5NW4PZ1aF8MbDqDeH4MezSVEPMsEKnB6a8aNNZiU0hCG5mvprC2MhzC884vOcMMwzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA9Qe+NK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA9Qe+NK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C421F000E9;
	Tue,  1 Sep 2026 17:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284756;
	bh=4+eJ05EYcYl/X2yON9wDovfRwDxzooILuabJR+fv504=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FA9Qe+NKBzwV2u9DBHwCoi2qbJ7p+OGK99XCzVkgTp+iNI2c9W0zblSyg2YsiPzXA
	 7ty+yQuHNqJ59bIOoCRwBqhYEE8NcGJ0TUhosW9pBlJiksVEHMN0/zsf16ut6ooR5d
	 6//Wphdjg2D+0JT18E3o2sWkVP/wD67HJmqREaibeyswOZAsppBxZX5rhFj12NMXbD
	 DKsd/UdQxKDARz8Fov6BLqJsDMDoISnEKaN/AI6MvGpOeH0R6GOQkt0fEBPqCb1+nQ
	 aDrnYVAHvDG4Cyf4/v/Kn1AI/pFLF5Pl1sEKCI05SFkO6b68GDdIEYO7+9I9Lj1S9o
	 ne4Wf6zYQc0fw==
Date: Tue, 1 Sep 2026 18:45:51 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260901-audacious-brigade-dafd881edf34@spud>
References: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
 <20260829-iio-ad5710r-upstream-v4-2-8af3121c7d21@analog.com>
 <20260831-singer-reimburse-defba31848bc@spud>
 <20260901041408.06d3f7ac@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wU39Wj9gfRz4w7fM"
Content-Disposition: inline
In-Reply-To: <20260901041408.06d3f7ac@jic23-huawei>

--wU39Wj9gfRz4w7fM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 04:14:08AM +0100, Jonathan Cameron wrote:
>=20
> Hi Conor,
>=20
> > > +  adi,range-double:
> > > +    description:
> > > +      Configure the output range for all channels. If the property i=
s present,
> > > +      the output will range from 0V to 2 x Vref. If the property is =
not present,
> > > +      the output will range from 0V to Vref. =20
> >=20
> > What was the rationale provided for this not being a userspace control?
> >=20
> Jumping in as I happen to read this...
>=20
> For DACs we often do it in kernel as potentially there is a circuit depen=
dent aspect.
> In extreme case leading to the bad kind of smoke. Normally it is covered =
by an
> output-range pair, but can't do that here as it is relative to vref (which
> we have no way of knowing in the binding).=20
>=20
> For input devices it is always a userspace thing to control.

I thought it'd actually be the opposite, with the assumption that output
devices would default to being off and so there wouldn't be smoke
production.
If you say it's normal, then fine :)

>=20
> > > +    type: boolean

--wU39Wj9gfRz4w7fM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcPTwAKCRB4tDGHoIJi
0kP+AP9FLNmXu8h5joF37v4O3WSNVbtZXoqJzJfCv0IwhsfoSwD/W8RyALsvb/OD
lkLDGV0JeqYl3S9qxvTJxhH/eYyc0QI=
=G+oK
-----END PGP SIGNATURE-----

--wU39Wj9gfRz4w7fM--
