Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7373655DB;
	Fri, 19 Jun 2026 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781878041; cv=none; b=bz3oGH/ZJtb2C07Ckuvv0boz/lliRXMvC4UglMrj1M8TckkT7NnrPkCWjQ19pQ7r/CpcrIsGN4Sbg4z6+dygtKeTUWktRIheHiCDZe5Xff3ELuLlEiE683QbBFlMzZ23ufLFmsU2Dy/6GB1kAtOxuwSVyyd98zgzB6BKMzaxwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781878041; c=relaxed/simple;
	bh=OnmjZprV81VdXfIiMoCVV49KGLZwelIZ8VrOHXHo6gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8xVeQ5MuzRoFoN0KatWFS8Yp9CCFQz4LsMOfoaovxhjGd+csTqZwyepAJ4AuRIYHpS0CCIeIbeACbXcTyxqfrMeIzIZYwMJCr/Vk0duquD4r904sLnXPB3RlAvRqE3sHC+5hFuaZHWmSa08Pat45arQJhDxXXggvSueKi65qGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDNNQsWv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDNNQsWv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395B11F000E9;
	Fri, 19 Jun 2026 14:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781878039;
	bh=kW4v1Mu78MCErakvtUQ3kmAC8dtPDlYD27Od9rpdrII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NDNNQsWvXwc7MkdRrEIR/B1vtI3T7/u2XYGbvagzhKFCfp8Q0SAaUDKs3QD1B7KYF
	 gPJ00wYBQ+fbm1GiVOvo3ARk8q2Y0RVzbdsbQYMKSWcM7Af+Rqaasls97z0VAUsZMx
	 YhGNzxTBASKw5gFLAckGXJP57X4e5DihTNYIDa/+sxDuLUBbEki/t74rooR1BkvKRK
	 Bu4lXE8rUEy4twuc/uUXvTt1uIQo6yX3quPrvxXDyjJMqHnQEi4RzqFMDZQQQ4JGnq
	 MBTQlwh6s0Uf8zbr5UDW0Psm3I64DvjLunXnwcRNhuC28yDYUjLOGqiZsiqLd8Mv56
	 r8Blgz7rdRrsg==
Date: Fri, 19 Jun 2026 15:07:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, pop.ioan-daniel@analog.com
Subject: Re: [PATCH v3 1/5] dt-bindings: iio: adc: Add ltc2378
Message-ID: <20260619-barbecue-vascular-29c714614e0e@spud>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <f9e88abdbd23df8039282497a81d3c8698a10665.1781661028.git.marcelo.schmitt@analog.com>
 <20260617-bok-gains-9a1af41cf0de@spud>
 <ajLV-O60lCdlIbXR@debian-BULLSEYE-live-builder-AMD64>
 <20260617-oat-handclasp-ddd3135c5b84@spud>
 <ajU-_j1SWYbfjWla@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AivW+dRtBBf6OE2L"
Content-Disposition: inline
In-Reply-To: <ajU-_j1SWYbfjWla@debian-BULLSEYE-live-builder-AMD64>


