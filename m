Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EE469842;
	Wed, 29 Jul 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345080; cv=none; b=A1U1dry/jk4z9T88onW/aTePOU4T9BiAhMxEB/ie7zlddF1nSotj1E6yzbq7VH2o/ADmXA8yeNnY/neG2y+3lxvgDt5K5yL/lL/iyMpyRg580/HdsyBHt7y/KSWInzcHxDWzapCIchaGJ2Bxsf9tnBPJuskdhPb3UxL5O0iElWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345080; c=relaxed/simple;
	bh=GIBr0e6Qohif1hY06+maXM2OC1Sl/W3PH7t2MyVcScU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNfmgPZRqeW5b+dBuNjHDk/+1JyEf4tYoJuihyAadRXzOza2BYOV/k8O1u/5WTcZZO568KT8tExyV0vOeK/L3dI9IG5SYQ4Mb+tCeEwxuG1l5nQygJQtK0h/j02r0uUVBM5WA7I92vbXREnVqpfioyB4meetNosrCdCgGNOccuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+xvFhIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+xvFhIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021B1F000E9;
	Wed, 29 Jul 2026 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785345078;
	bh=iXYKxTlvKOPippmrUXWMD36DOpAVWQ48cIit+L9UArY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D+xvFhIsKkKhmLHd4/ZZLEC8kNSyQ3xI5wXBZnn53LCrz03r22XcNQC1EUPzFHlyo
	 Nj7yeW6UkNXEQDrVfJw5cbemHzGETOMfgItY+j8kbXj55YFwrrnls23Smq1MRT5Na2
	 69p530IzNe0WckUJUnONj8N4gtOYc6W6g+apZ2D1C9GhzuFwd/YMvb28gE4PHPQxLi
	 sdg2h0Eea0N9QsZ1jXf+P+hLXvsqtvdb4+LIq/nQjGrSj3CqgI2fK+UatQtGFDwzhw
	 b00LG7C0tupWlFcalfGKV6Vh3GqxTkMFhqpTuIimCvaIz6Eei2qzAFLGoo7Bcd+nyx
	 OSDerIKTmR80A==
Date: Wed, 29 Jul 2026 18:11:14 +0100
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
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260729-empower-suitcase-bca517bf113e@spud>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
 <20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
 <20260721-clustered-jolliness-30d70a2acc49@spud>
 <20260724225738.2e090842@jic23-huawei>
 <20260728-selected-pancake-8fa8a066f95d@spud>
 <20260728214450.121b6a69@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3TzUSDQHa89c6W6X"
Content-Disposition: inline
In-Reply-To: <20260728214450.121b6a69@jic23-huawei>

--3TzUSDQHa89c6W6X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 09:44:50PM +0100, Jonathan Cameron wrote:
> On Tue, 28 Jul 2026 16:41:26 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Fri, Jul 24, 2026 at 10:57:38PM +0100, Jonathan Cameron wrote:
> > > On Tue, 21 Jul 2026 16:52:10 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >  =20
> > > > On Tue, Jul 21, 2026 at 04:47:11PM +0800, Kim Seer Paller wrote: =
=20
> > > > > Add device tree bindings for the Analog Devices AD5710R/AD5711R
> > > > > 8-channel 12-/16-bit Configurable IDAC/VDAC.
> > > > >=20
> > > > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++=
++++++++++++++   =20
> > > >  =20
> > > > > +patternProperties:
> > > > > +  "^channel@[0-7]$":
> > > > > +    $ref: /schemas/iio/dac/dac.yaml#
> > > > > +    type: object
> > > > > +    description:
> > > > > +      Represents the external channels which are connected to th=
e DAC.
> > > > > +
> > > > > +    properties:
> > > > > +      reg:
> > > > > +        description: Channel number
> > > > > +        items:
> > > > > +          minimum: 0
> > > > > +          maximum: 7
> > > > > +
> > > > > +      adi,ch-func:
> > > > > +        description:
> > > > > +          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for vo=
ltage
> > > > > +          output or CH_FUNC_CURRENT_OUTPUT for current output.
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        enum: [1, 2]   =20
> > > >=20
> > > > Please make this property a string. =20
> > >=20
> > > It's an existing binding.  I guess it is generic enough that perhaps =
we
> > > should make it a generic channel property and as part of that we can
> > > flip over to a string. =20
> >=20
> > Ah, if it is something already established then it can stay as-is.
> >=20
> > > We may need to create a top level channels.yaml to cover both ADC and=
 DAC
> > > channels though and reference that from both files. =20
> >=20
> > I mean yeah, that was one thought I had originally about the
> > spi-device-address property. I'm surprised there's already not more
> > commonality to begin with.
> >=20
> > Just how common is some sort of "channel function" property and how
> > many devices are bastardising other properties like diff-channel with a
> > virtual channel to achieve the same result?
>=20
> I don't think it is that common to mix different things that can be
> read on the same pin beyond a simple ADC / GPIO that we tend to
> handle by just not having the ADC channel specified.  Still there
> is clearly a non zero number of devices that do.
>=20
> I can't immediately recall the virtual channel trick you suggest
> being used except when it is routing from a different place
> in a SoC which to me is a different input via a mux, rather than
> mode of the channel.=20

It may be my lack of understanding of the devices, I just recall there
being use made of diff-channels to map to different internal references,
which felt like the kind of thing that someone might see a generic
"channel mode" property and use to achieve that goal instead.
I think the current approach using diff-channels is fine, even if it
isn't a real "channel" represented by a pin, I just don't want to see
two approaches for the same result (not that this particular binding is
doing that at all)

--3TzUSDQHa89c6W6X
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamo0MQAKCRB4tDGHoIJi
0t1IAQCK5TG2TzJwkgyLhjLEp8WPPLff6z6lHtL06dxokCExrQD+KaaObozNfhLK
DX+jr9aUjLtOgtIJtYR2Npjv511u6Qc=
=KTuR
-----END PGP SIGNATURE-----

--3TzUSDQHa89c6W6X--
