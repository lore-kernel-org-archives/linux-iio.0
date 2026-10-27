Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793123264;
	b=mpv+wKhYKiAN5hNz/mAjX2n37/+dDkU0bRByzZiYTULDyP1DYqr8FeSdRoFhxdQsaSNM
	 5DGPTJjoosUDCjBLEtIFZu88sQswcx7S7Di1SqaPTGd2yY49MoUVSqchzeDAZs/rDwtqP
	 on+UurVP4/W8560AcUmoTYbFHKBqmuVUvT0clFSz29coG3o0acbDXE90xKih0CpeViwk1
	 JTcp94FddKb7gPCXKDrb2XXR00gY2H6xnlBrVdRbmQgW/1SKUVuwOOD3+eFEkyhngNBl5
	 ygliovs1IN/zwvot+reM31nEOv0EOWHv4xmqWI8SC5GImV7eC9TG8xtrBU6InOU2W0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793123264;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=l7VNpg2kRwd5b+144/iE+6hpJCf1dqpyVWjx64qc4l0=;
	b=DTBUAFJ1cGEi8N3SMPAWrcxSScBNzKbb3MZ9qC3shmFBQ11LJI15uBL0X1/lPEPazU5s
	 tWXub8jN+XQA5LwyAi0dkbfwjLUiPEb3kjXcYTUncewm5IQVlCMPiEghkv64QHrxacm4+
	 WLpGAmVOSdG0Sx5It+hBj2BwKZxp2L8+VtXajh0vvzKPSG6wogU7eaghxKeK0w4RCPT9j
	 7wZiQBkaJp43/uhY1X+hjpbYWdBhzA5C0lwL2xM9pOkPz9JfCGrbinN/Uv3w3kHO1GuIU
	 Qnq94A+1PRJauBKLj7uH/nofqa0XI1L6VXCia56YbpMgQhKS5eWhiVcohY3GissexdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxx8rD+n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8287606A31A;
	Tue, 27 Oct 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nxx8rD+n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F3A1F01825;
	Tue, 27 Oct 2026 17:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793123263;
	bh=l7VNpg2kRwd5b+144/iE+6hpJCf1dqpyVWjx64qc4l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nxx8rD+nror4YxninkczUDa2I1XrwE4PQI2duzB6BvO+3EYvOaufFAvzZ2Gj9nES5
	 m2zhP7itgsRY8ByszH9+QY7e9oymBBzxIfJ3zvBXW3w7bS6/kqkm6HK9EIP2hRF3gx
	 hmOiOawrr2NgRfzq2VABkINRuQlPg0a+bna9PAWyTbUKUg2DYcYwVY5G62OPWiiqC0
	 cqXPw4Ti6rzYnpvSwsqPFTPY3B5TNQYlaXC3wYiszTVKqykpL5QqmAYXK9OJ0TFckC
	 JKJ0i0m5eOlPsX6OEZ8okOsW/w8f3mni5EbM2CUucBT4uAj2MoFNgzkAtZFEU8ibdM
	 AdUSHht44XH2w==
Date: Tue, 27 Oct 2026 17:47:38 +0000
From: Conor Dooley <conor@kernel.org>
To: Olivier Louvignes <olivier@mgcrea.io>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add the Ingenic X1600 ADC
Message-ID: <20261027-crunching-outsmart-deb81d2c4d6c@spud>
References: <20261023204209.48556-1-olivier@mgcrea.io>
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
	protocol="application/pgp-signature"; boundary="IVzTkKMFsWARD4NZ"
Content-Disposition: inline
In-Reply-To: <20261023204209.48556-1-olivier@mgcrea.io>

--IVzTkKMFsWARD4NZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 10:42:08PM +0200, Olivier Louvignes wrote:
> The X1600's SAR ADC has four auxiliary channels and none of the
> touchscreen or battery engines of the JZ47xx ADCs in
> ingenic,adc.yaml, so it gets a binding of its own.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
>  .../bindings/iio/adc/ingenic,x1600-adc.yaml   | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,x16=
00-adc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.=
yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> new file mode 100644
> index 000000000000..7886836b10c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ingenic,x1600-adc.yaml
> @@ -0,0 +1,60 @@
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
> +  measured against a 3.3 V reference. Its clients select a channel by in=
dex
> +  through "io-channels".
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
> +  clock-names:
> +    items:
> +      - const: adc

This clock name is pointless, but also probably wrong? The name of a
clock should be the name of the port/function in the device being
documented, not the name of the clock at the provider.

But it's not useful when you only have one clock, just like you do not
have reg-names or interrupt-names.

Otherwise, this looks fine.
pw-bot: changes-requested

Thanks,
Conor.

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
> +  - clock-names
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
> +
> +        clocks =3D <&cgu 28>;
> +        clock-names =3D "adc";
> +
> +        interrupt-parent =3D <&intc>;
> +        interrupts =3D <11>;
> +
> +        #io-channel-cells =3D <1>;
> +    };
>=20
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> --=20
> 2.39.5
>=20

--IVzTkKMFsWARD4NZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauDjugAKCRB4tDGHoIJi
0rHiAQDJqflN11vFOAQL32ZMWC+E2VMahLfw+dfMccVcVRCF9wD/b4ROSm7WtF59
puNa4dwEMEvAxnNVq+n1mo1WhBFgQgo=
=1Ief
-----END PGP SIGNATURE-----

--IVzTkKMFsWARD4NZ--
