Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00135AC34;
	Tue,  9 Jun 2026 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020730; cv=none; b=OuqmezioVk4vEmOD4ka1ZYuegsU94m9XTotG+zEUMtVI1rW9JnU5khNoVA+ikXUdORBmsA7MePdi2ujIqyVlu6ePmxw1k/MMuHJ94eECPoxxMz3e5ZvaUjFRVbE7W/66I8ny9bPAd86HU4fD4M1+oBwMeCyYjRlpbHzLZwK+7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020730; c=relaxed/simple;
	bh=cOaIJdTFqq83MKwZKsyyJUkczQcNRszHqogFq+0mymA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uWWY5+LQtBnk1bRhaWF/SQyukTFTqqud+7Mmig7gO0S53PUkYHWMGKjvqk6AYKRW+qX8ynmZtc2QgJIUj5zP/dR7b0Rj+2Zng27tnJuPZbm+oARPWuyuqi1IqepIpQui3QW7en4HiglRlGEFJMe1zpsWvn61DTHkectYaKYaqk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqOm3wHc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqOm3wHc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4471F00893;
	Tue,  9 Jun 2026 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020728;
	bh=cOaIJdTFqq83MKwZKsyyJUkczQcNRszHqogFq+0mymA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DqOm3wHcuLfaUlyy54HbF8//A9a/6W60/CEr+acqTOOocSBKY0liWiITjMauC3kC0
	 sze1GWGP74DJpoFL0XC7/X7eW//bomxps100x7GoWJYEbciM66/ASNJxCDKv4gwfOo
	 2DN26hJopOBkDforflt1oamjuSYdPNuIjV5UTXyc/cmVU2FkhT7RIJaxynEierv7kV
	 SXNneQYC95PA9v+m3qBFSmkZ0edxpSxiv9jYcjhdtTLP5HxuNAaP1DREyPYm76oBs1
	 kGbQ4odA/8AdpwOmhoYoK/SSaK3B71UaKb+alAnZzM+M6mOG7nQRbzYlfBr2pppEIO
	 /h023YeXDTMZA==
Date: Tue, 9 Jun 2026 16:58:43 +0100
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
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260609-donator-freefall-1a7e9293a567@spud>
References: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
 <20260609-ad5529r-driver-v4-1-2e4c02234a1a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qPxgsXOT/Ho013vw"
Content-Disposition: inline
In-Reply-To: <20260609-ad5529r-driver-v4-1-2e4c02234a1a@analog.com>


--qPxgsXOT/Ho013vw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--qPxgsXOT/Ho013vw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaig4MwAKCRB4tDGHoIJi
0vBoAP0e3RXoJO1WefX2s+XOlA/edgvzVUSspZy5boc2x8ZuGQD+N0b0R8F1dCBY
kOpchVPhhKevOPY8B/wLXcZ/4OtQJgM=
=2rRZ
-----END PGP SIGNATURE-----

--qPxgsXOT/Ho013vw--
