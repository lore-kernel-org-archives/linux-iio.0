Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A122FF65B;
	Tue, 28 Apr 2026 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388311; cv=none; b=fAsmxLJsSuIDmF6JGgd01uhlUTB1lNHwDGKDfLc6iftVDbdpv1gTKx0cdK0VfOImk2r+T+3eRC/hFQx0qgCaqkrUIjM8N68F3ANwd7hRcNci/wsdo2RnI1PVBY4hO4wdwhsMvd+VOVYAevuq4hAnIrj14HL4nbAxKi9jIJZ3TG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388311; c=relaxed/simple;
	bh=mHpXaX+bWyOel7GtRb5Zq4KR/mBR987aQReGiZXleg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQsDjZIwV3vuvGUQWSFteFfFGSHMzwSJqukwrHbXuxN2YHAeUt7O8Kwz0PTcFHM/sPyWbfjI4DR42WSjW9hrKYhsVI9izbIdPQzdDbBcfVAXme920kUNnZHwXsIUpMG2+u6TFiOKc8Yc1hZquEmBf5C29pqozNkH8eoYJBjiJik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZ2f/LTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZ2f/LTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4633AC2BCAF;
	Tue, 28 Apr 2026 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777388310;
	bh=mHpXaX+bWyOel7GtRb5Zq4KR/mBR987aQReGiZXleg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YZ2f/LTvJSR320Jf95EgDq6xYlRSXwCbIKeEcX09c6fA+L76Wk9rEmNrbez3dM7MO
	 3nYXBF3wN5J/Gj/DcmIN+uhTJlhmlKs6MFssRq33mt1GK4JiAz/yvn9Fe+JrCHRCJj
	 ASPmlyzRJP7/B1YtM+gvHT6XjudFbBb4g40HTPpqVgXQb2NTG4ihNAXQhoL1xLb5bC
	 GFLjb9C3GEXZ1pINlSgeJ/cJeg4mESjLveIAMoDlzc20h1Mch97Vm1W3aRzDL0xUAk
	 FpHYfahnflvlrfJeTKmQBTXS6t7o6iAxvzQTWHGC6urye53RO7n2UqBR9QCMNNqRBV
	 LhW90xTeLojvw==
Date: Tue, 28 Apr 2026 15:58:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support
 to adi,ltc2983
Message-ID: <20260428155819.3b56a3fa@jic23-huawei>
In-Reply-To: <20260427132526.272716-2-liviu.stan@analog.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
	<20260427132526.272716-2-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2026 16:25:07 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> The ADT7604 shares the same die as the LTC2984. It repurposes the
> custom RTD sensor type (18) as a copper trace resistance sensor
> and the custom thermistor type (27) as a leak detector, and
> removes thermocouple, diode and direct ADC sensor types.
>=20
> Add adi,adt7604 to the compatible list and introduce two new
> sensor node types specific to this device:
>=20
> - copper-trace@: maps to the custom RTD sensor type (18). Two
>   variants: sub-ohm (< 1 ohm, adi,copper-trace-sub-ohm boolean,
>   no custom table) and standard (> 1 ohm, optional adi,custom-rtd
>   table). Primary output is resistance in mOhm.

I don't know much about these temp sensors, but how is this different
in practice from a 2-wire RTD?  Obviously one is copper and the other
probably much more precise platinum but does that matter to us?

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
I'd go with "LTC2983 and similar" for the title now as it's
to long. Leave the description to list amount more info.

> =20
>  maintainers:
>    - Nuno S=C3=A1 <nuno.sa@analog.com>
> =20
>  description: |
> -  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985 Multi-Sensor Digital
> -  Temperature Measurement Systems
> +  Analog Devices LTC2983, LTC2984, LTC2986, LTM2985, ADT7604 Multi-Sensor
Alphabetical order and it might be worth thinking about switching this
to a bulleted list with one device per line as it'll make adding new ones
neater. (obviously they are already not in numeric order, so fix that too ;)


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

Is the absences of them enough to indicate this mode?  I.e. are there other=
 modes
with no specified excitation mode or custom rtd table?

I'm trying to work out if we can map this to the existing binding for
custom rtd just be adding more constraints + making existing ones more spec=
ific.

I don't mind if we can't and have to add a new child node definition but
I'm not yet sure that's the case.

> +        type: boolean
> +
> +      adi,custom-rtd:
> +        description:
> +          Optional resistance-to-temperature table for copper trace sens=
ors
> +          with resistance > 1 ohm. See Page 62 of the datasheet.
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

This feels more different so I don't so I'm fine with this being a separate=
 thing.

> +    $ref: '#/$defs/sensor-node'
> +    unevaluatedProperties: false
> +    description: |
> +      Leak detector sensor (ADT7604 only). Uses the custom thermistor se=
nsor

I'd avoid describing things as xx only as that tends to become wrong fast!
Better to put that as a conditional only (as you have below)
Maybe here you can say, (some parts only) or something like that.

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

