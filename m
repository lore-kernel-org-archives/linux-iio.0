Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1723002C8;
	Wed, 22 Jul 2026 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738720; cv=none; b=jbSqr8lDt4UE6LMV/X3WFUBZwzF7d/obRd0CiGmY3u+I2ophRBGbmmbV/mcbMLp0XUwXyYTvRPN7wFu7AwoQJCeEbTTkQONbXrqdfMTP+FBegJ9025BVNlFa7WhG8PWh2ycns7zCLpMfQpFwvGLDzx0+bBzhwSqmuLTP5L9uxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738720; c=relaxed/simple;
	bh=UKSu/98l29oWnHXmNZE6AqnpP8wzNFcgfW/LkW480AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vA+YMRVwgya2kkl977sqJYrDfyuFkBDtG/CkPvIrHwABhPPem6RP1rmxofty9MSkeM+I7zN0orYt2DQtiyfPG8378cYKuHgUpu1vF43eJyYm08DFkxcw8MTuNTicaz6+wQbCbAMHtqMzndBoFAtw/ojTROGugkYCJmdXBOftb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3HNK9jw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3HNK9jw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2111F00A3A;
	Wed, 22 Jul 2026 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738709;
	bh=QbkBpIQcNQohMGeDvjiAc0s7tZBvSrmmZfhHeUo9ERY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W3HNK9jwJg4xgwywJ3U5Y4+cdfgypdOAlemv68Ys9lC7z9dxYveF+cGuuG71QmTQZ
	 QJp5IcAs14VAdA9v6BSrBgPv2FrnjuLmZIy3Wjlcvt1j6AA/r2v1J2e1cIqn9heQej
	 mpMLAa5Q2I1IVHdlj8G/fwR/bxQ9XlWsvAkILaygtO4iW1zSVxIKiAdWne/mZEHYHT
	 EWOqhIWDWW1G3LrTpaf4aB/2303rC/h/rLGOXnSR1reXbsVXHx4yueVT7Pts+zkEgB
	 jaVyrHWIag5F+29H/kOfSuHoWbOxFP/eeHdvYgNSLl13Fw+q5I/e07tjiFQDahpNqB
	 4bHMaSZ1vRvHA==
Date: Wed, 22 Jul 2026 17:45:02 +0100
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
Subject: Re: [PATCH v7 3/7] iio: adc: mcp3564: Add support for spi-device-addr
Message-ID: <20260722-violet-dayroom-f1ec88771772@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-3-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o4/2wA7Y+HIrX7pW"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-3-7781cd74ad75@analog.com>

--o4/2wA7Y+HIrX7pW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:15AM +0200, Janani Sunil wrote:
> Read the generic spi-device-addr property when determining the hardware
> device address. Fall back to the deprecated microchip,hw-device-address
> property to preserve compatibility with existing device trees.
>=20
> The device address remains 1 when neither property is present.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  drivers/iio/adc/mcp3564.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> index 36675563829e..71deb05e878e 100644
> --- a/drivers/iio/adc/mcp3564.c
> +++ b/drivers/iio/adc/mcp3564.c
> @@ -1122,7 +1122,9 @@ static int mcp3564_config(struct iio_dev *indio_dev=
, bool *use_internal_vref_att
>  	 * addresses are available when multiple devices are present on the same
>  	 * SPI bus with only one Chip Select line for all devices.
>  	 */
> -	device_property_read_u32(dev, "microchip,hw-device-address", &tmp);
> +	ret =3D device_property_read_u32(dev, "spi-device-addr", &tmp);
> +	if (ret)
> +		device_property_read_u32(dev, "microchip,hw-device-address", &tmp);

Same on this one, shouldn't it check the return value so that the below
check of temp > 3 doesn't just pass with the default value of tmp?

> =20
>  	if (tmp > 3) {
>  		dev_err_probe(dev, tmp,
>=20
> --=20
> 2.43.0
>=20

--o4/2wA7Y+HIrX7pW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDzjgAKCRB4tDGHoIJi
0iivAP4xx5UiXvW3340sAe2/uks3I8mKJ106TzV6e++z5VyK8QD8D6LHMl4fTsrF
P0isMIcFcOsqdqYw2XqfQPy4qop9tg4=
=aOJq
-----END PGP SIGNATURE-----

--o4/2wA7Y+HIrX7pW--
