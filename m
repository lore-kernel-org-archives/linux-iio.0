Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDCE2E7185;
	Thu,  1 Oct 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879566; cv=none; b=T9In2F7h55FfH3J2gsizSTY3E8mCWcNLalwgmI4XrhryvX1odrOD0rOOPevRessA+tA9j15e09WfXmdyugkM4alsUpavhGA1Iyru3a8Wv+VwyrWoejSit3sDHlqaDd6dEPT/6JJ1mAzXuTz0RJKNpptW4Wi/nuz1kZU2UPZiZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879566; c=relaxed/simple;
	bh=MC1INlccf2rHPsk741T6kQd+cSexq7ou2v+m+6JnSeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TS7/rIKs1qGoF54/FaX8uTGchak38u5cWEgJMhzPRA+vhj6wl1aj3EJFfO4dqqntGKCUQ13/aJ1Q7z+2vZIRvDbwpLXCB/FSWUg39/vDHUaye81L6FNYJHoWiwMvNp3cp440BOF8Bgp7J2QX75wm8SxIdq8CA91ehjxvwXvsidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epQXHre5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epQXHre5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68651F000FF;
	Thu,  1 Oct 2026 18:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790879564;
	bh=oGBwnkqL/rRbOIROkDf5S2pEmAESTp09mNxFFxpctBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=epQXHre5RlUrjIwqfyE5DCwdIVIvNH+7PGRxG+Gk/23KXLfpkbzws6Zu1YSXf0RtR
	 JO3TNVGoR7k3YKF9qu6cwjDxrYoWdS0jxk+g7nw8MYJRjg0xxQAwDLKNFeSja4OclM
	 f7PEKLXV2NJo9+7bunVvp2jFf+J+tyIlyQihv5kRqa0NP3x+4AL18CjP3SFDXE2fdT
	 55fiXsXZzTYc3RlDDg+wBUbUVVNAa+BZvXgTJHdrKejEqjGx4SuUPF9i48+cgF0fnF
	 MEOI/fjjYZ4w+lJoFCoNYuEYHVfi6R5wAdKLt95PjQiPfQ0bwJqeHi4HNecmjmkyMR
	 8/FEKLffSIb6w==
Date: Thu, 1 Oct 2026 19:32:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
Message-ID: <20261001-tribesman-gauze-862e1ef0cdd8@spud>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0bmgHkmrH1zppk4N"
Content-Disposition: inline
In-Reply-To: <20261001145702.2628429-2-olivier.moysan@foss.st.com>

--0bmgHkmrH1zppk4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
> Add bindings that describes STM32 MDF settings to support
> digital filtering for Pulse Density Modulation (PDM) microphones
> and analog sigma delta modulators.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++++++++++
>  1 file changed, 383 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-md=
f-adc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.y=
aml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
> new file mode 100644
> index 000000000000..f2fbc3e150e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.yaml
> @@ -0,0 +1,383 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: STMicroelectronics STM32 Multi-function Digital Filter (MDF) ADC
> +
> +maintainers:
> +  - Olivier Moysan <olivier.moysan@foss.st.com>
> +
> +description: |
> +  STM32 MDF ADC is a sigma delta analog-to-digital converter dedicated to
> +  interface external sigma delta modulators to STM32 micro controllers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - st,stm32mp25-mdf
> +      - st,stm32mp23-mdf
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2

This needs an items list here. The size of the regions seems like crap
to begin with...

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    description: Internal clock used for MDF digital processing.
> +    items:
> +      - const: ker_ck

This is pointless when you only have one.

> +
> +  "#clock-cells":
> +    enum: [0, 1]

Why is this not fixed? Also why are parts of your own device consuming
the clocks?

> +
> +  clock-output-names:
> +    description: |
> +      CCK0 and CCK1 are optional output clocks, which share the same clo=
ck frequency,
> +      but can be gated independently to save power.
> +    minItems: 1
> +    maxItems: 2
> +    oneOf:
> +      - items:
> +          - const: cck0
> +      - items:
> +          - const: cck1
> +      - items:
> +          - const: cck0
> +          - const: cck1
> +
> +  clock-frequency:
> +    description: |
> +      Common clock frequency (Hz) for CCK0 and CCK1 output clocks.
> +      The frequency must be a multiple of the "ker_ck" clock frequency.
> +    maximum: 25000000

