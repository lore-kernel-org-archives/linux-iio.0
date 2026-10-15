Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6BE3DD526;
	Thu, 15 Oct 2026 18:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090795; cv=none; b=SUwN6+af1stH04Ka/EbI+QszlEp4TbBUVUNmPTy1M3Rh3FOltJNF8RHTHgdKGpOQH7Z6zlL8emhzyOPw4TxqOGPCrc3i3lRa+nBoEQSKvKKLMW/IJaRQ1VSnzf5i2mjFFkOVxrrjQb/xNm3IzEa/n/BiZ8w1bRdzSzWYq/w96XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090795; c=relaxed/simple;
	bh=eEElU/ASY7hM4FjTNpS3QxyZuVDzXjY8CVAKzpMxQIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5LRleHFId0XQg7DlKi9Af20Y1Ss7K6PFXSwm2k4FpOJ9JZjj4KJE3lRQHu4d8sa/29hBLX2Oh6F6t+Oyqpn/ZNgnt1Kn4kmNyUhnfouG5ALW/gCuSUAyQ4UWwhFkTCmudDz4OKzcZ+q/5EymEciEL82iiGfqxJQECeoNXdCVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wth7eYeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wth7eYeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A961F000C4;
	Thu, 15 Oct 2026 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090793;
	bh=QRhDD5Kba1/4vJE/aynvHCteJlbfDqNA5/X4nzhZ0Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wth7eYeZLmsM9VNp67WWO1Jb1ODN2CZb/kNwAsaHlgnb/surWcINGPQvTTFkpYAMU
	 gujfqTmB2U1usi+lAQEN8gnwjzWfjZZM+wW9HyeCCzxjc4ZHw47i7wICudgNN/Kw0w
	 aZ33rlRbNnX/Ju0Bbicedo8WHWI7cP5HDq34oBhIClUvXr83IwbPIwCkAz+Ltz6JDR
	 AxHvw17fBIWnV0+quaMclCvUSClt0U8ZMxq73VfPE0USoQVNqBxOIFa+noZFNw+Ph9
	 iv0Tqyl4iT0qqhSGwU7HKtMhFyr5XsHXMwsljVEyjkl0Y3gg40bqdEAJwAWeuVTiSz
	 5fYJNzS9T1dlw==
Date: Thu, 15 Oct 2026 19:59:47 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
Message-ID: <20261015-enjoying-dividers-94790b437fcd@spud>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-3-3c21648c8e26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Oi1NC4/rev2QJv0k"
Content-Disposition: inline
In-Reply-To: <20261015-ad9910-backend-support-v1-3-3c21648c8e26@analog.com>

--Oi1NC4/rev2QJv0k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 01:49:43PM -0300, Rodrigo Alencar via B4 Relay wrot=
e:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Add bindings for the AD9910 AXI backend IP core. The FPGA IP core
> interfaces with the data and control pins of the AD9910 DDS, streaming
> data from memory via DMA into the 18-bit parallel data port (F[1:0] and
> D[15:0] pins), which is clocked by the PDCLK output of the device. It
> also drives the PROFILE[2:0] pins and the DRCTL pin, which controls the
> slope direction of the digital ramp generator (DRG). The DRCTL pin is
> driven by a PWM generator, so the IP core is described both as an IIO
> backend and as a PWM provider.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../iio/frequency/adi,ad9910-axi-backend.yaml      | 74 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 75 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910-a=
xi-backend.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad991=
0-axi-backend.yaml
> new file mode 100644
> index 000000000000..20b884e8eb10
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-back=
end.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/frequency/adi,ad9910-axi-backend.=
yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9910 AXI Backend IP core
> +
> +maintainers:
> +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +description:
> +  FPGA IP core that interfaces with the data and control pins of the AD9=
910
> +  Direct Digital Synthesizer. The SPI bus is used as the control interfa=
ce
> +  of the AD9910 device, while this IP core streams data from memory via =
DMA
> +  into the 18-bit parallel data port (F[1:0] and D[15:0] pins), which is
> +  clocked by the PDCLK output of the AD9910. The IP core also drives the
> +  PROFILE[2:0] pins for profile selection and provides a PWM generator t=
hat
> +  drives the DRCTL pin, controlling the digital ramp generator (DRG) slo=
pe
> +  direction.
> +
> +  https://www.analog.com/en/products/ad9910.html

Should this link not point to the docs for the backend device?

Otherwise, this is pretty fine I think..

Conor.

> +
> +properties:
> +  compatible:
> +    const: adi,ad9910-axi-backend
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description: AXI bus clock (s_axi_aclk).
> +
> +  dmas:
> +    maxItems: 1
> +
> +  dma-names:
> +    items:
> +      - const: tx
> +
> +  '#io-backend-cells':
> +    const: 0
> +
> +  '#pwm-cells':
> +    const: 3
> +    description:
> +      The first cell must be 0, as only the DRCTL PWM output is availabl=
e.
> +      The second cell is the PWM period in nanoseconds and the third cell
> +      holds the PWM flags.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - dmas
> +  - dma-names
> +  - '#io-backend-cells'
> +  - '#pwm-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ad9910_backend: dds-backend@44a00000 {
> +        compatible =3D "adi,ad9910-axi-backend";
> +        reg =3D <0x44a00000 0x10000>;
> +        clocks =3D <&clkc 15>;
> +        dmas =3D <&tx_dma 0>;
> +        dma-names =3D "tx";
> +        #io-backend-cells =3D <0>;
> +        #pwm-cells =3D <3>;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a2dfd1a4fd8..93ad6a829cb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1731,6 +1731,7 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/debugfs-iio-ad9910
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
> +F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910-axi-backen=
d.yaml
>  F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
>  F:	Documentation/iio/ad9910.rst
>  F:	drivers/iio/frequency/ad9910.c
>=20
> --=20
> 2.43.0
>=20
>=20

--Oi1NC4/rev2QJv0k
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatEioAAKCRB4tDGHoIJi
0p6EAQClRur2Sf3UhlxYAaTJqDsuSMyJevkhnvLthhhfwjKnwAD7BunpY9WqCaXo
F3lDqqxKkiJbBPwxk6IK+Jp+wCE6fg8=
=4WDP
-----END PGP SIGNATURE-----

--Oi1NC4/rev2QJv0k--
