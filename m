Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6263002C8;
	Wed, 12 Aug 2026 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550635; cv=none; b=QxInQIdi99HERxq/MPRKeOAN/S2E5eMaCAZzvaUppbRqhd3aqNyPmzyNE1b7eiF7/CKhlwg2ZWW629hhasiAsGa48Xp/NrcMBZtTCVLnlMfCmDl+PDTEnAdpeqrIQQzqyPKl2CJWLUvtQdHlhRqwx/P3m1030bbSpzCQjtNPQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550635; c=relaxed/simple;
	bh=5dTc2XtnsAOJkTVU7goXjBLfRMlxIncQUOmpnqBZLbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOtfw4k62d5ufS/Lqs3g82u7MBaKp929RA/IL8E9qys01W6bWCVAeNqeqL+qtdgKZJboVq4Pa/wEP2MoICEJosXfXFGgLbDP+sxd2DkqsK858W3CKCSQNWJ4JcSsy95Zfv46ioBVSPQ+gGfUDP0PpP9J7hjPztpn5DQa8J2xmPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFGnJ22d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFGnJ22d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E451F000E9;
	Wed, 12 Aug 2026 16:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550634;
	bh=3TxMVPEUbs7/WJ/FGn9J8i8hfqblqPhEam02QjMxGEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oFGnJ22d/mVWYwGuvQSxzqG7mKBnHJhybyHTerRWgSlMWR1E5TEIerZyH3V0t3cEo
	 CIo5NMow0nCiWY+50X27AA5BaNqJMyEsXC01cIM0kBnj79dDsFNaCuhtd+BvzpqQ8R
	 Ws8izNSDIwNc+1GUwrayU+aMcinUFuGhUmTcSqrsVTeqb+HgzaCnKlIf4nQxMCm0sC
	 PIZMfxKd9dQT+juWNwCHy437BexXwWcZUGhgjEOGoXQ53BBA+5zdhuOA0xafrbTNjG
	 SJY5umTGSjGEmLktZTk+Iroke5YfSu9jWp2U/MaKuIEbzzQOGHGjVVXK8f/Zi1M08J
	 A+42irHxOdLNw==
Date: Wed, 12 Aug 2026 17:03:49 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kyle Hsieh <kylehsieh1995@gmail.com>,
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
Message-ID: <20260812-kindness-compactly-2c3f5bb1f0a2@spud>
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
 <20260811-ti-ads112c04-driver-v4-1-ae704ac17241@gmail.com>
 <20260811-union-editor-1d475c5f32cc@spud>
 <CAF7HswMcBx_DS4gLtsiy3ceBYBABF1ktJV4=+cDwAD9gLhP26w@mail.gmail.com>
 <20260812051107.204ae084@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iQVZFxmxc5fBXIth"
Content-Disposition: inline
In-Reply-To: <20260812051107.204ae084@jic23-huawei>

--iQVZFxmxc5fBXIth
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 05:11:35AM +0100, Jonathan Cameron wrote:
> On Wed, 12 Aug 2026 10:53:57 +0800
> Kyle Hsieh <kylehsieh1995@gmail.com> wrote:
>=20
> > Hi Conor,
> >=20
> > On Wed, Aug 12, 2026 at 12:56=E2=80=AFAM Conor Dooley <conor@kernel.org=
> wrote:
> > >
> > > On Tue, Aug 11, 2026 at 10:48:37AM +0800, Kyle Hsieh wrote: =20
> > > > Add device tree binding documentation for Texas Instruments ADS112C=
04
> > > > I2C Analog-to-Digital Converters.
> > > >
> > > > These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> > > > interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> > > > interrupt output.
> > > >
> > > > The binding uses child nodes to dynamically define the connected
> > > > single-ended or differential channels.
> > > >
> > > > Excitation current, burn-out current, and reference source properti=
es
> > > > are also included to fully describe the chip's hardware capabilitie=
s,
> > > > aligned with the ti,ads112c14 binding conventions.
> > > >
> > > > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com> =20
> > > =20
> > > > +patternProperties:
> > > > +  "^channel@[0-9a-b]$":
> > > > +    $ref: adc.yaml
> > > > +    unevaluatedProperties: false
> > > > +    properties:
> > > > +      reg:
> > > > +        items:
> > > > +          - maximum: 11
> > > > +
> > > > +      single-channel:
> > > > +        maximum: 3 =20
> > >
> > > Can someone explain to me please why the maximum for this is 3 when r=
eg
> > > goes up to 11? What do the additional reg entries beyond 3 represent?=
 =20
> > reg here is just an index for the channel node, not an input pin number.
> > The chip has 12 usable input MUX settings (8 differential pairs and 4
> > single-ended inputs), so at most 12 channel nodes can be described,
> > hence maximum 11.
> >=20
> > single-channel refers to the physical analog input pin, and the chip
> > only has AIN0-AIN3, hence maximum 3.
>=20
> Exactly as Kyle described - there is no right way to match reg to a prope=
rty
> when we have mix of single-channel and diff-channels. Hence in this
> one corner case reg is just a magic number - though it may reflect
> ordering of channel acquisition I guess, though we've never documented
> that requirement in a binding.
>=20
> We could restrict the differential to be only one direction which would
> give max 10 channels (4 single then 0-1, 0-2, 0-3, 1-2, 1-3, 2-3)
> but there isn't a huge advantage in doing so even though it is trivial
> for software to flip the sign if other direction is wanted.
>=20
> Note that we don't actually expect to see all the channels configured,
> it can just be a useful to do things like single ended voltage at
> top of a resistor and differential across the resistor (to get
> allow current to be computed) - so it's not unheard to to mix
> and match.

This kinda thing is what I expected, I just was not sure.

I forget if I have to:
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--iQVZFxmxc5fBXIth
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCanyZZQAKCRB4tDGHoIJi
0jJHAQDtcfyRPQeJETfGXjlpUbDiXXZy+m3P0p18QaAAVF6/CAD/RjAzKYxDuwfT
L1Lxy/mKUlSoi+wMKX/0y2W1n/+RegI=
=WHG1
-----END PGP SIGNATURE-----

--iQVZFxmxc5fBXIth--
