Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83612F8EAD;
	Sat,  9 May 2026 16:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778342439; cv=none; b=RcFGL9tJUl/JyDcuCxD7g27Ivx+E3fIk7Gxczy+RSvwzdXcOwpyKI1GjTDlQ+Y8gJcjKl8rlKVkFktkXoa+Qcgb8eBg3PBpaPHmeYs/63MTM3q7PqbIFwAaMMC64PGtCNMcFvoMcSotYqgZOGpX0CbS7jG8Xj7s4fIHrMaK4I/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778342439; c=relaxed/simple;
	bh=CL4fsrQ7OZHOmIgWZ43mltPIiknY6x3+CwZ9wFrY6+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkv2I9kInp+tLoft8H8cs9FdTiAnAjl6099NXXZiYj2nlw/LuxwsPXZ9rTWC1dCP1IEkxu90EFz7ZXBRhsbSc59iPBq4zxYDRgqIyhLbnArNUxV3odpHo5wVDdht0tJ+GGw8vG0BWUfrx//CSWk5IXDR5clH03dGeYzQWgucZx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx/Eir+C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx/Eir+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5860CC2BCB2;
	Sat,  9 May 2026 16:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778342439;
	bh=CL4fsrQ7OZHOmIgWZ43mltPIiknY6x3+CwZ9wFrY6+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lx/Eir+CfVng74DD5h3Zk49dyri9wYg8oCG8n24MTfUxsYdW0sehtD+yAM+Ua8P/1
	 rtVD/fAY9JpHf5FG+AqP5dObFVcZr09Ij/Bw0XPI7F1+6sWEBQlcDEu0LK9fVAD4Xi
	 yVAfe5R6SV2nbeuuyWYwcZ8nQ4sM9wp8plhqaP1VYtlzkDAzlZrLrZCWgNeLneTUnI
	 2vnmmYMdoYdTxO1gGTxcsNicoWYvLeFJdWB4QN47i1oEgspzepd55xFi+1aYBuGACX
	 XN1CnvddJSMsAIxGWVahzUYEAZdPzglnA/CtD4wFaz2f8M3X6FTJYChm1G8F+AA4jn
	 frT3ciTtuPtnw==
Date: Sat, 9 May 2026 17:00:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jic23@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Message-ID: <20260509-backdrop-contented-b81438c518f4@spud>
References: <20260508233730.77834-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lVmGhPeJik6vMtkp"
Content-Disposition: inline
In-Reply-To: <20260508233730.77834-1-dennylin0707@gmail.com>


--lVmGhPeJik6vMtkp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jonathan,

What's the story with adding bindings for things that are in staging?

Cheers,
Conor.

On Fri, May 08, 2026 at 11:37:30PM +0000, Hungyu Lin wrote:
> Add devicetree binding documentation for AD9832 and AD9835 DDS devices.
>=20
> These devices are SPI-controlled direct digital synthesizers
> requiring AVDD, DVDD supplies and an external master clock.
>=20
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  .../bindings/iio/dds/adi,ad9832.yaml          | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml b/=
Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> new file mode 100644
> index 000000000000..7e2eece086d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dds/adi,ad9832.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD9832 / AD9835 DDS
> +
> +maintainers:
> +  - Hungyu Lin <dennylin0707@gmail.com>
> +
> +description: |
> +  Analog Devices AD9832 and AD9835 are SPI-controlled direct digital
> +  synthesizers (DDS) capable of generating programmable frequency and
> +  phase output signals using an external master clock.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad9832
> +      - adi,ad9835
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: mclk
> +
> +  avdd-supply:
> +    description: Analog power supply
> +
> +  dvdd-supply:
> +    description: Digital power supply
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - avdd-supply
> +  - dvdd-supply
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ad9832@0 {
> +            compatible =3D "adi,ad9832";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <20000000>;
> +            clocks =3D <&mclk>;
> +            clock-names =3D "mclk";
> +            avdd-supply =3D <&vdd_3v3>;
> +            dvdd-supply =3D <&vdd_3v3>;
> +        };
> +    };
> --=20
> 2.34.1
>=20

--lVmGhPeJik6vMtkp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf9aIwAKCRB4tDGHoIJi
0ggOAP9CmJCGd6Uj4zBRYUly+mXIukd5sy/+OgKrJFBIuUCmzAD/eJeRYZLEbtRc
qSUC56+Io5LCWQT5BaKCt4yQwBepqgI=
=35P5
-----END PGP SIGNATURE-----

--lVmGhPeJik6vMtkp--
