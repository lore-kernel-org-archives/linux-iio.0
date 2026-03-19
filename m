Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9BF273D9F;
	Thu, 19 Mar 2026 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941128; cv=none; b=N+s182pgZtFO8TG7Ai5e8T+OY/QSK8CqTKxTGVqx/NsaobPWrtVdRthqGN9MpN6T2lcdOPnidf1E40/GiGcAVJPzpiygn75XljWG3Vx4qHViVBwBzOlBQknakVFP+VI2CxJwaGMGL3z/vmfO/faAYvmrvhtY5wcF4po5U1upDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941128; c=relaxed/simple;
	bh=ZosU4qn2Z1lRqQztdPFT/iatRJLCxlOP2ozjz8l9+og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ofsfnild8jZmeAFlN7QzG55KotxVbV4ZfK7IwJMiP/JN49ggpAFIyq8KhKeZTjXGdCPKMlutuVEsMfokEo7vwShaE+0CwBhCtSpqkoHsY4r3jXqfqEzXKXN3VjFkNJa4Ymmqd4eHM6wlEABZkPcfr+99rkgTDXcqlmAyTvsD2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIkEBdeq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIkEBdeq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCCAC19424;
	Thu, 19 Mar 2026 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773941128;
	bh=ZosU4qn2Z1lRqQztdPFT/iatRJLCxlOP2ozjz8l9+og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fIkEBdeqplbwtedyY41wxDL+TPIMyxwMPdYZhp0tBaoZYZ7qOyHYYO5ZUOemHH9pY
	 PDLF8mIXTOnxR2jZJqCYW6w05qtrdGmmjjfesXioug7wahE9xe3Mjwt9GMGa6vp4oB
	 BgBurnJe9ZBzZK42yQkT5zMO2h3FWVDT4QG21G0rmFHOWLJc3f6v2ufP3mKgG5VrsV
	 SQT2uUL0+Uy4WNs9AbKyYviWIICT7rPCZMuLioA4wUahIkgjf2wAHHBLS1L3j2Suxf
	 ZuZDavwRrNIWBCI0M2K8Iq5yPszkf6oK7DcPkKc4XTfBj5oqT8K0E3QgnhjGwzbFJv
	 lvIOo47IrZIaA==
Date: Thu, 19 Mar 2026 17:25:23 +0000
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 1/9] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260319-annex-varying-afbddcb825b7@spud>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-1-e79f93becf11@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fYwfFjjWcyX3QhEy"
Content-Disposition: inline
In-Reply-To: <20260318-ad9910-iio-driver-v2-1-e79f93becf11@analog.com>


--fYwfFjjWcyX3QhEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 05:56:01PM +0000, Rodrigo Alencar via B4 Relay wrot=
e:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> configurations for clocks, DAC current, reset and basic GPIO control.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../bindings/iio/frequency/adi,ad9910.yaml         | 189 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 196 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.y=
aml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> new file mode 100644
> index 000000000000..68eaefea3f5a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> @@ -0,0 +1,189 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,ad9910.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9910 Direct Digital Synthesizer
> +
> +maintainers:
> +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +description:
> +  The AD9910 is a 1 GSPS direct digital synthesizer (DDS) with an integr=
ated
> +  14-bit DAC. It features single tone mode with 8 configurable profiles,
> +  a digital ramp generator, RAM control, OSK, and a parallel data port f=
or
> +  high-speed streaming.
> +
> +  https://www.analog.com/en/products/ad9910.html
> +
> +properties:
> +  compatible:
> +    const: adi,ad9910
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 70000000
> +
> +  clocks:
> +    minItems: 1
> +    maxItems: 2
> +    description:
> +      First clock is always the reference clock (REF_CLK), while the sec=
ond
> +      clock is an optional synchronization clock (SYNC_IN).

This should be an items list, like:
items:
  - description: foo
  - description: bar

> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: ref_clk

s/_clk//, not like it can be anything else!

> +      - items:
> +          - const: ref_clk
> +          - const: sync_in
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clock-output-names:
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      enum: [ sync_clk, pdclk, sync_out ]

I'd say same here, but then you've got some issues with differentiation,
so idk.

> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2

