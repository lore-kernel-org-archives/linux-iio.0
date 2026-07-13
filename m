Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC333DED5;
	Mon, 13 Jul 2026 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960195; cv=none; b=RPmHF6CcSIDU0hWFkjnq8dUUCRGa8BW5cDO77fcww261MGDHj6kBJ2j4q6I+00bT2AzyK9Be4oOZQGQH7KX5OLEPm0Sj2zykplJXqlMVKgBTK8pLsED8nl+CcQbP4WJmrP0gauD9J2tQFXkDslhiyAtNrfBk+M2FObZeFCE9Jlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960195; c=relaxed/simple;
	bh=/5NamrAGapwYvtSdpujNLyMcYke9gZ1D7Z/dKA4rnw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeDZj9iXnkioia3oXW0YpygEngFWLf/R6EfGkyMHi/Fw05zIKn796NiInW2gfPoBGeEMuKk7/DY1lNH518b45ER3kwnZnj9q6SCXC/9kvYhz4ygndZH++q0Fuf8pdyfc99qbZWNYBIhbrdQpFz1+22g21FAQ1YJnsSKcDQHqPdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtNwsJv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtNwsJv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C769F1F000E9;
	Mon, 13 Jul 2026 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960193;
	bh=bXbO/chk6y7FyoCU9nLg7OxlB75XzaKFkDdMqIuXb7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KtNwsJv3ie3pT4KyKms0cEwKHNBYUHfkEarGkYu0YRytdJUwlhGn3AvBX/BYSQPA+
	 kQnNFH62O4uPVOs0ZiVWE7//D8HIl2ADoYZ8Mefz7TBEmTuktoQoRbYRj6sqYpKUFn
	 yTf5MNxd2uakwKDOZI9llTx/FpvoRP4vKqsVeE1eRusUAwzccw5x5hgd/os7iAEAH5
	 ZJKcAdZIEauIllIxN3DfL4/tAz+kXu9aUXaU+Iik/d7g2j0gza0NqNhGRkZyx7pB4i
	 9rSk8f9V0HJ37g9Y+he+w/9a5bfR4bovwaJlH7KQ7L8NVsAwx0DKOJEI6VK3cjXIj7
	 Ubbjuy32PMslg==
Date: Mon, 13 Jul 2026 17:29:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] dt-bindings: iio: adc: add input-chopping property
Message-ID: <20260713-confused-petticoat-35ca17051b08@spud>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-4-746d52cbf1d0@baylibre.com>
 <20260713023443.1a7a9acb@jic23-huawei>
 <1700ed07-47b5-4831-87c5-a6115928baab@baylibre.com>
 <20260713082400.000024f1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Bb60V4uQEnIBlLxY"
Content-Disposition: inline
In-Reply-To: <20260713082400.000024f1@oss.qualcomm.com>

--Bb60V4uQEnIBlLxY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 08:24:00AM -0700, Jonathan Cameron wrote:
> On Mon, 13 Jul 2026 09:55:53 -0500
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On 7/12/26 8:34 PM, Jonathan Cameron wrote:
> > > On Fri, 10 Jul 2026 17:50:37 -0500
> > > "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> > >  =20
> > >> Add a generic input-chopping property to adc.yaml. This is a feature
> > >> seen frequently in ADCs that are designed to measure resistive loads,
> > >> such as RTDs and strain gauges. Enabling this can reduce offset erro=
rs
> > >> by swapping the positive and negative input channels on every other
> > >> conversion. This can have side-effects in timing and filter response=
, so
> > >> it is not always desirable to enable this feature in some applicatio=
ns.
> > >> Therefore, it is best to make this a property that can be enabled or
> > >> disabled in the device tree.
> > >>
> > >> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> > >> ---
> > >> v3 changes:
> > >> * Renamed property to input-chopping to reflect more common terminol=
ogy.
> > >> * Removed "allowed" from the description.
> > >> * Extended description to explain when it should not be used.
> > >>
> > >> v2 changes:
> > >> * New patch.
> > >> ---
> > >>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
> > >>  1 file changed, 8 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Do=
cumentation/devicetree/bindings/iio/adc/adc.yaml
> > >> index 308857f11220..c408feebd46d 100644
> > >> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > >> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> > >> @@ -80,6 +80,14 @@ properties:
> > >>        ADCs usually allow choosing between internal reference source=
s or a pair
> > >>        of external pins.
> > >> =20
> > >> +  input-chopping:
> > >> +    type: boolean
> > >> +    description:
> > >> +      If set, the positive and negative input channels are swapped =
on every
> > >> +      other conversion to reduce offset error. This generally comes=
 at the
> > >> +      expense of added settling time between conversions, so should=
 be omitted
> > >> +      on systems with high-frequency signals or high data rate requ=
irements. =20
> > >=20
> > > I'm lazy so I didn't check back, but in my mental model of this, the =
DT is simply
> > > saying that the analog circuitry is suitable for doing chopping.  Dri=
ver decision
> > > on whether to do it.  Perhaps we can reword it for that? =20
> >=20
> > Heh, that was the "allowed" part that I removed.

To be clear, what I was looking for before was a wording that made it
clear that this property meant the hardware supported it. "Allowed" made
it sound like a software policy thing rather than a hardware capability.

> >=20
> > I think this is really more of a design decision between the tradeoff
> > of less noise vs. data rate. By setting this property, we are saying
> > we should favor less noise. So I think it is more about the expected
> > signal than the circuitry.
> >=20
> > So not sure that I would add anything here.
> Fair enough.  Given the driver can always ignore what is in DT I guess it
> is fine as is.

--Bb60V4uQEnIBlLxY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalUSfAAKCRB4tDGHoIJi
0k4nAQDA4jvFTfm0KR2DHxewJACm6YsMIS+WsBDiGfiICegXSwD/WdL5ALguyS+L
xYl2akKY1G63OIedLVnhDUynPsw4Igs=
=XCX5
-----END PGP SIGNATURE-----

--Bb60V4uQEnIBlLxY--
