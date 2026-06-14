Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EF31714B;
	Sun, 14 Jun 2026 19:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781466704; cv=none; b=OSu89Dp03UEGp6fzZ/C9AO/NILQrcV8lHixsqYpDIJ+0sg5HgyMzEzRGf1stH2P2DbTlpuibKUA1NBAKlDfMNXb2M1pg4sI/3Vj1A21vU6Q/bpdLvmRBSbgPPk3C25Xgq9OpoCgW3XJbJR/LjvYiezFqVGX3Hq9rsidlqMUKLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781466704; c=relaxed/simple;
	bh=2LUvsEZYLmYA95+lLjblKu4+Mb/N2E++mvok7V/fcF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=en8wEAr3s21W9jRko6+FCed9jXADrPy34EfOpzJ+0qrDdZBh4ZXe+ugY3uk5IbB/09LlbOT1eGxiauL6b0QsY2mHnLd17Ps92lK38OHt+w2qCjteo6+D3G1kLfxqWExIywnEFrBsu/ceDzh4ZLh/P9YPG+c+55tuCGmNuTuWi3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/8SAooQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/8SAooQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F8D1F000E9;
	Sun, 14 Jun 2026 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781466701;
	bh=hFA78dOwnGzgW/0GtADABUlpTH6ZRssXUVW0ddOA1F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T/8SAooQ095tRIfvFQXfaEWKRigTG8RcWJ/fFjnVOhQhi9ZK0IFfAiOsFdjGi7+ag
	 wG16sZ+oiewkbV5T4TQ2porulLGADyYsn5lpjfX7EO7rBn9L8do8rrwTgwwpetmQ1g
	 hYupctkzGsJwdu7OOCXMceI5A+uui0SLEJrjSb/mmhA5CB5PmHvKAq/D9A+05+hC/2
	 F082mVIAFk2sVd23JGY33QbNyJgBO1/dFQkhvMmys+oIx8gBQEum5SCP6hr7HYqsQk
	 4UD6bNHWxQK/oTy5qw54CEF6hY6kz9Q08mj4n9i/bUj/eQd+2znKc2+26TwEIW6aRy
	 JYObWQpGKQZMQ==
Date: Sun, 14 Jun 2026 20:51:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: github.com@herrie.org, me@herrie.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, tomasborquez13@gmail.com, masneyb@onstation.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: light: isl29018: add
 isil,cover-comp-gain
Message-ID: <20260614205131.7449d180@jic23-huawei>
In-Reply-To: <20260608-raft-auction-6305f9f324cd@spud>
References: <20260604100617.3486541-1-github.com@herrie.org>
	<20260604100617.3486541-3-github.com@herrie.org>
	<20260604-energy-lid-e7949164431a@spud>
	<20260605140449.1d7538ee@jic23-huawei>
	<b6919a62f06ad8e4e80232d9b2a0e706@herrie.org>
	<bb7c65095dc53dd8723c1ecd9c33796c@herrie.org>
	<20260608-raft-auction-6305f9f324cd@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jun 2026 18:49:13 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Jun 05, 2026 at 09:28:03PM +0200, me@herrie.org wrote:
> > On 2026-06-05 15:18, me@herrie.org wrote: =20
> > > On 2026-06-05 15:04, Jonathan Cameron wrote: =20
> > > > On Thu, 4 Jun 2026 18:01:08 +0100
> > > > Conor Dooley <conor@kernel.org> wrote:
> > > >  =20
> > > > > On Thu, Jun 04, 2026 at 12:06:16PM +0200, Herman van Hazendonk wr=
ote: =20
> > > > > > Document the new optional property that seeds the ISL29018 cali=
bration
> > > > > > scale factor at boot from firmware, allowing boards with tinted=
 cover
> > > > > > glass to ship with correct luminance readings without a userspa=
ce helper.
> > > > > >
> > > > > > The value is a positive integer (minimum 1, maximum 65535) that=
 is
