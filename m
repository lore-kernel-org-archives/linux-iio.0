Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A40B2F1FDE;
	Fri,  3 Jul 2026 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095685; cv=none; b=KqE7L+Yvvla5CuQ/e0SueOjsLfBrcvJGzAx1hE10P6hsbrEwpRV3wWQSeW/hHdOzgD3iAmNXhKGqnJKR9Ewonw3s+kbMMe1nLO3xYBO9+Xn+WguAFTlHKzoJ1sTEuPsoela9AX69yqtdbXd95D7phcZ5UneHOCm8CACAYvfWzq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095685; c=relaxed/simple;
	bh=xgoktPGMKhutwq/ZPKzyQO5jJpyJs1b8JDRtf0WOw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4OawbO/ZX9JtBa2ur0nhyXgLODoU2nhgs379zIpsPmUZyu8uqxq1FThkwLTwUQl18mzL/ghCnR89x6hgg/Irsh4kHZUQRHLlh6GE7z4wPvtx5v2unRMSlQaAd2Br9p5NJ/25KvjNfT01AtKxAKpTO6a44EWPjObobB4oUBsrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEvBEkhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEvBEkhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A93F91F000E9;
	Fri,  3 Jul 2026 16:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783095684;
	bh=xgoktPGMKhutwq/ZPKzyQO5jJpyJs1b8JDRtf0WOw7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BEvBEkhhxf/0M6kthQVA6f0c4+VgMV6dmEJgLtpcTZs90N8wNX5fT8oyeQU7mgBXX
	 m4h6KjGASRvj2eOWr2v/LuZPAnhA7VKpvJphAfFFfx1dI9FMlhfvKZZ9YuCQqHpZ6j
	 ABxjr/3limS6ju+NM4Z6tqcs+qRZ50FaKGrg/9mkUAb5mNgj3fqg0YmQ7hwcmNbf7d
	 WCvJuqSGIU+TKuZUxNxbnkmDGQZq0IEYa+HBTXTvjWVizlnHVfsgzDU0UZTF37ne3k
	 WxB5G9i52veaRqFGZvfSLmTZl+dhYDZB8Vw6WhCYoXkhySRc2irtDzvkrugyegCUBy
	 k6FeSe/Rf2Rgg==
Date: Fri, 3 Jul 2026 17:21:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: iio: adc: add maxim,max40080
Message-ID: <20260703-snowfield-unsolved-bc1c1f0afaeb@spud>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-2-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HRoI9HJ9l0JIbAJP"
Content-Disposition: inline
In-Reply-To: <20260703102941.1141341-2-stefan.popa@analog.com>

--HRoI9HJ9l0JIbAJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--HRoI9HJ9l0JIbAJP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakfhfwAKCRB4tDGHoIJi
0ivEAQDVxgG1bKE0NR0OIDCAvbazPP7Zu8Y1Fk0w22elAlL+PAEA3hp+ZkYeAkW8
nMMHv+Zaddp2YhRlUCethfH+ZpvcZgM=
=YmPC
-----END PGP SIGNATURE-----

--HRoI9HJ9l0JIbAJP--
