Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A237DE8D;
	Tue, 16 Jun 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781643035; cv=none; b=qp4a4riTNlBOsHTBqrOwHGvDfzwM4VkOOWrQz0e5HzAGLNmnTopVEqPOrxSLXRLUNIHVjs3vdxNtkqySUiTuHyYfFbzKY8IxUON+rEp++7NA5wmbJaNtS5ij9ivD+tFImZ0YS1dG+nsOtPFJVL6Ra1g/sLcgXYNvpSDf2yEk9wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781643035; c=relaxed/simple;
	bh=wOTShQ7D0uDgK/74NO9OUl4dLJ2GzO068iJ/vtqq3dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXy/IwlazZ5CvnoigUmXThEYJYwRksZOsXaV8awyrv3QuDkUf9oWBFQ2NuNEJ5i64Adz+ms1Swcg73i0sXhA1nuQNU93TCe6dNsI7VRCkHv4aywZAGXyb2q5b0DXmAO7+22T5cm2AMxsPuDnUPfEJ++meQEqYS8YPHn1PLnYFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pq7kGHhJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pq7kGHhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A871F000E9;
	Tue, 16 Jun 2026 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781643034;
	bh=hf48CQyd+tNtxYSZCi4Zb4W7/R7KVT1tYL9M6VkfKYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pq7kGHhJN2U5/Mn4bKbQMx7I7/NeSbRzTOObuwKrzAWudIiXiiRcXFCgKSbLZWyZN
	 x3rzPVQN04ILFMC1b2kIovOMhm4L/ZOAbKR3/BNa9HOB9RtPF5E1SNtP/RdsgG/dfO
	 b0yT/f/KPxTqarzN+cgChY0q5+XUyL3+hS4D7vM3LyTffe1/SIGLIrvApSY9mJV5+3
	 ce6XJZKgweS3uYDx5h1/doJeh/wCe14eYq87Dew6CPf1SqkppP+SDV7AXhuFKdHBdo
	 Amo2wkjjGJcJ2RurBYHCv50Fr5OHnRelxdta5qTabLkDAGPwWq+RQhjisnCmCQC1J7
	 HgmUtc9MKQe1Q==
Date: Tue, 16 Jun 2026 21:50:29 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260616-livable-muster-d268af11dcc8@spud>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
 <20260616-spoon-ducky-b05e9bf7e999@spud>
 <4bc99611-4bf1-4797-ba31-6f1d7dee1e1e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RqdSxK09HwJUqVPi"
Content-Disposition: inline
In-Reply-To: <4bc99611-4bf1-4797-ba31-6f1d7dee1e1e@baylibre.com>


--RqdSxK09HwJUqVPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 02:54:55PM -0500, David Lechner wrote:
> On 6/16/26 11:07 AM, Conor Dooley wrote:
> > On Mon, Jun 15, 2026 at 04:59:59PM -0500, David Lechner (TI) wrote:
> >> Add new bindings for ti,ads122c14 and similar devices.
> >>
> >> This is an ADC that is primarily intended for use with temperature
> >> sensors. There are a few unusual properties because of this. In
> >> particular, the reference voltage source and current output requiremen=
ts
> >> can be different for each measurement, so these are included in the
> >> channel bindings.
> >>
> >> The REFP/REFN reference voltage is usually just connected to a resistor
> >> that is being driven by the ADC's current outputs, so there is special
> >> property for this case rather than requiring a regulator to be defined
> >> to represent that.
> >>
> >> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> >> have preferred an enum of strings).
> >>
> >> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> >> ---
> >>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 ++++++++++++=
+++++++++
> >>  MAINTAINERS                                        |   7 +
> >>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
> >>  3 files changed, 242 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.ya=
ml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> >> new file mode 100644
> >> index 000000000000..dc7f37cad772
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> >> @@ -0,0 +1,224 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Texas Instruments' ADS112C14 and similar ADC chips
> >> +
> >> +description: |
> >> +  Supports the following Texas Instruments' ADC chips:
> >> +  - ADS112C14 (16-bit)
> >> +  - ADS122C14 (24-bit)
> >> +
> >> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
> >> +
> >> +  These chips are primarily designed for use with temperature sensors=
 such as
> >> +  RTDs and thermocouples. The channel bindings reflect this in that e=
ach channel
> >> +  represents the conditions required to make a measurement rather tha=
n strictly
> >> +  just the physical input channels.
> >> +
> >> +maintainers:
> >> +  - David Lechner <dlechner@baylibre.com>
> >> +
> >> +unevaluatedProperties: false
> >=20
> > Weird positioning of this.
>=20
> IIRC, Rob asked that I do it in this order on another binding a while
> ago (the reasoning being that it was too far away from properties:
> otherwise), so I've done it like this on a few bindings now. It doesn't
> make much difference to me though.

Too far away because it refers to properties in the "main" node, but
appears conventionally after a rake of properties belonging to the
children?

>=20
> >=20
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - ti,ads112c14
> >> +      - ti,ads122c14
> >> +
> >> +  reg:
> >> +    items:
> >> +      - minimum: 0x40
> >> +        maximum: 0x47
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +    description: Optional external clock connected to GPIO3 pin.
> >> +
> >> +  avdd-supply: true
> >> +  dvdd-supply: true
> >> +
> >> +  refp-supply: true
> >> +  refn-supply: true
> >> +
> >> +  refp-refn-resistor-ohms:
> >=20
> > Missing prefix here and elsewhere.
>=20
> I thought we didn't need a prefix when using standard units.

You don't need a ref to a typedef, but you still need a prefix if it is
some random resistor that's specific to this device etc.

> >> +      ti,vref-source:
> >> +        description: |
> >> +          Indicates the source for the reference voltage for this cha=
nnel.
> >> +          0 - Internal 2.5V reference
> >> +          1 - Internal 1.25V reference
> >> +          2 - External reference (REFP-REFN)
> >> +          3 - AVDD as reference
> >=20
> > My usual complaint here about things you have to make macros for, could
> > these just be strings from the get-go?
>=20
> As in the commit message, this is an existing property name, so I didn't =
want
> to change the type. But I agree that strings are better for this kind of =
thing
> so perhaps I should just use a different property name instead so we can =
do
> it better.

I wouldn't get too hung up on that sound adc, particularly since it
seems to have been added without an ack from a devicetree maintainer.
If you were trying to share a driver or something then I'd consider it
differently but these seem to be unrelated devices.

--RqdSxK09HwJUqVPi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajG3FQAKCRB4tDGHoIJi
0r0RAP9wRetGd4on6QQvatyjnWxRFMCdHlDLL2n8iCOUvVFpcQD7Bmqh3I2srTz1
ktF3oe7d4v69/IA220p02oMbEvDbMQM=
=ibbO
-----END PGP SIGNATURE-----

--RqdSxK09HwJUqVPi--
