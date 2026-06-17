Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC62C18871F;
	Wed, 17 Jun 2026 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731022; cv=none; b=Oh7qu8zh9rW6XK/YYH4xbcJltFm2ZlbWWI+FkvPMQGAtqNkQXjEfk9HglZlQ5bjeZWRnbjiSIF0LRLqWtjZDB/uvbD0urG0ZenZX4nlD0ctgtw8U9pcwb48saEMd0bGWn6UnU4YzYJQiBACBx5nr8cPcmlDfyEZui6ESJVJEhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731022; c=relaxed/simple;
	bh=/d07SA45uZuKBpFfl+4sDt18F+YlFuaUFTvcxvrvo9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm51wGVE6oRtlywzs7whRvhlHNJYCymnTE32UFjxJyRSp+gBE1UgJHyYjngaG+7qDfZzWbDuYRd9Om2Op0zhd2bbBV3AkY91df1qxo5nRqjNoL9quVRyhbT/tZ9tjfqlYvkNy/cQNkLm4cmf4HFpu6xQGKlfYTez3PZTY9MWcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lnlzttj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lnlzttj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EF61F000E9;
	Wed, 17 Jun 2026 21:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781731021;
	bh=BHrH6/ZA5cIwsCgwUogyPBPXGIZVjjCg3LMVpnJlpoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lnlzttj3uxD310HbGXNCK5ywfPvGOTJIcg/S8/Ts8xFqLuaQpadKTA0WS3Uj5LNZa
	 OkFlurnjvSb4I9s2nNeyoSjJlgmCVU1lu0XtysIsa9Q2Us6n6NwOG6srFq2EG/2l69
	 3PmB4W+KwdbBOqwTNKXOAIYe4n7lbsV+f+v+HmxfF9thCh3JS2BZIMeEqZPj1rCys4
	 wHRHRcIsgqG1BdVDR76eDtCzvZZr6KyuqiLgjbebf8x1C5BCEt9+LR9utcwzOgSwvR
	 zuKj4ksvGZ//dj2WjeAVRxreG0D2J71O9JF4zFEC3PYWyRRJFRAM0RIoib/DMWDEd3
	 FkhSAbdfCC0Nw==
Date: Wed, 17 Jun 2026 22:16:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pop.ioan-daniel@analog.com
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: adc: Add ltc2378
Message-ID: <20260617-oat-handclasp-ddd3135c5b84@spud>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
 <20260617-bok-gains-9a1af41cf0de@spud>
 <ajLV-O60lCdlIbXR@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CGtTqchTHqysmLPN"
Content-Disposition: inline
In-Reply-To: <ajLV-O60lCdlIbXR@debian-BULLSEYE-live-builder-AMD64>


--CGtTqchTHqysmLPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 02:14:32PM -0300, Marcelo Schmitt wrote:
> On 06/17, Conor Dooley wrote:
> > On Tue, Jun 16, 2026 at 11:03:11PM -0300, Marcelo Schmitt wrote:
> > > Document how to describe LTC2378-20 and similar ADCs in device tree.
> > >=20
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Change log v2 -> v3:
> > > - Re-added device tree fallback compatibles for LTC2378 chips, now wi=
th options
> > >   to provide a single compatible string or a pair of single compatibl=
e string
> > >   plus a fallback string to a slower sample rate spec in case a drive=
r for the
> > >   specific part is not found.
> > >=20
> > >  .../bindings/iio/adc/adi,ltc2378.yaml         | 160 ++++++++++++++++=
++
> > >  MAINTAINERS                                   |   7 +
> > >  2 files changed, 167 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc=
2378.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.ya=
ml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > > new file mode 100644
> > > index 000000000000..7d30a2cade8f
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > > @@ -0,0 +1,160 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices LTC2378 and similar Analog to Digital Converte=
rs
> > > +
> > > +maintainers:
> > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > +
> > > +description: |
> > > +  Analog Devices LTC2378 series of ADCs.
> > > +  Specifications can be found at:
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/233818fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/236416fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/236418f.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/236716fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/236718f.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/236816f.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/236818f.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/236918fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237016fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237616fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237618fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237620fb.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237716fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237718fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237720fb.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237816fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237818fa.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237820fb.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/237918fb.pdf
> > > +    https://www.analog.com/media/en/technical-documentation/data-she=
ets/238016fb.pdf
> > > +
> > > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      # Single compatible string match.
> > > +      - enum:
> > > +          - adi,ltc2338-18
> > > +          - adi,ltc2364-16
> > > +          - adi,ltc2364-18
> > > +          - adi,ltc2367-16
> > > +          - adi,ltc2367-18
> > > +          - adi,ltc2368-16
> > > +          - adi,ltc2368-18
> > > +          - adi,ltc2369-18
> > > +          - adi,ltc2370-16
> > > +          - adi,ltc2376-16
> > > +          - adi,ltc2376-18
> > > +          - adi,ltc2376-20
> > > +          - adi,ltc2377-16
> > > +          - adi,ltc2377-18
> > > +          - adi,ltc2377-20
> > > +          - adi,ltc2378-16
> > > +          - adi,ltc2378-18
> > > +          - adi,ltc2378-20
> > > +          - adi,ltc2379-18
> > > +          - adi,ltc2380-16
> > > +
> > > +      # Low sample rate fallback for 16-bit unipolar sensors.
> > > +      - items:
> > > +          - enum:
> > > +              - adi,ltc2370-16 # 2 MSPS
> > > +              - adi,ltc2368-16 # 1 MSPS
> > > +              - adi,ltc2367-16 # 500 kSPS
> > > +          - const: adi,ltc2364-16 # fallback (250 kSPS)
> >=20
> > Your driver still matches on ltc2370-16, which makes me question the
> > value of these fallbacks. That said, the chip info struct contains no
> > information about sampling rate.
> The info about sample rate is added in patch 4.

