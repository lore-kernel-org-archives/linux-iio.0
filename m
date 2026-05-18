Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E85E384258;
	Mon, 18 May 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123981; cv=none; b=XrACpnf/VnfkdkiNRkAPBydF2pZWjBraoN8qV6qN++PxHZVb/NaVR4FzjeaNsBIOSsg10V2NEhnLt8+FlDsK+Hxim49ADRxG9ltdIV8LBbJVmhfNwfNQg7H0PHdrHW/e+tfPsr3WDEcy9kMMblMK55Y5FLBMnFoLfja/ZLnnNSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123981; c=relaxed/simple;
	bh=glz5ydJG24D+wH38fMIDd0BE5BMa9GicHuYKAMFAfj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUMkAkZnjUHfmNlNVnyoYUGQcoHQGuH5ke458K3V3+eN6pN4pyWsfNrH68ChPgteeFwuJcj87Lu5fr5iUOQmdAfdy9fkX+qKnFS34cSIQ4lSCg+kkZ8OumeJkX8dCqO4JrYMPUvAZQFzT0MroNtWJEai87w0pdyng/CoLYu6ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZFh/LDl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZFh/LDl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A623C2BCC9;
	Mon, 18 May 2026 17:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779123981;
	bh=glz5ydJG24D+wH38fMIDd0BE5BMa9GicHuYKAMFAfj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QZFh/LDlxsMwtzj45gdBgd0viCfVrvtQqMvX2lAJRDhCCrwz4Kv8bcP5ODrR0JtPX
	 L0KS7ztAU0dj6FFuTBX5+8keLMwixh7GNwHPcABVcTm9Bel1tVbv5ecvjUwLpneLbq
	 fXc1XCNjLqCI9S00XKvrMlX1YFvyNQroyGMn7LadD05E/pkkdSV07P6KwxoYbaKIIy
	 mkrmSQuhRS+duXLY/STwG1YkoDPU40tZ/3Q+JotuoZuDOp2xmg91FDHLQ9YYlbdHxQ
	 K88dfmW3Yl/4Webk4WJB/8B4tAKyIXmvAuCDRmxH9UctTMYsH49uve0o1Jq2ATHEX8
	 F62pbCTa+Hvqw==
Date: Mon, 18 May 2026 18:06:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: Add ltc2378
Message-ID: <20260518-trapped-gauze-ada279af89fc@spud>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
 <cf404216011b6972519436c63fcc7c4e2c883c54.1779117444.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1dVv8AhUQcfqNuHf"
Content-Disposition: inline
In-Reply-To: <cf404216011b6972519436c63fcc7c4e2c883c54.1779117444.git.marcelo.schmitt1@gmail.com>


--1dVv8AhUQcfqNuHf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 12:21:01PM -0300, Marcelo Schmitt wrote:
> From: Marcelo Schmitt <marcelo.schmitt@analog.com>
>=20
> Document how to describe LTC2378-20 and similar ADCs in device tree.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  .../bindings/iio/adc/adi,ltc2378.yaml         | 131 ++++++++++++++++++
>  MAINTAINERS                                   |   7 +
>  2 files changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2378=
=2Eyaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml b=
/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> new file mode 100644
> index 000000000000..56e59bcd7306
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> @@ -0,0 +1,131 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ltc2378.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices LTC2378 and similar Analog to Digital Converters
> +
> +maintainers:
> +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> +
> +description: |
> +  Analog Devices LTC2378 series of ADCs.
> +  Specifications can be found at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
233818fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236416fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236418f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236716fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236718f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236816f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236818f.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
236918fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237016fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237616fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237618fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237620fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237716fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237718fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237720fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237816fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237818fa.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237820fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
237918fb.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
238016fb.pdf
> +
> +$ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - adi,ltc2338-18
> +          - adi,ltc2369-18
> +          - adi,ltc2370-16
> +          - adi,ltc2379-18
> +          - adi,ltc2380-16
> +      - items:
> +          - enum:
> +              - adi,ltc2364-18
> +              - adi,ltc2364-16 # fallback compatible
> +      - items:
> +          - enum:
> +              - adi,ltc2367-18
> +              - adi,ltc2367-16 # fallback compatible
> +      - items:
> +          - enum:
> +              - adi,ltc2368-18
> +              - adi,ltc2368-16 # fallback compatible
> +      - items:
> +          - enum:
> +              - adi,ltc2376-18
> +              - adi,ltc2376-20
> +              - adi,ltc2376-16 # fallback compatible
> +      - items:
> +          - enum:
> +              - adi,ltc2377-18
> +              - adi,ltc2377-20
> +              - adi,ltc2377-16 # fallback compatible
> +      - items:
> +          - enum:
> +              - adi,ltc2378-18
> +              - adi,ltc2378-20
> +              - adi,ltc2378-16 # fallback compatible

All of these are wrong.

