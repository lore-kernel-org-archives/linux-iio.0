Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793209816;
	b=Ya0QGPhG556UXbJ6oQuAI9/80Df9UvsAuicE9qH756QUCG4ra7VFBk9r0eqbry0U5BQg
	 F0gZRDhVXFdDkxOKB1q9j/cU2ECDUHQ9iI+lSwpqmSRiDdQ9Iw1IbHNfTHqi3jRGsGLPJ
	 TjfHN52vqbUVm2mu1HNK5wybwlcYjY1mgcl1cRTjDYMYLQwHrw53QgOaOOtO2uUdXzPmp
	 aIKzyhXjdQAr9BqapjnHuJxGnIXltETOU0s0qas/vm+DRhvDlMf2Zsclw8qs7nu+n9yUr
	 yUxGW+BSWjDrkbU7R42Wy0BeOu8ODLWQ8MJufD4wl/DtO8RM9LK0qgqH14CC2im9Y/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793209816;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2e3KpdJxUGATGICF1r62d9dYP/f5QUlpJF5vAsHC+Pc=;
	b=vdKtXTrBK7T5I21MM6rv+x68KCcJ3qqwreQ9WHYk3mr6F4O7BG4akHZzI5oxoiaTLzAf
	 ZK/wpyyElsH9BcxzLM3fOIVik2HnKPcTOAqM3YdpZixElCxF1CfgzCces2TQuT2CQh2mm
	 ImZm5NjgnL6d66Hwvk3mCjDfcIPjLmo2180Xr9XXsv7Gb0vgCS9TVbrrbLQkx3nzbsb7t
	 MlBE9j5+8XHCwYW+YhrdIyNoe3Q4pcv3OGTnNPoR1l7kpncWNxlqmA/iuc6A70NngPAaj
	 jl2x/Ndi3SrWkrJp2Qbf8PoAZsF7h365BV4n2HnFhVKu7N5KSlAPN+Diyo5DltVtwDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a456wK+f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681D606A31A;
	Wed, 28 Oct 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a456wK+f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BF21F01828;
	Wed, 28 Oct 2026 17:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793209816;
	bh=2e3KpdJxUGATGICF1r62d9dYP/f5QUlpJF5vAsHC+Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a456wK+fFcbYBilvXc5+dgqVWXue12jQ+dnFbXMtdD8Zr4/IgBTwc7jlFQ13pwdAe
	 YWDk7N0k9ljymzPg7sXH8ow/8Vsn6nLt1dmWSdc+OM70z9ufo2/Bjs8J30IC7LTf+1
	 8qeK41g/V4bzWHfVnrJQJTdIp9lueQCj7FJ0Hw360K2FMRxsvzjdHChrEMl1IwYD9k
	 eQ56HrfeTPhehsYuBN0XEI2p8foXOvZRjtCk0F4x1eOdzm8Go2yMBhufM+zKjM7W0k
	 sOQ8dzEOJL9lIKSivvRKiriodf0jUOm9aEROVMi24myzwbItSwebUB3Ap5sRTV2Lv4
	 qBkXJdGM/7WVg==
Date: Wed, 28 Oct 2026 17:50:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux@analog.com
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: add: document the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261028-snowless-duct-938b7ae95299@spud>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
 <20261028-topic-sm8x50-iio-max34417-adc-v4-1-d4baaf3ee903@linaro.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tTmT4diqU5R09fD8"
Content-Disposition: inline
In-Reply-To: <20261028-topic-sm8x50-iio-max34417-adc-v4-1-d4baaf3ee903@linaro.org>

--tTmT4diqU5R09fD8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--tTmT4diqU5R09fD8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauI10wAKCRB4tDGHoIJi
0utEAQCgfso1Mf6SiC/RAZp2Cfpz4Dx5U7doo4n2tWnerQHtXQD/Qmspq4uCyGL3
oA3YC64Z9jJ/vFJaZj+SZ0kh8yIrrQg=
=VAkz
-----END PGP SIGNATURE-----

--tTmT4diqU5R09fD8--
