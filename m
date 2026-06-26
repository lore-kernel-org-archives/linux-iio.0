Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CC3FC5AF;
	Fri, 26 Jun 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490459; cv=none; b=knzDeiM9Agnn75OThpOywLI1TZD8OMyDkw/8hwXxxGjGCDmWZl23ZcDWxnGaa/ygA4SXm/dlffCGUq9a6ZsxnWbtvYexCkuInUgzZ0QhCl/0jAtnwn4k3sWE1Xmf32bPMZzg1lB2yOwbzCy4zzvyrLu7toXrjX5R3a9D5gSaad8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490459; c=relaxed/simple;
	bh=hqoAxgjOBb7DeZi0ZnD/zVWfw9EJ4X+/v4sn/rcmXVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3cInd6W4a8HgaxLL5BfD5z1TI1a3u1OtJkneFUbcabFeKyOZuFqpKA8BKcy9eUSEWCn/7RYUT3pj/rJ8VMYvTM57F9rk1/1t6fBUfo5Q2J3MPaFw27HBVHAt/rRYrpPTjJRRQSyK/YS4odyTC1A8PaPlRcbfeDgNL2D8bCCvNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRkCFVVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRkCFVVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897FE1F00A3A;
	Fri, 26 Jun 2026 16:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782490458;
	bh=hmQYpZr1kNgAh8+TxXD7C1f5HU1OHqvs610DYKmDmsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HRkCFVVzZBAUA0dka6B1C3PNwsoLydW4F0fFeIzsX9Q0PDyHvjjgGHGfxdiN1JjYx
	 M0VEFxPeDYBNA7Yy5JuZWfj2iO5jknteZkh9mJgiFzGZDezdOVGXx0eJbgXRTxFfxQ
	 6AYSPOy3rfvdwhCAqmp8DCZik5f4R8DyrLQuiztEZ3eBXijm0ooG0SMUbfkDQfhy71
	 hRa82x8nklqMSwbxa81JbIGsDLeIcVhsH88DtyqnWD9sDXd2TlHZyxYPmvBcARIen9
	 aBMuxpvzDDN9ydz47Q6Kv92YyPm5mmlOEu1Noff01DIUP4dCmyfhz8xcXv+ueK7YIH
	 +sGWTii3Qrb+w==
Date: Fri, 26 Jun 2026 17:14:13 +0100
From: Conor Dooley <conor@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: iio: adc: add input-channel-rotation
 property
Message-ID: <20260626-retinal-thrash-1095940e36ab@spud>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-4-ceb9b0b561cb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1Q3eodbu6e6uJls3"
Content-Disposition: inline
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-4-ceb9b0b561cb@baylibre.com>


--1Q3eodbu6e6uJls3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 04:55:06PM -0500, David Lechner (TI) wrote:
> Add a generic input-channel-rotation property to adc.yaml. This is a
> feature seen frequently in ADCs that are designed to measure resistive
> loads, such as RTDs and strain gauges. Enabling this can reduce offset
> errors by swapping the positive and negative input channels on every
> other conversion. This can have side-effects in timing and filter
> response, so it is not always desirable to enable this feature in some
> applications. Therefore, it is best to make this a property that can be
> enabled or disabled in the device tree.
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v2 changes:
> * New patch.
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documen=
tation/devicetree/bindings/iio/adc/adc.yaml
> index 9ec1f447b565..3d52c00922c9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -81,6 +81,13 @@ properties:
>        ADCs usually allow choosing between internal reference sources or =
a pair
>        of external pins.
> =20
> +  input-channel-rotation:
> +    type: boolean
> +    description:
> +      If set, the positive and negative input channels are allowed to be=
 swapped
> +      on every other conversion to reduce offset errors. This is also re=
ferred
> +      to as "chop" in some datasheets.

"allowed to be swapped" means that this property says the feature can be
used, but userspace may have to be the thing that ultimately turns it
on?

> +
>    excitation-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
>      description:
>=20
> --=20
> 2.43.0
>=20

--1Q3eodbu6e6uJls3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6lVQAKCRB4tDGHoIJi
0gYVAQDAEAq8+uIUw1RpI4nSmRZAGMsiDR5lZ5NCQwD4B4HmkQD6AthrYpxAQRKH
ZzsuoxRVMyNjY2Vlrz3VX/1DDxN32ww=
=//Xl
-----END PGP SIGNATURE-----

--1Q3eodbu6e6uJls3--