Should not be needed, the consumers request what they need.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +  clock-ranges: true
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: mdf
> +
> +  access-controllers:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      Phandle to the rifsc device to check access right.
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  st,interleave:
> +    description: |
> +      List of phandles of interleaved filters. The indexes of interleave=
d filters must be
> +      consecutives starting from 0 (i.e in range [0..N]). The samples fr=
om interleaved filters
> +      are muxed in a single channel and retrieved through the device ass=
ociated to the filter 0.
> +      The filters 1..N have to be enabled, but inherit their configurati=
on from filter 0.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array

No idea what these even are, but this is probably not the right way to
represent the relationship between devices. They're apparently ADCs, but
this is also an ADC so I'm not sure what's going on here at all.

> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - clocks
> +  - clock-names
> +  - clock-ranges
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^sitf@[0-9]+$":
> +    type: object
> +    description: Serial interface child node

Why is this a child node at all?
=20
Probably not worth reviewing more without a link to the docs for this
device so I can figure out what on earth is going on!

Thanks,
Conor.

> +
> +    properties:
> +      compatible:
> +        enum:
> +          - st,stm32mp25-sitf-mdf
> +
> +      reg:
> +        description: Specify the SITF serial interface instance
> +        maxItems: 1
> +
> +      clocks:
> +        description: |
> +          Serial interface clock (optional depending on interface mode)
> +        maxItems: 1
> +
> +      st,sitf-mode:
> +        description: |
> +          Select serial interface protocol
> +          - spi: SPI mode
> +          - lf_spi: low frequency SPI mode for low power applications
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - spi
> +          - lf_spi
> +
> +    required:
> +      - reg
> +      - st,sitf-mode
> +
> +    additionalProperties: false
> +
> +  "^filter@[0-9]+$":
> +    type: object
> +    description: Digital filter path child node
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - st,stm32mp25-mdf-dmic
> +          - st,stm32mp25-mdf-adc
> +
> +      reg:
> +        description: Specify the MDF filter instance
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
> +
> +      clocks:
> +        minItems: 1
> +        description: Internal clock used for MDF digital processing and =
control blocks.
> +
> +      clock-names:
> +        items:
> +          - const: ker_ck
> +
> +      dmas:
> +        maxItems: 1
> +
> +      dma-names:
> +        items:
> +          - const: rx
> +
> +      "#io-channel-cells":
> +        const: 1
> +
> +      '#address-cells':
> +        const: 1
> +
> +      '#size-cells':
> +        const: 0
> +
> +      st,cic-mode:
> +        description: |
> +          Cascaded-integrator-comb (CIC) filter configuration
> +          - 0: MCIC & ACIC filters in FastSinc mode
> +          - [1-3]: MCIC & ACIC filters in Sinc mode order 1 to 3
> +          - [4-5]: Single CIC filter in Sinc mode order 4 to 5
> +          For audio purpose it is recommended to use CIC Sinc4 or Sinc5
> +          This property is mandatory for filter 0 or filters not used in=
 interleave mode.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        minimum: 0
> +        maximum: 5
> +
> +      st,delay:
> +        description: Filter delay in samples
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maximum: 127
> +
> +      st,rs-filter-bypass:
> +        description: Bypass RSFLT reshaping filter.
> +        $ref: /schemas/types.yaml#/definitions/flag
> +
> +      st,hpf-filter-cutoff-bp:
> +        description: |
> +          High Pass Filter (HPF) cut-off frequency expressed as a fracti=
on of the PCM sampling rate.
> +          Cut-off frequency =3D st,hpf-filter-cutoff-bp x Fpcm / 10000.
> +          If this property is not defined the HPF is disabled.
> +        enum: [625, 1250, 2500, 9500]
> +
> +      st,sync:
> +        description:
> +          Synchronize to another filter.
> +          Must contain the phandle of the filter providing the synchroni=
zation.
> +        allOf:
> +          - $ref: /schemas/types.yaml#/definitions/phandle-array
> +          - maxItems: 1
> +
> +      st,sitf:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        items:
> +          - items:
> +              - description: Phandle of the serial interface connected t=
o the digital filter
> +              - description: |
> +                  The phandle's argument selects the bitstream on the fa=
lling or rising edge
> +                  of the serial interface clock:
> +                  - 0: rising edge
> +                  - 1: falling edge
> +                enum: [0, 1]
> +                default: 0
> +        description:
> +          Should be phandle/bitstream pair.
> +
> +    required:
> +      - compatible
> +      - reg
> +      - interrupts
> +      - dmas
> +      - dma-names
> +      - "#io-channel-cells"
> +      - "#address-cells"
> +      - "#size-cells"
> +      - st,sitf
> +
> +    unevaluatedProperties: false
> +
> +    patternProperties:
> +      "^channel@([0-7])$":
> +        type: object
> +        $ref: adc.yaml
> +        description: Represents the external channel which is connected =
to the MDF.
> +
> +        properties:
> +          reg:
> +            maximum: 7
> +
> +          io-backends:
> +            description:
> +              Used to pipe external sigma delta modulator or internal AD=
C backend to MDF
> +              channel.
> +            maxItems: 1
> +
> +        required:
> +          - reg
> +
> +        unevaluatedProperties: false
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: st,stm32mp25-mdf-adc
> +
> +        then:
> +          patternProperties:
> +            "^channel@[0-7]$":
> +              required:
> +                - io-backends
> +
> +      - if:
> +          properties:
> +            compatible:
> +              contains:
> +                const: st,stm32mp25-mdf-dmic
> +
> +        then:
> +          patternProperties:
> +            "^mdf-dai+$":
> +              type: object
> +              description: child node
> +
> +              properties:
> +                compatible:
> +                  enum:
> +                    - st,stm32mp25-mdf-dai
> +
> +                "#sound-dai-cells":
> +                  const: 0
> +
> +                io-channels:
> +                  description:
> +                    From common IIO binding. Used to pipe external sigma=
 delta
