Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125720;
	b=W0Mm20OYiDNJQGh76wSogPsSrVprYyPOTTk47UL13MB4arnXkdCxJSb4ZgNKz//tYQBQ
	 d5rtoyDN/TnWioyyJmp5PwH525bLSGu4jOVP5FQUg4xvw/w/SaDmgjR1dVUMxrWTXM8n/
	 RdGmaGeMDAe+wc1XEftKCIWBsTBYqKpEqxE6+uUJrCNC5exby8xtLs+2U3TpHqIFRlwsk
	 3a9AEexIQaCnn0+33O5EIBZJ8lNbX7w+ifaiVoK2n6QM2DuuD2cnOR94EaoWJfrN7waXg
	 sGnbfZgkNcx1HvQ8daDixHOw/YyB8tRij7ZBXI4Xw3FJjkSLpMrREZ9REOeqEhee1NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125720;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qmTkjhfRVZXBH3VauU4MsoTCHvTi7jHmC9yQvfjqtMk=;
	b=lkDim+1s1fiXJVRH6ekxO7zbZ/58ZHENqpVWUrXnA2XmcFPZnWaODvgo2LbNDzlGQi/Z
	 EGKTEzo/0TQczBNv50Ed5XL+cx7IjsoinDM7FhN1HN4/rJYb94MWKnPids6NaV6Jf0dcI
	 vherwUiPwEL2HhB5uH5vQlW6EwHFGrxawQ/Iq55Id+WI2FpJs9T9JKzW/jk3LatvCG4tJ
	 +bBUPKJe8xFFzkZJ9JFKFqpYOTeIGRI3pS5D9CZ2tloNHuogB85+9n64P4Wxp7gqsXhyq
	 8nWaXw3CMIf1YX8GqIWhrbkQ7rI1U8xge4mpp0cBGMlzGGTrRlCxttgRCSadNtozYvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJr+iHiI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339EB606A31A;
	Tue, 27 Oct 2026 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UJr+iHiI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C201F01825;
	Tue, 27 Oct 2026 18:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793125719;
	bh=qmTkjhfRVZXBH3VauU4MsoTCHvTi7jHmC9yQvfjqtMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UJr+iHiIfOZ7o5mFrf4QdKdBqCq5SUsq48wJw1mpVi3v4Klbu5UKZiA2xajQRk610
	 DUldXfqm5y5X6yLyvtKR9DpfkgrloEGtS7dJg9A1w3F21tCVlSg+BmL/ukkpVryAjM
	 pOQotDbtzy1QPpPzAELFTsDFgo4Rt+FYW9LxuzykHOUKMUL7uZxnakMpp13+auwV5G
	 cuNmxW9oN+KhuB+9d6OG5XLVEj901Vt75Gjjs8Ifuu9aLMCtvjFlfxdpoP5nGpgaFM
	 u0dTgv0Bo+mv4ExDjGYgKRKkgTq8F9Fqhn89la/8sRA0dncqxwv2zmk8RCq5t5hGXd
	 KyJhQYazeyN4w==
Date: Tue, 27 Oct 2026 18:28:34 +0000
From: Conor Dooley <conor@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Message-ID: <20261027-attic-collector-cb4ffdb5cf82@spud>
References: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261027134409.76824-2-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kalH6PIzx3Y4bVJp"
Content-Disposition: inline
In-Reply-To: <20261027134409.76824-2-Nicolae-daniel.Deaconescu@analog.com>

--kalH6PIzx3Y4bVJp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 03:44:08PM +0200, Nicolae-Daniel Deaconescu wrote:
> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>=20
> Add bindings for the LTC2387-16 and LTC2387-18, 15 Msps SAR ADCs with
> an LVDS data interface, and for the ADAQ23875, ADAQ23876 and ADAQ23878
> uModule ADCs, which pair an LTC2387 die with a fully differential
> amplifier front end.
>=20
> Conversion start (CNV) and the gated LVDS clock are driven by two PWM
> channels. Sample data is captured by an AXI ADC IP core, referenced
> through io-backends. adi,use-two-lanes selects two-lane output, and
> adi,gain-milli gives the front-end gain: fixed at 2 on the ADAQ23875,
> set by pin strapping on the ADAQ23876 and ADAQ23878.
>=20
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@ana=
log.com>
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analo=
g.com>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  .../bindings/iio/adc/lltc,ltc2387.yaml        | 138 ++++++++++++++++++
>  MAINTAINERS                                   |   8 +
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc238=
7.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml =
b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
> new file mode 100644
> index 000000000000..f912260c8f79
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/lltc,ltc2387.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology / Analog Devices LTC2387 ADC
> +
> +maintainers:
> +  - Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +  - Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> +
> +description: |
> +  The LTC2387-18 is a low noise, high speed, 18-bit 15Msps
> +  successive approximation register (SAR) ADC ideally
> +  suited for a wide range of applications.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/23=
8718fa.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/23=
8716f.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adaq23875
> +      - adi,adaq23876
> +      - adi,adaq23878
> +      - lltc,ltc2387-16
> +      - lltc,ltc2387-16-x4
> +      - lltc,ltc2387-18
> +      - lltc,ltc2387-18-x4

