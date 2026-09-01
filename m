Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA754494829;
	Tue,  1 Sep 2026 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285910; cv=none; b=rhEOCqjvMleweKCWB1aEehB5xbV1PK3/DYqnyfQImP3VNuKpc7ea9I4ttBFdT8vSnEh8QPazdJWKSsbWnSSOs9tj0S+S9LHkBtrnBGPzwg4eW8orks9IUPhqUWMjW5Djy0AqB7d+7Q5joB+P/4DIG9px7zYlzavz2yC4KfH+9Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285910; c=relaxed/simple;
	bh=iWGNiDS8ZCSgb2W9PN+r8+jRy+ytgHRSpAHm+4BsZDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUyYpb43VaBV3beIK2JCyeNaU01yesZI7saX0wVxeniPI/jaI+X3WMauW5grbEd3XrQGxZzB09o6xn1D2/L/SmYkiK0mgTxXO3GnIsy9DB1hdna44gjqFYxqwFrLBA/aYsuzvsdlNG2EQfkDpX4PoLwTRW3aupKUSapbclq8yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUxnMkoA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUxnMkoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355231F000E9;
	Tue,  1 Sep 2026 18:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285909;
	bh=BBpsF2dg6Vi508P3YPVHwpdk4fG6Hs4x5J/YjvAMH3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JUxnMkoAN0LATLcDRxh1ClGduoMWsqrBcLKwxGnCVCOl7Fq0hTCeoylSJqS0C7tDl
	 8kcxAynyY6czTIht1Q01S4LJkfFRNOvQSkEq++5Refek8Bl0aJE+9A2mBbaAaeTAh9
	 69x94vXVmayPJg6OGLes8i4YLvGxCKNLzaTxQPikm/qvKVDlSL1/Ey87NGueG00HNj
	 9scvlxenR9g9dvOZH8qqhXf9hZ3Wk3KsAhVCgh0xVPTDwF6byD1Z2/n9+qDGU37eSl
	 TrLmQtXqeLTd2Sl9uBE1J2amEFcN2eBqRD4B/7UT9Ux3ikX8le3OvO9uzNWx4fD/Kl
	 xZ2G+1xBxzB6g==
Date: Tue, 1 Sep 2026 19:05:04 +0100
From: Conor Dooley <conor@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, gregkh@linuxfoundation.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org, marcelo.schmitt1@gmail.com,
	danascape@gmail.com
Subject: Re: [PATCH 3/3] dt-bindings: iio: accel: adi,adis16201: add
 adis16203 compatible
Message-ID: <20260901-ambitious-eloquent-7dcb297a9e6a@spud>
References: <20260831184201.34416-1-shehryar.amd@gmail.com>
 <20260831184201.34416-4-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZZpjyQTJecju7TVT"
Content-Disposition: inline
In-Reply-To: <20260831184201.34416-4-shehryar.amd@gmail.com>

--ZZpjyQTJecju7TVT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 11:42:01PM +0500, Shehryar Ahmad wrote:
> The ADIS16203 has the same external interface as the already documented
> ADIS16201/ADIS16209, for the properties covered by this binding
> (compatible/reg, the DIO-based interrupt pin, and VDD supply), verified
> by datasheets Table 5, Pin Function Descriptions, in the respective
> Analog Devices datasheets. Some Auxiliary pins differ (e.g. adis16209
> marks a few pins DNC where adis16201/adis16203 use them as AUX COM), but
> these are not represented in this binding.  Add adis16203 to the
> existing enum rather than creating a separate file.
>=20
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> ---
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

Why is this below the --- line (IOW it won't appear when the patch is
applied)?

>=20
> Previously reviewed at:
> https://lore.kernel.org/all/20260812043506.456ced6d@jic23-huawei/
>=20
>  .../devicetree/bindings/iio/accel/adi,adis16201.yaml        | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.ya=
ml b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
> index b6ba7ad1a..3ce5fb1be 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16201.yaml
> @@ -4,21 +4,23 @@
>  $id: http://devicetree.org/schemas/iio/accel/adi,adis16201.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: ADIS16201 Dual Axis Inclinometer and similar
> +title: ADIS16201 Inclinometer and similar
> =20
>  maintainers:
>    - Jonathan Cameron <Jonathan.Cameron@huawei.com>
> =20
>  description: |
> -  Two similar parts from external interface point of view.
> +  Three similar parts from external interface point of view.
>    SPI interface.
>      https://www.analog.com/en/products/adis16201.html
> +    https://www.analog.com/en/products/adis16203.html
>      https://www.analog.com/en/products/adis16209.html
> =20
>  properties:
>    compatible:
>      enum:
>        - adi,adis16201
> +      - adi,adis16203
>        - adi,adis16209
> =20
>    reg:
> --=20
> 2.43.0
>=20

--ZZpjyQTJecju7TVT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcT0AAKCRB4tDGHoIJi
0tvPAP45Wmq5LZYcSkWoAbFDkgmxpROzXFrfYtlKu2EXOWtePgEA/BVpsZIUconw
AZI0y8fAA+PuagsZaCPFfFJ6nILeDAk=
=Ft30
-----END PGP SIGNATURE-----

--ZZpjyQTJecju7TVT--
