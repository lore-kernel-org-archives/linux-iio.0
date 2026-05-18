Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD2371CF1;
	Mon, 18 May 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779121457; cv=none; b=NbjwOLkj7anzbEeqJNfsEZF0tXdBNBmma5OWb+IDZxHOnUg8rnNXCpyAQ8aPKDnrQRwUKBVuflygCox+wMe2HnoJjUVpTdrL8VEFu36DgU+HKuV14gHGlBR9Bhf2gtjSyczn/n35NX+YcAjT4owdlRkqkweNxH5NGG/vtKhtlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779121457; c=relaxed/simple;
	bh=Imw2HLnSjd8O9ATwzKpSN+Hub1Yq/AklHvaTAZrwlZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS29ldkN3uUlrA982Q7od/j354QoPddL25fVk+d9FjRgMekl0pc6piiBys1sL+ewxP3DB+BM1o3Q3/oqyNMMLvMsieox6qWTwm2l87+ONW6QuBrS66YUcuhY89e7THPVry2rvVdkR/PVu/pwr81bUMMeNa5/vsutNaCJR8iUHiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbxEWIdZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbxEWIdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF674C2BCB7;
	Mon, 18 May 2026 16:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779121457;
	bh=Imw2HLnSjd8O9ATwzKpSN+Hub1Yq/AklHvaTAZrwlZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SbxEWIdZzcCNj7Ti2tEBWUxuL6lq8Cq2VsZNNMu/i3CisOmK8ESZkbn7L6v09ydCo
	 s7Ia0kGe2bN/dy7R0DUK4dQYMK86zBOdX7AWTAo7Lr+9pme8/tB9nDDCQMgvS18OvZ
	 b0SMCF2B6bk2XttQzVMAiw5evR2gTSFiZqcZUk3Hp1sCfXPaT34h6qtdDCpXERdisY
	 yaayEKVDVMIreRTEc6EOPfsIOr6wupPl/NY6jE9YpZJqXLiBzeVZMqaeviV2H+RpFv
	 b+OElIMb1LNOd96C2HrYHuPwe2/LuTjkNZyiBh+zjVD1rePLpq/Y8Eufh861CixzIu
	 TnnmqHqDvYeKQ==
Date: Mon, 18 May 2026 17:24:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Message-ID: <20260518-elderly-barman-2b1abfc3755c@spud>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qp8cjv2LIbtSDRpT"
Content-Disposition: inline
In-Reply-To: <20260518081852.116909-2-xingyu.wu@starfivetech.com>


--Qp8cjv2LIbtSDRpT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:
> Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.
>=20
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/starfive,jh=
b100-saradc.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa=
radc.yaml b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sarad=
c.yaml
> new file mode 100644
> index 000000000000..ba8e19b72ad7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.ya=
ml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Successive Approximation Register (SAR) A/D converter for the Sta=
rFive JHB100 SoC
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jhb100-saradc
> +
> +  reg:
> +    maxItem: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  upper-bound-mv:
> +    description: The upper bound voltage value of the monitor.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +
> +  lower-bound-mv:
> +    description: The lower bound voltage value of the monitor.
> +    $ref: /schemas/types.yaml#/definitions/uint16
> +
> +  scan-freq:
> +    description: Number of the scan cycle interval.
> +    $ref: /schemas/types.yaml#/definitions/uint16

Can you explain why any of these three properties are something that
should be in the devicetree rather than software controlled?

How are the bounds calculated?

Given the warnings etc,
pw-bot: changes-requested

Cheers,
Conor.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    adc@11be1400 {
> +      compatible =3D "starfive,jhb100-saradc";
> +      reg =3D <0x11be1400 0x400>;
> +      interrupts =3D <172>;
> +      clocks =3D <&per0crg 18>;
> +      resets =3D <&per0crg 11>, <&per0crg 46>;
> +      #io-channel-cells =3D <1>;
> +      };
> --=20
> 2.34.1
>=20
>=20

--Qp8cjv2LIbtSDRpT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCags9KQAKCRB4tDGHoIJi
0oMuAQC2iWDwTcDy0u4apl7NFb9WBEudKmJuqK6r706Pg745hQEAqZYxqIzh3kfI
M/1/NfiI7Bd0skdjsvSllzb/GOXoAgM=
=/GZe
-----END PGP SIGNATURE-----

--Qp8cjv2LIbtSDRpT--
