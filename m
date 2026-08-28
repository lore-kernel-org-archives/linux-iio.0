Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C6394E8A;
	Fri, 28 Aug 2026 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935205; cv=none; b=sWm/jRxNN6sUW+TAJ5b7+/PPVih49xMOs1JnyVNktspjlNY48v19qbbNmiUwcIj2kx43FQifdLuQJUQxT7Mn42fqKhtOKTrqcTxm/7mC79/5YUgtulMtQchyEq+MG/vWsLjXWA7ES5VSBXDuOLDCIs7V080wOdg3Xg9LJbVA+oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935205; c=relaxed/simple;
	bh=nOKkl0afDOzI0WR6fbqvcoBKgiBpWIX01JX90Bqv9bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7kl0DkRgqIOtMCtnWL8cIMugTSqRcHc2YqjXeG2NcJpmqOaHNQJFOMMVxO+fb0vwb6765UIw/ic6fi3CrFk3C9JxRflb/wc1/QA/oKAr/tEDHJIGNEUxAQ1lnBa5dekesj/9d9w2xXaRmuErGijeo19SOuQxD0GWc/iCvTSZrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vt/IYjmc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vt/IYjmc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38621F000E9;
	Fri, 28 Aug 2026 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787935203;
	bh=25xcJit1FnmDRhjDl7LzWxjrzDkJEm7Zo4Ek8gWgOnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vt/IYjmcYZ+q7h1ir73ndhsb1D6LlI6kDfR8qfp1n0TzmmgfaMxYHq7522uuFXM1C
	 mISLVqj+j09YLyn5UKUJlTHuYbouin1YNQlDJNkD20f22StW3mx6Rwg7Rze3/GOH7U
	 3Yp8fmTBMEaIZOVVZ5OHyy/s9lhLm7/u6Lw/FKMOsHIi36AOrtIyi4CmdfaRR6CnY8
	 5zAV8ZaXPgbcYD33DBx6dPnGN39+daLEqyyBDPcPmIgm7k6UoqY+Fg6Budc3DI/no2
	 XNlZDa0evYn4nNN/H6EtVD0zj9dXtzksWRiKSkFHgXfRlO5XGeAZncn+yW1UOPWjqU
	 qcfPQ18K3Anlg==
Date: Fri, 28 Aug 2026 17:39:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/10] dt-bindings: iio: adc: support the TI ADS126x
 ADC family
Message-ID: <20260828-cartel-willow-9592e4e8b912@spud>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GniDptwhGn3Jax2r"
Content-Disposition: inline
In-Reply-To: <20260828-ads126x-v4-2-1dc27e9c0260@gmail.com>

--GniDptwhGn3Jax2r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 01:38:17AM -0500, Kurt Borja wrote:
> The ADS1262 and ADS1263 are 32-bit, 38.4-kSPS delta-sigma ADCs with an
> integrated PGA, internal reference, excitation and burn-out current
> sources for sensor biasing and diagnostics. The ADS1263 is compatible
> with ADS1262, but includes a second auxiliary ADC (ADC2) to perform main
> channel (ADC1) cross-checking measurements, system background
> measurements, or temperature compensation of the primary sensor.
>=20
> Both parts can configure per-channel voltage reference source,
> excitation current sources (IDAC), plus input and IDAC chopping for
> offset and IDAC mismatch cancellation. This lets the device drive and
> ratiometrically measure RTDs and other resistive sensors.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads1262.yaml    | 376 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 382 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> new file mode 100644
> index 000000000000..7e26572388e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> @@ -0,0 +1,376 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads1262.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI ADS1262/ADS1263 analog to digital converter
> +
> +maintainers:
> +  - Kurt Borja <kuurtb@gmail.com>
> +
> +description: |
> +  The ADS1262 and ADS1263 are 38.4-kSPS, delta-sigma (=CE=94=CE=A3) ADCs=
 with an
> +  integrated PGA, reference, and internal fault monitors. The ADS1263 in=
tegrates
> +  an auxiliary, 24-bit, =CE=94=CE=A3 ADC intended for background measure=
ments.
> +
> +  Datasheets:
> +    - ADS126x: https://www.ti.com/lit/ds/symlink/ads1262.pdf
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: ti,ads1262
> +      - items:
> +          - const: ti,ads1263
> +          - const: ti,ads1262
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  spi-max-frequency:
> +    maximum: 8000000
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    description: Data ready (DRDY) interrupt lines.
> +
> +  interrupt-names:
> +    description:
> +      The data ready (DRDY) signal has two independent interrupt lines. A
> +      dedicated DRDY pin and a pin shared with the serial interface MISO=
 pin,