Firstly, your "fallback" setups don't work, because they only permit a
single compatible. Secondly, if they did work, you still need to define
the fallback compatible in isolation for it to be permitted for use when
it isn't a fallback.
And thirdly, your driver appears to show that these devices aren't
actually compatible at all, given there's unique match data for each
one.
+static const struct of_device_id ltc2378_of_match[] =3D {
+	{ .compatible =3D "adi,ltc2338-18", .data =3D &ltc2378_chip_info[ID_LTC23=
38_18] },
+	{ .compatible =3D "adi,ltc2364-16", .data =3D &ltc2378_chip_info[ID_LTC23=
64_16] },
+	{ .compatible =3D "adi,ltc2364-18", .data =3D &ltc2378_chip_info[ID_LTC23=
64_18] },
+	{ .compatible =3D "adi,ltc2367-16", .data =3D &ltc2378_chip_info[ID_LTC23=
67_16] },
+	{ .compatible =3D "adi,ltc2367-18", .data =3D &ltc2378_chip_info[ID_LTC23=
67_18] },
+	{ .compatible =3D "adi,ltc2368-16", .data =3D &ltc2378_chip_info[ID_LTC23=
68_16] },
+	{ .compatible =3D "adi,ltc2368-18", .data =3D &ltc2378_chip_info[ID_LTC23=
68_18] },
+	{ .compatible =3D "adi,ltc2369-18", .data =3D &ltc2378_chip_info[ID_LTC23=
69_18] },
+	{ .compatible =3D "adi,ltc2370-16", .data =3D &ltc2378_chip_info[ID_LTC23=
70_16] },
+	{ .compatible =3D "adi,ltc2376-16", .data =3D &ltc2378_chip_info[ID_LTC23=
76_16] },
+	{ .compatible =3D "adi,ltc2376-18", .data =3D &ltc2378_chip_info[ID_LTC23=
76_18] },
+	{ .compatible =3D "adi,ltc2376-20", .data =3D &ltc2378_chip_info[ID_LTC23=
76_20] },
+	{ .compatible =3D "adi,ltc2377-16", .data =3D &ltc2378_chip_info[ID_LTC23=
77_16] },
+	{ .compatible =3D "adi,ltc2377-18", .data =3D &ltc2378_chip_info[ID_LTC23=
77_18] },
+	{ .compatible =3D "adi,ltc2377-20", .data =3D &ltc2378_chip_info[ID_LTC23=
77_20] },
+	{ .compatible =3D "adi,ltc2378-16", .data =3D &ltc2378_chip_info[ID_LTC23=
78_16] },
+	{ .compatible =3D "adi,ltc2378-18", .data =3D &ltc2378_chip_info[ID_LTC23=
78_18] },
+	{ .compatible =3D "adi,ltc2378-20", .data =3D &ltc2378_chip_info[ID_LTC23=
78_20] },
+	{ .compatible =3D "adi,ltc2379-18", .data =3D &ltc2378_chip_info[ID_LTC23=
79_18] },
+	{ .compatible =3D "adi,ltc2380-16", .data =3D &ltc2378_chip_info[ID_LTC23=
80_16] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ltc2378_of_match);

Why do you have fallbacks here? Is it because a limited set of channels
could be used in the fallback case? At the very least, the rationale for
fallbacks should be explained.

pw-bot: changes-requested

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 100000000
> +
> +  vdd-supply:
> +    description: A 2.5V supply that powers the chip (VDD).
> +
> +  ovdd-supply:
> +    description:
> +      A 1.71V to 5.25V supply that sets the logic level for digital inte=
rface.
> +
> +  ref-supply:
> +    description:
> +      A 2.5V to 5.1V supply for the reference input (REF).
> +
> +  cnv-gpios:
> +    description:
> +      When provided, this property indicates the GPIO that is connected =
to the
> +      CNV pin.
> +    maxItems: 1
> +
> +  interrupts:
> +    description:
> +      Interrupt for signaling the completion of conversion results. The =
active
> +      low signal provided on the BUSY pin asserts when ADC conversions f=
inish.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +  - ovdd-supply
> +  - ref-supply
> +
> +additionalProperties: false

As sashiko pointed out, this is not correct if you want to permit spi
properties other than spi-max-frequency (although I could definitely see
how this would be correct).

Cheers,
Conor.

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +        adc@0 {
> +            compatible =3D "adi,ltc2378-20";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <71000000>;
> +            vdd-supply =3D <&supply_2_5V>;
> +            ovdd-supply =3D <&supply_3_3V>;
> +            ref-supply =3D <&supply_5V>;
> +            cnv-gpios =3D <&gpio0 88 GPIO_ACTIVE_HIGH>;
> +            interrupts =3D <7 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent =3D <&gpio>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0de74503df08..768f56eea476 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15195,6 +15195,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml
>  F:	drivers/iio/dac/ltc1660.c
> =20
> +LTC2378 IIO ADC DRIVER
> +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/adc/adi,ltc2378.yaml
> +
>  LTC2664 IIO DAC DRIVER
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  M:	Kim Seer Paller <kimseer.paller@analog.com>
> --=20
> 2.53.0
>=20

--1dVv8AhUQcfqNuHf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagtHCAAKCRB4tDGHoIJi
0udmAQCYK1YC10+mA3RtJMEJb9G1E1ZW0TEBpPYCIxL+ktibDwEA8x25lAL2GAe2
/mpsQL8+UYeHt1nZFocMDVGa1PF8qgA=
=fQBx
-----END PGP SIGNATURE-----

--1dVv8AhUQcfqNuHf--
