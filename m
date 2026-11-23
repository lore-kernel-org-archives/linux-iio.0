Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455063;
	b=YH/SMWemDLD8DB44PCiB0D3NNFhk6TLclTLIBIg/W5B85YHLDRyMAqtAkfxn5oN7YjBa
	 GCUetp3M/pCoy2jbygI7+RNW19DYe/jxOkhatO07nwX3kQv56+zpG32Vt/MXjTeDvkDAi
	 US6sCJ40ECbCuxgdvxHufqJOraZBXPTKDp1q5gFF/TxRwXAua3xNhdYIX16++gFF1gfLm
	 yNV+O8hqJPYBDed6saob7s1UYf7CIKxDZi4yKLU7Vvf/yA3L2L2StGm2O4QQr1rzCGk4y
	 zVguhhLv9iDV27YC0UePjV70oJ6NkfnnSv4Px6Iop6v9g1w/eEcd5iRorPMAqGsEhWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455063;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=H5+Lix3xzZSXhmyLmSdI/jrXb/6kX811TwJY7/S4SQU=;
	b=X05NJbIq8wfaqakRnBf5BaJ5+pc9SSFT8dtnhjJtdKjlVU69/mnslB7MtyRXymg63d8y
	 TuAfydM68VVak1Bp0ML7rjf8v2bJP6Ex87RaLBMK1Ro48HuqHT94v2F1RhlTsX9+7fywJ
	 Zv0Oa4nCwhbyQfCtBAU0jvtVdxvS/mrAItD2qS3LUTqgtN+Uee/mMSEvGKHj/05jqV4p0
	 oNbN4yUl+TPzTmOO7OmMU+u7F9YBNMHaWThqysVtXx5fJbYKBJBtDmUWA+1NBSnnA422P
	 wWLQEiu6cACtHRSGU/SvYZzZ6QWSmNqCnl8ReBYdcNEyMUD9YFM36hABOGNXrcWq5hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amLS0Yjn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0557606A327;
	Mon, 23 Nov 2026 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amLS0Yjn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE51D1F000CF;
	Mon, 23 Nov 2026 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455062;
	bh=H5+Lix3xzZSXhmyLmSdI/jrXb/6kX811TwJY7/S4SQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=amLS0YjncvNQ8pmJUK54pkqj7g6R+BvKyP09zvF4FpC6ZYJmXf1rqrz7cnIDa8kEs
	 EUWLGPx3cl2WgTRKDzJkV84pGWBytW6j9+dXVHk7oe7IXom0C0t1BBtDTglYuoGEr2
	 +dudUVBvI0XE2yWAg43iUgkd3VALtI0xsoRsEWxc32FATRGUvTqFUJgYjC2wPW2ejR
	 3OYKYRxwTZ9nqFnxGFvdZog3FoMn5f+9VHIRADSYUm3uJ0DVSAP7h+a0vgFv4PVXYB
	 mCIrobfQpnSLlKmUBRL2VRuQAqVkSDv29/242VxHYj768lQqO4v6kUn4Wd1DakW3nd
	 HKQpbNyYBIH8Q==
Date: Mon, 23 Nov 2026 17:30:54 +0000
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
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: iio: adc: add stm32mp2 mdf filter
Message-ID: <20261123-barbecue-trickily-4ae8d9f01b3d@spud>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-1-7939d3c3720a@foss.st.com>
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
	protocol="application/pgp-signature"; boundary="qmIYYbkYuRL7omxq"
Content-Disposition: inline
In-Reply-To: <20261118-upstream_mdf_v2-v2-1-7939d3c3720a@foss.st.com>

--qmIYYbkYuRL7omxq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With an eye to accepting something of this nature, rather than a rework,
I have some initial questions before suggesting some remodeling of what
is here.

On Wed, Nov 18, 2026 at 04:17:46PM +0100, Olivier Moysan wrote:
> Add bindings that describes STM32 MDF settings to support
> digital filtering for Pulse Density Modulation (PDM) microphones
> and analog sigma delta modulators, on STM32MP2 SoCs.
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../bindings/iio/adc/st,stm32mp25-mdf.yaml         | 341 +++++++++++++++=
++++++
>  1 file changed, 341 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32mp25-mdf.y=
aml b/Documentation/devicetree/bindings/iio/adc/st,stm32mp25-mdf.yaml
> new file mode 100644
> index 000000000000..e4925a38012d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32mp25-mdf.yaml
> @@ -0,0 +1,341 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/st,stm32mp25-mdf.yaml#
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
> +      - st,stm32mp23-mdf
> +      - st,stm32mp25-mdf
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    enum: [0, 1]
> +
> +  clock-output-names:
> +    description: |
> +      CCK0 and CCK1 are optional output clocks, which share the same clo=
ck frequency,
> +      but can be gated independently to save power.
> +    minItems: 1
> +    items:
> +      - enum: [cck0, cck1]
> +      - const: cck1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges: true
> +
> +  resets:
> +    maxItems: 1
> +
> +  access-controllers:
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  st,interleave:
> +    description: |
> +      Number of interleaved filters, starting from filter 0. For a value=
 N,
