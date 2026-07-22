Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAC405862;
	Wed, 22 Jul 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739591; cv=none; b=MDJYTwEP+Sfyt288Ss12922bVDNsSIgw8iG6TFQi3hInLmskR9RdPYTWxVeKdrEV64iJVW/sQsHIxhPKn3HE0f0UyEnKYj/YxVeDwlst6cGdK3DxLeC3Au6j4AMgsH230rzDKSuq8gCMhQj7SSjSQ5drjkyC0BSnaG3EZFeZZbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739591; c=relaxed/simple;
	bh=7c0Uz9ZN5GvlXhCV70odEn00ERJrF9VzJkt0pDEYUag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgYKjCfHEfYdzYecg2bIYsccqzlUd3HqZ94YZKeOsqCI5WokJf4jHK+RpxXEUtrwr4JLB4u+65qDk9KutIBgGTpf831ktAHyEa4YlQ7LBHsf5ZOv682i43GJ4dIYtY8Fb0NklX2hNRIDMw81sMPzMWRpMNUFRbGkjfzN0MN3Aao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcMqteFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcMqteFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D361F00A3A;
	Wed, 22 Jul 2026 16:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739587;
	bh=7c0Uz9ZN5GvlXhCV70odEn00ERJrF9VzJkt0pDEYUag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WcMqteFRqHo+cuTezGRSw0RmSty2fR4OVMm+1e3VpYk1pFA0YXsu/QfuUeCjrORLn
	 Kh9SxzRro2O+jhjHYdQrpKlwxGvEBKDWhmItaxFDZZwsRXnX6eAlB4tVCPotBr0aiM
	 EdOGbjp+QL4h3MbZzuhi3se0tykhX7kNLGx5ggZxMsFWawfvJWsQvaEYeyFh7G2mDI
	 vS4RrjNCr3JOPCG6P9eqrZPbv0upd+gxSQDzUS84yQqIqY+bPsGLXLg35OmTuJY+0T
	 UlcDllORNNfNo572hWkUcuXdWB7G489o+KgjbkvGdNMo3QSukmjnhE6Jl1wHCEZa9k
	 PwVqmmLL8HFPg==
Date: Wed, 22 Jul 2026 17:59:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add icm42630
Message-ID: <20260722-creature-volley-0f083b904c1d@spud>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
 <20260720173411.82979-2-jorijnvdgraaf@catcrafts.net>
 <20260721-lethargic-purge-e3cfb3c50677@spud>
 <20260721171647.26128-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DxjpH36jZ0i959vW"
Content-Disposition: inline
In-Reply-To: <20260721171647.26128-1-jorijnvdgraaf@catcrafts.net>

--DxjpH36jZ0i959vW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 07:16:47PM +0200, Jorijn van der Graaf wrote:
> On Tue, Jul 21, 2026 at 05:01:26PM +0100, Conor Dooley wrote:
> > On Mon, Jul 20, 2026 at 07:34:10PM +0200, Jorijn van der Graaf wrote:
> > > The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> > > found e.g. in the Fairphone 6. Document its compatible.
> > >
> > > A fallback compatible to a sibling is not usable: the part reports its
> > > own WHOAMI register value, which software validates against the
> > > compatible.
> >
> > Why does software do this? If the whoami is the only difference, the
> > software should stop checking it.
>=20
> Whether the whoami is the only difference is exactly what I cannot
> establish: the part has no public datasheet. What I can establish is
> driver-visible: the unmodified driver has been tested to drive it
> correctly, and Jean-Baptiste confirmed the chip is "similar" to the
> ICM-42631 and "can be supported by inv_icm42600 driver without any
> modification". That is short of knowing the parts are identical (the
> family has precedent for real differences behind the same register
> layout: ICM-42686, different full-scale ranges), so I did not want
> to claim full compatibility with a sibling.
>=20
> As for the check: it is not mine - inv_icm42600 has returned -ENODEV
> on a whoami mismatch since its 2020 introduction (and per-part config
> does differ within the family, see above). Since every released
> kernel enforces it, a fallback would not probe on any kernel already
> out there regardless of what we change now; and even if the check
> were relaxed, a fallback-matched part would bind with icm42631 as
> its ABI-visible name - so the dedicated compatible is needed either

Is that really problematic? It's not problematic for any of the dozens
of other IIO devices that use fallbacks, is there something that would
make this one different?

> way. Whether the check should become a warning is
> Jean-Baptiste's call, as a behavior change for all parts the driver
> supports; I did not want to gate a trivial ID addition on it, but am
> happy to send that as a follow-up if wanted.

The check should be deleted since it prevent using fallbacks.
IMO, delete the check and add the fallback rather than retain it and
propagate the issue. Even if you think having a fallback is a bad idea
because you cannot be 101% sure that there are no programming model
differences, delete the check. Personally I think that given the
testing, patches and quote from JeanBaptiste, a fallback is suitable
here.

I think Jonathan has sorta changed his stance "recently" on the
correctness of checking whoami values versus the compatible, so what was
done in 2020 doesn't represent what's the current guidance and I am
always a proponent of removing these checks whenever I become aware of
one preventing use of fallbacks.

Cheers,
Conor.

> The commit message led with the driver check where the real reason
> is the identity uncertainty above; I will reword that in a v2 if one
> is needed.
>=20
> Thanks,
> Jorijn

--DxjpH36jZ0i959vW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamD2/gAKCRB4tDGHoIJi
0gPVAQDF2HsaeQooU24UvhnMhncTtQMXUE2/DERlr17JpY3gkgEAkwXYs9M59nFC
CWpch2C5wfuGhto6W0n6W7iXkeXjxQ4=
=12K2
-----END PGP SIGNATURE-----

--DxjpH36jZ0i959vW--
