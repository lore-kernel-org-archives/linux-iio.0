Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7A8471D01;
	Wed, 22 Jul 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738629; cv=none; b=j7A+GNe8Ucc97WEuhGtuoExNG4o557zf3NNQ6gp5zM7FxI0OKLaz11vSho5OcWuD2wsp3aS2NZbP3I5/WNEPknyevLI7fk2ZUmDjUPwpw2Z0YfIqyIfyiaioP9WhjYrDviN7BnygLgX0x1G3yJkvFBMvL1c7ghua4ZVucZACO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738629; c=relaxed/simple;
	bh=w/dE4dOtvAImQfMAwO+VC9JdGfEyBx7DM59sk0T+9Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nX5zgieKr7/06WdRQLdvGmyJR1trJFxPaAOK6G1ZY8x8Y8yqyWjsllDxjmkd/kKGAAwNSqug0Ts0qZCEribdNMjZpbRC7Bq0Lph1QjXpwykylw+qXNInbZeDUmiwXKuB2jOEaDWcaVAhjcFKgVenlEoCI1WzB5GyoCFwzzId7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+ry8V1Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+ry8V1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B651F000E9;
	Wed, 22 Jul 2026 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784738616;
	bh=apdjeW/vdjJoC5JPmWMfGkDH5JxiX5Mxi5GisR4T+4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S+ry8V1Zu5ElKuoeDoTXyjYllXCN9c02oN0NoMbJePVcVnbEOZBLnV66tP8V/B9H7
	 JelCEAJPZaPQUcxEGcFa8OQd6+3yr/S1sFJ3IRUKjkaO7GrOfi/Fy5MQyV3PDUsU+p
	 DTxXb05SupH7TUi0x/6su1CHkaX4kRHODxgb6aMMJ4mfkXdhBs8KEHVu5/oRtzquc4
	 m0EoJIUUMWAhwXYPEdoYjXYe4BVzLOUPRXjd0CGoMK9C1gUgzHzxe5FDmG7fghE10f
	 J2jqHl+4Kj1/mcm09I3Pt1uVwmiKxJnBcrzGjUNsBGnaeSR+ZETmG+WX6HxWZu7mb0
	 N5RLpMuJ+QOSw==
Date: Wed, 22 Jul 2026 17:43:30 +0100
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
Message-ID: <20260722-vintage-handwork-eaaa304ed0b4@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>
 <20260722-quickly-drone-6a2a3b79249d@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XAReEJ5S0eD4GPUv"
Content-Disposition: inline
In-Reply-To: <20260722-quickly-drone-6a2a3b79249d@spud>

--XAReEJ5S0eD4GPUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 05:41:54PM +0100, Conor Dooley wrote:
> On Wed, Jul 22, 2026 at 09:54:17AM +0200, Janani Sunil wrote:
> > Read the generic spi-device-addr property when determining the hardware
> > device address. Fall back to the deprecated microchip,device-addr
> > property and then to the historical device-addr property to preserve
> > compatibility with existing devicetrees.
> >=20
> > The device address remains 0 when none of the properties are present.
> >=20
> > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > ---
> >  drivers/iio/adc/mcp3911.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > index ddc3721f3f68..3919a326b4db 100644
> > --- a/drivers/iio/adc/mcp3911.c
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -740,10 +740,13 @@ static int mcp3911_probe(struct spi_device *spi)
> >  	}
> > =20
> >  	/*
> > -	 * Fallback to "device-addr" due to historical mismatch between
> > -	 * dt-bindings and implementation.
> > +	 * Fall back to the vendor-specific property, then to "device-addr"
> > +	 * due to a historical mismatch between the binding and implementatio=
n.
>=20
> Jaysus, bit of a mess here.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> >  	 */
> > -	ret =3D device_property_read_u32(dev, "microchip,device-addr", &adc->=
dev_addr);
> > +	ret =3D device_property_read_u32(dev, "spi-device-addr", &adc->dev_ad=
dr);
> > +	if (ret)
> > +		ret =3D device_property_read_u32(dev, "microchip,device-addr",
> > +					       &adc->dev_addr);
> >  	if (ret)
> >  		device_property_read_u32(dev, "device-addr", &adc->dev_addr);

Actually, this should check the return value, right?

> >  	if (adc->dev_addr > 3) {
> >=20
> > --=20
> > 2.43.0
> >=20



--XAReEJ5S0eD4GPUv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamDzMgAKCRB4tDGHoIJi
0rErAP9xzGMBe/PDCdRNBEqlrXN6qq5/O1LBKuRSGQ+tQODO4QEAlIfFedeapUhF
LnAS/LyqgovzW4LJZ0brnAlmGtWwNQc=
=D8op
-----END PGP SIGNATURE-----

--XAReEJ5S0eD4GPUv--