> +      filters 0 through N - 1 participate in interleaving. Their samples=
 are
> +      multiplexed into a single channel and retrieved through the device
> +      associated with filter 0. Filters 1 through N - 1 must be enabled =
and
> +      inherit their configuration from filter 0. If absent, interleaving=
 is
> +      disabled.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 2
> +    maximum: 8
> +
> +required:
> +  - compatible
> +  - reg
> +  - ranges
> +  - clocks
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  "^sitf@[0-9]+$":
> +    type: object
> +    description: |
> +      Serial interface configuration, managed by the MDF core. Pin contr=
ol
> +      states for the serial interface pins belong to the MDF parent node.
> +
> +    properties:
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

These two compatibles don't represent different hardware, just different
roles from the same hardware, right?

> +
> +      reg:
> +        description: Specify the MDF filter instance
> +        maxItems: 1
> +
> +      interrupts:
> +        maxItems: 1
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

Can this ever be more than a single phandle?

> +
> +      mdf-dai:
> +        type: object
> +        description: Audio interface for the MDF filter
> +
> +        properties:
> +          compatible:
> +            const: st,stm32mp25-mdf-dai
> +
> +          "#sound-dai-cells":
> +            const: 0
> +
> +          io-channels:
> +            description:
> +              From common IIO binding. Used to pipe external sigma delta
> +              modulator or internal ADC output to MDF channel.
> +
> +          power-domains:
> +            maxItems: 1
> +
> +          port:
> +            $ref: /schemas/sound/audio-graph-port.yaml#
> +            unevaluatedProperties: false
> +
> +        required:
> +          - compatible
> +          - "#sound-dai-cells"
> +          - io-channels
> +
> +        additionalProperties: false
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
> +          properties:
> +            mdf-dai: false
> +
> +    unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mdf1: filter@504d0000 {
> +      compatible =3D "st,stm32mp25-mdf";
> +      ranges =3D <0 0x504d0000 0x1000>;
> +      reg =3D <0x504d0000 0x8>, <0x504d0ff0 0x10>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +      clocks =3D <&rcc CK_KER_MDF1>;
> +      #clock-cells =3D <1>;
> +      clock-output-names =3D "cck0", "cck1";
> +
> +      sitf5: sitf@300 {
> +        reg =3D <0x300 0x4>;
> +        st,sitf-mode =3D "spi";
> +        clocks =3D <&mdf1 0>;
> +        assigned-clocks =3D <&mdf1 0>;
> +        assigned-clock-rates =3D <2048000>;
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
> +        mdf-dai {
> +          compatible =3D "st,stm32mp25-mdf-dai";
> +          #sound-dai-cells =3D <0>;
> +          io-channels =3D <&filter0 0>;
> +        };
> +      };
> +
> +      filter@104 {
> +        compatible =3D "st,stm32mp25-mdf-adc";
> +        reg =3D <0x104 0x70>;
> +        #io-channel-cells =3D <1>;
> +        interrupts =3D <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> +        dmas =3D <&hpdma 64 0x63 0x12 0>;
> +        dma-names =3D "rx";
> +        st,cic-mode =3D <2>;
> +        st,sitf =3D <&sitf5 1>;

Is this a realistic example, with multiple devices connected to the same
sitf? I assume it is technically possible, given what I have seen in the
docs but would anyone do this in reality?

Cheers,
Conor.

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
>=20
> --=20
> 2.43.0
>=20

--qmIYYbkYuRL7omxq
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawR4TgAKCRB4tDGHoIJi
0t1eAP9+SKDfz/fXqCrDw0Xq8RD8jyl2939S/hKOCEEMY+AzcQEA8kFKkJ2Ma5xy
MH26truzNzaIE4lDOb7gNwiUWblYrgk=
=JJBX
-----END PGP SIGNATURE-----

--qmIYYbkYuRL7omxq--
