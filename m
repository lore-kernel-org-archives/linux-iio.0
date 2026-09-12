Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CCF357CEC;
	Sat, 12 Sep 2026 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789208273; cv=none; b=VF6FLUlhavRaL/l7b6/QfDYDvh0Nb4tbZPKoZnG4CRW2tfJbFqWa64KjmwF46TQMcVRKbp+qQxkPCNnA6y6jJj3aIywcEZ+KP280LRSLxW637Esueca2Szn7bf35JLBMKn8bvSo7OFJS0HlZYvf677rBIHMHWdn40CXqxjcvP2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789208273; c=relaxed/simple;
	bh=3Hf8Eqlr+Ebp9f09GYEgMl/3B/tG67lXiBEhbgdIlso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1n+6kP9AyglM487ZsfIBfQCehjZiDdL46DP1+jw+CnzCSShEg2MX4ZcjARIrnD3LNVTIJHaaWTeTsAMsJrLFFpz6Blb7Xwp+uYFEI7qy1wp6rKx8/bHxmxKaCR3paPCOgmVlSOeUZsEgjoqt9pF9B4pUuLgtQZfp016O2Jn1Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa+qxoGg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa+qxoGg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C831F000FF;
	Sat, 12 Sep 2026 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789208272;
	bh=3Hf8Eqlr+Ebp9f09GYEgMl/3B/tG67lXiBEhbgdIlso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qa+qxoGghTv4oAOG7i/tSjYS4KhXAaaPb5yzEBw8nyLzYc3CVADLpMeHqc6N4Wety
	 NzzP+m3/LbFShGAUu22jxiU2XRyTZ6IWjnHHlIPpne/k47lHvREUaZ4ThFETNyfeMK
	 SPc9398ZBuiS3q8+Tp5jlmklxOwLeQgZvmzMmbKeR4BFMjXgTNBm2IYRrP5Sqf1Ay1
	 LeG4UGPBngYaBeS1gsCmFVt0tBl8VDTTiyxjndiUuu2VMRki/pZ9ZjAEgkV+Yz2nj6
	 Mc21OONP0SEvZB+Tx9yjfVtm45YepGJreCMjduVNmcdbPP0R9kr4f4lq0HHlBQ5m3n
	 UXT4BKgIWPHMQ==
Date: Sat, 12 Sep 2026 11:17:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana.Lazar@microchip.com
Cc: dlechner@baylibre.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
	nuno.sa@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, robh@kernel.org, jic23@kernel.org,
	andy@kernel.org, krzk+dt@kernel.org, linux-kernel@vger.kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add support for PAC1711
Message-ID: <aqUmxhYfDjjm7tLH@squawk>
References: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
 <20260909-pac1711-v3-1-dff81003b82f@microchip.com>
 <aqKauqCxYwo8_nxM@squawk>
 <b706814686dedc5a640970ae83e5e845589f4163.camel@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hJ3tvd1MLjv1w3cd"
Content-Disposition: inline
In-Reply-To: <b706814686dedc5a640970ae83e5e845589f4163.camel@microchip.com>

--hJ3tvd1MLjv1w3cd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2026 at 02:52:02PM +0000, Ariana.Lazar@microchip.com wrote:
> Hi Conor,
>=20
> > > +=A0 The accumulation-source property aims to specify what kind of
> > > hardware is
> > > +=A0 intended to be used/available for the user. There are two main
> > > cases here:
> > > +=A0=A0=A0 - the user wants to measure also the current/power consumed
> > > before the
> > > +=A0=A0=A0=A0=A0 driver insertion (e.g. from the boot to user control=
) and if
> > > this is a
> > > +=A0=A0=A0=A0=A0 runtime setting, the hardware accumulator will be re=
set by
> > > the default
> > > +=A0=A0=A0=A0=A0 configuration the driver starts with.
> > > +=A0=A0=A0 - the driver does not know what type of hardware it's deal=
ing
> > > with. In
> > > +=A0=A0=A0=A0=A0 case the part is monitoring the charge/discharge cur=
rent it
> > > does not
> > > +=A0=A0=A0=A0=A0 make sense in user-space to change the accumulator to
> > > calculate energy.
> > > +=A0=A0=A0=A0=A0 Same if the hardware is intended to calculate energy=
 it does
> > > not make
> > > +=A0=A0=A0=A0=A0 sense in user-space to change to Coulomb counter. Ch=
anging
> > > the setting
> > > +=A0=A0=A0=A0=A0 from one mode to another will reset the hardware acc=
umulator
> > > inside the
> > > +=A0=A0=A0=A0=A0 chip.
> >=20
> > Why is this here, rather than with the property in question or the
> > commit message? Anything justifying the property should just be in
> > the
> > commit message, this doc is user facing and just should explain when
> > and
> > why to use it.
> > >=20
>=20
> Thanks for the review. I put the explanation in the binding description
> as suggested in the V2 review here:
> https://lore.kernel.org/all/a73ab4e3-520e-4515-adaf-ed5ec644e5f6@baylibre=
=2Ecom/
>=20
> But if it's better, I will move it in the commit message instead in V4
> of this patch series.

Things explaining the use of the property and hinting to a user when
they might want to set it (which this does contain) should be reworded
to not talk about concepts like "userspace" and can be retained - but in
the property description not the binding's main one. Things justifying
your design that don't help the author of a dts should go in the commit
message.

--hJ3tvd1MLjv1w3cd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaqUmxgAKCRB4tDGHoIJi
0kOYAQDwJc0OEI3xpE/J4ek3A8yK4EIKGn8E68qXS0UeS98xwQEAtDVSfB2xkPSk
aNaJUueNn6pdwTFZIeFSiL5amcfHOAI=
=UPu5
-----END PGP SIGNATURE-----

--hJ3tvd1MLjv1w3cd--
