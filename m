Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DF47FAF5;
	Thu, 10 Sep 2026 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041346; cv=none; b=YrtxF3JfYAu3RGDCjttzLU3fYIONsbBCWgI+sGf6EwsPXB3GAX1JlElFK3qbztiosejs0KEgWheUeO7NyeUSn5fvUZio9fHianig9jI5BCvUuPuddfxpggNXJRf7F/budQcay7prnH/U9ka1xmLo+nLzugyPVADooziKWXYzyDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041346; c=relaxed/simple;
	bh=UUaEgNeNMccJLAoF7pwC14reszTjJaGKomlQDaMeR5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWDyQJYi7yquKUCmIAuIc7GNl/9gYJL9Jty0k5gzN6H3JbNCRHn/9uxdeLUbu4O4XoQGsV7isSRZa+Oc++mmvQZivpidRj8dLKlEzYJ8Z55ZKm4otYvo0jY309KMLiVpV5tL6SbqK+jWeg+WzPG80wyWGgvM1yYWVxqFTtpoiSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPO74S6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPO74S6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F0F1F000FF;
	Thu, 10 Sep 2026 11:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789041344;
	bh=q/ZoUG1g58Wphg9XuXpQn8gD79V0mdJu+nv6/V83IPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MPO74S6Dz7p7zDx3yU8cMO9igOOmAIxnG+mUzY3DzcSMwIe+y191wdNNZwbsztuk2
	 ZCr2lADtMUyAgT3aLB7/cF7hxM/iJOYFN5DWua7shyovAs31hOeIKbFhUh8aTz+75i
	 YyxFcA65hIcgsecJq5nzJkglnZC3QiZOTfJUO3q8u2aAc3PIbd4Ig0XJ7N171gN5rQ
	 SkwXhOdXCRQOfElljk2Yd7MdRQkzg0wpCgcyVulbI6vJ/4ey0SPZwvtgnJp9etqM7h
	 Y2s9iNP9YJ2yeYyrHTyMsUL0HiRZLyd0xc9prjoFVZ4b7H8LjLwB9xAoH+Y6u0UK3R
	 k92KDuCObKyfg==
Date: Thu, 10 Sep 2026 12:55:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add support for PAC1711
Message-ID: <aqKauqCxYwo8_nxM@squawk>
References: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
 <20260909-pac1711-v3-1-dff81003b82f@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/MoetIXoV046mHB9"
Content-Disposition: inline
In-Reply-To: <20260909-pac1711-v3-1-dff81003b82f@microchip.com>

--/MoetIXoV046mHB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2026 at 03:23:34PM +0300, Ariana Lazar wrote:
> This is the device tree schema for Microchip PAC1711, PAC1721, PAC1811 and
> PAC1821 single-channel power monitor with accumulator. The PAC1711 and
> PAC1721 devices use 12-bit resolution for voltage and current measurements
> and 24 bits for power calculations, while PAC1811 and PAC1821 have 16-bit
> resolution and use 32 bits for power calculations. The 56-bit accumulator
> register accumulates power (energy) or current (Coulomb counter).
>=20
> PAC1711 and PAC1811 measure up to 42V Full-Scale Range, respectively 9V f=
or
> PAC1721 and PAC1821.
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/adc/microchip,pac1711.yaml        | 183 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   6 +
>  2 files changed, 189 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.=
yaml b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..c10b4b83a08d690b8045a3f42=
d4e43d17a8058d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> @@ -0,0 +1,183 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/microchip,pac1711.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip PAC1711 Power Monitors with Accumulator
> +
> +maintainers:
> +  - Ariana Lazar <ariana.lazar@microchip.com>
> +
> +description: |
> +  This device is part of the Microchip family of Power Monitors with Acc=
umulator.
> +  Datasheet links:
> +  [PAC1711]: https://ww1.microchip.com/downloads/aemDocuments/documents/=
MSLD/ProductDocuments/PAC1711-Data-Sheet-DS20007058.pdf
> +  [PAC1721]: https://ww1.microchip.com/downloads/aemDocuments/documents/=
MSLD/ProductDocuments/PAC1721-Single-Channel-Power-Monitor-with-Accumulator=
-DS20007088.pdf
> +  [PAC1811]: https://ww1.microchip.com/downloads/aemDocuments/documents/=
MSLD/ProductDocuments/DataSheets/PAC1811-Data-Sheet-DS20007066.pdf
> +  [PAC1821]: https://ww1.microchip.com/downloads/aemDocuments/documents/=
MSLD/ProductDocuments/DataSheets/PAC1821-Data-Sheet-DS20007097.pdf
> +
> +  PAC1711, PAC1721, PAC1811 and PAC1821 are Single Channel Power Monitors
> +  with Accumulator, having 12-bit or 16-bit resolution. The devices PAC1=
711
> +  and PAC1811 can measure up to 42V Full-Scale Range, respectively 9V
> +  Full-Scale Range for PAC1721 and PAC1821.
> +

> +  The accumulation-source property aims to specify what kind of hardware=
 is
> +  intended to be used/available for the user. There are two main cases h=
ere:
> +    - the user wants to measure also the current/power consumed before t=
he
> +      driver insertion (e.g. from the boot to user control) and if this =
is a
> +      runtime setting, the hardware accumulator will be reset by the def=
ault
> +      configuration the driver starts with.
> +    - the driver does not know what type of hardware it's dealing with. =
In
> +      case the part is monitoring the charge/discharge current it does n=
ot
> +      make sense in user-space to change the accumulator to calculate en=
ergy.
> +      Same if the hardware is intended to calculate energy it does not m=
ake
> +      sense in user-space to change to Coulomb counter. Changing the set=
ting
> +      from one mode to another will reset the hardware accumulator insid=
e the
> +      chip.