> +      which is called DOUT/DRDY.
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [drdy, doutdrdy]
> +
> +  start-gpios:
> +    description: Start conversion control.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  dvdd-supply:
> +    description: Digital power supply.
> +
> +  avdd-supply:
> +    description:
> +      Analog power supply. In bipolar supply configurations, the reported
> +      voltage should be in reference to DGND.
> +
> +  avss-supply:
> +    description:
> +      Negative analog power supply for bipolar configurations. AVSS can =
only be
> +      at or below the ground reference (DGND). If not described, AVSS is=
 assumed
> +      to be connected to ground (0V).
> +
> +  clocks:
> +    maxItems: 1

clock doesn't appear mandatory, what does it do?

> +
> +  '#io-channel-cells':
> +    minimum: 1
> +    maximum: 2

What's the use case for actually setting this as a single cell? Kinda
confused by it.

Otherwise, quite frankly, the binding is too complicated for me! I'll
have to leave it up to the IIO folks to cover whether what's being done
is sane.

Cheers,
Conor.

> +    description: |
> +      The first cell selects the channel by its reg. The second cell sel=
ects
> +      between the main ADC (ADC1) and the auxiliary ADC (ADC2) as follow=
s:
> +        0: ADC1
> +        1: ADC2
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  regulators:
> +    type: object
> +    description:
> +      List of regulators provided by this chip.
> +
> +    properties:
> +      vbias:
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        description:
> +          Level-shift voltage output on the AINCOM pin. Its output is the
> +          mid-voltage of the analog supply, (AVDD + AVSS) / 2, and is us=
ed to
> +          shift floating sensors to within the ADC input range.
> +        unevaluatedProperties: false
> +
> +      refout:
> +        $ref: /schemas/regulator/regulator.yaml#
> +        type: object
> +        description:
> +          Buffered internal voltage reference output on the REFOUT pin.
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +patternProperties:
> +  "^ain([0-9]|com)-supply$":
> +    description:
> +      Common-mode voltage supply connected to AIN<N> or AINCOM.
> +
> +  "^refp[1-3]-supply$":
> +    description:
> +      Positive voltage reference connected to REFP1 (AIN0), REFP2 (AIN2)=
 or
> +      REFP3 (AIN4). If this regulator is not described and a channel sel=
ects
> +      it as a reference source, then it's assumed to be connected to gro=
und
> +      (0V).
> +
> +  "^refn[1-3]-supply$":
> +    description:
> +      Negative voltage reference connected to REFN1 (AIN1), REFN2 (AIN3)=
 or
> +      REFN3 (AIN5). If this regulator is not described and a channel sel=
ects
> +      it as a reference source, then it's assumed to be connected to gro=
und
> +      (0V).
> +
> +  "^ti,refp[1-3]-refn[1-3]-resistor-ohms$":
> +    description:
> +      Magnitude of the external reference resistor connected between REF=
P<N>
> +      and REFN<M>. In ratiometric configurations, such as RTD measuremen=
ts, the
> +      IDAC excitation current returns through this resistor, generating =
the
> +      reference voltage for the conversion.
> +
> +  "^channel@[0-9a-f]+$":
> +    $ref: /schemas/iio/adc/adc.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      single-channel:
> +        minimum: 0
> +        maximum: 10
> +
> +      common-mode-channel:
> +        minimum: 0
> +        maximum: 10
> +        default: 10
> +
> +      diff-channels:
> +        items:
> +          minimum: 0
> +          maximum: 10
> +
> +      input-chopping: true
> +
> +      reference-sources:
> +        minItems: 2
> +        description:
> +          Indicates the reference sources for this channel. The first an=
d second
> +          items are the positive (REFP) and negative (REFN) sources of t=
he main
> +          ADC (ADC1). The third item is the reference source of the seco=
ndary
> +          ADC (ADC2) and must always have a positive differential voltag=
e.
> +        items:
> +          - enum: [internal-p, refp1, refp2, refp3, avdd]
> +          - enum: [internal-n, refn1, refn2, refn3, avss]
> +          - enum: [internal, refp1-refn1, refp2-refn2, refp3-refn3, avdd=
-avss]
> +
> +      ti,reference-reversal:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Indicates that the ADC1 (this has no effect on ADC2) reference=
 voltage
