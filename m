Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6731D759;
	Wed, 10 Jun 2026 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781109957; cv=none; b=oaI7hjZURrvd40ASeZcAVjK7751YuWtUmPAhpQFABIYpTLW4scYOfvKK43tKopU85iB6IFEswqdD3zl0McD1pm2kZgSqtfJlQWBTktSd0aGqJHCY+UW4tXGxSLH+IU5EV/G6KSt38aJmEUq+6gGWvuR2+RjU5CHGd/++4AowTo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781109957; c=relaxed/simple;
	bh=Dwfla7ljRHGOdc2dosvIj1PLGsSY3rDKLsmBWusCknk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueXNMk+NZzR2LUyetZVje6RRn1be6Nkf6LJvL2PeMv0b19UFA60xckwxTM2+Z88IyaukbCUx9owN1dqD5eJAvxvSWzHYUmeviaEJJ/dJU+GbzQ4FcwM+VDga9jo8uUtMA1+RS6UTJNsaQae4qNjRlVMkfxB/0KOKo9pEz4KusO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbTRvuKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbTRvuKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2988E1F00893;
	Wed, 10 Jun 2026 16:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781109956;
	bh=Dwfla7ljRHGOdc2dosvIj1PLGsSY3rDKLsmBWusCknk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gbTRvuKRczjMxJjvqmk8hMgddfxW9WKMZDNNqXRHrpsxDOXSgN5G84D/73imxJ+8m
	 wuEeugbzUyXTiuHILEFMhDGBGfX0hduXfo5mSIFRfzo0rnYl0nfIAovoyh2VvZaw0I
	 VQUwclLt1HAfVp/Ijmj7ly0wW9LtPcfD09Ot3B6QErTQFd2LXXQGDztuZ+ybONdOn/
	 6zf9OS4q48sI1YMu6AyEAjJdfirIxH8nqRVqRruv+BsEkjHGeXgOvEOxUAp4WkT6/D
	 U2MQp//6fNa42X8+CGj9jQu89KJKQQpICT4m3ICaO+Pl9UZl8hF0MAhIb88cBXdVaO
	 u33EKSmSLfUtA==
Date: Wed, 10 Jun 2026 17:45:52 +0100
From: Conor Dooley <conor@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: Add MS5637
Message-ID: <20260610-broadness-unraveled-b5187dcb2fb8@spud>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
 <20260610020458.104818-2-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7Pn2wnQn8Xikch5i"
Content-Disposition: inline
In-Reply-To: <20260610020458.104818-2-adamianlouis@gmail.com>


--7Pn2wnQn8Xikch5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2026 at 10:04:57PM -0400, Louis Adamian wrote:
> Create meas,ms5637 devicetree binding and move existing devices from
> trivial-devices.yaml. Explicit compatible strings are added for the
> different sub-variants because each requires different constants for the
> second-order temperature compensation formulas. Previously, the driver
> exposed the generic compatibles for the ms5637, MS5803, MS5805
> and MS5837 families and applied the MS5637-02BA compensation to all of
> them.To preserve the DT ABI the existing compatibles are retained and
> mapped to the -02BA variant of each family (ms5637-02ba, ms5803-02ba,
> ms5837-02ba).

I think this should be made clear by use of fallbacks, or being marked
deprecated with a comment.

pw-bot: changes-requested

Otherwise, it looks okay to me.

--7Pn2wnQn8Xikch5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaimUwAAKCRB4tDGHoIJi
0s4OAPwMqpiW7IcnS9CigZGU1d+dwYAdHTJZ9IW/guciPAcNTwEA/Nq/kb4KqcE0
U0z/eKjj0CFXyQx/XJL9zJ/CUFvKBAs=
=1GsX
-----END PGP SIGNATURE-----

--7Pn2wnQn8Xikch5i--
