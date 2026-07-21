Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F56E46C4D0;
	Tue, 21 Jul 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784649136; cv=none; b=Ba1IkNvBbX5nUt2U2sz7wkW6J/72Q6wtjCLMqgugs/PT3e0CUaEYsxVCTg+ymWZa9k0R4N6E9G/EQSh/m+MsGBteWDjVMj//6yK3Yzd2b7ZZvsIGPLMLIR3VUAnMIHjnm7NJNmmgxU5485sZGyIx5v2cdgX9d1cnEmj+AwdzUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784649136; c=relaxed/simple;
	bh=WaqO+0Sd6OBxbgkZaZdirty+9SuMRBYzygP2XymE0xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9DOVhDnV31YU+TLC3KLmaSpO8sg2dXQa/47SLeZrvCQMWW0E3EIZ7VqatZ3ZGgLZn5/iP6O7DzLRtrhs3VZdU/cw3KatFYt4HTZhYkntlCdNBmyxtSrOf52QJYlIEiZH7vSS6t7k1FQBIrh09puTk7In9AieNr95p+Qc0Vl/IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nH4WNPHm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nH4WNPHm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931741F00A3A;
	Tue, 21 Jul 2026 15:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784649135;
	bh=64doCOkg+HqChPkn3H1nVLM/h0aZW7xzC2i+AdH3pSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nH4WNPHmovzsbaB3LEqCejbf+3qePDZpiEEE0UccyUJqlvgXMN5MJlGKPFzgF+otD
	 ubdVvpEXrZs+kVBBFaLeno1pAg8hVdNpi63wOgQlgogXFgsU0LxQu4+5MBgPJ/YXTU
	 3hqaNSN4SfwO3PKDylg6mxiSLYH9ocTP6AJxZu5qj9ELW54PcGFsGWfkGjke+CxeNR
	 YHS+m1jJ677TYOMk8GA7q+THhh2TuEt2XuU+7oNbow+nwCt/axCfITSvG3XothHB3D
	 ZVhAzb6xHxFV8lPBcPlhCeBBMHL1fFxV2QhEE2GARr1z4g3+PxeKI8cDTOsZAayyxB
	 ZupFYRmJl71mg==
Date: Tue, 21 Jul 2026 16:52:10 +0100
From: Conor Dooley <conor@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260721-clustered-jolliness-30d70a2acc49@spud>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
 <20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0I7ziWDQvqA7a73S"
Content-Disposition: inline
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>

--0I7ziWDQvqA7a73S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 04:47:11PM +0800, Kim Seer Paller wrote:
> Add device tree bindings for the Analog Devices AD5710R/AD5711R
> 8-channel 12-/16-bit Configurable IDAC/VDAC.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++=
++++++

> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: /schemas/iio/dac/dac.yaml#
> +    type: object
> +    description:
> +      Represents the external channels which are connected to the DAC.
> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        items:
> +          minimum: 0
> +          maximum: 7
> +
> +      adi,ch-func:
> +        description:
> +          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
> +          output or CH_FUNC_CURRENT_OUTPUT for current output.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [1, 2]

Please make this property a string.

--0I7ziWDQvqA7a73S
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCal+VqgAKCRB4tDGHoIJi
0in9AP95r/C1M8EaGZVwIe1PvHCkbd9PTmHZTrzC9JfHVhM5aAD/WL3zIRFXi2Jm
/E5Et8q/OGs5u/iR2tim377Jt4kJkQA=
=6URQ
-----END PGP SIGNATURE-----

--0I7ziWDQvqA7a73S--
