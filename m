Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612F3A16AC;
	Tue, 16 Jun 2026 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626046; cv=none; b=Gsl1q54XGf2/0+797mCJqQLAsRvcP67GML9byVnEzOW4+gYbYG0uAR30EEW19fHPch+OfyQKRW5JPw1uFobyJpNr2S24KJ0s5wTiNzW0FdMQoGPjzqmf8ofQstc2XP26cSA7kXVJY8JSVSNOzFd/HULMOWR1t9mpFkW/9mynvys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626046; c=relaxed/simple;
	bh=3tzZnjmNjmotFZ7uaMnAomU+ygB5XKg7WBs+mh1XAQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr+/OcmQjsehN1C/Tsccmneg1Rn4YceKuZDA+rKzrnBvDxwya7nF0YYhJfDLII2iacIx0EyvOousWkr8/tlhHn8DhKQL5Esyfgd07syvpxTGhLp1QFyquSavK0tUl85b6r29pX8y1OM3Z125f0GRDmtTP6SjKRmO1PBn55FCAJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lA6q07+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lA6q07+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30B11F00A3A;
	Tue, 16 Jun 2026 16:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781626045;
	bh=A6qXeT9XxkhSfASDVonIFYEzG76sxThY93rvQLvFR0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lA6q07+2xJLK/v8OrIBxStGcP66KNC8c6KjWyLNkiLJf/nPedtW53EXjSBgCILpWV
	 BPgGEcI7LWuvZh8ue0yovKueIU4QS/Hbw4m7fpd9/rb7TB5vkhTVo1ldeT+50ngsQL
	 91Yc5mBwkJpNnmL9BfqFTtN8RWpYf8SKmqTuArXUr8cLmo7Fjim6n6+Gd1AaKCG6am
	 OcXN1YWZ1MNaQv+jGxrddNLA0MJtqDyKtPjj4ERZeYikD9lXjfvsNuLjs77MzNeRmF
	 xEuiUMCsDIC2XGcQWjdByyvKFiJObCARtTsf3CMv9qqu25NE0wEwuY/w9FFW3uCVdZ
	 TgxQrJyKrxl0w==
Date: Tue, 16 Jun 2026 17:07:20 +0100
From: Conor Dooley <conor@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260616-spoon-ducky-b05e9bf7e999@spud>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HSGwlUuCraZwW8tT"
Content-Disposition: inline
In-Reply-To: <20260615-iio-adc-ti-ads122c14-v1-1-e6bdadf7cb2b@baylibre.com>


--HSGwlUuCraZwW8tT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 04:59:59PM -0500, David Lechner (TI) wrote:
> Add new bindings for ti,ads122c14 and similar devices.
>=20
> This is an ADC that is primarily intended for use with temperature
> sensors. There are a few unusual properties because of this. In
> particular, the reference voltage source and current output requirements
> can be different for each measurement, so these are included in the
> channel bindings.
>=20
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
>=20
> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> have preferred an enum of strings).
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
>  .../devicetree/bindings/iio/adc/ti,ads112c14.yaml  | 224 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   7 +
>  include/dt-bindings/iio/adc/ti,ads112c14.h         |  11 +
>  3 files changed, 242 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml =
b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> new file mode 100644
> index 000000000000..dc7f37cad772
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> @@ -0,0 +1,224 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,ads112c14.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments' ADS112C14 and similar ADC chips
> +
> +description: |
> +  Supports the following Texas Instruments' ADC chips:
> +  - ADS112C14 (16-bit)
> +  - ADS122C14 (24-bit)
> +
> +  https://www.ti.com/lit/ds/symlink/ads122c14.pdf
> +
> +  These chips are primarily designed for use with temperature sensors su=
ch as
> +  RTDs and thermocouples. The channel bindings reflect this in that each=
 channel
> +  represents the conditions required to make a measurement rather than s=
trictly
> +  just the physical input channels.
> +
> +maintainers:
> +  - David Lechner <dlechner@baylibre.com>
> +
> +unevaluatedProperties: false

Weird positioning of this.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,ads112c14
> +      - ti,ads122c14
> +
> +  reg:
> +    items:
> +      - minimum: 0x40
> +        maximum: 0x47
> +
> +  clocks:
> +    maxItems: 1
> +    description: Optional external clock connected to GPIO3 pin.
> +
> +  avdd-supply: true
> +  dvdd-supply: true
> +
> +  refp-supply: true
> +  refn-supply: true
> +
> +  refp-refn-resistor-ohms:

Missing prefix here and elsewhere.

> +    description:
> +      The resistance of the external resistor between REFP and REFN when=
 using
> +      resistor bridge driven by current outputs for RTD measurements.
> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description: FAULT interrupt (GPIO2 pin)
> +      - description: DRDY interrupt (GPIO3 pin)
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [fault, drdy]
> +
> +  gpio-controller: true
> +  '#gpio-cells':
> +    const: 2
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  ^channel@[0-7]$:
> +    $ref: adc.yaml
> +
> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        maximum: 16 # arbitrary limit, channel@ can be any combination o=
f AIN0-AIN7
> +
> +      single-channel:
> +        maximum: 7
> +
> +      diff-channels:
> +        items:
> +          maximum: 7
> +
> +      bipolar:
> +        description:
> +          Set this flag if the differential input can be negative.
> +
> +      excitation-channels:

