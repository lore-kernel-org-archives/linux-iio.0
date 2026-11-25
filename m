Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628474;
	b=SrMGjOTuBft/4rM3MvSXPGGxmPIW9qwrzrbF+X+FEj8P6eih8KtaukIHgZfKix3LbE1W
	 IO0SvtqUTK/J2obRim+/FB/b0kKuE98qS3cJdgOZSDQbCvA9PYzppWtt8+B5noeAYP6uk
	 VJ19KbiKuRr6X7PKWHKAp4MpVJYq6rZfwah09iPaT5TO1XD28h+fVSleuLHoXjixp7T7u
	 vsgu3jw9tRgCqas9xfAVKdmY5btiO5NIn7ZfMbiHj5R6AyVkErQDhFQJspTnJX17M6X19
	 qOD1uj3hNKMKdFM9JGe9aXS7CLsOfSdScI/LTHkLJHDq6dZ2yo0VfYl3lbM+ohwkxDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628474;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=erAEA25th+KOHMa1v7FaF8fZBgd6XaRDc38NojJlE54=;
	b=2FJtaKHTuYGV5Q8CUalf0bMj8/AhcCdXc1H5GQe60qNZj5abweRTMpA7wLAVv6weUg7m
	 r0XoYQAYDQ8lXK7rWVyDJ8Oid+K9qoU6BZlczGaDWiZf8MFPRJkXhhvEmITR/Wj0vdl8K
	 Fi/Rdm85cIlZIX6wJZvR3ohnaSd9OaAjo7ZiohY0lavaPJsmtJEdEL+tvmEaap0bucxHv
	 tUHTE4OfHKeJN3X1RgnNUfIS1nEdIOw2+GPfpgjRUcRx93KQpLOLR6GlXARKq9pgDyC09
	 jF/SvZ2005aws+HtbYntbpx81DY8EyqzrBYhHvSAJnfYQqxqPOhZGpPbeJiIm5Y5now==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx9aUz7G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E4606A323;
	Wed, 25 Nov 2026 17:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx9aUz7G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD6C1F000CF;
	Wed, 25 Nov 2026 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628473;
	bh=erAEA25th+KOHMa1v7FaF8fZBgd6XaRDc38NojJlE54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cx9aUz7Gkn8V5RpWI9TdDq2zUqUtUAll1kuVlmMGILqbE/6zoEFpRZeC8Afzdjine
	 Q7v1lsr28rQVHbclQCWtu+anvy9yS0gPSuKSmU9Za8LJHM83uiOrz0SJvrF9ne5JI/
	 4bmVzFyCOvtNNNSKUCxmeN5QlsJKV2nOplJzjh8q6+0bSl4VHuhbdGKK84++UTJbCs
	 E4jfDhRECorKXTSygQE+PBZzzDWGyAfdrsVLmLcx0ellyl5K9pdxzQ4W+HG4Ng93L1
	 a9gwfFF32NFalDF3EGvrTUa664VrGFt4yYEar7iA0MLmLgkCKdYkO5fx39uU/RFq41
	 3rDzZt4Wq+orQ==
Date: Wed, 25 Nov 2026 17:41:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: add AD7793 and similar ADCs
Message-ID: <20261125-whenever-spinning-36a6dc477a00@spud>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-5-54e4c8830b57@analog.com>
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
	protocol="application/pgp-signature"; boundary="WPSmGh/W8R/DGKZI"
Content-Disposition: inline
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-5-54e4c8830b57@analog.com>

