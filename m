Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631A244AB7A;
	Wed, 22 Jul 2026 17:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740374; cv=none; b=rN35Ln/vxXudepUwI404zPb9uhA7iigJ1l0ImdIgh/Dn17WqQwLvIJmlB5gKK+Rog4KzY8P7rrDSgpDqjRe6jisrjPHcH8wnr4Mbzh+qbFTfsdqfRLGUuFwpzMn0FYIsxW5NvAVKqECkSaTuADt5aKrUMVs0CdlLAVZC8ISyULQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740374; c=relaxed/simple;
	bh=/1YX3bwxlajlhjhv1vW8e1ZN3loAApww/cYzf0JJeGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8HaAxYojBGM7KZbM7gtagiDHrNu6CTw25XMG34fC7TrdQaCHnmfPAMO0QEwF8vojVBEiJKzJUcXBwBrNIwqxPMw6gbXj4w5dQuD/UhuRbw8zxTQqnt0pYvUc+PfQ+QfYj5ZHYMfVSTLOCsdCm01Z1v80IFllnYF2T2ltwmJZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkhxCEDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkhxCEDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE9F1F000E9;
	Wed, 22 Jul 2026 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740361;
	bh=8bgLXWfwE4nFVG1YPsFmk/a0Gn9ZwXWD+5m+sYroCU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TkhxCEDA5AtN2xqidm23k69FwygPyK9VtRXlPu1iWbS1ZPQH5qS+fa2wH0xML//lA
	 80Vp6QdqS4xNpjN47Z6nBeJPv3Lpc3d+gIo4FLwzVGeRAfvo6F8LV/IBzWdVlZ3Z1i
	 c+qusg9mZmiGHe3RKMeTftvpQXK38F3tk//BKMg0AX4TSMamL0tAs/AJw4xaPs4rYs
	 6TYrecjI1fH1VYvbwKRy/7PGzL7HW9k22Q3s9CljfdARG+2SQxGWUmf44jgnNbYbMC
	 MiS9QA7fzbuuJ7eK/zXmkYhkH2l91cHjidCRjE3c1Ttv5hSVde72gKyQNefZ1TXMPk
	 cy6UHAv5R9ASQ==
Date: Wed, 22 Jul 2026 18:12:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Marius.Cristea@microchip.com
Cc: janani.sunil@analog.com, corbet@lwn.net, linux-doc@vger.kernel.org,
	robh@kernel.org, andy@kernel.org, nedo80@gmail.com, kent@minoris.se,
	Michael.Hennerich@analog.com, jan.sun97@gmail.com, lars@metafoo.de,
	conor+dt@kernel.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	skhan@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, p.zabel@pengutronix.de, jic23@kernel.org,
	marcus.folkesson@gmail.com, krzk+dt@kernel.org,
	linux-iio@vger.kernel.org, broonie@kernel.org
Subject: Re: [PATCH v7 3/7] iio: adc: mcp3564: Add support for spi-device-addr
Message-ID: <20260722-trickery-unglazed-f51a23dc3842@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-3-7781cd74ad75@analog.com>
 <20260722-violet-dayroom-f1ec88771772@spud>
 <3b5253f88b8363727dedee9481212e5be222bc9f.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5vqZUIbKn5YO3NPT"
Content-Disposition: inline
In-Reply-To: <3b5253f88b8363727dedee9481212e5be222bc9f.camel@microchip.com>

--5vqZUIbKn5YO3NPT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 05:02:28PM +0000, Marius.Cristea@microchip.com wrot=
e:
> On Wed, 2026-07-22 at 17:45 +0100, Conor Dooley wrote:
> > On Wed, Jul 22, 2026 at 09:54:15AM +0200, Janani Sunil wrote:
> > > Read the generic spi-device-addr property when determining the
> > > hardware
> > > device address. Fall back to the deprecated microchip,hw-device-
> > > address
> > > property to preserve compatibility with existing device trees.
> > >=20
> > > The device address remains 1 when neither property is present.
> > >=20
> > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > ---
> > > =A0drivers/iio/adc/mcp3564.c | 4 +++-
> > > =A01 file changed, 3 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/adc/mcp3564.c b/drivers/iio/adc/mcp3564.c
> > > index 36675563829e..71deb05e878e 100644
> > > --- a/drivers/iio/adc/mcp3564.c
> > > +++ b/drivers/iio/adc/mcp3564.c
> > > @@ -1122,7 +1122,9 @@ static int mcp3564_config(struct iio_dev
> > > *indio_dev, bool *use_internal_vref_att
> > > =A0	 * addresses are available when multiple devices are
> > > present on the same
> > > =A0	 * SPI bus with only one Chip Select line for all devices.
> > > =A0	 */
> > > -	device_property_read_u32(dev, "microchip,hw-device-
> > > address", &tmp);
> > > +	ret =3D device_property_read_u32(dev, "spi-device-addr",
> > > &tmp);
> > > +	if (ret)
> > > +		device_property_read_u32(dev, "microchip,hw-
> > > device-address", &tmp);
> >=20
> > Same on this one, shouldn't it check the return value so that the
> > below
> > check of temp > 3 doesn't just pass with the default value of tmp?
> >=20
>=20
> Default hardware address is 0x01, unless a special order with custom
> hardware address is made. I think is safe to try to communicate with
> the default HW address.

Ah, sounds good so.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--5vqZUIbKn5YO3NPT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamD5/wAKCRB4tDGHoIJi
0vzqAP4mqLpKsej/7q1V53o44jxEt6lJSZRQlb13CZQK729KJgEAzPUI+HXMAdL1
VrktYU8w5nNZDFJsfRDeT5vtANt79Qk=
=DSAg
-----END PGP SIGNATURE-----

--5vqZUIbKn5YO3NPT--
