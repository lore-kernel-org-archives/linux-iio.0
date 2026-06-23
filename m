Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBD6311968;
	Tue, 23 Jun 2026 17:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235606; cv=none; b=lkjqM9R2TC9i8km6bZbxjkH5EikwyKiNNSAgBaDnDVEGFAcZOf0JtSPS8KNngNGIDBCa8v6SvyM4OBKhR30UAup+mbKOKtH1eS9Kft31ZT9kAAbQShw0itsVA8THaiR8KiJbiLRJemhowrMOSl2fnF/WCgua6gg8vDXiYsqFdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235606; c=relaxed/simple;
	bh=775RyjAhTi/Y0SVRpHHuxL2qSH0D28OpgK//YNzq75I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fI0AQRFKELKNHDPjL4b4a0oAGUpQW0yv+ZHOBD5qLAqw2XbGhK2l6J04VGCyfZsCuYAqup/TOSidCRYyjSVwgKY50wXy1yVKtGEUlpOt/vNRNzmZHDqUFyKDhxUP5EkxLqSdrUhv50lPYgr28H2+dc9wyDOACLevnYVkBQQ3aP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RotgOa4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RotgOa4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E441F000E9;
	Tue, 23 Jun 2026 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782235605;
	bh=n0OabhRPaKb8ZtVjW0dZ5Ep+A9j/jCXntRyyMO7DeCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RotgOa4Nm+9+wWbya9PzPZu80TPtMmKQw3Ui0AbTe1Plw2UPSJtnyTGmyxBx8aznh
	 4t3ZDIexYyM/VGwZEzX7d8VLmp17AImurWuIb0LGjdY/4JT4cU1l5bakML3JuBxLBx
	 wcIogjysKhSxCeL1bHMgMtEdLbaZhy9umzw7/He+nrmR63d531dKFP58qghuhe4Oss
	 NPDehHsd+rvmgI69mBbESvL7sK+sJmszYiDPur2xfOH828T3uYAwc5UZf3aN0OHQDt
	 MotKIK39Vpdq7iSbBxlMX5oOWAO5ITAJUNJTWTsgacDBnHPavKcD/PmUFuaV3N10EI
	 acaI2aPflr+5w==
Date: Tue, 23 Jun 2026 18:26:39 +0100
From: Conor Dooley <conor@kernel.org>
To: Varshini Rajendran <varshini.rajendran@microchip.com>
Cc: ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, srini@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 01/12] dt-bindings: iio: adc: at91-sama5d2: document
 sama7d65
Message-ID: <20260623-swiftness-catering-6884c3a58715@spud>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
 <20260623105944.128840-2-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bWWrdvlOUOdbawuY"
Content-Disposition: inline
In-Reply-To: <20260623105944.128840-2-varshini.rajendran@microchip.com>


--bWWrdvlOUOdbawuY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 04:29:33PM +0530, Varshini Rajendran wrote:
> Add dt-binding documentation for sama7d65 ADC.

Commit message is missing an explanation of why a fallback is not
suitable.
pw-bot: changes-requested

Thanks,
Conor

>=20
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.=
yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> index 4817b840977a..e8a65fdcd018 100644
> --- a/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama5d2-adc.yaml
> @@ -15,6 +15,7 @@ properties:
>        - atmel,sama5d2-adc
>        - microchip,sam9x60-adc
>        - microchip,sama7g5-adc
> +      - microchip,sama7d65-adc
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.34.1
>=20

--bWWrdvlOUOdbawuY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajrBywAKCRB4tDGHoIJi
0jM6AQDUdgx+Qm+a5ugJzb/Gn79+XAaFjUqEMNYBMSFtptCA6gEAj82jix8YsxqH
fgYFWhFEg5ve5yF6iKFTwp5ik+Oj8AM=
=HOgm
-----END PGP SIGNATURE-----

--bWWrdvlOUOdbawuY--
