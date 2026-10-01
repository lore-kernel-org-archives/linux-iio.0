Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A340F72F;
	Thu,  1 Oct 2026 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790881488; cv=none; b=LOeIA/zrnz75SEkfngEHeOcSb5pBM3EBue9XZChbzh+rEuIpiKYrYjie8Bjkm9VdnXHhHINkBMvcej1BRY/wtYDSxxOaZqeQNZFQZUkVsZpnJ0XlJ3NRjahfHCMfDKKhrwn/PM/SfBB4lk2GElzV9MGqNxJXJw2WJOrrwBh6l7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790881488; c=relaxed/simple;
	bh=t5SlTVlC9o4zXQLctQeaePUP8bIJz+3Q5oQC+3O2paA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQLmMJqyHK/MuzZYYidUdOtbobbOe6Z2e8aWVx32w28f9q0l8yzDOf0BLJ1UV1KaStA2x/52Qt4COZI/DZ65SAV9M7tDkGVcBHG8n66VBRVmm0tyhUscJIO7Z46sfSJ/EvVi6zD6vv5fwEoWg5dTQBK6T2V6Ji3iGzh6JXOd3QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9LUIX2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9LUIX2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3201F000FF;
	Thu,  1 Oct 2026 19:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790881483;
	bh=yFQjna1L1rwGBalsjTJZK98c/RCqNMRKtY0FU9F4neg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I9LUIX2Tuy9LxC6BTrbYnkQ+ZIILRHvK+eEr3usGFtt/nkVTgcJyVThzPfAsorbQo
	 4Keq3NKvRyQ43Q9oIOuDk6kqDqVSZnMbpaPuwEHyDNCdiwpYJ2z2HlbxYspM9xIwXk
	 1UMohHsjgfqIyY6IwTBwykAecxsh+P/dvG87b6bEhV8LkDt5MaLmMqCUX4lDrFW0YX
	 4NK3FvCGC1aPurMauaOGxHyz+LpWCSc7vEPu+7prTbJ8LMMYLryaCNMdBHM8YExGIa
	 q15aKngP2vQyOu5xcPRxvuVcpKnfofORlobqSukRq1S/uvwA7Ggw/sBq8HBaZfix8H
	 39pzDz2gFNNLw==
Date: Thu, 1 Oct 2026 20:04:39 +0100
From: Conor Dooley <conor@kernel.org>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: Add bindings for ADI ADIS16607
Message-ID: <20261001-custodian-marvelous-4e0dc985fa3e@spud>
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
 <20261001-adis16607-v1-1-9c89cee35d56@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z1n9a1k4QbNaH3pC"
Content-Disposition: inline
In-Reply-To: <20261001-adis16607-v1-1-9c89cee35d56@analog.com>

--z1n9a1k4QbNaH3pC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 01, 2026 at 12:11:49PM +0300, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add device tree bindings for the Analog Devices ADIS16607 Precision
> MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> gyroscope, triaxial accelerometer, and temperature sensor, and
> communicates over SPI Half-Duplex.
>=20
> Three compatible variants are supported: adis16607-1, adis16607-2,
        ^^^^^^^^^^^^^^^^^^^

> and adis16607-3.
>=20
> The binding exposes optional properties for:
>   - An external clock for sync mode (falling back to the internal 8 kHz
>     clock when absent)
>   - A hardware reset GPIO (active low)
>   - FIFO mode for buffered data acquisition with a configurable watermark
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 91 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 98 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> new file mode 100644
> index 000000000000..5fb1ba36e0b7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> @@ -0,0 +1,91 @@
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
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adis16607-2
> +      - adi,adis16607-3

Yet they are not compatible. Why?
pw-bot: changes-requested

> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-cpha: true
> +
> +  spi-cpol: true
> +
> +  spi-max-frequency:
> +    maximum: 15000000
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
> +      Optional GPIO for hardware reset. If specified, it will be asserted
> +      during driver probe. The line is active low.
> +    maxItems: 1
> +
> +  adi,fifo-enable:
> +    type: boolean
> +    description:
> +      Enable hardware FIFO mode for buffered data acquisition. When enab=
led,
> +      the driver uses the device FIFO with configurable watermark thresh=
old
> +      instead of single-sample burst reads.

What aspect of the usecase does setting this depend on?
Why not just always enable this?

Cheers,
Conor.

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
> +            spi-max-frequency =3D <15000000>;
> +            vdd-supply =3D <&vdd>;
> +            interrupts =3D <4 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-parent =3D <&gpio>;
> +            clocks =3D <&sync_clk>;
> +            reset-gpios =3D <&gpio 10 GPIO_ACTIVE_LOW>;
> +            adi,fifo-enable;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a7fd31320b38..f6ad73be5260 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1717,6 +1717,13 @@ S:	Supported
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

--z1n9a1k4QbNaH3pC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar6uxwAKCRB4tDGHoIJi
0oOXAQDDkqTeuq9vL4rEg4kpx7kY8cGjqutIXIaZ6XcPLWESFgEAiQ9ZjuLrkSyp
fMQ5J2HUrgBa/bEYn1Do7Nl7WtKxWQk=
=bCka
-----END PGP SIGNATURE-----

--z1n9a1k4QbNaH3pC--
