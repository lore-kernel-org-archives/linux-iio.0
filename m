Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652491;
	b=t9duYaYXFKbnkGRfnVLigIlXRR3O0ARvorxadMdGPLtl4cx1MH5GkQwZVfy37JQpurOM
	 bZslCfeCGwylzYYD+Ev4CaGi7rW9EXrbOJ/0skQDqr7jp0JWwYTEFNNQitqgtZumMaYuO
	 6L29sRBJaP2HYdxxsP+dBGOQ34e+U6Yd5KWVexCVmhy16X/qTzeNbpGnETAOfhydRwPhr
	 MDDA3e7lJpUDV792BUI/BJSO4pOe0Xoq8DU9HOUDs8V6xKwpCUGrF+7DLwPuv67gvMW2N
	 2hTbY4AN+x7kmhTQL7ZrgrKjb3aR0zLlUlbF5SKF/osyVkLZlfj6hCy8yc3Z+EdQ6Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652491;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6xddysbA9HgFqkLFd1E0uqGDoPhRvcZXwufnklq7AKw=;
	b=3drzxr8J3j52g7gBvRxTyM4T0PiJ/C+vjkhzaKt0lUDVkkmfKM/Ph8Zmh0TYGR1XfwHl
	 ufF23KSw+kYdsriuvT9N/JM/CGZFKQFggP+g23ojCT10ggK1iPFjt0Ql0l38wxx66aAsx
	 mpY6XanjxueISlMcNKnkAF0KhwLcrsTXiM4Kz2MI0xp8prc+WR2ZGHWn/gKlwwQj1J1ZG
	 7Nff32XG/BC7SKqBt8sx1qypShbJZlVsIqYwlBoZ2X4yAY7zPRtQOoQLh4uzDMc2OoNwt
	 fxneHbVuNLc9kzv6ruusg3xyiQXeExfqYBWbepnVljYJ7fkyrUCRGNi97Sm13F11BOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLi60mjn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDECE606A326;
	Mon,  2 Nov 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mLi60mjn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958691F00A16;
	Mon,  2 Nov 2026 20:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652490;
	bh=6xddysbA9HgFqkLFd1E0uqGDoPhRvcZXwufnklq7AKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mLi60mjnzwIDAfg8Z77TOtGj++a1B0tdHNieMumnaMy8uY0MuCNafh/FBUKUWD7NG
	 YViiwaIZ9OYLnB6tcLch7QRqd8/hZ+CYBYPRsrwGWBBMc1Y+2d+euZJVaUX0zP81em
	 z4c2k7h+0o5Ud1Jjet2GpwdfA1vBhGrXTi4bAjUzN55po0epU5o9v9YglfHvHm9nij
	 iGoEGtA3+ykAukpfpdby3fkNsaGlHzwwgkZgv+mAH8YHgA+//nIA0MrWFByIZS9uTP
	 8vXvVjatSPgoRCSzjK1E5ZFm8HSQUrrwZlbnF+ljz2l9ac2XZcFPfchJLi3yxpJpAP
	 EA4FK/JKe9y8A==
Date: Mon, 2 Nov 2026 20:48:05 +0000
From: Conor Dooley <conor@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261102-salute-cylinder-22c9a8896ca9@spud>
References: <20261102201155.10948-1-olivier@mgcrea.io>
 <20261102201155.10948-2-olivier@mgcrea.io>
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
	protocol="application/pgp-signature"; boundary="6qWinq+OBSPdtkNb"
Content-Disposition: inline
In-Reply-To: <20261102201155.10948-2-olivier@mgcrea.io>

--6qWinq+OBSPdtkNb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2026 at 09:11:54PM +0100, Olivier Louvignes wrote:
> The X1600's SAR ADC has four auxiliary channels and none of the
> touchscreen or battery engines of the JZ47xx ADCs in ingenic,adc.yaml,
> so it gets a binding of its own.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x16=
00-adc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.=
yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> new file mode 100644
> index 000000000000..f6356ea97980
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ingenic,x1600-adc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ingenic X1600 ADC
> +
> +maintainers:
> +  - Olivier Louvignes <olivier@mgcrea.io>
> +
> +description:
> +  The SAR ADC of the Ingenic X1600 SoC, with four auxiliary input channe=
ls
> +  measured against a 3.3 V reference.

The wording here makes me wonder if a 3v3 supply is missing here? Or is
this some internal supply on the soc?

Otherwise, this looks fine really.

> +
> +properties:
> +  compatible:
> +    const: ingenic,x1600-adc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  '#io-channel-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - interrupts
> +  - '#io-channel-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc@10070000 {
> +        compatible =3D "ingenic,x1600-adc";
> +        reg =3D <0x10070000 0x30>;

That said, the 0x30 looks suspiciously small - but the region is aligned
neatly so I suppose it's probably not problematic..

Cheers,
Conor.

> +
> +        clocks =3D <&cgu 28>;
> +
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <11>;
> +
> +        #io-channel-cells =3D <1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc22d1149d1..fd4bb5c6bf16 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12925,6 +12925,11 @@ F:	include/linux/mfd/ingenic-tcu.h
>  F:	sound/soc/codecs/jz47*
>  F:	sound/soc/jz4740/
> =20
> +INGENIC X1600 ADC DRIVER
> +M:	Olivier Louvignes <olivier@mgcrea.io>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> +
>  INJOINIC IP5xxx POWER BANK IC DRIVER
>  M:	Samuel Holland <samuel@sholland.org>
>  S:	Maintained
> --=20
> 2.54.0
>=20

--6qWinq+OBSPdtkNb
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauj3BQAKCRB4tDGHoIJi
0m8HAQC5fMDxvkrjUejVaTLi/E/rwAz2L7R0fnR1vob61z4DhwD/bO9L0839+IN3
BXxrFlk9Kl+2bcLK5VW8G+xNp/LlRQU=
=7Eap
-----END PGP SIGNATURE-----

--6qWinq+OBSPdtkNb--
