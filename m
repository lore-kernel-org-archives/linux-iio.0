Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8098625783A;
	Fri, 13 Feb 2026 18:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006584; cv=none; b=fHfsaDtW8N/HKmDWi0EBcgcwBtkaX28waGPwR1tSzGRZvt6s9UCwNcr8SOdxcylDu4t3v6gWJiFlRdLG5iBAVCu1VojXCvOwrWLkhvHuA3fCQLcsdWT3MTN8frgaNsL30zghknhLEBjqR6uQfomXfbiD/66JL0x/qi8DVZe/TbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006584; c=relaxed/simple;
	bh=2IhDcyJ5+RyqvRRa/f8RVx1r+vG9fWYxZtamksKEahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbafVQW9SDZihkQZy9RNney/oEKcYdI+TJ6EWhOzTSMkwHB0DwtigzijXz+vflq+mtXTRR2Odx965onpkSDZwy+5P1cau2BREst1vNu9CQo3rcAwXjwoKjttS5vtRBW9kSUF/Om16mcZEzJAYzSPUb/5uFKzuzLGX5+rgzfnv3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRcvCRo0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRcvCRo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C46C116C6;
	Fri, 13 Feb 2026 18:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771006584;
	bh=2IhDcyJ5+RyqvRRa/f8RVx1r+vG9fWYxZtamksKEahw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RRcvCRo0dWdIoJVuXO/R81Ea7IHYLQ0zBRFi+usYFOMLpVX+LHLAx8IT5HcHJGfb2
	 3r542kSTcd1zbpH8VMrdyNN386vKkNpx+ZGNqHEzWdIXisRFxhLY1Qr6/X6FXK69kI
	 lGNb6cMt5YkpUp/uIW2UG33ODRQ34N0lg5cYsJE7AMulfddVozqNob4mxJ4nMsWh6a
	 j4irToJO7wQRmFrclux3wycx+uzemkyDjP4Yju42XmOKDxrKFXZ3DjVFU7v8o4f/VD
	 kgArQd67Z4JpwU9a2MuiAOtLMUGHiP4NuD6P7vCFrbAuAUsgEYXqoR09gF4FwP7//1
	 DqQV2hU+WMwlg==
Date: Fri, 13 Feb 2026 18:16:19 +0000
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
Subject: Re: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad4080: add support
 for AD4088
Message-ID: <20260213-senorita-surrender-9336a60b5f7a@spud>
References: <20260213144629.16001-1-antoniu.miclaus@analog.com>
 <20260213144629.16001-6-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HcvIetrB/Fx8qSYR"
Content-Disposition: inline
In-Reply-To: <20260213144629.16001-6-antoniu.miclaus@analog.com>


--HcvIetrB/Fx8qSYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 04:46:26PM +0200, Antoniu Miclaus wrote:
> Add device tree binding support for the AD4088 14-bit SAR ADC.
> Add adi,ad4088 to the compatible enum.
>=20
> A fallback compatible string to adi,ad4080 is not appropriate as the
> AD4088 has a different LVDS CNV clock count maximum (8 vs 7), requiring
> different driver configuration.

Same here, as your driver patch says:
|Add support for AD4088 14-bit SAR ADC. The AD4088 has the same
|resolution as AD4087 (14-bit) but differs in LVDS CNV clock count
|maximum (8 vs 1).

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
> index 106267aee195..79df2696ef24 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
> @@ -33,6 +33,7 @@ properties:
>        - adi,ad4085
>        - adi,ad4086
>        - adi,ad4087
> +      - adi,ad4088
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.43.0
>=20

--HcvIetrB/Fx8qSYR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaY9qcwAKCRB4tDGHoIJi
0gguAQDBJDshx1AxkMQfTrGw6GuO5FRDva/0vwPz8848LuO5AQD/SEZ6tuve/m+i
Hn7tUkZbgIeVA9ujRIgVJRRGUG74hgY=
=VjbF
-----END PGP SIGNATURE-----

--HcvIetrB/Fx8qSYR--
