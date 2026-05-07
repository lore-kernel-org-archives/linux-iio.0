Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2493128C6;
	Thu,  7 May 2026 17:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778175327; cv=none; b=TXDVZmnCQuPgztq8mz3IszsrvPnRS36D5dkp4vpaePtfm2Tx2PXgsKj3JLI91FDEJCs2wEFc6xH9zJYAplaoConTZf7RaLNyXaEdjsju9dn1RmV/x7ZAZn/qCNEJgB901JBtQtFnCGimzi67GnOFWXOal635zMvoIatFe9ehkF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778175327; c=relaxed/simple;
	bh=4sogXO8yVe8MTdd4LFVkRhzKfpGjlYWI2a5B1todpO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYU9xhGyXRNQWzaxlgQryQ0QhDLVv3DfrRQKVS2/YT9A3krCy3QYZqUOQyvJ8c58UGTBjOva0XrBNdd3etwx0SsKqtpeINs4CQ6Km4pL3GBm1zP4Ok+Odq0B/Oc6UfaQ5b4lt4P99cfsO2EgCsJfWYA7hn84rAR3zbkKJ4ds6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlrvAIc2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlrvAIc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14F0C2BCB2;
	Thu,  7 May 2026 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778175327;
	bh=4sogXO8yVe8MTdd4LFVkRhzKfpGjlYWI2a5B1todpO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlrvAIc2b86c95Z5ifp+9Uv0G/x7+tU7zDBU9JVJMVVHlK1DoYgyjwyMd9NhrXP9e
	 B8OKgm8nyYnfWns9PQYJ07ed3IpPSAxYo7UGUHjW6yIFoLhaGywZozhd4L/cERfw5t
	 YeIOEK/e6CWkTBqqCLHXLHhMpTDxOYFTu3pMUivgelj5fwozrwQpGqOoqVbzMzm5LU
	 Njsl2kTEJqy7OxdkcAu9jAo3j5NUxZZitdhQLPhmSvUZMzU5ye1iAhrspm6vhIWLO6
	 hElOXG9kGWRSOiHC+cmPP0JkFDA0a10sLtSpfahkGhd0Ts02pMea9/WhC0z5mn998j
	 gkakhFnWIBqXg==
Date: Thu, 7 May 2026 18:35:21 +0100
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
Subject: Re: [PATCH 1/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260507-skinless-urchin-750a15abf4b5@spud>
References: <20260507-ad5529r-driver-v1-0-b4460f3cb44f@analog.com>
 <20260507-ad5529r-driver-v1-1-b4460f3cb44f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Z4xIYm+sqROBgik5"
Content-Disposition: inline
In-Reply-To: <20260507-ad5529r-driver-v1-1-b4460f3cb44f@analog.com>


--Z4xIYm+sqROBgik5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 06:28:09PM +0200, Janani Sunil wrote:
> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Z4xIYm+sqROBgik5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCafzNWQAKCRB4tDGHoIJi
0oYVAQC/Fi9IxVcvKRhgOWs5STiiJWl0p+WVpOz/8s7NkvQ3iwEA6FQKRUpuC+Sq
hrLvUJhdUqlLXNNDOg26otXzFYVvkgU=
=fbHe
-----END PGP SIGNATURE-----

--Z4xIYm+sqROBgik5--
