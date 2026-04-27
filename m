Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E5266581;
	Mon, 27 Apr 2026 19:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777318474; cv=none; b=k3oReg9XUlmkcb2f11toGgy4jh45IBRM3p6yepQD+wCQ4OkZ3x4mCXhsmmeLHCu8LLfMo+oOJTF1mcXRvW5BcbJcBqSV1Yu5HHAHnXGqKq8MPPFE9Dtzr3NrtN8txNGrcWLNPXgPLGQhcQi2X21RKHAEa8p58nJhleRpOJlC5XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777318474; c=relaxed/simple;
	bh=W18Evk+YRcqS95zXPu3KOI6ef0AlvGaElOd5O0CFqSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uXPHZ/rFwgis+WDWDi2+hCCjbgH2iQr78s9p+RzQLM/TAuCgWhEujbVFfDNFCB4KK+e3eYw/9XF6VkMZyItnLyXFdrlLiFVh7aREbeEnppXXSghcVrgoRQzzTB1OS+wx7bggD/1UEn4lhe4EZ2ubpNbZhmoPDuFXrG8TvKqqdzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXX+6XSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXX+6XSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127BFC19425;
	Mon, 27 Apr 2026 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777318474;
	bh=W18Evk+YRcqS95zXPu3KOI6ef0AlvGaElOd5O0CFqSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cXX+6XSy3xYwi/odyvfWLHOIYA3qG2CsoyJycpXUffhtbf8E+vf/y6noZJ0qgsoNw
	 tDN+oeFeoKK+w4XVogXZj7iww6vz4A/5CHy310YOzOzH0+y/vNMBIbfWK//HGMWTDd
	 58+szmqeAJPph8hnozhc/S3/JEgcwvJaWiErtOhCJ8ReTywZVWCSTsx0M8IC8pEOsL
	 iXmfmYiKOn4MAoZrqzE9IGoxQ4Psa4CWDsLDAVaRvs0llGgNQVMDwEwKrOZT75hDKi
	 Je2DlhU5QiEScaXF/D+pPog8j+6Z2Vk4U29pvzBEwYKz9/FjgaOesI7ABPQmvyJDD/
	 NgBouQG5ISy5A==
Date: Mon, 27 Apr 2026 20:34:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support
 to adi,ltc2983
Message-ID: <20260427-epileptic-pendant-1df77a472793@spud>
References: <20260427132526.272716-1-liviu.stan@analog.com>
 <20260427132526.272716-2-liviu.stan@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d/+lsmD5c9DEyzRI"
Content-Disposition: inline
In-Reply-To: <20260427132526.272716-2-liviu.stan@analog.com>


--d/+lsmD5c9DEyzRI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 04:25:07PM +0300, Liviu Stan wrote:
> The ADT7604 shares the same die as the LTC2984. It repurposes the
> custom RTD sensor type (18) as a copper trace resistance sensor
> and the custom thermistor type (27) as a leak detector, and
> removes thermocouple, diode and direct ADC sensor types.

I have to wonder if this is the right approach, if it's the same device
just with a different label and advertised purpose.

>=20
> Add adi,adt7604 to the compatible list and introduce two new
> sensor node types specific to this device:
>=20
> - copper-trace@: maps to the custom RTD sensor type (18). Two
>   variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
>   no custom table) and standard (> 1 ohm, optional adi,custom-rtd
>   table). Primary output is resistance in mOhm.
>=20
> - leak-detector@: maps to the custom thermistor sensor type (27).
>   Takes an optional adi,custom-leak-detector lookup table encoding
>   resistance (uOhm) against coverage data (P + 273.15 in uK).
>   Primary output is resistance in Ohm; when a table is provided,
>   IIO_TEMP reports coverage percentage (raw / 1024).
>=20
> allOf conditions are added to restrict thermocouple, diode, direct
> ADC and active temperature nodes to non-ADT7604 devices, and to
> restrict copper-trace and leak-detector nodes to the ADT7604.
>=20
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 170 +++++++++++++++++-
>  1 file changed, 167 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc298=
3.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> index a22725f7619b..e777b37d588d 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> @@ -4,14 +4,14 @@
>  $id: http://devicetree.org/schemas/iio/temperature/adi,ltc2983.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Analog Devices LTC2983, LTC2986, LTM2985 Multi-sensor Temperature=
 system
> +title: Analog Devices LTC2983, LTC2986, LTM2985, ADT7604 Multi-sensor Te=
mperature system
> =20
>  maintainers:
>    - Nuno S=E1 <nuno.sa@analog.com>
> =20
>  description: |
> -  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
> -  Temperature Measurement Systems
> +  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985, ADT7604 Multi-Sensor
> +  Digital Temperature Measurement Systems
> =20
>    https://www.analog.com/media/en/technical-documentation/data-sheets/29=
83fc.pdf
>    https://www.analog.com/media/en/technical-documentation/data-sheets/29=
84fb.pdf
> @@ -43,6 +43,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - adi,adt7604
>            - adi,ltc2983
>            - adi,ltc2986
>            - adi,ltm2985
> @@ -436,6 +437,96 @@ patternProperties:
>      required:
>        - adi,custom-temp
> =20
> +  '^copper-trace@':

Pedantry perhaps, but isn't this an "ohmmeter"?

> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +    description: |
> +      Copper trace resistance sensor (ADT7604 only). Uses the custom RTD
> +      sensor type (18). Two variants exist: sub-ohm (< 1 ohm, no custom
> +      table allowed) and standard (> 1 ohm, optional custom table).
> +
> +    properties:
> +      reg:
> +        minimum: 2
> +        maximum: 20
> +
> +      adi,sensor-type:
> +        description: Sensor type for copper trace sensors.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        const: 18
> +
> +      adi,rsense-handle:
> +        description: Associated sense resistor sensor.
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      adi,copper-trace-sub-ohm:
> +        description:
> +          Select the sub-ohm (< 1 ohm) copper trace variant. Custom table
> +          and excitation current are not allowed in this mode.
> +        type: boolean
> +
> +      adi,custom-rtd:
> +        description:
> +          Optional resistance-to-temperature table for copper trace sens=
ors
> +          with resistance > 1 ohm. See Page 62 of the datasheet.

I want to look into this property, where is the datasheet?

> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
> +        minItems: 3
> +        maxItems: 64
> +        items:
> +          items:
> +            - description: Resistance point in uOhms.
> +            - description: Temperature point in uK.
> +
> +    required:
> +      - adi,rsense-handle
> +
> +    allOf:
> +      - if:
> +          required:
> +            - adi,copper-trace-sub-ohm
> +        then:
> +          properties:
> +            adi,custom-rtd: false
> +
> +  '^leak-detector@':
> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +    description: |
> +      Leak detector sensor (ADT7604 only). Uses the custom thermistor se=
nsor
> +      type (27). Outputs resistance in ohms and, when a custom table is
> +      provided, a coverage percentage via IIO_TEMP (raw/1024 =3D coverag=
e %).
> +
> +    properties:
> +      reg:
> +        minimum: 2
> +        maximum: 20
> +
> +      adi,sensor-type:
> +        description: Sensor type for leak detector sensors.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        const: 27
> +
> +      adi,rsense-handle:
> +        description: Associated sense resistor sensor.
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +
> +      adi,custom-leak-detector:
> +        description: |
> +          Lookup table mapping resistance to coverage data. Entries must=
 be
> +          in ascending resistance order. The coverage data field encodes=
 the
> +          coverage percentage P as (P + 273.15) expressed in uK, i.e.
> +          (P * 1000000 + 273150000).
> +        $ref: /schemas/types.yaml#/definitions/uint64-matrix
> +        minItems: 3
> +        maxItems: 64
> +        items:
> +          items:
> +            - description: Resistance point in uOhms.
> +            - description: Coverage data point (P + 273150000) in uK.
> +
> +    required:
> +      - adi,rsense-handle
> +
>    '^rsense@':
>      $ref: '#/$defs/sensor-node'
>      unevaluatedProperties: false
> @@ -477,6 +568,22 @@ allOf:
>        patternProperties:
>          '^temp@': false
> =20
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: adi,adt7604
> +    then:
> +      patternProperties:
> +        '^thermocouple@': false
> +        '^diode@': false
> +        '^adc@': false
> +        '^temp@': false
> +    else:
> +      patternProperties:
> +        '^copper-trace@': false
> +        '^leak-detector@': false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/irq.h>
> @@ -556,4 +663,61 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        temperature-sensor@0 {
> +            compatible =3D "adi,adt7604";
> +            reg =3D <0>;
> +            interrupt-parent =3D <&gpio>;
> +            interrupts =3D <25 IRQ_TYPE_EDGE_RISING>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            vdd-supply =3D <&supply>;
> +
> +            trace_rsense: rsense@2 {
> +                reg =3D <2>;
> +                adi,sensor-type =3D <29>;
> +                adi,rsense-val-milli-ohms =3D <100000>; // 100 ohm
> +            };
> +
> +            copper-trace@4 {
> +                reg =3D <4>;
> +                adi,sensor-type =3D <18>;
> +                adi,rsense-handle =3D <&trace_rsense>;

Are these ever linked in a different way?

> +                adi,copper-trace-sub-ohm;
> +            };
> +
> +            r_sense: rsense@12 {
> +                reg =3D <12>;
> +                adi,sensor-type =3D <29>;
> +                adi,rsense-val-milli-ohms =3D <1000000>; // 1 kohm
> +            };
> +
> +            leak-detector@14 {
> +                reg =3D <14>;
> +                adi,sensor-type =3D <27>;
> +                adi,rsense-handle =3D <&r_sense>;

Ditto here and in the rtd node. Are these fixed linkages or actually
dynamic?

Cheers,
Conor.

> +                adi,custom-leak-detector =3D
> +                    /bits/ 64 <          0 373150000>,
> +                    /bits/ 64 <  202020000 372150000>,
> +                    /bits/ 64 < 1000000000 293150000>;
> +            };
> +
> +            rtd@18 {
> +                reg =3D <18>;
> +                adi,sensor-type =3D <12>; // PT100
> +                adi,rsense-handle =3D <&r_sense>;
> +                adi,number-of-wires =3D <2>;
> +                adi,rsense-share;
> +                adi,excitation-current-microamp =3D <500>;
> +                adi,rtd-curve =3D <0>;
> +            };
> +        };
> +    };
>  ...
> --=20
> 2.43.0
>=20

--d/+lsmD5c9DEyzRI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCae+6RQAKCRB4tDGHoIJi
0ondAP4vRb6e14f71gvvDAQMA9KVeFuP3kXYp9XkenaligSBgAD9EYkspMqYqOmc
r9dBi4u4qwOWTIOOpIIILlHSiwzPbgw=
=tSLa
-----END PGP SIGNATURE-----

--d/+lsmD5c9DEyzRI--
