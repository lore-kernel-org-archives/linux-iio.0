Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398D1F09B3;
	Tue, 27 Jan 2026 19:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769543365; cv=none; b=W+Piv6qbUh7pWRP71T/2ZfYg4C9pCF4f3LLsjhE/Xavya91MHItc5RmC67Phda2O+Nd9gz7Wkora5t4/A3SYvghPoqN52hnjteZQknDEqDUH2D+r3B7dIdds0Sfn2Gl1RcHrsQz7XGk++NdR74a2DTKJ03IKjwl3/PPTcLIFStA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769543365; c=relaxed/simple;
	bh=4/uUjf4/GufOtTdgVCwHb7grIVbnVhgExUt+Y2JxJrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrEDuTa+JgoSKhQUrO32JQ+7UXboaXCS+kbfLLBqJQoyUgzUArKlyka5qAhzfSFEirtcDl0iepF4TMMwcMSZSwIWApS+7GBeNIZtVI2FmghdH63yHp9VpjaKSfJlQCWzCSo0HivRO6GdRSu7pxILXXyQs0YhQbG+p8Ya28Jk0Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6xZ91xJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6xZ91xJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6630C116C6;
	Tue, 27 Jan 2026 19:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769543365;
	bh=4/uUjf4/GufOtTdgVCwHb7grIVbnVhgExUt+Y2JxJrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6xZ91xJzMy5lCcfwPb6aIRHZXwrvhDXKednT+UQUVwBcxYoIsSDw32XJ9Du70a6J
	 7L+pOD+VwuO3XMyAhqCQtAejGPuggZDaR3LF+6WbZULzPOuvOGdKvWpKO7WaCbsUfs
	 Vp4hwW4WGp6rmyR6o8hISAXrnV7hvqOjUMjaCTKXrHe1IjmB3O8TyvSa4hij5cwEA0
	 50eFQb8zPKtfLu/3FJfKilPPROVP1JmXixmubOXbZsfMvdzFYkK1e2xmInGe/LAQVY
	 7esxSRW6ga4/C7lL5g3CSeJkfqhorAMhVTNiswq/i4/ngdiWeQJ6EsUGK8YZ3YNUSk
	 SxHrIHRDCs11A==
Date: Tue, 27 Jan 2026 19:49:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260127-consonant-vividness-13707c7cf8f6@spud>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ENel2A2ld7ahsmtT"
Content-Disposition: inline
In-Reply-To: <20260127060939.3914006-3-o.rempel@pengutronix.de>


--ENel2A2ld7ahsmtT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 07:09:33AM +0100, Oleksij Rempel wrote:
> The Maxim DS4422/DS4424 and DS4402/DS4404 current DACs determine their
> full-scale output current via external resistors (Rfs) connected to the
> FSx pins. Without knowing these values, the full-scale range of the
> hardware is undefined.
>=20
> Add the 'maxim,rfs-ohms' property to describe these physical components.
> This property is required to provide a complete description of the
> hardware configuration.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v2:
> - make maxim,rfs-ohms a required property as the hardware range is undefi=
ned
>   without external resistors.
> - add allOf constraints to enforce 2 vs 4 items in maxim,rfs-ohms based on
>   compatible string.
> - drop explicit $ref for maxim,rfs-ohms to fix dt_binding_check warning.
> - update example in binding to include the new required property.
> ---
>  .../bindings/iio/dac/maxim,ds4424.yaml        | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml =
b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> index efe63e6cb55d..400afd8771aa 100644
> --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> @@ -27,9 +27,44 @@ properties:
> =20
>    vcc-supply: true
> =20
> +  maxim,rfs-ohms:
> +    description: |
> +      Array of resistance values in Ohms for the external Rfs resistors
> +      connected to the FS pins.
> +      - For DS44x2 (2 channels): 2 values required.
> +      - For DS44x4 (4 channels): 4 values required.
> +      Typical values range from 40000 (40 kOhm) to 160000 (160 kOhm).

Add here
maxItems: 4
minItems: 2

Are 40kOhm and 160kOhm actual max/min values, or just a suggested range?

> +
>  required:
>    - compatible
>    - reg
> +  - maxim,rfs-ohms
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - maxim,ds4402
> +              - maxim,ds4422
> +    then:
> +      properties:
> +        maxim,rfs-ohms:

> +          minItems: 2

Remove this...

> +          maxItems: 2
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - maxim,ds4404
> +              - maxim,ds4424
> +    then:
> +      properties:
> +        maxim,rfs-ohms:
> +          minItems: 4


> +          maxItems: 4

=2E..and this. The outer-most constraints should be in the definition and
the if/else bit just adjusts whichever bounds it needs to.

Cheers,
Conor.

pw-bot: changes-requested

> =20
>  additionalProperties: false
> =20
> @@ -43,6 +78,7 @@ examples:
>              compatible =3D "maxim,ds4424";
>              reg =3D <0x10>; /* When A0, A1 pins are ground */
>              vcc-supply =3D <&vcc_3v3>;
> +            maxim,rfs-ohms =3D <5100>, <5100>, <5100>, <5100>;
>          };
>      };
>  ...
> --=20
> 2.47.3
>=20

--ENel2A2ld7ahsmtT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXkWwAAKCRB4tDGHoIJi
0h8nAP9tMsqy0ql9+AwS4iH6tv8c+ZKRJ+neGd6+cLDiHYqu8wD/a4hQns3PXyBf
0XKTviXmwH5XQ1/Ad8QaaWYjv1VMIAc=
=8NZX
-----END PGP SIGNATURE-----

--ENel2A2ld7ahsmtT--
