Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ECB381AF;
	Mon,  8 Jun 2026 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940959; cv=none; b=UDIeSJj8bm5kyF2p7SljY/wNGQeFtw4q/xYJUvwM5MRmFV6G7cDW/tbKAvecA4WytgfS9R+H6aMAOXqLMOrrwYSFDEGCKkUJnoKcu/O7w6PtXw87rdu1BW85PfPFuZLPIpWtBbhHsvnyCJhPsd7yqtiKpj1lpunDP3wvUb7c8/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940959; c=relaxed/simple;
	bh=WvZU5Crk5UxadfyeFEf99yZbIxvjlXC3WY0+ybhIqa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2dCgX3/TmkXpimcc35s0djmYravhzLPKDfkfx3VGDUdyNYlCj36DyMcDpyvG5cbZ7azMzrRp5c4T9O124XoWmmr7leg701VHcy1f0SdOMdCFxMEdEluCk6i0epJXSdsEYyheH6DPzjcRtbbKyLuReEv+ttfFOHcHmB+ZNwIQGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ec4Qj0BI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ec4Qj0BI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AD51F00893;
	Mon,  8 Jun 2026 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940957;
	bh=69/BQWwiOuitH+3EAoePvFha5cJu4gUH6jfi/XJPRLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ec4Qj0BISVhtZtiUWljbcIVCYK9P3KT0bHnG+38Fujj6hRJU/p8uIEf/9TLTaO+OP
	 DSAjOgkohr/wWgGJ/ZPeFeNFeZYgQTjA48eA+iy0T2oed/7H97b7qElIneGTk7QsqT
	 fZa+W5ecONl0IXTiXCeLs7pQIXeHaMCrTEF1lvD7shXRfxlWVQC/aDAUJ0UqN81UVX
	 /3uDdFfqwwfCupE/CYyaFVXfDl91cKfDBP9vS2NlHPEUhMc8gVel10/tVj98eBz8mq
	 dclwQ3PKmFTVoSLTa5s9mm3ivYAIZf7nSB0EYIi1IKfQhmgbw5YrzHbyl5rJeOxL2b
	 ziJ1juCxon/sQ==
Date: Mon, 8 Jun 2026 18:49:13 +0100
From: Conor Dooley <conor@kernel.org>
To: github.com@herrie.org, me@herrie.org
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, tomasborquez13@gmail.com,
	masneyb@onstation.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: light: isl29018: add
 isil,cover-comp-gain
Message-ID: <20260608-raft-auction-6305f9f324cd@spud>
References: <20260604100617.3486541-1-github.com@herrie.org>
 <20260604100617.3486541-3-github.com@herrie.org>
 <20260604-energy-lid-e7949164431a@spud>
 <20260605140449.1d7538ee@jic23-huawei>
 <b6919a62f06ad8e4e80232d9b2a0e706@herrie.org>
 <bb7c65095dc53dd8723c1ecd9c33796c@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NkNPpO7dxieUAI+O"
Content-Disposition: inline
In-Reply-To: <bb7c65095dc53dd8723c1ecd9c33796c@herrie.org>


--NkNPpO7dxieUAI+O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2026 at 09:28:03PM +0200, me@herrie.org wrote:
> On 2026-06-05 15:18, me@herrie.org wrote:
> > On 2026-06-05 15:04, Jonathan Cameron wrote:
> > > On Thu, 4 Jun 2026 18:01:08 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >=20
> > > > On Thu, Jun 04, 2026 at 12:06:16PM +0200, Herman van Hazendonk wrot=
e:
> > > > > Document the new optional property that seeds the ISL29018 calibr=
ation
> > > > > scale factor at boot from firmware, allowing boards with tinted c=
over
> > > > > glass to ship with correct luminance readings without a userspace=
 helper.
> > > > >
> > > > > The value is a positive integer (minimum 1, maximum 65535) that is
> > > > > multiplied with the raw lux reading.  Userspace can still overrid=
e it
> > > > > at runtime through in_illuminance0_calibscale.
> > > > >
> > > > > Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/light/isl29018.yaml     | 13 +++++++=
++++++
> > > > >  1 file changed, 13 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/iio/light/isl29018=
=2Eyaml b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > > > > index 0ea278b07d1c..92ea2742bbd3 100644
> > > > > --- a/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > > > > +++ b/Documentation/devicetree/bindings/iio/light/isl29018.yaml
> > > > > @@ -34,6 +34,19 @@ properties:
> > > > >    vcc-supply:
> > > > >      description: Regulator that provides power to the sensor
> > > > >
> > > > > +  isil,cover-comp-gain:
> > > > > +    description: |
> > > > > +      Multiplier applied to the ambient-light reading at startup=
 to
