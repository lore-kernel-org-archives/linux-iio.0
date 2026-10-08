Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670673D25AF;
	Thu,  8 Oct 2026 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454450; cv=none; b=CrufAta7TnYotG5nibjx4cPbPWH3/X9j35ELm6cj28SOMkIFb6BUoKFQzAR+nOdMwIGfU+0F1PwM01rEP7hwvyIfWoy239C/P7ZbmI/pxUDIAUrqL6pY6tRhvlhDwdb3lCXZgsvRipRN8jx8HM7pAOlSPkkFmXe/MXc/atxGUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454450; c=relaxed/simple;
	bh=CccT5TB+pQ4zubx3i/KhMe1hKRb8P8ETiVDiouPaM6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqfWQxfKKpgNtSOYdsrmg4KnN30PJxouBQFRPMl2JUTx76gr+er5ZmmyrxL11ASDSgdMorQJ5em4sh02t/4XBLgGVyUsQK5eOu/JTQCgf2uwh1QHWgLbQWb31OJdmg/N90/jnWA5DCloMUeei8ZJdimlg2eyAmSMDdiukB2lNYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRMVtVVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRMVtVVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FF0E1F000FF;
	Thu,  8 Oct 2026 10:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791454449;
	bh=H/RXgr/8jtdvQ/043uKgHLi3KX8oQAHjKho/r5JmOlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gRMVtVVIeEW5wX3XMpuJp+VdWS3JxmStErKhKOwhHzfqtKtZX2nZ9G0ZezwZB5Bmk
	 ARlD558EBEFDS9qrbAHLzdBlaR7IDfeXLEZGVoc0JTu1B9U0o2Jalx9f9QMu8kQ8yi
	 PPPXSbyXzSVVrceuO+LySV3bpr4TiMfyEuWpu/1GRE009j9Wvv211IMd+QrZUw0z0L
	 9NWM9umRfnw/RO0INIm1CRNlt+U+n7I/wzRO6G81rMGDm5W6QElKIfqBWWKi5sPPdN
	 UFbVWIeryLEkPH2YgqKkGyT8rReWFQqZ1QS8ZzVNPRMny4ACyKUe8I+Oy+giF+C6Zc
	 ccPnxIl7e5VZg==
Date: Thu, 8 Oct 2026 11:14:03 +0100
From: Conor Dooley <conor@kernel.org>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: imu: Add bindings for ADI
 ADIS16607
Message-ID: <20261008-fba3b6449e19245b845ab442@squawk>
References: <20261008-adis16607-v2-0-7c94df80878a@analog.com>
 <20261008-adis16607-v2-2-7c94df80878a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JT0wtQh0oKH8tN3L"
Content-Disposition: inline
In-Reply-To: <20261008-adis16607-v2-2-7c94df80878a@analog.com>

--JT0wtQh0oKH8tN3L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 11:31:54AM +0300, Radu Sabau via B4 Relay wrote:
> From: Radu Sabau <radu.sabau@analog.com>
>=20
> Add device tree bindings for the Analog Devices ADIS16607 Precision
> MEMS Inertial Measurement Unit. The ADIS16607 integrates a triaxial
> gyroscope, triaxial accelerometer, and temperature sensor, and
> communicates over SPI Half-Duplex.
>=20
> Two compatible variants are supported: adis16607-2 and adis16607-3.
>=20
> The binding exposes optional properties for:
>   - An external clock for sync mode (falling back to the internal 8 kHz
>     clock when absent)
>   - A hardware reset GPIO (active low)
>   - FIFO mode for buffered data acquisition with a configurable watermark
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  .../devicetree/bindings/iio/imu/adi,adis16607.yaml | 83 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 90 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml=
 b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> new file mode 100644
> index 000000000000..b08809e2f327
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16607.yaml
> @@ -0,0 +1,83 @@
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

Commit message says they're compatible, binding says they're not!

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
> +      Optional GPIO for hardware reset. If specified, it will be asserted
> +      during driver probe. The line is active low.

Drop the second sentence, since that's a linux driver specific detail.
pw-bot: changes-requested

Thanks,
COnor,

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

--JT0wtQh0oKH8tN3L
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCasds6wAKCRB4tDGHoIJi
0kTQAP93Z+zHbyLKGxqq6f/YHGoY5ZI7Ia1SyQLfDcUEHBT1NgD+PHdFSEnFQuKe
kcD3AebH8Rj6JhDqPjjlkIlQulvKEgw=
=4SJ/
-----END PGP SIGNATURE-----

--JT0wtQh0oKH8tN3L--
