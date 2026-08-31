Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B293955C3;
	Mon, 31 Aug 2026 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788195849; cv=none; b=EVpd4psKEJaF8KabqlgImKB4WRtkLRv/do+A28dUWtZAwIm11xj++CHXPRfxEVaO314Zh0ymykW9ks/WSv7jkm8WS3ke8jB/qhS7KdG9vIsnV7n3Qu/C1G6Fuj+rSNWa5ZZVjUf2YA3bQnOlMuxQyAxHNaqUvLJ8WNJ4uM8RKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788195849; c=relaxed/simple;
	bh=/OaGt3Qay5RfFCBQPbWoxk7FpWTTf0owlGsjEizOONE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMx6laruiGtBX2wtSatbZ0BTt+J4UV9CzZQJe8qClwLeVuf6PKvV3pLm10LNbaRVeXUkDsoR+GkE94kIIJ3Fenf63Him9uB3gAf+GJBU0UuqOvYoIg89OUxJu7dEsTeVhdLgi/Ph9MyKO5VB6AvZ2dWj615NERp/37/LS0Jrkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muxBm/LZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muxBm/LZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DBB1F00A3D;
	Mon, 31 Aug 2026 17:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788195847;
	bh=dsR6Jx8PTvg1ZUXWSP5F8HFPrWko+mwbB0W9cXhzzPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=muxBm/LZtlxYGCWxJB6JwR5xqDAHLRmUJ3dwyD+gkmv53xKZm45tfhq1lJUBrdUrM
	 OtOX7Favbm9a7PqpG4RL43t5a2L3f9fcCkC2pkp871k9qT1Atxo4CgjTaaz95vW0uW
	 3gH3FmMId7c60A+7X/nESLgAGa+lxrPA4XH9m0eHyjt+iEUMJ6tqhL0eY5D6/lOxwF
	 doKwSPDNJRhEYVJcebYyHyA/YkAyKH2y39CLhAdDxiLbLrzHcoHDXij8cZbOwwe+Eu
	 2cMJtTv+Lobl62dmuUdCC3TsuILjmZCFh9sm5NvVs3qqr4r/t6wcOBxdGP3fHEFuQN
	 gjZ6hu8BnMfog==
Date: Mon, 31 Aug 2026 18:04:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260831-singer-reimburse-defba31848bc@spud>
References: <20260829-iio-ad5710r-upstream-v4-0-8af3121c7d21@analog.com>
 <20260829-iio-ad5710r-upstream-v4-2-8af3121c7d21@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b6/AnpX2Ldcjh/ZL"
Content-Disposition: inline
In-Reply-To: <20260829-iio-ad5710r-upstream-v4-2-8af3121c7d21@analog.com>

--b6/AnpX2Ldcjh/ZL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 01:59:21PM +0800, Kim Seer Paller wrote:
> Add device tree bindings for the Analog Devices AD5710R/AD5711R
> 8-channel 12-/16-bit Configurable IDAC/VDAC.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 144 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
> new file mode 100644
> index 000000000000..259866ca87cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5710r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5710R/AD5711R 8-channel 12-/16-bit Configurable =
IDAC/VDAC
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> +  configurable current/voltage output digital-to-analog converters (DACs=
) with
> +  an on-chip 2.5V, 3ppm/=B0C reference. Each channel can be independently
> +  configured as a voltage output (0V to VREF or 0V to 2 x VREF) or a cur=
rent
> +  output (0mA to 50mA). These devices operate from a single 2.7V to 5.5V
> +  supply and are guaranteed monotonic by design.
> +
> +  Datasheet can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
5711r-ad5710r.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5710r
> +      - adi,ad5711r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  vdd-supply:
> +    description: Power Supply Input.
> +
> +  iovdd-supply:
> +    description: Digital Power Supply Input.
> +
> +  io-channels:
> +    description:
> +      ADC channel used to monitor internal die temperature, output volta=
ges, and
> +      current of a selected channel via the MUXOUT pin.
> +    maxItems: 1
> +
> +  ref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-s=
cale
> +      range of all channels. If not provided the internal reference is u=
sed and
> +      also provided on the VREF pin.
> +
> +  reset-gpios:
> +    description:
> +      Active low signal that is falling edge sensitive. When it is deass=
erted,
> +      the digital core initialization is performed and all DAC registers=
 except
> +      the Interface Configuration A register are reset to their default =
values.
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description:
> +      LDAC pin to be used as a hardware trigger to update the DAC channe=
ls. If
> +      not present, the DAC channels are updated by Software LDAC.
> +    maxItems: 1
> +
> +  adi,range-double:
> +    description:
> +      Configure the output range for all channels. If the property is pr=
esent,
> +      the output will range from 0V to 2 x Vref. If the property is not =
present,
> +      the output will range from 0V to Vref.

What was the rationale provided for this not being a userspace control?

> +    type: boolean
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: /schemas/iio/dac/dac.yaml#
> +    type: object
> +    description:
> +      Represents the external channels which are connected to the DAC.
> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        minimum: 0
> +        maximum: 7
> +
> +      adi,ch-func:
> +        description:
> +          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
> +          output or CH_FUNC_CURRENT_OUTPUT for current output.
> +        $ref: /schemas/types.yaml#/definitions/uint32

Valid point from sashiko here that you never cover which is which (or
cite the header where the defines come from).
pw-bot: changes-requested

Cheers,
Conor.

> +        enum: [1, 2]
> +
> +    required:
> +      - reg
> +      - adi,ch-func
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - iovdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/iio/addac/adi,ad74413r.h>
> +
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        dac@0 {
> +            compatible =3D "adi,ad5710r";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            vdd-supply =3D <&vdd>;
> +            iovdd-supply =3D <&iovdd>;
> +            #address-cells =3D <1>;
> +            #size-cells =3D <0>;
> +
> +            channel@0 {
> +                reg =3D <0>;
> +                adi,ch-func =3D <CH_FUNC_VOLTAGE_OUTPUT>;
> +            };
> +
> +            channel@1 {
> +                reg =3D <1>;
> +                adi,ch-func =3D <CH_FUNC_CURRENT_OUTPUT>;
> +            };
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f5e7b2f524d..ec0f3812199c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1468,6 +1468,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad3530r.yaml
> +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
>  F:	drivers/iio/dac/ad3530r.c
> =20
>  ANALOG DEVICES INC AD3552R DRIVER
>=20
> --=20
> 2.34.1
>=20

--b6/AnpX2Ldcjh/ZL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapW0AgAKCRB4tDGHoIJi
0vBvAP9qaWx/fKGkwEgyeNToTO/hw7rc5ynUTDedUA93HDuyzAD/bNOl9x8ORACx
I+5ffm8PeETXks7XaHVbVx7ELVkxjQ4=
=by4N
-----END PGP SIGNATURE-----

--b6/AnpX2Ldcjh/ZL--
