Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5A3275AF0;
	Fri, 13 Feb 2026 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006525; cv=none; b=oSjfFgo1XieRUIBn0meGorEo85giEn5Tt/gqlU4aMx7m5rwS7BBflK9uJ6solb6HjHFOKR9n93tGgOWl+ibBkCWSz8M5vVyt7Kl0q0sIcHxIcxtQAurgpVs5SXCnuOr/ynCtpRydUne65O2688bcL/W1NKpBmD7sv65UbtXjw/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006525; c=relaxed/simple;
	bh=cUHiVUePBSFKNjII0iPrYK01E3P8iA2vgxwjV9dSxak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU24bKw0VZ/IvaIRu7MIFEJK50g1fG2uiYXbe2SeAHbSZJ+SUESWjotzKv91PIGYDdQEf5zWogSNFEoWUJZcU1x+tao5z0E95F0GX7nMmXFfEp3VrHPTPIFMqxrbhDnNlkttPtTd+P/6Xohr5eyKoF7HnjV9FNrhPFl46kCXUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZqh0YrY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZqh0YrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E9EC116C6;
	Fri, 13 Feb 2026 18:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771006524;
	bh=cUHiVUePBSFKNjII0iPrYK01E3P8iA2vgxwjV9dSxak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZqh0YrYPM4eSKEEDKwneD7sB0Sk+8dN04DcsNsE4MKDZUIx4Y9I4JjExAQRUYhFE
	 v4+KGHqwuiWS8DvXbfgMll86wWW11dQrqP4/gYFF3lciuICTiTSaIMNtNI2TxYTNdy
	 V9P4cN6Q1rHyKOI30acNB/PWsI4fE4qHXXd8x9M0dxCkkJTqBYyHyobGEg0Jph+82x
	 guLoXihX+FQ8SPdppivS/guT13gzV4jf/BjjTWT26q5znNb5jaPLoyLewZyIxIpFOs
	 /i09fAH5FQHn/pVvWdTSMt+1jh8ZeHfzheTFKlxc3c157y0HtGzTDTuZMA3lyjTDh/
	 64B+3QSV3CAug==
Date: Fri, 13 Feb 2026 18:15:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] dt-bindings: iio: adc: adi,ad4080: add support
 for AD4085
Message-ID: <20260213-shorts-fiscally-f3c59d8429b6@spud>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
 <20260213144629.16001-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dAptl5weIVbfX5DM"
Content-Disposition: inline
In-Reply-To: <20260213144629.16001-4-antoniu.miclaus@analog.com>


--dAptl5weIVbfX5DM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 04:46:24PM +0200, Antoniu Miclaus wrote:
> Add device tree binding support for the AD4085 16-bit SAR ADC.
> Add adi,ad4085 to the compatible enum.
>=20
> A fallback compatible string to adi,ad4080 is not appropriate as the

Is citing 4080 a copy-paste mistake here? I assume you mean to reference
a different device in each of these three patches, each matching a
different accuracy?

> AD4085 has a different LVDS CNV clock count maximum (8 vs 7), requiring
> different driver configuration.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> No changes since v1.
>=20
>  Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> index eeabf99f9a12..106267aee195 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> @@ -30,6 +30,7 @@ properties:
>        - adi,ad4082
>        - adi,ad4083
>        - adi,ad4084
> +      - adi,ad4085
>        - adi,ad4086
>        - adi,ad4087
> =20
> --=20
> 2.43.0
>=20

--dAptl5weIVbfX5DM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaY9qNwAKCRB4tDGHoIJi
0vOTAP9/72L7WGqtwFkZTPFZa1L1aBut29f4zBtzm65/wBhJNgEAiVtlFudWs77P
fwvBrAjQxDq1Nu428rADjMFhdUHwygU=
=rXhA
-----END PGP SIGNATURE-----

--dAptl5weIVbfX5DM--
