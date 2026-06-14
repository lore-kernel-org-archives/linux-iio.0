Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893461F418F;
	Sun, 14 Jun 2026 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459760; cv=none; b=sUV8WhBs3K64v/4BcQ6I5ZbcoqCr4tBvOJj1H1fGSmr+9P3qF80sshJJwglSKDIrY6joP5ExEL/i6nS2g9tJiqKlNI9/3jwXymviWUM5Hn40rpYS9NvskwDp3I0X86VwB6zTuXeeN6PG6ddOY5omzMU0QylxiRDkZSp61HC4nUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459760; c=relaxed/simple;
	bh=sQeWZoYE0XAQ19pbkxpsBEqVZvj1SqpTqB2U89AGOYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjFgXzjI+3/j2BB3yMZmwW0Guq9z0A12TJ1b1Azd+1y9xtzulcAIREyldw5qopL5N9mzjTjG/hmcdJKotPeVjkyO60petsXwjhQhpTAxJc1C1SjnDowxwHC7OQMl0deHLop8Y4iECNHqGGWMBEp7/EGBBz+Ku1tC3WmWqpqb5b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQb2+5Sg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQb2+5Sg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5831F000E9;
	Sun, 14 Jun 2026 17:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781459759;
	bh=3wX+k8AweJr41Uh+HSAbbs1fTO5cz53wP8fll9P+6Os=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KQb2+5Sgf0JGq3GnvMwk34F055JhJcQ88Jv8RSP3QbDYMROnVzKWKNR/uiysy0XjQ
	 C4UO47/CSialCtT7pUlG1KflOZ4ANk2BjZTRYLmeRdYILHL99fYG4L9QECd6FWWCWL
	 BZAC4eYrHVM+dye9xLyGU6BVQVSZPFxc3+y9EZ2nVwOrHgxAA9zfZHUJtbUIbu+Hp1
	 aIRaKNmsKhNzJcW9ZXVXTHqYz/dD+baDuEb6zZUH3Ne6R5qjHAdsikgXddPYvxU/or
	 HezVeWdXRWzW4b6Rp37NZkoJhXXYr1gpvRTmeFG95SkIQ4Bx9KCrYzRC79WhGpkfaa
	 rctpDX2k1zN2g==
Date: Sun, 14 Jun 2026 18:55:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Jinseob <kimjinseob88@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC v4 1/6] dt-bindings: iio: add Open Sensor Fusion
 device
Message-ID: <20260614185551.10ca9e0f@jic23-huawei>
In-Reply-To: <CALMSew+cL0_kG6W15RapxLtE+Fw2_DYdrYoRFSjENQktWw2H4Q@mail.gmail.com>
References: <20260607234343.22109-1-kimjinseob88@gmail.com>
	<20260607234343.22109-2-kimjinseob88@gmail.com>
	<20260609-glacial-colossal-38b4937ec620@spud>
	<CALMSew+cL0_kG6W15RapxLtE+Fw2_DYdrYoRFSjENQktWw2H4Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2026 18:33:54 +0900
Kim Jinseob <kimjinseob88@gmail.com> wrote:

> > Do you think it makes sense to permit a regulator here, so that the
> > "host" OS can power on/off the board running the osf stack? =20
>=20
> From the OSF hardware side, yes, that makes sense.
>=20
> The current prototype used for testing is powered independently, but an O=
SF
> device may also be integrated as a host-powered UART peripheral. In that =
case
> allowing the host to control the board supply through an optional regulat=
or
> would be useful.
>=20
> Unless the IIO side prefers otherwise, I will add an optional supply prop=
erty
> to the binding and matching optional regulator handling in the driver in =
the
> next revision.

When a device needs power, the regulator is required, not optional from a b=
inding
point of view.  If it is always one people can use a fixed regulator to rep=
resent it.

Now from a driver point of view, the regulator framework in linux provides =
stub regulators
for missing ones - on assumption they are always on.  So we can just reques=
t the
regulators in the driver.  Keep it simple for now and use a
devm_regulator_get_enable() in probe so we have power on for all the time
the driver is loaded. Can do fancy stuff later when you have a board where =
the
power is controlled.

>=20
> Jinseob
>=20
>=20
> 2026=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 1:19,=
 Conor Dooley <conor@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Jonathan/IIO folks,
> >
> > On Mon, Jun 08, 2026 at 08:43:38AM +0900, Jinseob Kim wrote:
> > =20
> > > diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,o=
sf.yaml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > > new file mode 100644
> > > index 000000000..a4049715a
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
> > > @@ -0,0 +1,43 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Open Sensor Fusion Sensor Aggregation Hub
> > > +
> > > +maintainers:
> > > +  - Jinseob Kim <kimjinseob88@gmail.com>
> > > +
> > > +description: |
> > > +  Open Sensor Fusion is a sensor aggregation hub. The hub exposes an=
 OSF
> > > +  protocol data stream over its host interface and may report capabi=
lities and
> > > +  samples for multiple sensor classes. The Linux driver discovers th=
e actual
> > > +  sensor channels from OSF capability reports instead of describing =
those
> > > +  sensors in Device Tree.
> > > +
> > > +  Open Sensor Fusion is not a generic industry standard. Public proj=
ect
> > > +  documentation is available at:
> > > +
> > > +    https://github.com/opensensorfusion
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: opensensorfusion,osf
> > > +
> > > +required:
> > > +  - compatible =20
> >
> > Do you think it makes sense to permit a regulator here, so that the
> > "host" OS can power on/off the board running the osf stack?
> > =20
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    serial {
> > > +        sensor {
> > > +            compatible =3D "opensensorfusion,osf";
> > > +        };
> > > +    };
> > > +... =20

