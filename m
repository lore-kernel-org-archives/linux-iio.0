Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D7A3D75C2;
	Tue, 30 Jun 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838743; cv=none; b=j5UdBiaX2gp9LNbq2+tpGHU9vyhXyOnDsIXbr8PsgSO7w1D5Npb+mkEb6DmjYyciNUJDP5XDAdkvYrJPkOmpB1weDs3Zqc5HGA0zTM7CbKXStitoQnHkehIpSOE+0UUlWj2HXGSufKFg9Ff4iUnPOGatVczJcrEd8C9ZqQt2iHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838743; c=relaxed/simple;
	bh=iYaN1QyP0urxVGpBNVcNIOw0jlHkLq8MSvJKmBqa/MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1pXFmjARsdfSZ966g9ip7YRAlDHxfuvvCGSCBMbMA1pqoJCs7sqe1SGeL7KpdP7Hl2DVN9ABEDXqxI6vStVIHNSFVeT6EmUp70f28ilqIGNwEt+QervH14aIwvsjprQiEq4LlOTlidXRZCS8lQjHBoZd7s74kq9aYcDfXG00qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgTRKZPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgTRKZPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABB81F00A3A;
	Tue, 30 Jun 2026 16:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782838742;
	bh=iYaN1QyP0urxVGpBNVcNIOw0jlHkLq8MSvJKmBqa/MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cgTRKZPUZI9NlYOao5EGH8J2OKTwZ2eXz8PIwlfjYCyFuYbT8Elyh7o6YzHn83sXU
	 oOMGUEkrCKyz9UrxZVKhHO+UljTH6XUjJ54KwrZt8dNlRPtfjUEYZpYjFKzvvntN8A
	 uxvA5gNPuUFBBQqj1TVEr9W+B2wNq2pFBMyMSWq+bU4WhiWkpFE4fgm7PnvGSxSsXQ
	 o0+mHJHq412zgRp4CUifUsJiTtDFx2X0fEpIiEpC9kKPv2dqeURq5cQHirqU7J2syC
	 OPNwchUHldTbgBMhtT+JTmY7efplj3A9Inn1t9f6qtCjRc0iwa2yt6VWCuqTh2OlrU
	 gprEiL4/iLvEw==
Date: Tue, 30 Jun 2026 17:58:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Wil Stark <wil_stark@keysight.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: ti,tmp117: add binding for the
 TMP119
Message-ID: <20260630-hypnotic-tragedy-6dd3f3e48f9a@spud>
References: <20260630-tmp119-v3-0-cfdb50e2e99f@bootlin.com>
 <20260630-tmp119-v3-1-cfdb50e2e99f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTVQYSB8yTzuUPyM"
Content-Disposition: inline
In-Reply-To: <20260630-tmp119-v3-1-cfdb50e2e99f@bootlin.com>

--aTVQYSB8yTzuUPyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--aTVQYSB8yTzuUPyM
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakP1ywAKCRB4tDGHoIJi
0oIbAQCk8l1NPb6hSRl5FSPEoU6E6qFTMMI2zxQlfNiYVHgMygD/aweNvAutJ9Bn
lCAqIIdnLwtqes/Ln9qICXOWHWvp/QY=
=u8Tq
-----END PGP SIGNATURE-----

--aTVQYSB8yTzuUPyM--