Why are we getting new devices with linear vendor prefixes? My
understanding was that new devices from ADI subsidiaries were to use the
adi vendor prefix.


> +
> +  clocks:
> +    description: Sampling clock
> +    maxItems: 1
> +
> +  pwms:
> +    maxItems: 2
> +    description:
> +      PWM signals used to synchronize the sampling procedure
> +
> +  pwm-names:
> +    items:
> +      - const: cnv
> +      - const: clk_gate

Hmm, ltc2387-16 does not appear to have these signals?
Well, it has "cnv" but "cnv" has "sample clock" as the input name so is
the clocks property above and pwm-clock can be used if the provider is a
pwm?

Either there's some mutual exclusion missing here or the modelling in
incorrect.

"clk_gate" doesn't appear in either of the datasheets I looked at, what
does that actually do?

pw-bot: changes-requested

> +
> +  io-backends:
> +    description:
> +      The AXI ADC IP block (axi_ltc2387) that captures the LVDS data str=
eam.
> +    maxItems: 1
> +
> +  vref-supply:
> +    description:
> +      External voltage reference. When absent the device's internal 4.09=
6 V
> +      reference is assumed.
> +
> +  adi,use-two-lanes:
> +    description: The device uses two lanes for data transfer
> +    type: boolean

Please explain how this is not determinable from the compatible.

Cheers,
Conor.

> +
> +  adi,gain-milli:
> +    description:
> +      Gain of the fully-differential amplifier that the ADAQ2387x modules
> +      integrate ahead of the LTC2387 die, expressed as gain * 1000. It is
> +      fixed on the ADAQ23875 and set by pin strapping on the ADAQ23876 a=
nd
> +      ADAQ23878, so it must match the board. The bare ltc2387-* parts ha=
ve
> +      no amplifier.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [370, 730, 870, 1380, 2000, 2250]
> +
> +required:
> +  - compatible
> +  - clocks
> +  - io-backends
> +  - pwms
> +  - pwm-names
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - lltc,ltc2387-16
> +              - lltc,ltc2387-16-x4
> +              - lltc,ltc2387-18
> +              - lltc,ltc2387-18-x4
> +    then:
> +      properties:
> +        adi,gain-milli: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,adaq23875
> +    then:
> +      properties:
> +        adi,gain-milli:
> +          const: 2000
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,adaq23876
> +              - adi,adaq23878
> +    then:
> +      properties:
> +        adi,gain-milli:
> +          enum: [370, 730, 870, 1380, 2250]
> +      required:
> +        - adi,gain-milli
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc {
> +            compatible =3D "lltc,ltc2387-16";
> +            clocks =3D <&clk 0>;
> +            io-backends =3D <&axi_adc>;
> +            pwms =3D <&pwm 0 0>, <&pwm 1 0>;
> +            pwm-names =3D "cnv", "clk_gate";
> +            vref-supply =3D <&vref>;
> +    };
> +  - |
> +    adc {
> +            compatible =3D "adi,adaq23878";
> +            clocks =3D <&clk 0>;
> +            io-backends =3D <&axi_adc>;
> +            pwms =3D <&pwm 0 0>, <&pwm 1 0>;
> +            pwm-names =3D "cnv", "clk_gate";
> +            vref-supply =3D <&vref>;
> +            adi,use-two-lanes;
> +            adi,gain-milli =3D <870>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52024397dc78..b871d7f25d76 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15529,6 +15529,14 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
>  F:	drivers/iio/adc/ltc2378.c
> =20
> +LTC2387 IIO ADC DRIVER
> +M:	Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> +M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
> +
>  LTC2664 IIO DAC DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Kim Seer Paller <kimseer.paller@analog.com>
> --=20
> 2.34.1
>=20

--kalH6PIzx3Y4bVJp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauDtUgAKCRB4tDGHoIJi
0mhqAP412YGM8tjEuoPHIpRc3MotpTsdTFAtTjKi6T98iyNx6QEAp/G1BrLrISod
4STFsH+BlH9SpK8CcvKlU77TLfLSVgk=
=TQny
-----END PGP SIGNATURE-----

--kalH6PIzx3Y4bVJp--