> > > > > > multiplied with the raw lux reading.  Userspace can still overr=
ide it
> > > > > > at runtime through in_illuminance0_calibscale.
> > > > > >
> > > > > > Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> > > > > > ---
> > > > > >  .../devicetree/bindings/iio/light/isl29018.yaml     | 13 +++++=
++++++++
> > > > > >  1 file changed, 13 insertions(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/light/isl290=
18.yaml b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > > > > > index 0ea278b07d1c..92ea2742bbd3 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > > > > > @@ -34,6 +34,19 @@ properties:
> > > > > >    vcc-supply:
> > > > > >      description: Regulator that provides power to the sensor
> > > > > >
> > > > > > +  isil,cover-comp-gain:
> > > > > > +    description: |
> > > > > > +      Multiplier applied to the ambient-light reading at start=
up to
> > > > > > +      compensate for optical loss in the board's cover glass. =
Boards
> > > > > > +      that mount the sensor under a tinted or coated window ty=
pically
> > > > > > +      need a value between a few and a few hundred. =20
> > > >=20
> > > > Is it useful to support decimal points on these values?  The
> > > > userspace interface
> > > > does and you mention the 'right' answer might be only a few which
> > > > means precision
> > > > at that range will be terrible - less of an issue if 100s!
> > > >=20
> > > > Thanks
> > > >=20
> > > > Jonathan
> > > >  =20
> > > Hard to say, my old HP TouchPad needs 100 as a value here (taken from
> > > legacy 2.6.35
> > > kernel and binaries). So we probably don't need precision, but I have=
 no
> > > other
> > > references to substantiate.
> > >=20
> > > Thanks
> > > Herman =20
> > Scratch that. Did some more research. Proof is in the legacy webOS bina=
ries:
> >=20
> > What legacy webOS actually does here:
> >=20
> > 1. Per-device calibration via factory token reads an ALSCal token from
> > system storage
> > containing JSON with calibration points at lux_0, lux_50, lux_100, lux_=
400
> > (measured
> > ADC counts at known reference illuminance levels).
> >=20
> > 2. Computes a floating-point ratio AlsToLux_Ratio_WhiteLED =3D average =
of
> > expected_lux /
> > measured_count across the JSON calibration points. This is a real numbe=
r,
> > not an integer.
> >=20
> > 3. Adjusts for light source spectrum at runtime detects illuminant type=
 from
> > ALS:IR
> > ratio, then applies a fractional spectrum correction:
> > Fluorescent above 100 counts: ratio x 0.4652
> > Incandescent above 700 counts: ratio x 0.4
> > Incandescent 50-100 counts:    ratio x 0.9
> > Fluorescent < 50 counts:       ratio x (-0.000724=C2=B7N + 0.7463)
> >=20
> > 4. Final lux =3D ALSCount / spectrum_corrected_ratio - a true floating-=
point
> > division.
> >=20
> > Implications
> >=20
> > - The "right" cover-comp value is per-device factory-measured, not
> > per-board. Different
> > units off the same production line have different optical transmission =
due
> > to coating
> > tolerance.
> > - The values are fractional by nature. Examples from the legacy code:
> > 0.4652, 0.7463,
> > 0.8333. None are integers.
> >=20
> > The ISL29023 datasheet itself says nothing about cover compensation - i=
t's
> > strictly
> > board-level optical correction. So there's no "right" answer from the c=
hip
> > side;
> > it's whatever the board's cover glass + coating attenuates.
> >=20
> > ALSCal values found on the particular device:
> >=20
> > {"lux_50":{"c":31}, "lux_100":{"c":58}, "lux_400":{"c":164}}
> >=20
> > This is device specific TouchPad's factory calibration:
> >   - At 50 lux, ADC reads 31 counts  lux/count =3D 1.613
> >   - At 100 lux, ADC reads 58 counts lux/count =3D 1.724
> >   - At 400 lux, ADC reads 164 counts  lux/count =3D 2.439
> >=20
> > Note the ratio isn't constant - the response is mildly non-linear, but =
per
> > the legacy
> > code the driver computes the average ratio as the calibration:
> >=20
> >   ratio =3D (1.6129 + 1.7241 + 2.4390) / 3 =3D 1.9253 lux/count
> >=20
> > Independent verification:
> >   - At calibscale=3D34: lux =3D 1295
> >   - Implied raw count: 1295 / (34 x 0.015258) =3D 2496 counts
> >   - Applying legacy formula: 2496 / 1.9253 =3D 1296.4 =3D 1295
> >=20
> > The factory-calibrated value for this specific TouchPad is 34.04 (not 1=
00).
> > Per-point
> > calibscale values from the ALSCal JSON:
> >=20
> > Cal point=E2=80=9A lux/count ratio=E2=80=9A Equivalent calibscale
> > lux_50    =E2=80=9A 1.6129          =E2=80=9A 40.64
> > lux_100   =E2=80=9A 1.7241          =E2=80=9A 38.01
> > lux_400   =E2=80=9A 2.4390          =E2=80=9A 26.87
> > average   =E2=80=9A 1.9253          =E2=80=9A 34.04
> >=20
> > What this means concretely
> >=20
> > 1. Decimal precision is necessary, not nice-to-have. Real per-device fa=
ctory
> > values
> > span 26.9 - 40.6 across the chip's response curve. A single scalar
> > approximation costs
> > precision; restricting to integer compounds it.
> >=20
> > 2. Updated v5 plan: switch to two-cell <int micro> for fractional value=
s,
> > and change
> > the tenderloin DTS default from <100> to <34 040000> (or close to that).
> >=20
> > Thoughts on this? =20
>=20
> Instead of going 2-cell, it might be worth moving the property to be
> based in some fractional unit to begin with. I just don't know what to
> call that, milligain? I dunno.
>=20
>=20
> Jonathan's call here I think

If this is varying that a lot per device, then, unless you plan to
have a bootloader inject it into DT, are we better off making this
a userspace problem?  There is a hybrid we've done before, which is
to make it a firmware loading problem but that requires some way to
generate a suitable file to load and typically a calibration sequence
that goes with it.

If it is 'fairly constant' for a given device then fine to be in DT
- it will just be a case of picking the average of a bunch of measured
devices and assuming it is good enough.

If it does end up in dt, then a fractional type like Conor suggests
is fine.

Jonathan


