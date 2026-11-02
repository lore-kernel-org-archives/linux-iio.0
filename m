Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648165;
	b=UXWtt322ZU7iGRXt6pelInYkZwq+7EmEhMLooPm2kL8undKERKsTcQ5Gg1dAEGranUiG
	 4od0qdVP6OAVv4M7Xpj5reP49EuHZCgey2TK+dWDLuY42nIs3gltD2sEGWNZBPognBiXK
	 4pAuukh5JaZKuApk/It905wZ5T3aIjPciv83pQ4xDIG7MW0jNl1u3Rqr2aW1FISKRuqeP
	 M5p6ORlKrDMMRwOjUeN4CSmTp3C2pe5TfU0qQ9PDihX+SvFZYzKm4xvwzK5nYZQTDPFEO
	 5M0RMR/zFRUOBAXnlkU2mH953eZpfwduTMt30xg0Ydq/hSL+Kzdb3tLkyIgPtZIPt/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kFbaBVZ3E8VDa8y4rJe8i5lAzf0iMureMcz7WZdjFgU=;
	b=b5MXbSBg3vdeV1/7U7o3K4xB0OLCyVrV8qZkKgBDUNDTO9UWodNynWKnfA9Zwb078jJQ
	 My+zF7ARAs5ZAd9ajLNAvQaXHbmTNA48bv9MOPsWsJnQSdMypXjKkj7b6KsFBv3Y8UfGz
	 JAJv/b+uIahqg2tB8VhPq9B6k4KwZFKvT7TPPwoqtuU8ZP2KKRMriOUOOOkNsFFMb4AiJ
	 sMS+OuhQZD3weXEIk2ZDduTH1RXpkT1Qpu4HPOamKZJ2mVxJny7GMchSCGYo8Dxkhy6Mp
	 uEatBY0J2tmaHoYU9zscu5L0DTJqmZJmvIj8GfEChVtTybT5R/fWT9MiGq9x6Vk4KBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2zTKQbQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6482A606A324;
	Mon,  2 Nov 2026 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J2zTKQbQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9431F00A16;
	Mon,  2 Nov 2026 19:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793648164;
	bh=kFbaBVZ3E8VDa8y4rJe8i5lAzf0iMureMcz7WZdjFgU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2zTKQbQ2a9YnOwXQ7pHAjTXL2ul16UN7sRs3Ls4XywpEsJPs4x7RaqdPButw4xga
	 Qa0Xtpw89792fJOJQcAkfFeBOtmwv5+zxH5k//ifx5oQbCORZFp1ZUg6gcvNRDmyBS
	 fCzu2PI2bKrHJO1erUNjrz3JkkaBt+NjZQUjAeijfEf6R8rarbMDQ76VcGBylmmIOT
	 jqTfKC4tBgiuNfT0ccpOpaWWp+w3N7yDC2z09e/HzrCZPChP4f0n5k9ytJavSSIE2E
	 ElA7wIpp/LRkLOYxuYaSgRVidYk9PQ7j2+A3zgeGDXmX+2wYhiMsnDsZ/K8m5+0qlh
	 UFFyEMpqAIXbw==
Date: Mon, 2 Nov 2026 19:36:00 +0000
From: Conor Dooley <conor@kernel.org>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v5 4/8] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <20261102-barista-haste-6f219aa98c81@spud>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
 <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>
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
	protocol="application/pgp-signature"; boundary="6uYAIMUekWtdEWnh"
Content-Disposition: inline
In-Reply-To: <20261102-adis16607-v5-4-4f98b0d271ac@analog.com>

--6uYAIMUekWtdEWnh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 11:25:40AM +0200, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add device tree bindings for the Analog Devices ADIS16607 Precision
> MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> gyroscope, triaxial accelerometer, and temperature sensor, and
> communicates over SPI Half-Duplex.
>=20
> Two variants are supported, adis16607-2 and adis16607-3, differing
> only in gyroscope full-scale range (=B1450=B0/s and =B12000=B0/s
> respectively).
>=20
> The binding exposes optional properties for:
>   - An external clock for sync mode (falling back to the internal 8 kHz
>     clock when absent)
>   - A hardware reset GPIO (active low)
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Why did you drop Rob's tag?

Cheers,
Conor.

> ---
>  .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 94 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 101 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> new file mode 100644
> index 000000000000..4545f942365c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> @@ -0,0 +1,94 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/imu/adi,adis16607.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADIS16607 IMU
> +
> +maintainers:
> +  - Radu Sabau <radu.sabau@analog.com>
> +
> +description: |
> +  Analog Devices ADIS16607 Precision MEMS Inertial Measurement Unit (IMU)
> +  with a triaxial gyroscope, triaxial accelerometer, and temperature sen=
sor.
> +  Uses SPI Half-Duplex communication protocol.
> +
> +  The device has five GPIO pins (GPIO0-GPIO4 in the datasheet), each
> +  independently selectable for a single fixed function. This binding
> +  exposes GPIO0's reset function as reset-gpios; GPIO2's sync function
> +  is modeled via the clocks property, and GPIO4's DEV_NOK interrupt via
> +  the interrupts property. GPIO3 (data-ready) is required internally
> +  regardless of board wiring and isn't exposed. GPIO1 (wake) gates
> +  whether the bootloader auto-loads its NVM contents after reset; it
> +  defaults to enabled with a weak pull-up, which already gives normal
> +  operation with no configuration needed, so it isn't exposed either.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16607-2
> +      - adi,adis16607-3
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 10000000
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Optional external clock for sync mode. If not provided, the intern=
al
> +      8 kHz clock is used.
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description:
> +      Optional GPIO for hardware reset, active low. Routes to the
> +      device's GPIO0 pin, which can be independently set to the reset
> +      function or left idle via an on-chip register.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - spi-cpha
> +  - spi-cpol
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        imu@0 {
> +            compatible =3D "adi,adis16607-2";
> +            reg =3D <0>;
> +            spi-cpha;
> +            spi-cpol;
> +            spi-max-frequency =3D <10000000>;
> +            vdd-supply =3D <&vdd>;
> +            interrupts =3D <4 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-parent =3D <&gpio>;
> +            clocks =3D <&sync_clk>;
> +            reset-gpios =3D <&gpio 10 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f53047aa8d3c..d5679e8d0ffd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1792,6 +1792,13 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> =20
> +ANALOG DEVICES INC ADIS16607 DRIVER
> +M:	Radu Sabau <radu.sabau@analog.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Supported
> +W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> +
>  ANALOG DEVICES INC ADL8113 DRIVER
>  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
>  L:	linux-iio@vger.kernel.org
>=20
> --=20
> 2.43.0
>=20
>=20

--6uYAIMUekWtdEWnh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaujmIAAKCRB4tDGHoIJi
0tpJAP4sufhyWEI86Iw2h8fgtjkpUlYldDEE3jc2LVLaUeQ3igD/TaRo7RhTNKJb
HI/9EDZXAoLlMdbKP5Yx8kFyuNFY9AE=
=QhiH
-----END PGP SIGNATURE-----

--6uYAIMUekWtdEWnh--