--WPSmGh/W8R/DGKZI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:19:21AM +0000, Nuno S=E1 wrote:
> Add a binding for the AD7785, AD7792, AD7793, AD7794, AD7795, AD7796,
> AD7797, AD7798 and AD7799 low power sigma-delta ADCs. The driver has
> supported these parts for a long time, but only through platform data.
>=20
> The ADC reference is described by which supplies are present: REFIN
> (REFIN1 on the AD7794/AD7795), then REFIN2, and otherwise the internal
> 1.17 V reference. In the same way, an external clock on the CLK pin is
> used if one is given, and the internal 64 kHz clock otherwise.
>=20
> The remaining properties describe how the analog front end is wired:
> the input buffer (enabled by default, as it is at power-up), unipolar
> or bipolar coding, the burnout current sources, the bias voltage
> generator and the excitation current sources.
>=20
> Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7793.yaml    | 236 +++++++++++++++=
++++++
>  MAINTAINERS                                        |  10 +
>  2 files changed, 246 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> new file mode 100644
> index 000000000000..c4a0be06e5c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> @@ -0,0 +1,236 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7793.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7793 and similar sigma-delta ADCs
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +  - Nuno S=E1 <nuno.sa@analog.com>
> +
> +description:
> +  Low power, low noise sigma-delta ADCs with an SPI interface.
> +
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7785.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7792_7793.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7794_7795.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7796_7797.pdf
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/AD=
7798_7799.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7785
> +      - adi,ad7792
> +      - adi,ad7793
> +      - adi,ad7794
> +      - adi,ad7795
> +      - adi,ad7796
> +      - adi,ad7797
> +      - adi,ad7798
> +      - adi,ad7799
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpol: true
> +
> +  spi-cpha: true
> +
> +  interrupts:
> +    description: Interrupt connected to the DOUT/RDY pin.
> +    maxItems: 1
> +
> +  rdy-gpios:
> +    description:
> +      GPIO reading the DOUT/RDY line. DOUT/RDY also toggles during SPI
> +      transfers, which usually triggers spurious interrupts. Reading thi=
s GPIO
> +      allows to tell those apart from real conversion done events.
> +    maxItems: 1
> +
> +  avdd-supply: true
> +
> +  dvdd-supply: true
> +
> +  refin-supply:
> +    description:
> +      External reference applied between REFIN(+) and REFIN(-), or betwe=
en
> +      REFIN1(+) and REFIN1(-) on the AD7794 and AD7795. If present, it i=
s used
> +      as the ADC reference. If neither refin-supply nor refin2-supply are
> +      present, the internal 1.17 V reference is used.
> +
> +  refin2-supply:
> +    description:
> +      External reference applied between REFIN2(+) and REFIN2(-). Used a=
s the
> +      ADC reference if refin-supply is not present.
> +
> +  clocks:
> +    description:
> +      External clock connected to the CLK pin. Either 64 kHz, or 128 kHz=
 in
> +      which case it gets divided by 2 internally. If not present, the in=
ternal
> +      64 kHz clock is used.
> +    maxItems: 1
> +
> +  bipolar:
> +    description: see Documentation/devicetree/bindings/iio/adc/adc.yaml
> +    type: boolean

This is odd, why not ref the file normally?

> +
> +  adi,buffer-disable:
> +    description:
> +      Operate the analog inputs in unbuffered mode. Unbuffered mode allo=
ws the
> +      inputs to go from 30 mV below GND to 30 mV above AVDD, while buffe=
red
> +      mode needs 100 mV of headroom to the supply rails but tolerates so=
urce
> +      impedances in front of the inputs. Buffered mode is always used fo=
r gains
> +      higher than 2.
> +    type: boolean

What determines if the gain is higher than 2?

> +
> +  adi,burnout-currents-enable:
> +    description:
> +      Enable the 100 nA burnout current sources in the signal path, whic=
h allow
> +      to detect an open circuit on the selected analog input. They can o=
nly be
> +      enabled when either the buffer or the in-amp is active.

The former should be somewhat enforceable with the binding, what
determins this in-amp's setting?