(here)

> +        description: AINx pins used as current output.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +        minItems: 1
> +        maxItems: 2
> +        items:
> +          maximum: 7
> +
> +      excitation-current-microamp:

(here)

> +        description: The current output of the excitation channels in mi=
croamps.
> +        minimum: 1
> +        maximum: 1000
> +
> +      current-chopping:

(and here)

> +        $ref: /schemas/types.yaml#/definitions/flag
> +        description:
> +          If provided, the two excitation channels are to be used with c=
urrent
> +          chopping enabled.
> +
> +      ti,vref-source:
> +        description: |
> +          Indicates the source for the reference voltage for this channe=
l.
> +          0 - Internal 2.5V reference
> +          1 - Internal 1.25V reference
> +          2 - External reference (REFP-REFN)
> +          3 - AVDD as reference

My usual complaint here about things you have to make macros for, could
these just be strings from the get-go?

> +
> +          For convenience, macros for these values are available in
> +          dt-bindings/iio/adc/ti,ads112c14.h.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 3
> +        default: 0
> +
> +    dependencies:
> +      excitation-channels: [ excitation-current-microamp ]
> +      excitation-current-microamp: [ excitation-channels ]
> +      current-chopping: [ excitation-channels ]
> +
> +    oneOf:
> +      - required: [ single-channel ]
> +      - required: [ diff-channels ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
> +
> +dependencies:
> +  refn-supply: [ refp-supply ]
> +
> +allOf:
> +  - oneOf:

"allOf: - oneOf:" is equivalent to just writing "oneOf:"

pw-bot: changes-requested

Thanks,
Conor.


> +      - required: [ refp-supply ]
> +      - required: [ refp-refn-resistor-ohms ]
> +      - properties:
> +          refp-supply: false
> +          refn-supply: false
> +          refp-refn-resistor-ohms: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@40 {
> +            compatible =3D "ti,ads112c14";
> +            reg =3D <0x40>;
> +
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +
> +            /* 3-Wire RTD: Two IDACs, One Measurement (AIN1-AIN2) */
> +
> +            refp-refn-resistor-ohms =3D <500>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@0 {
> +              reg =3D <0>;
> +              diff-channels =3D <1>, <2>;
> +              excitation-channels =3D <0>, <3>;
> +              excitation-current-microamp =3D <500>;
> +              current-chopping;
> +              ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
> +              label =3D "rtd";
> +            };
> +        };
> +    };
> +  - |
> +    #include <dt-bindings/iio/adc/ti,ads112c14.h>
> +
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@40 {
> +            compatible =3D "ti,ads112c14";
> +            reg =3D <0x40>;
> +
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +
> +            /* Resistive Bridge Measurement With a Thermistor for Temper=
ature Compensation*/
> +
> +            refp-supply =3D <&avdd>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@0 {
> +              reg =3D <0>;
> +              diff-channels =3D <6>, <7>;
> +              bipolar;
> +              ti,vref-source =3D <ADS112C14_VREF_SOURCE_EXTERNAL>;
> +              label =3D "bridge";
> +            };
> +
> +            channel@1 {
> +              reg =3D <1>;
> +              diff-channels =3D <1>, <2>;
> +              ti,vref-source =3D <ADS112C14_VREF_SOURCE_INTERNAL_2_5V>;
> +              label =3D "thermistor";
> +            };
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f1caa6e5198b..9ce7c61b0c14 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26911,6 +26911,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
>  F:	drivers/iio/adc/ti-ads1119.c
> =20
> +TI ADS112C14 ADC DRIVER
> +M:	David Lechner <dlechner@baylibre.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> +F:	include/dt-bindings/iio/adc/ti,ads112c14.h
> +
>  TI ADS1018 ADC DRIVER
>  M:	Kurt Borja <kuurtb@gmail.com>
>  L:	linux-iio@vger.kernel.org
> diff --git a/include/dt-bindings/iio/adc/ti,ads112c14.h b/include/dt-bind=
ings/iio/adc/ti,ads112c14.h
> new file mode 100644
> index 000000000000..96906642fe41
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/ti,ads112c14.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_TI_ADS112C14_H
> +#define _DT_BINDINGS_TI_ADS112C14_H
> +
> +#define ADS112C14_VREF_SOURCE_INTERNAL_2_5V	0
> +#define ADS112C14_VREF_SOURCE_INTERNAL_1_25V	1
> +#define ADS112C14_VREF_SOURCE_EXTERNAL		2
> +#define ADS112C14_VREF_SOURCE_AVDD		3
> +
> +#endif /* _DT_BINDINGS_TI_ADS112C14_H */
>=20
> --=20
> 2.43.0
>=20

--HSGwlUuCraZwW8tT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajF0uAAKCRB4tDGHoIJi
0mcJAP44DrE0LNcsX+Iafys5e3uy5YT7UIkD0S12BY0qT9TBKQEAqf1acULQmuGU
ChznUhI4oo46RSs451RW9ZuV9MoAYgI=
=/Zhv
-----END PGP SIGNATURE-----

--HSGwlUuCraZwW8tT--