> +                    modulator or internal ADC output to MDF channel.
> +
> +                power-domains:
> +                  maxItems: 1
> +
> +                port:
> +                  $ref: /schemas/sound/audio-graph-port.yaml#
> +                  unevaluatedProperties: false
> +
> +              required:
> +                - compatible
> +                - "#sound-dai-cells"
> +                - io-channels
> +
> +              additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mdf1: mdf@504d0000 {
> +      compatible =3D "st,stm32mp25-mdf";
> +      ranges =3D <0 0x504d0000 0x1000>;
> +      reg =3D <0x504d0000 0x8>, <0x504d0ff0 0x10>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +      clocks =3D <&rcc CK_KER_MDF1>;
> +      clock-names =3D "ker_ck";
> +      clock-ranges;
> +      #clock-cells =3D <1>;
> +      clock-output-names =3D "cck0", "cck1";
> +      clock-frequency =3D <2048000>;
> +
> +      sitf5: sitf@300 {
> +        compatible =3D "st,stm32mp25-sitf-mdf";
> +        reg =3D <0x300 0x4>;
> +        st,sitf-mode =3D "spi";
> +        clocks =3D <&mdf1 0>;
> +      };
> +
> +      filter0: filter@84 {
> +        compatible =3D "st,stm32mp25-mdf-dmic";
> +        reg =3D <0x84 0x70>;
> +        #io-channel-cells =3D <1>;
> +        interrupts =3D <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas =3D <&hpdma 63 0x63 0x12 0>;
> +        dma-names =3D "rx";
> +        st,cic-mode =3D <5>;
> +        st,sitf =3D <&sitf5 0>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        channel@0 {
> +          reg =3D <0>;
> +        };
> +
> +        asoc_pdm0: mdf-dai {
> +          compatible =3D "st,stm32mp25-mdf-dai";
> +          #sound-dai-cells =3D <0>;
> +          io-channels =3D <&filter0 0>;
> +        };
> +      };
> +
> +      filter1: filter@104  {
> +        compatible =3D "st,stm32mp25-mdf-adc";
> +        reg =3D <0x104 0x70>;
> +        #io-channel-cells =3D <1>;
> +        interrupts =3D <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas =3D <&hpdma 64 0x63 0x12 0>;
> +        dma-names =3D "rx";
> +        st,cic-mode =3D <2>;
> +        st,sitf =3D <&sitf5 1>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        channel@1 {
> +          reg =3D <1>;
> +          settling-time-us =3D <1000>;
> +          io-backends =3D <&sd_adc1>;
> +        };
> +      };
> +    };
> +
> +...
> --=20
> 2.43.0
>=20

--0bmgHkmrH1zppk4N
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar6nRAAKCRB4tDGHoIJi
0pLUAP4iHORp6R5LSOhErNzwNF64wY+EkW4TCosH3xQI5JbymwD/RxyTWWvEQymD
4o8999cZEpEPmyyS03wkF8vDo+rN8gY=
=aAiR
-----END PGP SIGNATURE-----

--0bmgHkmrH1zppk4N--
