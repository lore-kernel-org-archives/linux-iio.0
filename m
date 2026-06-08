Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5606330307;
	Mon,  8 Jun 2026 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938732; cv=none; b=rt3FpVcvkUKPCm6TLlvvV/VFQH0Jlcr2stT/A+nuAHzunRNl2rAdwacKA35mTn2jJ/txmDLmRX8pgv5BtZcgXZB/K48bLisHBsxMSRIFqwrTnk1G5+FjsXEbaizbIhotR/E9apnPmlHEDN6s8UDSOsDjmeobwULgdh9nVnI24P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938732; c=relaxed/simple;
	bh=roO0q2NA0hqIfkSNiuLcww0RGric+vlE5VMTRsvys1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+y31TK6mHIvIuhn6TG1OqANQ1+/NJ5DMspCTMoJmesFA1SG4p84tqtAfmrcyxeHbnL1d+eJEAGLpX5G39L6TYm8M/rP5tGlgVK+/XYLR7T+hASDAa6B1xbK9wy5AuYLctWMHHbc4A6H2Fx+IcGoebwATf/7ziG4ocdhbAJ6r3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUgdTd0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUgdTd0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE6A1F00893;
	Mon,  8 Jun 2026 17:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780938731;
	bh=mcJ3rg/6j3zmSyzJlFFskmupYtzcGwCdVBCGTpSDsNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lUgdTd0v+TvjNJH6hbTPKkoNK99tHarljjURkb1M4t+e89yW2i4GQco/8p1gGseEy
	 BQ+NJVJt+qDcYMa8IOV88160R/EElTm6udSp70Lxw/989jM+Cvo7p96J9xaX/2wfcC
	 XGOhHcNhh9V9qUgIHvUnWEyBLiszs2Os7ZxB5I0moprq/xoadAWq9mCERUQA0eT70W
	 aIIC4NPsXa6IshexAhE5URTpxQrzDaBk+tFBqqi/XEFzFiT6UV7X5ziciAYkHLvepm
	 f0QtIJU+2sc+qAlEsH6NFVYGPFPXq2kJsq68bj/a12O3LMrCmAaimzpYuyL5swHquK
	 F1Ve9UOP021fA==
Date: Mon, 8 Jun 2026 18:12:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: ti,tmp117: add binding for the
 TMP119
Message-ID: <20260608-scrambled-quack-7833e0348830@spud>
References: <20260608-tmp119-v2-0-30c3537d5097@bootlin.com>
 <20260608-tmp119-v2-1-30c3537d5097@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n2Onr6CqXwKhAuw+"
Content-Disposition: inline
In-Reply-To: <20260608-tmp119-v2-1-30c3537d5097@bootlin.com>


--n2Onr6CqXwKhAuw+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 06:00:24PM +0200, Romain Gantois wrote:
> The TMP119 has the same register layout as the TMP117, and a better local
> sensor accuracy. Add a compatible for it.
>=20
> Use ti,tmp117 as a fallback compatible for ti,tmp119.
>=20
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
>  .../devicetree/bindings/iio/temperature/ti,tmp117.yaml   | 16 ++++++++++=
+-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.=
yaml b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> index fbba5e934861c..d12dfef315b6c 100644
> --- a/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> +++ b/Documentation/devicetree/bindings/iio/temperature/ti,tmp117.yaml
> @@ -7,19 +7,25 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
>  title: TI TMP117 - Digital temperature sensor with integrated NV memory
> =20
>  description: |
> -    TI TMP116/117 - Digital temperature sensor with integrated NV memory=
 that
> -    supports I2C interface.
> +    TI TMP116/117/119 - Digital temperature sensor with integrated NV me=
mory
> +    that supports I2C interface.
>        https://www.ti.com/lit/gpn/tmp116
>        https://www.ti.com/lit/gpn/tmp117
> +      https://www.ti.com/lit/gpn/tmp119
> =20
>  maintainers:
>    - Puranjay Mohan <puranjay12@gmail.com>
> =20
>  properties:
>    compatible:
> -    enum:
> -      - ti,tmp116
> -      - ti,tmp117
> +    oneOf:
> +      - enum:
> +        - ti,tmp116
> +        - ti,tmp117
> +      - items:
> +        - enum:
> +          - ti,tmp119
> +        - const: ti,tmp117

Indent here looks undersized, is that just the diff being weird?

> =20
>    reg:
>      maxItems: 1
>=20
> --=20
> 2.54.0
>=20

--n2Onr6CqXwKhAuw+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaib35gAKCRB4tDGHoIJi
0q9EAQDXw0FehFMuPQTiW4ya4WniKMC0Ac1jvUixsztl3oFvjwEAvv7bd14yBTv/
DHdMoeBZwZldqIYscdO0HDVUCzkhOwE=
=N6OK
-----END PGP SIGNATURE-----

--n2Onr6CqXwKhAuw+--
