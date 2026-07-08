Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC437206E;
	Wed,  8 Jul 2026 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783528669; cv=none; b=gx9X68VffF5xhDtajwvO8iYEVwo9+0mm2i1lK09sRhDIL0+D+xiSvAY4d/dCveg6RwCg+lU9hV/mpHFRaxUhOQPBm72Ht7NvOakaMmMLVBJpAs5fpCvXAVVPMWF4uqc5sQ5/WS4+P84Sg/Nrr9895KhaRfFhVazPDByY0IYRFZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783528669; c=relaxed/simple;
	bh=jT/RGHVS4XuaivAkFk4bDPqAS17YAjYUPvxIBFSLVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8J0SqEvyrYE05LFIXzLZDUbAvVTZL1ftExNjC7Jsanb+4XqJ5ZQE8e9AzOoMrpMXmqeHcInUr1sHWjyIk5xda/hw9xsafiQZZ0HKFkjM7HioJfyieqSC8kWf/veSTfOHqKzUsSzp0Ca3hi8lKRCOIhbzrsxWeeZCga9vmXjdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JspVQ6Ai; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JspVQ6Ai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3047F1F000E9;
	Wed,  8 Jul 2026 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783528668;
	bh=bwtS7EXkluOQeV5+ebdh9Zvf9kVf5d87rQfU1fZ5kEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JspVQ6Ai/NiBPy/puA4qT3mxV2xkinmlH80PAFGAxp47J7pF88YFPgpEFwRHulX+H
	 bzRMkGr2O48oYHNFXaG91vittroDVQCi1Se3k1AzyJk0C4KUReBijuSP2zMctqHFlt
	 suDMRvEGRIVrhHC7T00aXdNbZ4Iu+ylgy7lpHvB6MFkCc5JwEleX9QvzdBku1ipEUL
	 PsD66fj1YQHN592xyE8fDuT7YpHO0j9c4MElJEu1EmQ9U7x6Is1S3QVbPnDDcHqTaa
	 Z3QN02itZ5Hva5K/xFm+CBh8l4+SUGBz2HkiGO5eHntllIvcjHZ0acNn2j6h/3LH6B
	 bxznhA/oVBGhA==
Date: Wed, 8 Jul 2026 17:37:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Lukas Metz <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: dac: Add DAC8163
Message-ID: <20260708-spotty-spectacle-f270b4c66d18@spud>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-1-3acd1bf20182@gmx.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+98e8U4nx9qKZJ9Z"
Content-Disposition: inline
In-Reply-To: <20260708-dac8163-work-v2-1-3acd1bf20182@gmx.net>

--+98e8U4nx9qKZJ9Z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2026 at 11:52:43AM +0200, Lukas Metz wrote:
> Add device tree binding for the Texas Instruments DAC8163 family
> including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.
>=20
> Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> ---
>  .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 85 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 91 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/=
Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> new file mode 100644
> index 000000000000..533cc7327c2b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/ti,dac8163.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DAC8163 family of DACs
> +
> +description:
> +  The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-outpu=
t,
> +  dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> +  respectively. These devices include a 2.5-V, 4-ppm/=B0C internal
> +  reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> +  The sync pin on the device acts as chip-select pin.
> +
> +maintainers:
> +  - Lukas Metz <lukas.metz@gmx.net>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,dac7562
> +      - ti,dac7563
> +      - ti,dac8162
> +      - ti,dac8163
> +      - ti,dac8562
> +      - ti,dac8563

Please provide an explanation as to why none of these can use fallback
compatibles, or alternatively, use fallback compatibles.
pw-bot: changes-requested

> +
> +  spi-rx-bus-width:
> +    items:
> +      - const: 0
> +
> +  spi-max-frequency:
> +    maximum: 50000000
> +
> +  spi-cpha: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true
> +
> +  clr-gpios:

Sounds like this should be reset-gpios?

Cheers,
Conor.

> +    description:
> +      The device registers are reset when this pin is asserted. The outp=
ut is
> +      set to zero (xxx2 devices) or mid-scale (xxx3 devices).
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description:
> +      Pin needs to be asserted permanently when updating the DAC synchro=
nously.
> +    maxItems: 1
> +
> +  vrefin-supply:
> +    description:
> +      External reference voltage supply for scaling. When no vrefin-supp=
ly
> +      is present the internal voltage reference is used.
> +
> +required:
> +  - compatible
> +  - reg
> +  - spi-cpha
> +  - avdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        dac@1 {
> +            compatible =3D "ti,dac8163";
> +            reg =3D <0x1>; /* CS1 */
> +            spi-cpha;
> +            ldac-gpios =3D <&gpiog 8 GPIO_ACTIVE_LOW>;
> +            avdd-supply =3D <&avdd_3v3>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d238590a31f2..314f235332f5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26394,6 +26394,12 @@ S:	Odd Fixes
>  F:	drivers/clk/ti/
>  F:	include/linux/clk/ti.h
> =20
> +TI DAC8163 DAC DRIVER
> +M:	Lukas Metz <lukas.metz@gmx.net>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> +
>  TI DATA TRANSFORM AND HASHING ENGINE (DTHE) V2 CRYPTO DRIVER
>  M:	T Pratham <t-pratham@ti.com>
>  L:	linux-crypto@vger.kernel.org
>=20
> --=20
> 2.43.0
>=20

--+98e8U4nx9qKZJ9Z
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak582AAKCRB4tDGHoIJi
0k4qAQDkUqGYnn5fOly57EMfn8ZIi20wFKaJ1s04h6XswSvsZgD+MYAGMo0JsQhH
YqeDPmJ9sJutkr6BMIqSqgqL/Qgpmgs=
=nj+Y
-----END PGP SIGNATURE-----

--+98e8U4nx9qKZJ9Z--
