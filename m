Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A59366DA3;
	Fri, 28 Aug 2026 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787934113; cv=none; b=gWEMhZ0F6e4duZqs8AWQ+JQoTPvDSzN/CArWtlWkUrRxN2SEMzcjJu4W+cNg6ZDrK3GVmFuo0q/UjdZqeLT3CCm/OByex/uNuoQQN28ENpvP2dwz8RPlF9aIqpVIDOWxcNN4Bw4ikoOvELngU7NNdXo+7n8GeyYpJAPsmWEGVVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787934113; c=relaxed/simple;
	bh=BX7Ip8uAT4O3Cu2AY+CH6LhtblYazToBKL6QCvtyuFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4BhxYO21dhYw++BYyworn7zKASqRY8BFwg3y0RVaECApm4nS/mBqO0+qlh4Vgaer/tRLjDKqRmJqV+soxo1s9f/otDSiKhFTLnrpZCFXZUjFHQk7SQPtcbrcMeGK7PGARVCFWFhsV2n8kdK37EQvVqMFPaXwYzm4c6Av4xXt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzDtX1fW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzDtX1fW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D41F000E9;
	Fri, 28 Aug 2026 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787934111;
	bh=n5cdlXyDppmfJXRYYz52pa+3kGjY+vQ3tL6RUIYinmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QzDtX1fWSxprwm4P+6bJgphzCF99XG+w5QZ4rst5AcaMxfXX5mJr0yTt4xGDsqUpI
	 fZfpOaqmwLDkBsrqipSiPmwIfDPJwtB8xG6ABo4n7gB4SvxvOdRxZm7kKd7mqCsi7g
	 o2FWlO6IaPOEFgG3AGNLBw4NrbukiGCFxKKzDSlRTWM8yyOEjJMQutoQDkRLyvKn62
	 DStQUAqtGOISADuyHHszGPjJJKHgYOl2+lW/58WE+XbmB1SQOayb8yZj3srNUFo4my
	 f/rbCcZFs9QwEdlG3DeMRASt+7yvmV4bnSyZ9FT6IsakMMqbZUDuUx+j4395OhIXhp
	 W7GDQi3jVLNsg==
Date: Fri, 28 Aug 2026 17:21:47 +0100
From: Conor Dooley <conor@kernel.org>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] dt-bindings: iio: adc: renesas,r9a09g077-adc:
 document DMA support
Message-ID: <20260828-stoppable-clone-db6c2fefe0fd@spud>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260828145943.2077589-8-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5gSPc2i/A8WI5ivx"
Content-Disposition: inline
In-Reply-To: <20260828145943.2077589-8-cosmin-gabriel.tanislav.xa@renesas.com>

--5gSPc2i/A8WI5ivx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 05:59:40PM +0300, Cosmin Tanislav wrote:
> The ADC can transfer conversion results to memory over DMA.
>=20
> Allow up to three DMA specifiers, as the ADC conversion DMA request can
> be routed to any of the SoC's three DMA controllers.
>=20
> Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
> ---
>  .../bindings/iio/adc/renesas,r9a09g077-adc.yaml      | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-=
adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.=
yaml
> index dc0206b28231..4b5934ac296b 100644
> --- a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
> @@ -57,6 +57,18 @@ properties:
>        - const: adclk
>        - const: pclk
> =20
> +  dmas:
> +    minItems: 1
> +    maxItems: 3
> +    description:
> +      Must contain a list of references to DMA RX specifiers.
> +
> +  dma-names:
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      const: rx

How does this make any sense?

If the device can make use of three DMA controllers at once, you need 3
names. If it cannot, then just limit this to 1.

pw-bot: changes-requested

Thanks,
Conor.

> +
>    power-domains:
>      maxItems: 1
> =20
> --=20
> 2.55.0
>=20

--5gSPc2i/A8WI5ivx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapG1mgAKCRB4tDGHoIJi
0iiHAP94zOQvc2anyw/mmBqZvGqptkvLUUt0DY1ASYo5ypbzCAD/a4R9IE4owZ2e
TwBoDA0m6XZXiz2c1BP/Vw13/5Nmfwo=
=diCa
-----END PGP SIGNATURE-----

--5gSPc2i/A8WI5ivx--
