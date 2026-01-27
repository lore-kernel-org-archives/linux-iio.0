Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91235DD1D;
	Tue, 27 Jan 2026 19:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769542722; cv=none; b=Dl+aaTMxeQtaV/AoYbuBXTA/+CfSFalf+vu/OVbJ5lsRX4hZfypeQsfgAyUPluF1vX2fipYmWsqLmiD2RMZPOCESnj2Av8eU6+udtsoXhyQMHJ1LS0J6fM0BdfFxvoyllerMMd1ernSzdSUg5XDaNEA65q/dmog6HoBYDKhqups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769542722; c=relaxed/simple;
	bh=WQ+4gjflcLv9d5LwcfBpmsfiJCT/J6DX8iLLgXKm8x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvIWI/f2MzqZC9RgF8dip0k2/WU7xoHSNrlMCoCwZugW/OTWchffxlIiaOqyU3/fQC6PCjtQBsXkxzrqsR2Nymjw+gnQmc9V6LIZqkU5rG3tSJI1hxTs3jS4fdvJ0UbbkqRDaySsljNnhKNLEGS2+z3JgrFeJ2hZYtfbHg/a7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmMifiCd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmMifiCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10943C2BC86;
	Tue, 27 Jan 2026 19:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769542722;
	bh=WQ+4gjflcLv9d5LwcfBpmsfiJCT/J6DX8iLLgXKm8x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmMifiCdZDTbz6ovAbqxUCYopTUg7+HUh/NPmR1A0xllRMclpHqwVPI2vQ7qgVz/8
	 5f+F3urw20N8/2dRXR8Ka4HaMLVKRdj3I0r7weqXASSJBI3tzCj0GK5n+hlQ1tIOoK
	 MrRPdPpNKL0tGTMoCms6p5bSPNzG1Vu4Zwf6opS8dgRm1Fl5AjCUDT82cJoq0lX2rb
	 jUbT5p9sXsr7CLUio0AnWaUdmZeDVfC/B42A3sjEa451oYtpmTMOa7jZJ9wIsr8+tp
	 xpgy0ejhicvT8HSF5LWqZha4LLJsRB++xhOQ48ztpkwFMhy3wkxLii3n8SKZo17m2p
	 YfigFrMtkuyFg==
Date: Tue, 27 Jan 2026 19:38:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: amplifiers: Add AD8366 support
Message-ID: <20260127-goes-grandpa-891eb0dc413a@spud>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-2-c9a4d31aeb01@analog.com>
 <20260126-porous-hurdle-bfc510f113bb@spud>
 <rzco2g6psoblzaaqrdnmpmhs44hl7kqusa2kuafpkjx635dug2@rtwebhwztfkd>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hex63lWBCk07Jfvr"
Content-Disposition: inline
In-Reply-To: <rzco2g6psoblzaaqrdnmpmhs44hl7kqusa2kuafpkjx635dug2@rtwebhwztfkd>


--Hex63lWBCk07Jfvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 11:37:52AM +0000, Rodrigo Alencar wrote:
> On 26/01/26 08:11PM, Conor Dooley wrote:
> > On Mon, Jan 26, 2026 at 01:51:03PM +0000, Rodrigo Alencar via B4 Relay =
wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Add device tree binding documentation for amplifiers and digital
> > > attenuators. This covers different device variants with similar
> > > SPI control.
>=20
> ...
>=20
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad8366
> > > +      - adi,ada4961
> > > +      - adi,adl5240
> > > +      - adi,adrf5720
> > > +      - adi,adrf5730
> > > +      - adi,adrf5731
> > > +      - adi,hmc271a
> > > +      - adi,hmc792a
> > > +      - adi,hmc1018a
> > > +      - adi,hmc1019a
> > > +      - adi,hmc1119
> >=20
> > Why do none of these devices use fallback compatibles? Please put the
> > rationale in the commit message.
>=20
> Will do. Each device has their own gain range/step.=20
>=20
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vcc-supply:
> > > +    description: Regulator that provides power to the device.
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +
> > > +  enable-gpios:
> > > +    maxItems: 1
> >=20
> > How come enable-gpios is optional? Is it optional on all devices?
> > Do all devices support enable-gpios and/or reset-gpios?
>=20
> Board designs often hardwire powerup or serial mode enable signals
> to high voltage level, so there will not be a reason to add the
> enable-gpio.

I don't see anything about all devices supporting enable-gpios, adl5240
doesn't appear to have one? I'm not going to check all of the datasheets
to see about the others, but you should disallow the property on devices
that don't have an enable pin.

> I went over the device datasheets and I could not find the
> reason for the reset gpio. I left it there because it was being used
> in the current driver implementation, and I would not like to
> invalidate designs that might be currently using it. I will ask around.

If none of the devices have a reset pin, then you should delete the
property from the binding and the driver. Not like you're going to break
something if none of the supported devices even have the pin!

--Hex63lWBCk07Jfvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaXkUPQAKCRB4tDGHoIJi
0ocDAP9pgL4QVFVYJ4DmkBPlQ6XtFzfk2Gzz0A7mVWX2lYPfaQD/ZiYpQgcJGHMF
tEAVjXD12AEkjzOGwNZbnVO+CrVGfw4=
=vDbG
-----END PGP SIGNATURE-----

--Hex63lWBCk07Jfvr--
