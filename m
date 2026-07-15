Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C1307AC6;
	Wed, 15 Jul 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784131269; cv=none; b=ZuqoJLPuUn9fL6NQqnSm12VH9YSBqbggYKSMxuAMwGHA7RdPd4h3DE2LeyaUDF/ShYVrRhgHLDXfdUV5hlRiPWuQ6/wJDf+igmgoJ2m0Y20gwUg/6jt4sr1xYZmxJlUco1w5xL6ZV00/OgzqaCNe3kKY7JFrQYrkM8qUK5A7spc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784131269; c=relaxed/simple;
	bh=8FhUTpmbSP/i4Dzmpy0xRPkpWGKH9Ot141W2sefmwCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwGQYtYVYnHstvIZeCZhlvZlO93guZbsYp8JoHALylSWdHUuNGR/rNivbNb25LBPJ7U1j0qBGQ8Kg1OUEL5jlT23PiVpIICorTN85bhs/Z+a+10ZnhxBk/j2qQYYuSIBax6OU5cYWtsnh/XZeZECYZ/v9heSH3UgMAGxTAbFAP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MR5yP81Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MR5yP81Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3CF11F000E9;
	Wed, 15 Jul 2026 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784131268;
	bh=8FhUTpmbSP/i4Dzmpy0xRPkpWGKH9Ot141W2sefmwCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MR5yP81YA7Wpx5DaqQLcUwq2fs5RPouSMsbc/zp2s7tGTeztZhkClJPw40m3/7jTc
	 D7QDA+jBu37Io8WUo4TkvRikM/U/DQDUjdkpgBPddM/6YdcE614Hm5itYrUTqdv6ZE
	 zqlnwMn9tveXONZ/Gzdt6CcxG80hhyjwl5zAqK8tmGkrUQt47vqwQV1EGR0LEgSZxa
	 ERrWANFYa8MZk7wC7N1nv82r0efdrzXix+VDTfCv8AQ+GZVOmA1Zn1ejkqO1THP/Yd
	 9+Uss4l9Ae98gpUGnNCxflLDg/xTH6fAzTRSpcYQrCdfuHmw9rHaUO+VzBoPHLxTbz
	 wvJmfkXKcZXvw==
Date: Wed, 15 Jul 2026 17:01:03 +0100
From: Conor Dooley <conor@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/8] dt-bindings: iio: adc: add input-chopping property
Message-ID: <20260715-wriggle-gently-bb9c3c994f2f@spud>
References: <20260714-iio-adc-ti-ads122c14-v4-0-25f8e3084485@baylibre.com>
 <20260714-iio-adc-ti-ads122c14-v4-4-25f8e3084485@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xdc/a6Xzh+K+sHl4"
Content-Disposition: inline
In-Reply-To: <20260714-iio-adc-ti-ads122c14-v4-4-25f8e3084485@baylibre.com>

--Xdc/a6Xzh+K+sHl4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Xdc/a6Xzh+K+sHl4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaleuvAAKCRB4tDGHoIJi
0ldsAQDMhV/gk6/zC13U+Kg3eN46pLqNXImK7oybSXMNpwGpyAD/XlNiMGTK/71A
mjUzRP75FUAs1vHFVYL+UrWMluzZvgo=
=GaF8
-----END PGP SIGNATURE-----

--Xdc/a6Xzh+K+sHl4--
