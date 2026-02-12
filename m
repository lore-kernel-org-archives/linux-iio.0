Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D2F9C0;
	Thu, 12 Feb 2026 18:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770919211; cv=none; b=JYlCRSUYDmOers0VQUk2kYBSvJ5hSEjdiZeqLXE+PkvzMd51Bgp0wDaBaGFAg+DH29mTGInR1nGVfnq06pX+3QGwDEEnXe1qZzsXy+5Ivkr3QgFKjFkL2d00F89LtNqrR4t2e59GZmg4vofwR+22I4Zvp+lWYrnPjvnv+jdohB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770919211; c=relaxed/simple;
	bh=s7u9AhIOESjrkM2qI9JtGUX7DXLML7Dnl6WGHKtGoxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efTAvdVoxGz7tMqIxaUu1znRPWfjjrFIyJ+Z114zP7Cn+vui5HSJ3el3/jUEw/ja3+gN2n0AjV0upVUB7BkWiBZu5MTS2Hy31D/bdTBbvnrRMTDEo62B+Oz7haS4QyErYkoi+AB/lDZAR6xz1BuSsy5f3D4ic6ogwknzq44HqHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2XF/Peg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2XF/Peg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AA8C4CEF7;
	Thu, 12 Feb 2026 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770919211;
	bh=s7u9AhIOESjrkM2qI9JtGUX7DXLML7Dnl6WGHKtGoxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2XF/PegghZiKrnVM/PAl+sux97OeRxQZCMcXgXMc+NvBR2yA6H7hBTYBVU1MCvuc
	 GiBPSXFLLHS+vPMupnnor4cdaJcDVkWaZGrb6F2X6u+ZxuTvXNUrLFpmoRJsnNtxVR
	 CaELOmBMndPPcuaczeC87NZPhvJ7uTQKPlIw5Hsd/mjxKGPUZ3cPIodL35xJ+VQF7u
	 GAvobIt3+wih4inebfwkH5OwK/+N0na8lxwNhAh+WWFPv61OY3a/8bfbdEjSTM7fA/
	 lUtREvh6s6Xi1vgWEi4OpX8JGbk1ejHBOdLdfZpfD1BbJFEweSPJ3u/9lnm3gXTyVi
	 BCvBZ3Cdkdf8A==
Date: Thu, 12 Feb 2026 18:00:06 +0000
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02
Message-ID: <20260212-germless-favoring-c27ab4c53128@spud>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
 <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I9nsXitjwyJV+GTG"
Content-Disposition: inline
In-Reply-To: <20260212-mcp48feb02-v1-1-ce5843db65db@microchip.com>


--I9nsXitjwyJV+GTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 12, 2026 at 02:48:34PM +0200, Ariana Lazar wrote:
> This is the device tree schema for iio driver for Microchip
> MCP48FxBy1/2/4/8 series of buffered voltage output Digital-to-Analog
> Converters with nonvolatile or volatile memory and an SPI Interface.
>=20
> The families support up to 8 output channels.
>=20
> The devices can be 8-bit, 10-bit and 12-bit.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>

Other than the interface, what's actually different between this and the
47? Could they share the same binding?

Cheers,
Conor.

