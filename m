Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E3392C5A;
	Wed, 12 Aug 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786507908; cv=none; b=rsXkY723ezcVS3Whi4hqAmrByKKRU4jCQyHdZ98Gog18Ol9ISSLFbPcpvlrJpOzSllG2D2uEy2U2cAyAVm+fkrb0389gkoFh/7pulTH0nVMufwlpDAzEQNl58V6mzLophh5OWm7lkiWvHqKrCAAGux2+UIkrkvo5clvBaLh6Gco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786507908; c=relaxed/simple;
	bh=/ubd83NkkdVIjRhWp/GkugYX1b2Sc3wpGm29lOgz1n8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZ9aL6MrM8FUAb1Iz7Us5fHuFfsf2BhImlubXGevuwYEvKFfQLRLdT5dFvZNE0W0r0Z1RtaKdG42zt52z1RQOJTTSibXMBDNaiC+X4+dzH3joBPQUc9IsksNjV0EIskawQqAQk6aQtNHA1ZyjecUDsZfF8anzxgzf3PRQogXYxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXiddU7Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXiddU7Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD3F61F000E9;
	Wed, 12 Aug 2026 04:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786507907;
	bh=OewTlPQjPE13SgKyOwT+b3HZrALNu4W7pkrsgSWb2Bk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aXiddU7QOmHQT6J9v4R7y6A3Hf8xsSr4vvZQo3l2tE5Uf/Yyo46LTHmk+nn1AUKBj
	 LcRjmXN+BJs+zYQwSednwj0SiNdWsItT8yd2di3SLrSoZClqDqJ8XbHK9RGjxfzxPa
	 xmmSHOnJByLNYHEMf1jFBoz/1dTmh5wEmSgiN+DpsvYJPe6tc1wcLVdh5h1rOowv7w
	 58M69aL9KCgFAVskei02Ins7nkqs2e+xXgWCWHMa4kvAAJ+w1tzQK5w5fU//5XwPX7
	 2OclwQvt6fJ2J3vHV/uVnJwrsqGqlHLw/M5O/0qcPqHCC6PewCxe6tBVXLwul6DWXE
	 gyiC7VH9M4KOA==
Date: Wed, 12 Aug 2026 05:11:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: ti,ads112c04: Add binding
 for ADS112C04
Message-ID: <20260812051107.204ae084@jic23-huawei>
In-Reply-To: <CAF7HswMcBx_DS4gLtsiy3ceBYBABF1ktJV4=+cDwAD9gLhP26w@mail.gmail.com>
References: <20260811-ti-ads112c04-driver-v4-0-ae704ac17241@gmail.com>
	<20260811-ti-ads112c04-driver-v4-1-ae704ac17241@gmail.com>
	<20260811-union-editor-1d475c5f32cc@spud>
	<CAF7HswMcBx_DS4gLtsiy3ceBYBABF1ktJV4=+cDwAD9gLhP26w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Aug 2026 10:53:57 +0800
Kyle Hsieh <kylehsieh1995@gmail.com> wrote:

> Hi Conor,
>=20
> On Wed, Aug 12, 2026 at 12:56=E2=80=AFAM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Tue, Aug 11, 2026 at 10:48:37AM +0800, Kyle Hsieh wrote: =20
> > > Add device tree binding documentation for Texas Instruments ADS112C04
> > > I2C Analog-to-Digital Converters.
> > >
> > > These devices provide 4-channel, 16-bit delta-sigma ADCs with an I2C
> > > interface, programmable gain amplifier (PGA), and data-ready (DRDY)
> > > interrupt output.
> > >
> > > The binding uses child nodes to dynamically define the connected
> > > single-ended or differential channels.
> > >
> > > Excitation current, burn-out current, and reference source properties
> > > are also included to fully describe the chip's hardware capabilities,
> > > aligned with the ti,ads112c14 binding conventions.
> > >
> > > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com> =20
> > =20
> > > +patternProperties:
> > > +  "^channel@[0-9a-b]$":
> > > +    $ref: adc.yaml
> > > +    unevaluatedProperties: false
> > > +    properties:
> > > +      reg:
> > > +        items:
> > > +          - maximum: 11
> > > +
> > > +      single-channel:
> > > +        maximum: 3 =20
> >
> > Can someone explain to me please why the maximum for this is 3 when reg
> > goes up to 11? What do the additional reg entries beyond 3 represent? =
=20
> reg here is just an index for the channel node, not an input pin number.
> The chip has 12 usable input MUX settings (8 differential pairs and 4
> single-ended inputs), so at most 12 channel nodes can be described,
> hence maximum 11.
>=20
> single-channel refers to the physical analog input pin, and the chip
> only has AIN0-AIN3, hence maximum 3.

Exactly as Kyle described - there is no right way to match reg to a property
when we have mix of single-channel and diff-channels. Hence in this
one corner case reg is just a magic number - though it may reflect
ordering of channel acquisition I guess, though we've never documented
that requirement in a binding.

We could restrict the differential to be only one direction which would
give max 10 channels (4 single then 0-1, 0-2, 0-3, 1-2, 1-3, 2-3)
but there isn't a huge advantage in doing so even though it is trivial
for software to flip the sign if other direction is wanted.

Note that we don't actually expect to see all the channels configured,
it can just be a useful to do things like single ended voltage at
top of a resistor and differential across the resistor (to get
allow current to be computed) - so it's not unheard to to mix
and match.

Jonathan

>=20
> Best regards,
> Kyle Hsieh
> > =20
> > > +
> > > +      diff-channels:
> > > +        items:
> > > +          maximum: 3
> > > +
> > > +      excitation-channels:
> > > +        maxItems: 2
> > > +        items:
> > > +          maximum: 5
> > > +        description:
> > > +          Additionally to AIN0-AIN3, IDAC1/IDAC2 can also be routed =
to
> > > +          REFP0 (4) and REFN0 (5). =20

