Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9C951D50F;
	Wed, 30 Sep 2026 21:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790803095; cv=none; b=UDVe3VbOYV84tF/MQSRj0ndG8DxsaadhJLLM9MVfeiKCHTCgbJZVD2D8QWjTK46sTBAEfygPvg+PjKK1WToP4oC+6g6BjA1fSh37RKU5b9C68okk4dJHTkiLLBBQeUpmUblGAqpWHBX6Mo+phSAfA9NesO2KBlv1K2goGJY5KTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790803095; c=relaxed/simple;
	bh=Asdm0TpB8u5zy0lzy5pt0MvWertRtCXOd6lENqyikxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3iUFqDfdLTjZGOtrxqyQKhYflRBkpA4B3XRhXYHKVf7LNV2GqV/pfyT4bmNUUVJqJw/BNqHJS88HKUDNipimdhsLmxMA3TNodrwPW1A1VQ7DTqM9V4H2zHIpt+v+/y51RP3AmIflIr53ZqoHRDvANm3QcJrTNRUQ0yGcH+3InU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l15rZbWi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l15rZbWi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D531F000FF;
	Wed, 30 Sep 2026 21:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790803094;
	bh=Asdm0TpB8u5zy0lzy5pt0MvWertRtCXOd6lENqyikxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l15rZbWiW/tSQiObx6mwp+9gGKh9XCppH7zEZjV4/ws0N0fhhL935fgxY8T/b9ryq
	 scgrbCydtbaS9kU0dxFiENiEic8kWwHrDvgrlsQlvuMOK5MtRkasgICmtoCwsDFpec
	 g1JnkEsBFNCOisjA7nDuJPTofbwDarZmGApQoWfT3O7J1v/UYjpJ5z8s0ZTURjkSkq
	 Ywil6TqsOkRzj2rX+mR0kGfZEycli/3RPDCiIhczFzNmkk5OD7Hlk+6smZD2mdqbn5
	 6NMqF51tZttN2pdFPcSNA4UlpmDwNKAqPY4Kyzdb95j7m4x0cGaXJkPbpYvMy6F+jF
	 U0wyl9hTDnUqA==
Date: Wed, 30 Sep 2026 22:18:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Marek Vasut <marex@nabladev.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Cheick Traore <cheick.traore-ext@st.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 01/15] dt-bindings: iio: adc: stm32-adc: add support
 for stm32mp23 and stm32mp25
Message-ID: <20260930-blip-hacker-c0eb3c978fb8@spud>
References: <20260930-adc-stm32mp25-v1-v3-0-406834430d72@foss.st.com>
 <20260930-adc-stm32mp25-v1-v3-1-406834430d72@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H5isfrlAMKPo+WOT"
Content-Disposition: inline
In-Reply-To: <20260930-adc-stm32mp25-v1-v3-1-406834430d72@foss.st.com>

--H5isfrlAMKPo+WOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--H5isfrlAMKPo+WOT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar18kAAKCRB4tDGHoIJi
0pgAAQCk8EVeiVU7bhrDnX9SGs0jNb+botmOIZKyWqLMT6HyVQD8CSU3PsZX2Dlz
pRsbaiCvl7wPH8G7uJ99rxHJL+MOcQI=
=tsxz
-----END PGP SIGNATURE-----

--H5isfrlAMKPo+WOT--