--AivW+dRtBBf6OE2L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 10:07:10AM -0300, Marcelo Schmitt wrote:
> On 06/17, Conor Dooley wrote:
> > On Wed, Jun 17, 2026 at 02:14:32PM -0300, Marcelo Schmitt wrote:
> > > On 06/17, Conor Dooley wrote:
> > > > On Tue, Jun 16, 2026 at 11:03:11PM -0300, Marcelo Schmitt wrote:
> > > > > Document how to describe LTC2378-20 and similar ADCs in device tr=
ee.
> > > > >=20
> > > > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > ---
> > > > > Change log v2 -> v3:
> > > > > - Re-added device tree fallback compatibles for LTC2378 chips, no=
w with options
> > > > >   to provide a single compatible string or a pair of single compa=
tible string
> > > > >   plus a fallback string to a slower sample rate spec in case a d=
river for the
> > > > >   specific part is not found.
> > > > >=20
> > > > >  .../bindings/iio/adc/adi,ltc2378.yaml         | 160 ++++++++++++=
++++++
> > > > >  MAINTAINERS                                   |   7 +
> > > > >  2 files changed, 167 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi=
,ltc2378.yaml
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc237=
8.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..7d30a2cade8f
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> > > > > @@ -0,0 +1,160 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Analog Devices LTC2378 and similar Analog to Digital Conv=
erters
> > > > > +
> > > > > +maintainers:
> > > > > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > > +
> > > > > +description: |
> > > > > +  Analog Devices LTC2378 series of ADCs.
> > > > > +  Specifications can be found at:
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/233818fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/236416fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/236418f.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/236716fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/236718f.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/236816f.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/236818f.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/236918fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237016fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237616fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237618fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237620fb.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237716fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237718fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237720fb.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237816fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237818fa.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237820fb.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/237918fb.pdf
> > > > > +    https://www.analog.com/media/en/technical-documentation/data=
-sheets/238016fb.pdf
> > > > > +
> > > > > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    oneOf:
> > > > > +      # Single compatible string match.
> > > > > +      - enum:
> > > > > +          - adi,ltc2338-18
> > > > > +          - adi,ltc2364-16
> > > > > +          - adi,ltc2364-18
> > > > > +          - adi,ltc2367-16
> > > > > +          - adi,ltc2367-18
> > > > > +          - adi,ltc2368-16
> > > > > +          - adi,ltc2368-18
> > > > > +          - adi,ltc2369-18
> > > > > +          - adi,ltc2370-16
> > > > > +          - adi,ltc2376-16
> > > > > +          - adi,ltc2376-18
> > > > > +          - adi,ltc2376-20
> > > > > +          - adi,ltc2377-16
> > > > > +          - adi,ltc2377-18
> > > > > +          - adi,ltc2377-20
> > > > > +          - adi,ltc2378-16
> > > > > +          - adi,ltc2378-18
> > > > > +          - adi,ltc2378-20
> > > > > +          - adi,ltc2379-18
> > > > > +          - adi,ltc2380-16
> > > > > +
> > > > > +      # Low sample rate fallback for 16-bit unipolar sensors.
> > > > > +      - items:
> > > > > +          - enum:
> > > > > +              - adi,ltc2370-16 # 2 MSPS
> > > > > +              - adi,ltc2368-16 # 1 MSPS
> > > > > +              - adi,ltc2367-16 # 500 kSPS
> > > > > +          - const: adi,ltc2364-16 # fallback (250 kSPS)
> > > >=20
> ...
> > > > What actually is the impact of the sample rate on the programming m=
odel?
> > > If the user tries to set a sample rate beyond the maximum supported, =
software
> > > can throw an error to indicate that.
> >=20
> > I think you have misunderstood this. I was asking how the driver
> > interacts with the hardware. Do all devices come out of reset with the
> > minimum sampling rate? Or a per-device default rate? Do the faster
> > devices support all slower rates? If they do, do the registers have the
> > same meaning and the same value sets 2370-16 device to 1 MSPS as
> > 2368-16.
>=20
> Ah, the sampling rate is indirectly dictated both by how fast the CNV pin=
 is
> toggled and how fast SPI transfers run. Each rising edge of CNV starts a =
new
> ADC conversion. Software may take spi-max-frequency as default but it wil=
l also
> need to set a pace for CNV, and there is no default for that. The CNV pin=
 may
> also toggled on demand (e.g. single-shot read) and so I'd say all devices
> support all slower sample rates. What software ought to do is orchestrate=
 CNV
> and SPI transfers to meet the timing requirements. No configuration regis=
ters
> to be set.

I forget if I asked for other changes, but the compatible setup then is=20
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--AivW+dRtBBf6OE2L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajVNEwAKCRB4tDGHoIJi
0sotAQCQcVebqtg8ICHEifSetaw82FpVZXXT9t219LG9X/l1yQD/fk87IEmu2/gs
9yJTIxK62jUapNCX0eeURqfsOBCOhwU=
=rHCT
-----END PGP SIGNATURE-----

--AivW+dRtBBf6OE2L--