Why is this here, rather than with the property in question or the
commit message? Anything justifying the property should just be in the
commit message, this doc is user facing and just should explain when and
why to use it.

Otherwise, this is fine.
pw-bot: changes-requested

Thanks,
Conor.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - microchip,pac1711
> +      - microchip,pac1721
> +      - microchip,pac1811
> +      - microchip,pac1821
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value in micro Ohms of the shunt resistor connected between the VS=
ENSE+
> +      and VSENSE- inputs, across which the current is measured. This val=
ue is
> +      needed to compute the scaling of the measured current.
> +
> +  label:
> +    description: Unique name to identify which device this is.
> +
> +  microchip,vbus-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the voltage f=
ull
> +      scale range (FSR). The range should be set as <minimum, maximum> by
> +      hardware design and should not be changed during runtime.
> +
> +      The VBUS could be configured into the following full scale range:
> +        - for PAC1711 or PAC1811:
> +            - VBUS has unipolar 0V to 42V FSR (default)
> +            - VBUS has bipolar -42V to 42V FSR
> +            - VBUS has bipolar -21V to 21V FSR
> +        - for PAC1721 or PAC1821:
> +            - VBUS has unipolar 0V to 9V FSR (default)
> +            - VBUS has bipolar -9V to 9V FSR
> +            - VBUS has bipolar -4.5V to 4.5V FSR
> +
> +  microchip,vsense-input-range-microvolt:
> +    description: |
> +      Specifies the voltage range in microvolts chosen for the current f=
ull
> +      scale range (FSR). The current is calculated by dividing the vsense
> +      voltage by the value of the shunt resistor. The range should be se=
t as
> +      <minimum, maximum> by hardware design and it should not be changed
> +      during runtime.
> +
> +      The VSENSE could be configured into the following full scale range:
> +        - VSENSE has unipolar 0 mV to 100 mV FSR (default)
> +        - VSENSE has bipolar -100 mV to 100 mV FSR
> +        - VSENSE has bipolar -50 mV to 50 mV FSR
> +    oneOf:
> +      - items:
> +          - const: 0
> +          - const: 100000
> +      - items:
> +          - const: -100000
> +          - const: 100000
> +      - items:
> +          - const: -50000
> +          - const: 50000
> +
> +  microchip,accumulation-source:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      The Hardware Accumulator may be used to accumulate VPOWER or VSENS=
E values
> +      for any channel. By setting the accumulator for a channel to accum=
ulate
> +      the VPOWER values gives a measure of accumulated power over a time=
 period,
> +      which is equivalent to energy. Setting the accumulator for a chann=
el to
> +      accumulate VSENSE values gives a measure of accumulated current, w=
hich is
> +      equivalent to charge.
> +
> +      The Hardware Accumulator could be configured as:
> +       "energy" - Accumulator accumulates VPOWER (energy)
> +       "charge" - Accumulator accumulates VSENSE (Coulomb Counter)
> +    enum: [energy, charge]
> +    default: energy
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - shunt-resistor-micro-ohms
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          pattern: "^microchip,pac1[78]11$"
> +    then:
> +      properties:
> +        microchip,vbus-input-range-microvolt:
> +          oneOf:
> +            - items:
> +                - const: 0
> +                - const: 42000000
> +            - items:
> +                - const: -42000000
> +                - const: 42000000
> +            - items:
> +                - const: -21000000
> +                - const: 21000000
> +          default: [0, 42000000]
> +  - if:
> +      properties:
> +        compatible:
> +          pattern: "^microchip,pac1[78]21$"
> +    then:
> +      properties:
> +        microchip,vbus-input-range-microvolt:
> +          oneOf:
> +            - items:
> +                - const: 0
> +                - const: 9000000
> +            - items:
> +                - const: -9000000
> +                - const: 9000000
> +            - items:
> +                - const: -4500000
> +                - const: 4500000
> +          default: [0, 9000000]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        power-monitor@40 {
> +            compatible =3D "microchip,pac1711";
> +            reg =3D <0x40>;
> +
> +            shunt-resistor-micro-ohms =3D <11000000>;
> +            label =3D "VDD3V3";
> +            vdd-supply =3D <&vdd>;
> +            microchip,vbus-input-range-microvolt =3D <(-21000000) 210000=
00>;
> +            microchip,vsense-input-range-microvolt =3D <(-50000) 50000>;
> +            microchip,accumulation-source =3D "energy";
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a92290fffa163f9fe8fe3f04bf66426f9a894409..399da37f79fd9768f29cc60aa=
5384a1ba9fe8afc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16337,6 +16337,12 @@ F:	Documentation/devicetree/bindings/nvmem/micro=
chip,sama7g5-otpc.yaml
>  F:	drivers/nvmem/microchip-otpc.c
>  F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
> =20
> +MICROCHIP PAC1711 POWER/CURRENT MONITOR DRIVER
> +M:	Ariana Lazar <ariana.lazar@microchip.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/iio/adc/microchip,pac1711.yaml
> +
>  MICROCHIP PAC1921 POWER/CURRENT MONITOR DRIVER
>  M:	Matteo Martelli <matteomartelli3@gmail.com>
>  L:	linux-iio@vger.kernel.org
>=20
> --=20
> 2.43.0
>=20

--/MoetIXoV046mHB9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqKaugAKCRB4tDGHoIJi
0mKLAQCO6l7oFprAmTtRLSq7BTowVq1KW1lXvMqP6oceQvVaDgEA+1uiOqPdeMOU
aXNe8IFM7R4t7jhRF3+1K9fEYtB5Uws=
=Pd+M
-----END PGP SIGNATURE-----

--/MoetIXoV046mHB9--
