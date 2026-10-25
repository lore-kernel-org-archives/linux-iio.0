Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792972492;
	b=fYFS2KbqcQaBVt7rGlAqKHkF1QoVE48kXVP2gloWMkYfE+6W3rhhClBHAtff6YGTkNbh
	 24VLW0I4zHN0IZVpZUbHgyFrfXIyZ+mcHiVPLyfbt8hizxYEu6JeGe7CrArpwAWkJtMkw
	 GQxyleb5ywSaSFeueHGZ66HVcwZfnyDzRn7k/ukH2S3eKJ2JleytiviN24xaRcFV57CQH
	 BcllILoNbJk+bMZXHaOdgDdYHOfnf3eZZAOJWH9SkM417XfXHgNTTqLp1FIPys86Agf2v
	 5H6b/29HLWQxDmxIeOJRj0T4HF6oYyAbbagPfiCQJqrC1JoZL8v11xnlY2hxHb2/J+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972492;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=LkGkgiiJ14vcz/5K/9BxVarCa1Rt0W0jKXIzP/tm76s=;
	b=4bqw5eODROsNHj0mmtRzu3e0+LgY3zrqFsbY2lhVflHLguzOAxxWVtjOJhlokXoiBUn+
	 Y43WFrEG28bRDf+GG2yFS9yiMuN50e/dgHcqN2vZ3zLqedSQnF/mkZHxqlQYqBZ0zKDms
	 mveFjkAjZY5oIPqP8jm5jyxWYglzhE8MymKyyMy7bt9uBHgoBg6q8llrjSqzFB6VdzWeE
	 4Lyj8de63Wk5Tyn9aiCv+o1btEZ6U77Xe1bU7ySKkciWeGTo237fclyrIbe+zu+N7l09e
	 r0hW+n1Cah6EAR4gOu+uJw/DpiW22AXoK8r8IcqmNHLltyTkmRqsUD78P1Mk6tvVT/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FN7XVxpC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE287606A31A;
	Sun, 25 Oct 2026 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FN7XVxpC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9C51F01825;
	Sun, 25 Oct 2026 23:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792972491;
	bh=LkGkgiiJ14vcz/5K/9BxVarCa1Rt0W0jKXIzP/tm76s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FN7XVxpCqcCIg269fh5/6/vn/3TEvobOrTKHo7ZxV9ptsP554olOyR6qlVnkoIj7K
	 HAHxhBol0Pop7Rg2W92nQ0ORoimqeNL/5otJFyFBklxw07jWtCZSlnmyiIKABqlPs3
	 chTZK9hL+3XoMn+yrNNu4cVrmHME4ReDa9iAj3qpuATFxmPcAYavhMvUFso/rucOHl
	 hHWUjdL345QuoNutepUK3xMvUbm9ql7uYhFytyOQDproSXQlFYLVqL7q4TK7RTTiU5
	 zCbNCRZlI2vkZPilFJGkH3S3OLJayJ9E5JZyLGaRc0qzL7wBaghUztmFV+DEFFx9kQ
	 5KLqmsfUtBoEQ==
Date: Sun, 25 Oct 2026 23:54:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com
Subject: Re: [PATCH v4 4/8] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <20261025235443.07d75197@jic23-hlaptop>
In-Reply-To: <20261023-adis16607-v4-4-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
	<20261023-adis16607-v4-4-a4d541ebfd13@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Oct 2026 12:30:21 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add device tree bindings for the Analog Devices ADIS16607 Precision
> MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> gyroscope, triaxial accelerometer, and temperature sensor, and
> communicates over SPI Half-Duplex.
>=20
> Two variants are supported, adis16607-2 and adis16607-3, differing
> only in gyroscope full-scale range (=C2=B1450=C2=B0/s and =C2=B12000=C2=
=B0/s
> respectively).
>=20
> The binding exposes optional properties for:
>   - An external clock for sync mode (falling back to the internal 8 kHz
>     clock when absent)
>   - A hardware reset GPIO (active low)
>=20
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

There is enough new stuff in here I'd have dropped Rob's tag.

> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---

and noted you had done so here with a breadcrumb of why, which
is the gpio handling

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

