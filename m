Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E3471CF4;
	Wed, 22 Jul 2026 16:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738536; cv=none; b=rflYMN2KqhCPoNZyS/KGQyrpxQkDcb7B2Z9SWKabIiDs2HES1qm/LCB+NUhOTrZuCTHRy8wDsRokBAUt28jETm/mRbpFZiHQCee7sa4TtqCUFaNQkPvJUHVsdDhwj6aUuKqupy13G7xL76Lwsf/IImXWXPyh5OYE5vg6FGSzce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738536; c=relaxed/simple;
	bh=IFagrB00Yachu5fQE3L5vJMarJDBvtSMQpDDnyYcIbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJSwMGkn+oL4XMhYIrwOF/MVWM1F8tZv7mT41ry3eue5SUbjVXQcmb8g/WIZx3+0p4vIT/mfdFwjRgsUry2InkU7+l61hb790H6vSdpZpMbTie61CO2F5ej6+JdzooMqYq8qi7FFJPj6MYbSFk3476vnYxJGc3FPoykxoFJdPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JA/jWsYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JA/jWsYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6E71F000E9;
	Wed, 22 Jul 2026 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738521;
	bh=tZ+0meYxskm+tmV2fl/4jhmazvGqcrBuOUaB9oNmRpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JA/jWsYdIIa/TcyMoRj/NF5lYjWREpUzP7l8RxJ2nJ9H5ElIHH3ntfHGDCY48iwo4
	 nUtql/XWxwN6f9vWqq+Ifz5fCLy7CTR6Yq5Xiifd8SVWirjbl7IJagvuS1391DqasK
	 xldtMwCApvuARop+WghWbARJoIK9w9f3rdlhVoTIKfRsf1E06IBjOvfObOMFZqsCHI
	 LNvjUHzwZ7D4XR3+jZ2v/DfNjxxXMfNKy6aN5aiFIg2419UCODBmpTI6ZfA17xD0i+
	 +RYWEbm9UaN8t/hkZLjtcpH6q8D4NLSkKJwGePZ2fMu1LnPFevP4RY3iiDzO5Ml5gI
	 0gd6DU2o1amzQ==
Date: Wed, 22 Jul 2026 17:41:54 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 5/7] iio: adc: mcp3911: Add support for spi-device-addr
Message-ID: <20260722-quickly-drone-6a2a3b79249d@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AJCDWyaYMEfwNlGn"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>

--AJCDWyaYMEfwNlGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:17AM +0200, Janani Sunil wrote:
> Read the generic spi-device-addr property when determining the hardware
> device address. Fall back to the deprecated microchip,device-addr
> property and then to the historical device-addr property to preserve
> compatibility with existing devicetrees.
>=20
> The device address remains 0 when none of the properties are present.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  drivers/iio/adc/mcp3911.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index ddc3721f3f68..3919a326b4db 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -740,10 +740,13 @@ static int mcp3911_probe(struct spi_device *spi)
>  	}
> =20
>  	/*
> -	 * Fallback to "device-addr" due to historical mismatch between
> -	 * dt-bindings and implementation.
> +	 * Fall back to the vendor-specific property, then to "device-addr"
> +	 * due to a historical mismatch between the binding and implementation.

Jaysus, bit of a mess here.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

>  	 */
> -	ret =3D device_property_read_u32(dev, "microchip,device-addr", &adc->de=
v_addr);
> +	ret =3D device_property_read_u32(dev, "spi-device-addr", &adc->dev_addr=
);
> +	if (ret)
> +		ret =3D device_property_read_u32(dev, "microchip,device-addr",
> +					       &adc->dev_addr);
>  	if (ret)
>  		device_property_read_u32(dev, "device-addr", &adc->dev_addr);
>  	if (adc->dev_addr > 3) {
>=20
> --=20
> 2.43.0
>=20

--AJCDWyaYMEfwNlGn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDy0gAKCRB4tDGHoIJi
0gcIAP9p7QLrvHULCTbp+m0KiZDoToCng0aN92F3tZx/h7w8GgD8DixzPtqRL0vZ
Irm6CNsO+BVkqtgN/ejURNmrQhnorA0=
=AKHs
-----END PGP SIGNATURE-----

--AJCDWyaYMEfwNlGn--
