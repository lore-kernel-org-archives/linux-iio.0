Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035D52D23B9;
	Mon,  8 Jun 2026 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780939855; cv=none; b=CjaA49f0GHkvAB5s0TtZP6k5KisKlMugi1Ny+k1kw8kii2g5mT9h5avF9zoHM0GLoX6N/Rx0gYnOL9nib+bw5dv4eLExf6gdrovk6SL797FMJ0JIfvcYBnTP2qebN4/VGnYzkzfSlEeWIHhr3WvGHqVne3tA1lCZj1RaR6f5lIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780939855; c=relaxed/simple;
	bh=xaRCLUeeFiQVw1R7X3Bk4L9sca5W65yPaPkHtSqVsm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN6R8LEE4fyfhLRpbzlv/utFeBioQnxcGqMwadeb0SxJHQCG+Cs2VE8i1/KreXCnLzvqYaS1A6GylPc224frvHbQvD/j7Gzq86uQVWE2LlGDLd6oWtnoOMXSIpWU/XO4hw9XPRqGHveTgy8LLxq6WO1BmXnO+6nz7F9EsFqKXTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFX7P8Td; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFX7P8Td"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176791F00893;
	Mon,  8 Jun 2026 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780939853;
	bh=wj1z2Ftw+sgGKRj+NIWl5o3RU5HdxjtVfe2qpfcSpww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IFX7P8Td2ZSOEvbUyS6A7OJIJch01lZAd1jPEDGeA+xy9oVLdA48JNkDgSHfkShK2
	 UQhoTYGmyfLT6SMangP0KPTpSty485sOs5dLJ9bE5rpsgmozIYp3SpeLjTmE49cFgz
	 fGPn/+7oxtzvwXnrgTT7HkKZhVOoP7u94s7nsiyFHIE+EJXGAzp4CgD/IzzNcA85D3
	 hGR4RWVRvnM/9BCCuqLAF5kC0UZMCASEwkwf1UYcT4lJDOxGFKCGLmTwFgZO58o5xT
	 t/agY/nSOjwb2wZOdNZOfnz4WthgLcguYJl2938UUmTC31j0wpdz0zfEfhyxx6BNRb
	 0ZUCGRMAD+QLg==
Date: Mon, 8 Jun 2026 18:30:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mike.looijmans@topic.nl, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jorge.marques@analog.com,
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz,
	wens@kernel.org, sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: Update title and enum
Message-ID: <20260608-leverage-taunt-54a5164eb128@spud>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
 <20260607183542.368184-2-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xrTrwg6zCyeujvaw"
Content-Disposition: inline
In-Reply-To: <20260607183542.368184-2-jakubszczudlo40@gmail.com>


--xrTrwg6zCyeujvaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2026 at 08:35:40PM +0200, Jakub Szczudlo wrote:
> From: jszczudlo <jakubszczudlo40@gmail.com>
>=20

$subject: dt-bindings: iio: adc: Update title and enum

This should read "dt-bindings: iio: adc: ti,ads1100: add support for $newde=
vice".

> Add ads1110 into title and enum compatible for ads1100 driver.

And so should this.
Additionally, please explain why this device is not compatible with
existing ones.
pw-bot: changes-requested

>=20
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>

Probably your signoff should be "Jakub Szczudlo <jakubszczudlo40@gmail.com>=
".


Thanks,
Conor.

> ---
>  Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/=
Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> index 970ccab15e1e..4c43996b7ec6 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
> +title: TI ADS1100/ADS1000/ADS1110 single channel I2C analog to digital c=
onverter
> =20
>  maintainers:
>    - Mike Looijmans <mike.looijmans@topic.nl>
> @@ -17,6 +17,7 @@ properties:
>      enum:
>        - ti,ads1100
>        - ti,ads1000
> +      - ti,ads1110
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.47.3
>=20

--xrTrwg6zCyeujvaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaib8SAAKCRB4tDGHoIJi
0jbiAQDtpOcmvzAjJs3mf+y1iPz7xRduDUkpc8oSOJuo2OzBEQEAkfzmVRYrf9w/
Vjt6toU83B93ihJKpBrIc5kG6KW23AE=
=IKcT
-----END PGP SIGNATURE-----

--xrTrwg6zCyeujvaw--