> ---
>  .../bindings/iio/dac/microchip,mcp48feb02.yaml     | 299 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 305 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb=
02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.ya=
ml
> new file mode 100644
> index 0000000000000000000000000000000000000000..78c6bd641c6e37321e4fc056d=
b83eb4277f429b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.yaml
> @@ -0,0 +1,299 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/microchip,mcp48feb02.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip MCP48F(E/V)B(0/1/2)(1/2/4/8) DAC with SPI Interface Fam=
ilies
> +
> +maintainers:
> +  - Ariana Lazar <ariana.lazar@microchip.com>
> +
> +description: |
> +  Datasheet for MCP48FEB01, MCP48FEB02, MCP48FEB11, MCP48FEB12, MCP48FEB=
21,
> +  MCP48FEB22 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Produ=
ctDocuments/DataSheets/20005429B.pdf
> +  Datasheet for MCP48FVB01, MCP48FVB02, MCP48FVB11, MCP48FVB12, MCP48FVB=
21,
> +  MCP48FVB22 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/Produ=
ctDocuments/DataSheets/20005466A.pdf
> +  Datasheet for MCP48FEB04, MCP48FEB14, MCP48FEB24, MCP48FEB08, MCP48FEB=
18,
> +  MCP48FEB28, MCP48FVB04, MCP48FVB14, MCP48FVB24, MCP48FVB08, MCP48FVB18,
> +  MCP48FVB28 can be found here:
> +    https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/Prod=
uctDocuments/DataSheets/MCP48FXBX4-8-Family-Data-Sheet-DS20006362A.pdf
> +
> +  +------------+--------------+-------------+-------------+------------+
> +  | Device     |  Resolution  |   Channels  | Vref number | Memory     |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP48FEB01 |              |      1      |      1      |   EEPROM   |
> +  | MCP48FEB02 |     8-bit    |      2      |      1      |   EEPROM   |
> +  | MCP48FEB04 |              |      4      |      2      |   EEPROM   |
> +  | MCP48FEB08 |              |      8      |      2      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP48FEB11 |              |      1      |      1      |   EEPROM   |
> +  | MCP48FEB12 |    10-bit    |      2      |      1      |   EEPROM   |
> +  | MCP48FEB14 |              |      4      |      2      |   EEPROM   |
> +  | MCP48FEB18 |              |      8      |      2      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP48FEB21 |              |      1      |      1      |   EEPROM   |
> +  | MCP48FEB22 |    12-bit    |      2      |      1      |   EEPROM   |
> +  | MCP48FEB24 |              |      4      |      2      |   EEPROM   |
> +  | MCP48FEB28 |              |      8      |      2      |   EEPROM   |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP48FVB01 |              |      1      |      1      |   RAM      |
> +  | MCP48FVB02 |     8-bit    |      2      |      1      |   RAM      |
> +  | MCP48FVB04 |              |      4      |      2      |   RAM      |
> +  | MCP48FVB08 |              |      8      |      2      |   RAM      |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP48FVB11 |              |      1      |      1      |   RAM      |
> +  | MCP48FVB12 |    10-bit    |      2      |      1      |   RAM      |
> +  | MCP48FVB14 |              |      4      |      2      |   RAM      |
> +  | MCP48FVB18 |              |      8      |      2      |   RAM      |
> +  |------------|--------------|-------------|-------------|------------|
> +  | MCP48FVB21 |              |      1      |      1      |   RAM      |
> +  | MCP48FVB22 |    12-bit    |      2      |      1      |   RAM      |
> +  | MCP48FVB24 |              |      4      |      2      |   RAM      |
> +  | MCP48FVB28 |              |      8      |      2      |   RAM      |
> +  +------------+--------------+-------------+-------------+------------+
> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,mcp48feb01
> +      - microchip,mcp48feb02
> +      - microchip,mcp48feb04
> +      - microchip,mcp48feb08
> +      - microchip,mcp48feb11
> +      - microchip,mcp48feb12
> +      - microchip,mcp48feb14
> +      - microchip,mcp48feb18
> +      - microchip,mcp48feb21
> +      - microchip,mcp48feb22
> +      - microchip,mcp48feb24
> +      - microchip,mcp48feb28
> +      - microchip,mcp48fvb01
> +      - microchip,mcp48fvb02
> +      - microchip,mcp48fvb04
> +      - microchip,mcp48fvb08
> +      - microchip,mcp48fvb11
> +      - microchip,mcp48fvb12
> +      - microchip,mcp48fvb14
> +      - microchip,mcp48fvb18
> +      - microchip,mcp48fvb21
> +      - microchip,mcp48fvb22
> +      - microchip,mcp48fvb24
> +      - microchip,mcp48fvb28
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  vdd-supply:
> +    description:
> +      Provides power to the chip and it could be used as reference volta=
ge. The
> +      voltage is used to calculate scale. For parts without EEPROM at po=
werup
> +      this will be the selected as voltage reference.
> +
> +  vref-supply:
> +    description: |
> +      Vref pin (it could be found as Vref0 into the datasheet) may be us=
ed as a
> +      voltage reference when this supply is specified. The internal refe=
rence
> +      will be taken into account for voltage reference besides VDD if th=
is supply
> +      does not exist.
> +
> +      This supply will be voltage reference for the following outputs:
> +        - for single-channel device: Vout0;
> +        - for dual-channel device: Vout0, Vout1;
> +        - for quad-channel device: Vout0, Vout2;
> +        - for octal-channel device: Vout0, Vout2, Vout4, Vout6;
> +
> +  vref1-supply:
> +    description: |
> +      Vref1 pin may be used as a voltage reference when this supply is s=
pecified.
> +      The internal reference will be taken into account for voltage refe=
rence
> +      beside VDD if this supply does not exist.
> +
> +      This supply will be voltage reference for the following outputs:
> +        - for quad-channel device: Vout1, Vout3;
> +        - for octal-channel device: Vout1, Vout3, Vout5, Vout7;
> +
> +  lat-gpios:
> +    description:
> +      LAT pin to be used as a hardware trigger to synchronously update t=
he DAC
> +      channels. The pin is active Low. It could be also found as LAT0 in
> +      datasheet.
> +    maxItems: 1
> +
> +  lat1-gpios:
> +    description:
> +      LAT1 pin to be used as a hardware trigger to synchronously update =
the odd
> +      DAC channels on devices with 4 and 8 channels. The pin is active L=
ow.
> +    maxItems: 1
> +
> +  microchip,vref-buffered:
> +    type: boolean
> +    description:
> +      Enable buffering of the external Vref/Vref0 pin in cases where the
> +      external reference voltage does not have sufficient current capabi=
lity in
> +      order not to drop its voltage when connected to the internal resis=
tor
> +      ladder circuit.
> +
> +  microchip,vref1-buffered:
> +    type: boolean
> +    description:
> +      Enable buffering of the external Vref1 pin in cases where the exte=
rnal
> +      reference voltage does not have sufficient current capability in o=
rder not
> +      to drop its voltage when connected to the internal resistor ladder
> +      circuit.
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: dac.yaml
> +    type: object
> +    description: Voltage output channel.
> +
> +    properties:
> +      reg:
> +        description: The channel number.
> +        maxItems: 1
> +
> +      label:
> +        description: Unique name to identify which channel this is.
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp48feb01
> +              - microchip,mcp48feb11
> +              - microchip,mcp48feb21
> +              - microchip,mcp48fvb01
> +              - microchip,mcp48fvb11
> +              - microchip,mcp48fvb21
> +    then:
> +      properties:
> +        lat1-gpios: false
> +        vref1-supply: false
> +        microchip,vref1-buffered: false
> +        channel@0:
> +          properties:
> +            reg:
> +              const: 0
> +      patternProperties:
> +        "^channel@[1-7]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp48feb02
> +              - microchip,mcp48feb12
> +              - microchip,mcp48feb22
> +              - microchip,mcp48fvb02
> +              - microchip,mcp48fvb12
> +              - microchip,mcp48fvb22
> +    then:
> +      properties:
> +        lat1-gpios: false
> +        vref1-supply: false
> +        microchip,vref1-buffered: false
> +      patternProperties:
> +        "^channel@[0-1]$":
> +          properties:
> +            reg:
> +              enum: [0, 1]
> +        "^channel@[2-7]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp48fvb04
> +              - microchip,mcp48fvb14
> +              - microchip,mcp48fvb24
> +              - microchip,mcp48feb04
> +              - microchip,mcp48feb14
> +              - microchip,mcp48feb24
> +    then:
> +      patternProperties:
> +        "^channel@[0-3]$":
> +          properties:
> +            reg:
> +              enum: [0, 1, 2, 3]
> +        "^channel@[4-7]$": false
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - microchip,mcp48fvb08
> +              - microchip,mcp48fvb18
> +              - microchip,mcp48fvb28
> +              - microchip,mcp48feb08
> +              - microchip,mcp48feb18
> +              - microchip,mcp48feb28
> +    then:
> +      patternProperties:
> +        "^channel@[0-7]$":
> +          properties:
> +            reg:
> +              enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +  - if:
> +      not:
> +        required:
> +          - vref-supply
> +    then:
> +      properties:
> +        microchip,vref-buffered: false
> +  - if:
> +      not:
> +        required:
> +          - vref1-supply
> +    then:
> +      properties:
> +        microchip,vref1-buffered: false
> +
> +additionalProperties: false
> +
> +examples:
> +    - |
> +      spi {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          dac@0 {
> +            compatible =3D "microchip,mcp48feb08";
> +            reg =3D <0>;
> +            vdd-supply =3D <&vdac_vdd>;
> +            vref-supply =3D <&vref_reg>;
> +
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +            channel@0 {
> +              reg =3D <0>;
> +              label =3D "Adjustable_voltage_ch0";
> +            };
> +
> +            channel@1 {
> +              reg =3D <0x1>;
> +              label =3D "Adjustable_voltage_ch1";
> +            };
> +          };
> +      };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa163f9fe8fe3f04bf66426f9a894409..ed24fd2758ad0103dbc5191d0=
ec180f8ee5e8298 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14945,6 +14945,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp4821.yaml
>  F:	drivers/iio/dac/mcp4821.c
> =20
> +MCP48FEB02 MICROCHIP DAC DRIVER
> +M:	Ariana Lazar <ariana.lazar@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp48feb02.yaml
> +
>  MCR20A IEEE-802.15.4 RADIO DRIVER
>  M:	Stefan Schmidt <stefan@datenfreihafen.org>
>  L:	linux-wpan@vger.kernel.org
>=20
> --=20
> 2.43.0
>=20

--I9nsXitjwyJV+GTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaY4VJgAKCRB4tDGHoIJi
0rRMAQCZMRY1FOe7uj/I87LSS6RiM09yoIPgyd7uubtLjkNuIwEAkY7f7UFoWire
MZ3Urm+Lbx5CrQdXwl6ntN34O9PWBgw=
=kkFn
-----END PGP SIGNATURE-----

--I9nsXitjwyJV+GTG--
