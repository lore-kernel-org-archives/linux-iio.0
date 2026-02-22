Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3632470D;
	Sun, 22 Feb 2026 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771766655; cv=none; b=rk4GFfznLSF/ou0DCVk50OGeBNNEmvG30sRa/4c8jMSzzYcajOaOk21Y+/9ZiJWisFjcUkyHkO4CDtZUlNrr1HqNqTCRu84L/Wa3vmViT5fmA3xSOx9h36JXSJ6vokcRYZdjSNWFXZTjqWkRomtiwWvd0rLjECjP0Z6X3r7FYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771766655; c=relaxed/simple;
	bh=u8GpRGUNuYz/wGXgnCq/A7vQELRTOzXH9bEVX/UA49s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQlk6b0p1+dFPQrj5yYjSEG88Wc/STmXhcCvRy1gEaLDSIzyDSH7WfR9wJeZPioZLkmA8PSZeQ8lk5QvYT9NVApxNxFF6eT2WNMWkGasq67zCRuz1YJnZTMEIveGqQaPlowq/GZWcTm6DWVe1sux5PgRmg/munsbew2RzMiZuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpW0i/rM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpW0i/rM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41349C116D0;
	Sun, 22 Feb 2026 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771766654;
	bh=u8GpRGUNuYz/wGXgnCq/A7vQELRTOzXH9bEVX/UA49s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpW0i/rM3Tkl79FEQHinlnb2NJkEyjj7nGeVX+s7uqaj3u/SiUy5JO45ARoo2Cl/J
	 v6HN0t0wJ8YKczNHzbPKPTyL87fe1WFJ2Rc+CaztVtOh08zb8bXGDq5leFknDklG+m
	 zp/U+i4xsf/OnrrCJnpMpQAWYu1RJH5CpDPqgRueJt1zzbY4t6OuLbth21/Jl6F6H/
	 ATeYXxRrHnFfdbuBO8WGQe6gZLSF/aB86LF0LWi/j960fU9Y/YCd4Q5+BZo664NbMQ
	 j3GCOr8A6KvnuXYkU7K8v67igqO5ezq8W7RXcm5xztoHhwe3ClwZWiFoFDCYfTJNRt
	 7KeamLty/2WmQ==
Date: Sun, 22 Feb 2026 13:24:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 1/8] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260222-lucid-spirited-b665fe3524b7@spud>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-1-3b264aa48a10@analog.com>
 <41190a42-70ab-45b9-922f-317e792b25a0@baylibre.com>
 <20260221-batting-amiable-fc01ae386789@spud>
 <rvsygiakolyb6gtinpwojn3atj6i627zmpxecbs4b2z6urllp4@iaxemesawckd>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j8JF6CTG3uyWGCfE"
Content-Disposition: inline
In-Reply-To: <rvsygiakolyb6gtinpwojn3atj6i627zmpxecbs4b2z6urllp4@iaxemesawckd>


--j8JF6CTG3uyWGCfE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 10:49:35AM +0000, Rodrigo Alencar wrote:
> On 26/02/21 10:43PM, Conor Dooley wrote:
> > On Sat, Feb 21, 2026 at 02:43:02PM -0600, David Lechner wrote:
> > > On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:
> >=20
> > > > +dependentSchemas:
> > > > +  resets:
> > > > +    properties:
> > > > +      reset-gpios: false
> > > > +  reset-gpios:
> > > > +    properties:
> > > > +      resets: false
> > >=20
> > > This seems too strict. Couldn't we have some resets from a reset
> > > controller and others from gpios?
> > >=20
> > > Or maybe the reset bindings are enough and we don't need the gpio
> > > bindings for the same pin?
> >=20
> > Actually, I'd be interested in seeing evidence for the resets property
> > ever being used with this device. I think every single reset-controller
> > that's currently documented is an on-chip device for resetting
> > peripherals.
>=20
> As mentioned, an FPGA IP as an IIO backend (MMIO platform_device) will
> implement the reset controller interface.

I think you're confusing this with some other patch, I don't see any
mention of FPGA IPs or io-backends here.

--j8JF6CTG3uyWGCfE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZsDYgAKCRB4tDGHoIJi
0mERAP4y1f99OAX2wlGGzDorDAtVG3rVOS/1CL7NeGUcW5N17QEAxFxERwZU/5X0
+kilmA5TUhLNPOeIRDrJtj0LLeFPaAA=
=JWpZ
-----END PGP SIGNATURE-----

--j8JF6CTG3uyWGCfE--