> > > > > +      compensate for optical loss in the board's cover glass. Bo=
ards
> > > > > +      that mount the sensor under a tinted or coated window typi=
cally
> > > > > +      need a value between a few and a few hundred.
> > >=20
> > > Is it useful to support decimal points on these values?  The
> > > userspace interface
> > > does and you mention the 'right' answer might be only a few which
> > > means precision
> > > at that range will be terrible - less of an issue if 100s!
> > >=20
> > > Thanks
> > >=20
> > > Jonathan
> > >=20
> > Hard to say, my old HP TouchPad needs 100 as a value here (taken from
> > legacy 2.6.35
> > kernel and binaries). So we probably don't need precision, but I have no
> > other
> > references to substantiate.
> >=20
> > Thanks
> > Herman
> Scratch that. Did some more research. Proof is in the legacy webOS binari=
es:
>=20
> What legacy webOS actually does here:
>=20
> 1. Per-device calibration via factory token reads an ALSCal token from
> system storage
> containing JSON with calibration points at lux_0, lux_50, lux_100, lux_400
> (measured
> ADC counts at known reference illuminance levels).
>=20
> 2. Computes a floating-point ratio AlsToLux_Ratio_WhiteLED =3D average of
> expected_lux /
> measured_count across the JSON calibration points. This is a real number,
> not an integer.
>=20
> 3. Adjusts for light source spectrum at runtime detects illuminant type f=
rom
> ALS:IR
> ratio, then applies a fractional spectrum correction:
> Fluorescent above 100 counts: ratio x 0.4652
> Incandescent above 700 counts: ratio x 0.4
> Incandescent 50-100 counts:    ratio x 0.9
> Fluorescent < 50 counts:       ratio x (-0.000724=C2=B7N + 0.7463)
>=20
> 4. Final lux =3D ALSCount / spectrum_corrected_ratio - a true floating-po=
int
> division.
>=20
> Implications
>=20
> - The "right" cover-comp value is per-device factory-measured, not
> per-board. Different
> units off the same production line have different optical transmission due
> to coating
> tolerance.
> - The values are fractional by nature. Examples from the legacy code:
> 0.4652, 0.7463,
> 0.8333. None are integers.
>=20
> The ISL29023 datasheet itself says nothing about cover compensation - it's
> strictly
> board-level optical correction. So there's no "right" answer from the chip
> side;
> it's whatever the board's cover glass + coating attenuates.
>=20
> ALSCal values found on the particular device:
>=20
> {"lux_50":{"c":31}, "lux_100":{"c":58}, "lux_400":{"c":164}}
>=20
> This is device specific TouchPad's factory calibration:
>   - At 50 lux, ADC reads 31 counts  lux/count =3D 1.613
>   - At 100 lux, ADC reads 58 counts lux/count =3D 1.724
>   - At 400 lux, ADC reads 164 counts  lux/count =3D 2.439
>=20
> Note the ratio isn't constant - the response is mildly non-linear, but per
> the legacy
> code the driver computes the average ratio as the calibration:
>=20
>   ratio =3D (1.6129 + 1.7241 + 2.4390) / 3 =3D 1.9253 lux/count
>=20
> Independent verification:
>   - At calibscale=3D34: lux =3D 1295
>   - Implied raw count: 1295 / (34 x 0.015258) =3D 2496 counts
>   - Applying legacy formula: 2496 / 1.9253 =3D 1296.4 =3D 1295
>=20
> The factory-calibrated value for this specific TouchPad is 34.04 (not 100=
).
> Per-point
> calibscale values from the ALSCal JSON:
>=20
> Cal point=E2=80=9A lux/count ratio=E2=80=9A Equivalent calibscale
> lux_50    =E2=80=9A 1.6129          =E2=80=9A 40.64
> lux_100   =E2=80=9A 1.7241          =E2=80=9A 38.01
> lux_400   =E2=80=9A 2.4390          =E2=80=9A 26.87
> average   =E2=80=9A 1.9253          =E2=80=9A 34.04
>=20
> What this means concretely
>=20
> 1. Decimal precision is necessary, not nice-to-have. Real per-device fact=
ory
> values
> span 26.9 - 40.6 across the chip's response curve. A single scalar
> approximation costs
> precision; restricting to integer compounds it.
>=20
> 2. Updated v5 plan: switch to two-cell <int micro> for fractional values,
> and change
> the tenderloin DTS default from <100> to <34 040000> (or close to that).
>=20
> Thoughts on this?

Instead of going 2-cell, it might be worth moving the property to be
based in some fractional unit to begin with. I just don't know what to
call that, milligain? I dunno.


Jonathan's call here I think

--NkNPpO7dxieUAI+O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaicAmAAKCRB4tDGHoIJi
0p5vAP9LDSgatJT0HLERoWYv3o/O1xFKLhAdWEDlRT/Ub1nE8gD/YpMk6EMsrCXZ
LcgoV48QV9V222zLjmDVRdYXAnTzDwY=
=GnEn
-----END PGP SIGNATURE-----

--NkNPpO7dxieUAI+O--