Ah, I missed that.

> > What actually is the impact of the sample rate on the programming model?
> If the user tries to set a sample rate beyond the maximum supported, soft=
ware
> can throw an error to indicate that.

I think you have misunderstood this. I was asking how the driver
interacts with the hardware. Do all devices come out of reset with the
minimum sampling rate? Or a per-device default rate? Do the faster
devices support all slower rates? If they do, do the registers have the
same meaning and the same value sets 2370-16 device to 1 MSPS as
2368-16.

> > Is there actually a benefit to matching on ltc2370-16, or can you just
> > match on the fallback?
> The benefit is telling software that it is safe to go up to 2 MSPS. It is=
 also
> okay to match on the fallback, but software may restrain operation to a s=
lower
> sample rate.

My whole review here is shit cos I didn't see patch 4, so the use of
fallbacks seems appropriate (provided your answers to my programming
model questions are sane!).

>=20
> With the code being proposed in this patch set, there is no benefit in ma=
tching
> the ltc2364-16 fallback if there is a faster ltc2370-16 device connected =
because
> device driver supports that. Though, other operating systems and/or platf=
orms
> might not support all device variants and so the fallback might be useful.
>=20
> > +static const struct ltc2378_chip_info ltc2370_16_chip_info =3D {
> > +	.name =3D "ltc2370-16",
> > +	.resolution =3D 16,
> In a later patch ...
> +	.max_sample_rate_hz =3D 2 * HZ_PER_MHZ,
> +	.tconv_ns =3D 322,
> > +	.bipolar =3D false,
> > +};
> >=20
> > +static const struct ltc2378_chip_info ltc2368_16_chip_info =3D {
> > +	.name =3D "ltc2368-16",
> > +	.resolution =3D 16,
> +	.max_sample_rate_hz =3D HZ_PER_MHZ,
> +	.tconv_ns =3D 527
> > +	.bipolar =3D false,
> > +};
> >=20
> > +static const struct ltc2378_chip_info ltc2367_16_chip_info =3D {
> > +	.name =3D "ltc2367-16",
> > +	.resolution =3D 16,
> +	.max_sample_rate_hz =3D 500 * HZ_PER_KHZ,
> +	.tconv_ns =3D 1500,
> > +	.bipolar =3D false,
> > +};
> >=20
> > +static const struct ltc2378_chip_info ltc2364_16_chip_info =3D {
> > +	.name =3D "ltc2364-16",
> > +	.resolution =3D 16,
> +	.max_sample_rate_hz =3D 250 * HZ_PER_KHZ,
> +	.tconv_ns =3D 3000,
> > +	.bipolar =3D false,
> > +};
> >=20
> ...
> > > +      # Low sample rate fallback for 20-bit bipolar sensors.
> > > +      - items:
> > > +          - enum:
> > > +              - adi,ltc2378-20 # 1 MSPS
> > > +              - adi,ltc2377-20 # 500 kSPS
> > > +          - const: adi,ltc2376-20 # fallback (250 kSPS)
> >=20
> > I didn't check these, but I assume they are the same.
>=20
> Yes, except for small variations on input (unipolar/bipolar) and precisio=
n bits,
> these devices are pretty much equal.

What I meant here was that 2378-20, 2377-20 and 2376-20 would follow the
same pattern of having identical match data (pre patch 4).

--CGtTqchTHqysmLPN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajMOyAAKCRB4tDGHoIJi
0hgQAP9Y84Pna4CxPnkeKmnsdjnkUBp/SO+Ps+QPOFmrY0S/NwEA7Xatww56qmWl
DUktptMH00MxlhrnrITLdobkfERDowA=
=iIiH
-----END PGP SIGNATURE-----

--CGtTqchTHqysmLPN--