> +          for this channel has negative polarity and thus should be inte=
rnally
> +          reversed.
> +
> +      excitation-channels:
> +        minItems: 1
> +        maxItems: 2
> +        description:
> +          Selects the pins for the IDAC sources from 0 (AIN0) to 10 (AIN=
COM).
> +          The first value corresponds to IDAC1 and the second to IDAC2.
> +        items:
> +          minimum: 0
> +          maximum: 10
> +
> +      excitation-current-nanoamp:
> +        minItems: 1
> +        maxItems: 2
> +        description:
> +          The first value corresponds to IDAC1 and the second to IDAC2.
> +        items:
> +          enum: [50000, 100000, 250000, 500000, 750000, 1000000, 1500000,
> +                 2000000, 2500000, 3000000]
> +
> +      excitation-current-chopping: true
> +
> +      burn-out-current-nanoamp:
> +        description:
> +          Selects current magnitude for the sensor bias current source.
> +        enum: [500, 2000, 10000, 50000, 200000]
> +
> +      ti,burn-out-resistor:
> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          Instead of a fixed current, the sensor bias (burn-out) current=
 source
> +          can be pulled using an internal 10 M=CE=A9 resistor.
> +
> +      ti,burn-out-polarity:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          The sensor bias can be configured to either pull-up or pull-do=
wn mode.
> +          In pull-up mode, the current flows into the positive input and=
 flows
> +          out of the negative input. In pull-down mode, the polarities a=
re
> +          reversed.
> +        enum: [pull-up, pull-down]
> +        default: pull-up
> +
> +    dependencies:
> +      excitation-channels: [excitation-current-nanoamp]
> +      excitation-current-nanoamp: [excitation-channels]
> +      burn-out-current-nanoamp:
> +        not:
> +          required:
> +            - ti,burn-out-resistor
> +
> +    required:
> +      - reg
> +
> +    allOf:
> +      - if:
> +          properties:
> +            excitation-channels:
> +              maxItems: 1
> +          required:
> +            - excitation-channels
> +        then:
> +          properties:
> +            excitation-current-nanoamp:
> +              maxItems: 1
> +        else:
> +          properties:
> +            excitation-current-nanoamp:
> +              minItems: 2
> +
> +    oneOf:
> +      - required: [single-channel]
> +      - required: [diff-channels]
> +
> +dependencies:
> +  interrupts: [interrupt-names]
> +  interrupts-extended: [interrupt-names]
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - avdd-supply
> +  - dvdd-supply
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: ti,ads1263
> +    then:
> +      properties:
> +        '#io-channel-cells':
> +          minimum: 1
> +          maximum: 2
> +      patternProperties:
> +        "^channel@[0-9]+$":
> +          properties:
> +            reference-sources:
> +              minItems: 3
> +              maxItems: 3
> +              default: [internal-p, internal-n, internal]
> +    else:
> +      properties:
> +        '#io-channel-cells':
> +          const: 1
> +      patternProperties:
> +        "^channel@[0-9]+$":
> +          properties:
> +            reference-sources:
> +              minItems: 2
> +              maxItems: 2
> +              default: [internal-p, internal-n]
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "ti,ads1262";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <8000000>;
> +            spi-cpha;
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            interrupts-extended =3D <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "drdy";
> +
> +            /* Typical common mode voltage configuration */
> +            aincom-supply =3D <&ads1262_vbias>;
> +
> +            regulators {
> +                ads1262_vbias: vbias { };
> +            };
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                single-channel =3D <0>;
> +                /* The VBIAS is enabled on pin 10 (AINCOM) */
> +                common-mode-channel =3D <10>;
> +            };
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "ti,ads1263", "ti,ads1262";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <8000000>;
> +            spi-cpha;
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            interrupts-extended =3D <&gpio 0 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-names =3D "drdy";
> +
> +            ti,refp2-refn2-resistor-ohms =3D <3520>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                diff-channels =3D <4 5>;
> +                reference-sources =3D "refp2", "refn2", "refp2-refn2";
> +                excitation-channels =3D <1 6>;
> +                excitation-current-nanoamp =3D <500000 500000>;
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f3be900e5b9d..7593e33c5346 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27019,6 +27019,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
>  F:	drivers/iio/adc/ti-ads1018.c
> =20
> +TI ADS1262 ADC DRIVER
> +M:	Kurt Borja <kuurtb@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
> +
>  TI ADS7924 ADC DRIVER
>  M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
>  L:	linux-iio@vger.kernel.org
>=20
> --=20
> 2.55.0
>=20

--GniDptwhGn3Jax2r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapG53gAKCRB4tDGHoIJi
0i2sAQCBsOwQGW3Bfjomml7Gi0Ir258xhlXmvBSvn/oKDGHrygEAnbPBh4lgNDjM
ga5oqS/Vl5NMkG4f0SZwiOYdXkLG6gQ=
=Y5gE
-----END PGP SIGNATURE-----

--GniDptwhGn3Jax2r--