Items list here please, the -names property shouldn't be the only place
one can figure out what goes where.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [ drover, ram_swp_ovr ]
> +
> +  dvdd-io33-supply:
> +    description: 3.3V Digital I/O supply.
> +
> +  avdd33-supply:
> +    description: 3.3V Analog DAC supply.
> +
> +  dvdd18-supply:
> +    description: 1.8V Digital Core supply.
> +
> +  avdd18-supply:
> +    description: 1.8V Analog Core supply.
> +
> +  reset-gpios:
> +    description:
> +      GPIOs controlling the Main Device reset.
> +
> +  io-reset-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the I/O_RESET pin.
> +
> +  powerdown-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the EXT_PWR_DWN pin.
> +
> +  update-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO controlling the I/O_UPDATE pin.
> +
> +  profile-gpios:
> +    minItems: 3
> +    maxItems: 3
> +    description:
> +      GPIOs controlling the PROFILE[2:0] pins for profile selection.
> +
> +  sync-err-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO used to read SYNC_SMP_ERR pin status.
> +
> +  adi,pll-enable:
> +    type: boolean
> +    description:
> +      Indicates that a loop filter is connected and the internal PLL is =
enabled.
> +      Often used when the reference clock is provided by a crystal or by=
 a
> +      single-ended on-board oscillator.
> +
> +  adi,charge-pump-current-microamp:
> +    minimum: 212
> +    maximum: 387
> +    default: 387
> +    description:
> +      PLL charge pump current in microamps. Only applicable when the int=
ernal
> +      PLL is enabled. The value is rounded to the nearest supported step=
=2E This
> +      value depends mostly on the loop filter design.
> +
> +  adi,refclk-out-drive-strength:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ disabled, low, medium, high ]
> +    default: disabled
> +    description:
> +      Reference clock output (DRV0) drive strength. Only applicable when
> +      the internal PLL is enabled.
> +
> +  adi,dac-output-current-microamp:
> +    minimum: 8640
> +    maximum: 31590
> +    default: 20070
> +    description:
> +      DAC full-scale output current in microamps.
> +
> +dependencies:
> +  adi,charge-pump-current-microamp: [ 'adi,pll-enable' ]
> +  adi,refclk-out-drive-strength: [ 'adi,pll-enable' ]
> +  interrupts: [ interrupt-names ]
> +  clocks: [ clock-names ]
> +  '#clock-cells': [ clock-output-names ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks

Worth pointing out, you haven't made either clock-names or
interrupt-names (when interrupts are used) mandatory, so the properties
cannot be used by a driver. I suggest you make clock-names mandatory and
interrupts depend on interrupt-names.

pw-bot: changes-requested

Cheers,
Conor.

> +  - dvdd-io33-supply
> +  - avdd33-supply
> +  - dvdd18-supply
> +  - avdd18-supply
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
> +        dds@0 {
> +            compatible =3D "adi,ad9910";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <1000000>;
> +            clocks =3D <&ad9910_refclk>;
> +            clock-names =3D "ref_clk";
> +
> +            dvdd-io33-supply =3D <&vdd_io33>;
> +            avdd33-supply =3D <&vdd_a33>;
> +            dvdd18-supply =3D <&vdd_d18>;
> +            avdd18-supply =3D <&vdd_a18>;
> +
> +            reset-gpios =3D <&gpio 0 GPIO_ACTIVE_HIGH>;
> +            io-reset-gpios =3D <&gpio 1 GPIO_ACTIVE_HIGH>;
> +            powerdown-gpios =3D <&gpio 2 GPIO_ACTIVE_HIGH>;
> +            update-gpios =3D <&gpio 3 GPIO_ACTIVE_HIGH>;
> +            profile-gpios =3D <&gpio 4 GPIO_ACTIVE_HIGH>,
> +                            <&gpio 5 GPIO_ACTIVE_HIGH>,
> +                            <&gpio 6 GPIO_ACTIVE_HIGH>;
> +
> +            adi,pll-enable;
> +            adi,charge-pump-current-microamp =3D <387>;
> +            adi,refclk-out-drive-strength =3D "disabled";
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08d8ddf4ef68..2ca8b68e5daa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1630,6 +1630,13 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/dac/adi,ad9739a.yaml
>  F:	drivers/iio/dac/ad9739a.c
> =20
> +ANALOG DEVICES INC AD9910 DRIVER
> +M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> +
>  ANALOG DEVICES INC MAX22007 DRIVER
>  M:	Janani Sunil <janani.sunil@analog.com>
>  L:	linux-iio@vger.kernel.org
>=20
> --=20
> 2.43.0
>=20
>=20

--fYwfFjjWcyX3QhEy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabwxggAKCRB4tDGHoIJi
0p/8AQDmCRKAeeiKuUKKrZ4alKEChjbHTWeGE4Uf0O9x+my1LQEA5BkA4f5G7QyP
iUXW1a4HWxsb5kzZf3WUeJU8u0TBzAU=
=nta5
-----END PGP SIGNATURE-----

--fYwfFjjWcyX3QhEy--
