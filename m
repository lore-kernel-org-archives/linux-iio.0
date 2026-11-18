Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025468;
	b=Fko3oEhm4CmCEXe2K4NnIqh2e6Qh71aVOzHsJEDz4ASPnySJDtPgRB/6oLZWmNhY8RDw
	 l9peyspQ4lPYsShLUCHc4KWjIwexEOi4zwG1ziHuT6o8fWfbO0rS+2OwgJx4oCHQGdaDi
	 TERaFfw/gOOlqOpGrJsEIJwNSTqvvCwjhK7QQejwxOHLM2o0pP19752WPxL5tOWp5QPnP
	 dZtikovEL1vpURVz1fRUzmpD7uDu8QRAZ9XJPPqJ7YJXGQj4t4P1z6geBljWcdFXr2JqJ
	 j6vt+/rjNEkYtUvhyTqf7bl1WZ94Pkw93M1kNi6grVHYb4ztL2hOPJK4cCXXD4k+yGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025468;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=U/9XfZET71DYWQeWdXA9lUIqEGmTY7QUPfBxbI9EKdk=;
	b=aIYVXX37clyHSKMb2rmF7oo3CRQUP9X3N9vjtGv/ENvXerZQjdCWx+708UYRSay7D/Hz
	 MTprLGRkOQUcysEUtKqoyG2SNiHq6jWPI2t1nJ6T8X2GdgF2TSEfBtTC/AqtgV6X6QYOB
	 sa8kkAIywmmlAzCqQmSTP90KuQ0voNvCyFeDVmRopz1mXzcuHCNgBseKh7ZzRkgILMl3Q
	 bxHjdUGSzTW9MWt+Tn6vU7vELRkpjpihu4oXiuE5BccTSO2HzDgUgmr37g9unay/KcTEG
	 qinl6boWMD8+o3TPA3PFoCoSx2IXwXbbdfeCPUWseVkNJLOFCcxJ9Cw0KdcVtdilTBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apgUEkAi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D660A2613;
	Wed, 18 Nov 2026 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apgUEkAi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68DE81F000C5;
	Wed, 18 Nov 2026 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795025468;
	bh=U/9XfZET71DYWQeWdXA9lUIqEGmTY7QUPfBxbI9EKdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=apgUEkAiZPvVpdEM7GH9/yAFQi/8J5gRWc4RR+NW8kEhmStiSxiWmOGsxhdwpp7/M
	 3fwfguvTcpI92FG06OC4fSmIqrfn1GauHvfaVA7H2eBzHk9ROlvE/ys0m9e8mDBd60
	 Ydu5LXHfXAN0k55J/nddQiURXHyu6nVF06ku/O9jn8UtLP6AuDisImNhqZvk+tOCCK
	 egtNaYm23SsqwuH8scMrKv3YwBLNsEOPxZl1RR9c02D8C+1kv/zTeekWHKTAG0eu9K
	 nLPOgWd1XSc7mcRbWsZfmR9v0O4tDNOjOKeDi/VYd7ZQ0icXdaOyVs6XOFs5Exdq91
	 GztAgoVI5TfCA==
Date: Wed, 18 Nov 2026 18:11:04 +0000
From: Conor Dooley <conor@kernel.org>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: light: stk33xx: add stk3337
Message-ID: <20261118-brussels-spearhead-2bf5e247829b@spud>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
 <20261117-6768-stk3337-v2-2-92f4c7be3bc6@protonmail.com>
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
	protocol="application/pgp-signature"; boundary="p/pHSUQxsDxL9i3n"
Content-Disposition: inline
In-Reply-To: <20261117-6768-stk3337-v2-2-92f4c7be3bc6@protonmail.com>

--p/pHSUQxsDxL9i3n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--p/pHSUQxsDxL9i3n
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3qOAAKCRB4tDGHoIJi
0kS7AQD7ciZuSuQjv8RdPyxOz2SjkhTFr6fgZB21sc01XdaY4wEAqkB+YzLJEJLx
LFHemNSQh3XOoOPCpVa+/lcB/c7RVA0=
=J1Y3
-----END PGP SIGNATURE-----

--p/pHSUQxsDxL9i3n--
