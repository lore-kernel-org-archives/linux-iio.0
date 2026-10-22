Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792694338;
	b=4ShJYxXboH+vbYvgIuk5PY1d2p5WrL6Djcc7gIxdSsXWQFs7xpj2UHWHJ7DA9G+QG6ly
	 qPh4bUyZDlt/6Vain2IYSCav5pbC/C8o3Pp6N8L++cGKAVILksyt+woeewxMm205dBWyB
	 IwfqC+vQnmsQv+BhaL/BNAdBeiIAGGC2hDkM94+ndBafal/OwmbVtlP8zwlcmr8w+JgTB
	 h66PryEKspTlZyzjVx0J/GsiCF+yvUiWSKMArPJnw5CET1NyzoRG76AAUVyARW7vw244B
	 7Ex09NEPlB3hZtNl2Gdi4+bWoPuJfwO7subXfmn//QO6y9UjQqYpee4hGuX/MAu1skA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792694338;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RP33vO+e+kcFqrmiKrJlwuCPkEWPh+ZrwQ3D6/xs7uA=;
	b=BenkCXKquZPhoQm3Ydeq1hGZnCbnQ+Q72ETnvMkVWKkufP0PS0HQ0v89bq6RIDM5wuwa
	 qHgEHW9NpKikpZOI2C9b00ZNnWBHt9JMiEOaLHjRDnvWSWFF1JD97LKQxtZfvgnRITCOa
	 VZi51wRjT1sGyBFKQTbnNlFW/O2hoPYoKcHhzSO3Fr6039RRGyXM1qLkXZaWfeXA98I1E
	 k4YLyU6Z4Pp277DRPVvT6h2VrhQLImvh2s5FgqqBjLqcLN9aen44+OMp9yP7qTt9zu+hK
	 E+phcKnnA83/4/ZyzOdSljCqDDkKYiHDvb4djP/JwaS1yrNCXvLlq2gRRC1VMBgd8ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDxx2KAo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36B606A7B6;
	Thu, 22 Oct 2026 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDxx2KAo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466A51F01825;
	Thu, 22 Oct 2026 18:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792694338;
	bh=RP33vO+e+kcFqrmiKrJlwuCPkEWPh+ZrwQ3D6/xs7uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gDxx2KAoT9zJgXhfY+LDU2eh64sg62D/2W5lAtApH5/SPvjtvGTl+AQrQQoD5tT+/
	 UBpygU1NE+eAfnLL7wLPJDEZKBv9QOQ+l6wDPbq4dkwkwjWJkXHQQ6JZXxRuvkBW3c
	 syUfevjDMJRImGzo9+wP4LjcR5DAAzF24sfEaRS1MbOUSID8Xkepf3YYj45stIyiRN
	 eyILUcGLlgEPQQ6J7J3WlAgyKdQHUrt//OEmKPrsrkN1D+yz7WqwUjqDdk/JZhyWiR
	 5UYRuOj92PMz2w6o1VCyi5FEox3s1CNM9Ol5th5nNVQRGCXme2SMrqj93jtnjHk96G
	 b5ATT7j3fBOpQ==
Date: Thu, 22 Oct 2026 19:38:52 +0100
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
Subject: Re: [PATCH v2 03/10] dt-bindings: iio: frequency: add
 adi,ad9910-axi-backend
Message-ID: <20261022-banish-scenic-030717ca503e@spud>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
 <20261022-ad9910-backend-support-v2-3-0ff7f0bff326@analog.com>
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
	protocol="application/pgp-signature"; boundary="fkpbZrR5UrdritMv"
Content-Disposition: inline
In-Reply-To: <20261022-ad9910-backend-support-v2-3-0ff7f0bff326@analog.com>

--fkpbZrR5UrdritMv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 12:19:01PM -0300, Rodrigo Alencar via B4 Relay wrot=
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
> index 000000000000..20c45fbaf945
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
> +  https://developer.analog.com/docs/hdl/latest/library/axi_ad9910/index.=
html
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

I was about to ack this, but the wording here caught my eye. Are there
other PWMs that are unavailable?

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
> index 52024397dc78..351ec0bca477 100644
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

--fkpbZrR5UrdritMv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatpYPAAKCRB4tDGHoIJi
0rARAQDdnLOWa2ND/sj89km2o8Q1E0l12aIxbl9XxRyMeUBMcwD8C3d+7j30TNco
We3rundA62FLb/kQnm0WrJKGv8KgAQ0=
=QdtC
-----END PGP SIGNATURE-----

--fkpbZrR5UrdritMv--
