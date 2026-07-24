Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E56345CD0;
	Fri, 24 Jul 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784912017; cv=none; b=T7dqAeHTfwq2GUeynNVIe5H9I9x4kXlzuBvhlovK53vo4RX7wva0AvbYF2OoLkYTRInUcHjTAI1gsPx5D0jhazGfNxnoXDl3BmD0dSl3pVdxJVP4CqwXgmEdvxwNJRHIrQnvtfPFb328hvjOmvHHb5svE8NoYvs5xphha6p9F88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784912017; c=relaxed/simple;
	bh=Ej7dj+z0Cyu0ZFrtcH0Y8M2eGSdFCAL+KFVos5SqCWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePcSCGGzvT5vPtIvTknAguWz4uBaoG92qRLMdu4rEtsJXq3X162lw6jEuYfKsQSd4f0+UV9WRMUIMey66pKqLu4GALZSBf5TEWmO87zh2WLsSYRe4iDJ6anC62C4zKkHMboY5hi2vcl83JNq6rpzFBBule9GrwFA68i8KJqKMN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLGX2pdn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLGX2pdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402321F000E9;
	Fri, 24 Jul 2026 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784912015;
	bh=Ej7dj+z0Cyu0ZFrtcH0Y8M2eGSdFCAL+KFVos5SqCWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oLGX2pdnaWt/NjnbnfrHCWMTE8gFdfyVkNOXr2ezRATGDYdZEd7qvq1RQwHWy7r+Q
	 nsRanSFXZ98wKeEa+apwOfiKiaH4G8fcx+v+hZHDxMTx6dZzzxLdPApAImYPuHImqX
	 +LEQw0zfKEtixr1vv7Gvvxoi3crzIvuDzwZONgYLgH9AWv9q7PMYshxSENd16QmoAU
	 /YhsFhfufwjAHSVwhaMr9oJzILue7pCV5fwEycxSG4gxsgMlquObEdA4OQh/Znea/W
	 YT4crIW0WwphwBkKpGbCdeLbb8cn6g2w+Y+ph821FDGL9vZZK+UhRNpLfrEJZ3Mh1C
	 /YEShhZLUppGQ==
Date: Fri, 24 Jul 2026 17:53:31 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: iio: dac: ad5696: add
 AD5673R/AD5677R support
Message-ID: <20260724-rescuer-sliding-49b446591d52@spud>
References: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
 <20260724-ad5686-extend-dev-support-v2-1-cfc2b30ce988@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bz+ABYr8mY0hYAYT"
Content-Disposition: inline
In-Reply-To: <20260724-ad5686-extend-dev-support-v2-1-cfc2b30ce988@analog.com>

--bz+ABYr8mY0hYAYT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 01:03:11PM +0100, Rodrigo Alencar via B4 Relay wrot=
e:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Add compatible entries for AD5673R and AD5677R. These 16-channel devices
> have different bit resolutions so no fallback compatibles are used.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--bz+ABYr8mY0hYAYT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamOYiwAKCRB4tDGHoIJi
0kROAP9KXP6liZdyUuR5UvS1kbLN4JXdZpPa4EDBKRWFY3omIwEA9SWNnqk+vb0N
tEXaU8YRm0ULu7w6OKBGpu3cX/ScvQg=
=9/qd
-----END PGP SIGNATURE-----

--bz+ABYr8mY0hYAYT--