> +    type: boolean
> +
> +  adi,vbias-pin:
> +    description:
> +      Negative analog input (AINx(-)) to bias to AVDD / 2 with the bias =
voltage
> +      generator.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ain1, ain2, ain3]
> +
> +  adi,vbias-boost-enable:
> +    description:
> +      Increase the current of the bias voltage generator, reducing its p=
ower-up
> +      time.
> +    type: boolean
> +
> +  adi,excitation-current-microamp:
> +    description:
> +      Enables the excitation current sources IEXC1 and IEXC2. Both are a=
lways
> +      enabled together and set to this same value. Where each one is con=
nected
> +      is given by adi,excitation-pins.
> +    enum: [10, 210, 1000]
> +
> +  adi,excitation-pins:
> +    description:
> +      Output pins the excitation current sources IEXC1 and IEXC2 are rou=
ted
> +      to, in that order. The default routes IEXC1 to IOUT1 and IEXC2 to =
IOUT2.
> +      Both sources can be routed to the same pin, which then outputs twi=
ce the
> +      configured current. This is not allowed when
> +      adi,excitation-current-microamp is 1000.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    minItems: 2
> +    maxItems: 2
> +    items:
> +      enum: [iout1, iout2]
> +    default: [iout1, iout2]
> +
> +dependencies:
> +  adi,vbias-boost-enable: [ 'adi,vbias-pin' ]
> +  adi,excitation-pins: [ 'adi,excitation-current-microamp' ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - avdd-supply
> +  - dvdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        adi,excitation-current-microamp:
> +          const: 1000
> +      required:
> +        - adi,excitation-current-microamp
> +    then:
> +      properties:
> +        adi,excitation-pins:
> +          oneOf:
> +            - items:
> +                - const: iout1
> +                - const: iout2
> +            - items:
> +                - const: iout2
> +                - const: iout1
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7785
> +              - adi,ad7792
> +              - adi,ad7793
> +    then:
> +      properties:
> +        refin2-supply: false
> +        adi,vbias-pin:
> +          enum: [ain1, ain2]
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7796
> +              - adi,ad7797
> +              - adi,ad7798
> +              - adi,ad7799
> +    then:
> +      properties:
> +        refin2-supply: false
> +        adi,vbias-pin: false
> +        adi,vbias-boost-enable: false
> +        adi,excitation-current-microamp: false
> +        adi,excitation-pins: false
> +      required:
> +        - refin-supply
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7796
> +              - adi,ad7797
> +    then:
> +      properties:
> +        adi,buffer-disable: false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - adi,ad7798
> +              - adi,ad7799
> +    then:
> +      properties:
> +        clocks: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@0 {
> +            compatible =3D "adi,ad7793";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <5000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            interrupts =3D <25 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&gpio>;
> +            avdd-supply =3D <&avdd>;
> +            dvdd-supply =3D <&dvdd>;
> +            refin-supply =3D <&vref>;
> +            adi,vbias-pin =3D "ain2";
> +            adi,excitation-current-microamp =3D <210>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 658895c3b0fa..e55236f4accb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1731,6 +1731,16 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7780.yaml
>  F:	drivers/iio/adc/ad7780.c
> =20
> +ANALOG DEVICES INC AD7793 DRIVER
> +M:	Michael Hennerich <Michael.Hennerich@analog.com>
> +M:	Nuno S=E1 <nuno.sa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> +F:	drivers/iio/adc/ad7793.c
> +F:	include/linux/platform_data/ad7793.h
> +
>  ANALOG DEVICES INC AD8366 DRIVER
>  M:	Michael Hennerich <Michael.Hennerich@analog.com>
>  M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> --=20
> 2.56.0
>=20

--WPSmGh/W8R/DGKZI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawcdtAAKCRB4tDGHoIJi
0i0uAP0SufCE3ii+9E6g3cLh257vwsUw0GvJyavRtpoJ22BJ3QEA7KE86xqFH43v
q94l6ls00ot37MbFF1HdLO16+tbFXww=
=nsiV
-----END PGP SIGNATURE-----

--WPSmGh/W8R/DGKZI--
