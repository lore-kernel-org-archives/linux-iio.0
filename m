Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DC5650F7;
	Thu, 15 Oct 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792090862; cv=none; b=IAe9/glKUghpq2pJifIYh563BW5kHS5tA2UEvFRRsvWi+efNocVy/TXJkgJWigdgkqleum0OOa93hgi62Xrvo/DCe6n2L8Pf8xd15mmE8vOE0FEJp6es+wVBrkbgbr+MXbny9YP65adrufjl5Fv54eEyzFToXOnLkoqtIlLIsfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792090862; c=relaxed/simple;
	bh=OGGP3Gc+g4ugsGV/o/gkbmqVWY/OYF6rYovKSR2ACQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uM7aEsk+/hcoFpAT1FYaPFVvxHMbDoKlHmrTcZ4JFwSHjxsD4rYBmj+8o6lIPtwT9Nom1aM6vTv95NemHfFu1bMeu6hUAoOxi7sXRAa5s92/RHSV3AV1CDOOwFVTMW0Xan3pReqa/feIlQ8zn54P9IOThafMLWUIhKEk50JtaAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0eGglui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0eGglui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBEE1F000C4;
	Thu, 15 Oct 2026 19:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792090843;
	bh=OGGP3Gc+g4ugsGV/o/gkbmqVWY/OYF6rYovKSR2ACQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c0eGglui3ZCuMcFeS7bbG1bQ21NsUWClNzdHaHe9wXocNO/MkX3O/G3W1SzudiW5U
	 OrH7m0JqhUBrvbCOQ9te2Ya/E4qOXaCttMZ2JcIW4CcjhMd3OSX/ZNMLHInVTPXJjo
	 cHr/VA9rvKfQVWuLYtbJPZP9jSAksPVkWdF/WIdCt8HuZ/NWDjhQaCmeTIivegumXb
	 BlV0Bp7s0DzTXZoMT1zF31DXVz+OcoH9OyI5vbB3cs57nNDfFK1N8TNCTDd6F7TNut
	 HAIfXUwg9TM6h4aPInvxBGt2VV/YMP5Qw6E0UQ8jVB5ETyFn79a/VJQjE164XTEL9A
	 05zY/LBORDAsw==
Date: Thu, 15 Oct 2026 20:00:37 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 04/10] dt-bindings: iio: frequency: ad9910: add
 io-backends property
Message-ID: <20261015-uncurious-unwrapped-aa7b2fa6787a@spud>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
 <20261015-ad9910-backend-support-v1-4-3c21648c8e26@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rXpn9wAQnF+zzvmy"
Content-Disposition: inline
In-Reply-To: <20261015-ad9910-backend-support-v1-4-3c21648c8e26@analog.com>

--rXpn9wAQnF+zzvmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--rXpn9wAQnF+zzvmy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatEi1QAKCRB4tDGHoIJi
0uCxAP95ntDYEgJy1qERWZSEz20Xl3vlfQRB8z7M5bHV7NqTvwD+MqH/CJls1uPL
57lDZhz1XYBpZua6haLyUeyWhgayQgg=
=UaJ6
-----END PGP SIGNATURE-----

--rXpn9wAQnF+zzvmy--
