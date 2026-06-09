Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF92328B56;
	Tue,  9 Jun 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020886; cv=none; b=E9Uldp7o8gPr1dsUXaK5VelSDjo3+ELJ5En1hyBj6MYrhrqIKxggDkqGeKi4vdhfqFzgf4Iaiho8F2/8bt5W/AGjfdDnLdkBl/CSsXJ0RTpFjim2nFsuK+dgSr9Z7fqm3+W3ZWDQ4EloApKZLXPULb9rXB7qZIzIgukiU6cFOhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020886; c=relaxed/simple;
	bh=Im/zrKokHnC01B8LSWBgOKLo4xVrio7gHFjgiwW2Ub4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnv1xs0+Yn1x6yxOSlfT8HZcdNcXXXk66E1X4GGzAdu0RInTb6U2LDUNRvzeyeO7smQmLxL3GXRKiJc0ZN5YY7XD2n0SExfzGOfitIPU1/U7zJH33K1LTxUzVsQ6qkL5XGY6T08Vb4EK4dIva3WDMMQDWsXMmYuP44Rtev2OVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa2WZLV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa2WZLV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9879B1F00899;
	Tue,  9 Jun 2026 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020884;
	bh=cPoTQhxanAhm9Gm2AUInHKfMoTxSR1RmkShaozP3V4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sa2WZLV3Z/gRbC9cLbpzc2ifg6LubkZcfCSWQG7FV2d8JsCb+mdBu4dmJHD541Z3V
	 /kD8uv+/6aO/kp2rayhW6MoaQsL5I7bSR+xiLxCg51/2GHaKdl/PlPrO3k30H/tBXd
	 p/hPiFsDPpWsWgAH+xtIeCdJ9PP8WYBIHehKOeXs4tBrDo7/zz/yBtMnYkO1HGUblu
	 2sFmDy1ZEHmSzk+ZSAvo7JCO6bzWqxVGazO7CZM9a+n1yphej6KBMj83H8t2z2lwkO
	 ZgcwFZlxpbS/qtFDmR4CWh4l263ZIeXv4aZhjO+ZqqDAaDn8T2oU7HRzknkz+OSu9N
	 aD41EyS+HxtZQ==
Date: Tue, 9 Jun 2026 17:01:19 +0100
From: Conor Dooley <conor@kernel.org>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: adc: mediatek,mt6359-auxadc:
 add mt6323 PMIC AUXADC
Message-ID: <20260609-gangway-frayed-366f6d3cc867@spud>
References: <20260609-mt6323-adc-v2-0-aa93a22309f9@protonmail.com>
 <20260609-mt6323-adc-v2-1-aa93a22309f9@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Lzw7ey4J+6nnG0oo"
Content-Disposition: inline
In-Reply-To: <20260609-mt6323-adc-v2-1-aa93a22309f9@protonmail.com>


--Lzw7ey4J+6nnG0oo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2026 at 04:31:58PM +0300, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>=20
> The MediaTek mt6323 PMIC includes an AUXADC used for battery voltage,
> temperature, and other internal measurements.
>=20
> Add the devicetree binding documentation and the associated header file
> defining the ADC channel constants.
>=20
> Also change the description to 'MT6350 series and similar' because
> the binding already includes more than mt635x series PMICs.
>=20
> Finally, add the MAINTAINERS entry for the header with ADC constants.
>=20
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |  3 ++-
>  MAINTAINERS                                        |  6 ++++++
>  .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   | 24 ++++++++++++++++=
++++++
>  3 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-au=
xadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxad=
c.yaml
> index 5d4ab701f51a..852eb7336a5a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.ya=
ml
> +++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.ya=
ml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: MediaTek MT6350 series PMIC AUXADC
> +title: MediaTek MT6350 series and similar PMIC AUXADC
> =20
>  maintainers:
>    - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> @@ -19,6 +19,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - mediatek,mt6323-auxadc

Commit message needs to explain why a fallback is not suitable.
pw-bot: changes-requested

>        - mediatek,mt6357-auxadc
>        - mediatek,mt6358-auxadc
>        - mediatek,mt6359-auxadc
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..2551c8cd9e9d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16256,6 +16256,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/mmc/mtk-sd.yaml
>  F:	drivers/mmc/host/mtk-sd.c
> =20
> +MEDIATEK MT6323 PMIC AUXADC DRIVER
> +M:	Roman Vivchar <rva333@protonmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h

Why is the binding not being included here?

Cheers,
Conor.

> +
>  MEDIATEK MT6735 CLOCK & RESET DRIVERS
>  M:	Yassine Oudjana <y.oudjana@protonmail.com>
>  L:	linux-clk@vger.kernel.org
> diff --git a/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h b/inclu=
de/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
> new file mode 100644
> index 000000000000..6ee9a9ecffc1
> --- /dev/null
> +++ b/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_MEDIATEK_MT6323_AUXADC_H
> +#define _DT_BINDINGS_MEDIATEK_MT6323_AUXADC_H
> +
> +#define MT6323_AUXADC_BATON2		0
> +#define MT6323_AUXADC_CH6		1
> +#define MT6323_AUXADC_BAT_TEMP		2
> +#define MT6323_AUXADC_CHIP_TEMP		3
> +#define MT6323_AUXADC_VCDT		4
> +#define MT6323_AUXADC_BATON1		5
> +#define MT6323_AUXADC_ISENSE		6
> +#define MT6323_AUXADC_BATSNS		7
> +#define MT6323_AUXADC_ACCDET		8
> +#define MT6323_AUXADC_AUDIO0		9
> +#define MT6323_AUXADC_AUDIO1		10
> +#define MT6323_AUXADC_AUDIO2		11
> +#define MT6323_AUXADC_AUDIO3		12
> +#define MT6323_AUXADC_AUDIO4		13
> +#define MT6323_AUXADC_AUDIO5		14
> +#define MT6323_AUXADC_AUDIO6		15
> +#define MT6323_AUXADC_AUDIO7		16
> +
> +#endif
>=20
> --=20
> 2.54.0
>=20
>=20

--Lzw7ey4J+6nnG0oo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaig4zwAKCRB4tDGHoIJi
0n6MAQCnDXNVMnWZGe4f1faCEvn5pbBT50qSq8LSnOk1vjV8+AEAlL1snbNccP0J
r3m520zkbDUiyuIurTwNMF1q1kkMLwg=
=adwT
-----END PGP SIGNATURE-----

--Lzw7ey4J+6nnG0oo--
