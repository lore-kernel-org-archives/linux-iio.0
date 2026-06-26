Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B7402B98;
	Fri, 26 Jun 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490361; cv=none; b=QCSqnyLu6TBOcqkF+KYuPDD/w+YwLHTvIMjnfzcBsEHXk8G2AFQHaGhYLJwJOirUHRszCTyxxvc0GYH+NiMGDUIHdomV/w20f23OpDZ7yUKBpmiQJLTxeSxEj3Dv9L52OHQtMfZAA9UK4nCPMQ5VOrt2VNNS9MIzneaMshNE+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490361; c=relaxed/simple;
	bh=Nultrl7mJxODWLO9R/jTUlXSH0aAIEl2SAMf3KJO2jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrNlAp29fDR6kgnfk1Xuhj2O2kEqEd4H9fah0WvE3e4YC0gaNOmr6wU+Nl3iS0kxZNisrr6j9cLc2Wx+TsQhrmihTzr15RvsdVOw7hUwfQ6FtmGjA0oWq7WRqVCPEgTsIiYswoVtqpM0vnaadAzT/gLl1HEjCcedcZjmYYgd4gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LxSJQM5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxSJQM5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1151F000E9;
	Fri, 26 Jun 2026 16:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782490357;
	bh=xcyphHnLR0StuSGBAIa8l2bjQ5FpL0S1+pAd1aOoyHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LxSJQM5xCWDSkYpaUSg7hnRF6TlhT6Y1xWFIqY89oZ/8FnhMe/SjNXEsUK/4/ehoy
	 Gn3AYmu55JIYss8t3+3pcOrKc7ek+KT9XUj4z4ulz9Ie4TQdeIxvTCbtwjlghpZL4d
	 qokj77G7JhQZHfXIUFLvtjWVl14VB/UtpcPedE3aQGx8gAdOuIHyVARtQ3sLNCeKVK
	 Wps0sDP5G1jNK5SrRJNob/Y3W8xCZPM9mo6SSLxp9QivVQY6OpgRSgCwK+gwv2i8jI
	 zmfkj7oFQFIRXf8PLbgviyOX4lH2DO/4XjYWUsTiI+OgtOoo+jJmwIPPgjBUK1jKUE
	 CZwfgob3q39DA==
Date: Fri, 26 Jun 2026 17:12:32 +0100
From: Conor Dooley <conor@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/8] dt-bindings: iio: adc: Add reference-sources
 property
Message-ID: <20260626-clatter-divisive-881344478b09@spud>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
 <20260625-iio-adc-ti-ads122c14-v2-1-ceb9b0b561cb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BItz65KatC+Bz2SN"
Content-Disposition: inline
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-1-ceb9b0b561cb@baylibre.com>


--BItz65KatC+Bz2SN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 04:55:03PM -0500, David Lechner wrote:
> From: Kurt Borja <kuurtb@gmail.com>
>=20
> Some ADCs have configurable voltage reference sources for each channel.
>=20
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v2 changes (compared to Kurt's RFC v2):
> * Drop maxItems.
> * Drop 2nd paragraph of description.
> * Make reference-sources plural since it is an array.
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documen=
tation/devicetree/bindings/iio/adc/adc.yaml
> index b9bc02b5b07a..12800737d4fb 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -73,6 +73,14 @@ properties:
>        device design and can interact with other characteristics such as
>        settling time.
> =20
> +  reference-sources:
> +    $ref: /schemas/types.yaml#/definitions/string-array

Either Kurt didn't use strings, or I didn't notice they did, but the
property is much clearer about how custom it is with undefined strings
than with numbers.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> +    minItems: 1
> +    description:
> +      Indicates the voltage reference source or sources for this channel=
=2E Some
> +      ADCs usually allow choosing between internal reference sources or =
a pair
> +      of external pins.
> +
>  anyOf:
>    - oneOf:
>        - required:
>=20
> --=20
> 2.43.0
>=20
>=20

--BItz65KatC+Bz2SN
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj6k8AAKCRB4tDGHoIJi
0hCZAQDWONW4YKrwFIHBv2gfr4pu/FqOFpQ7d/EfJ12liYjurQD/aE48TeCd1DzF
Flfw4QdE2T6LkUQZwQexmJ0SpMzbLAk=
=+LC0
-----END PGP SIGNATURE-----

--BItz65KatC+Bz2SN--
