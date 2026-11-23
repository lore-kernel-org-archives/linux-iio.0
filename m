Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453682;
	b=hKXN+Js3VIJQ1UyxbKu6Rn9ZhnbMCfR8lGEEryob+sqCifkMfJ0fVYXzJi20dxzRIWbM
	 2q3tUJA1oTtxLrpcc6h1SQWVIp9AnAAgBCCgC03gJSTcj9/8lDWIZvCkmnq1aIbamKpgw
	 ohdpJRxKAeXpqTQ1BK9hNGAWlgJsiYmxf3LMTmsaNoxp+dreYIkUwNJV2Vl5HN4axGv6D
	 NzrbCjxi3+llIGzXjuIJh4KpedYOoB53wHfMihS8xbAWOcUPE/agWP0YjXQE8QOspCo6a
	 oNMZMLTuxkN8pl4wqxks3Vbsaq9/5sS56d9WstgWYXNtXwAhuFtL0MSrv5S9B42Qd8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453682;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DlOdsAbl+7GPy5K40QdjPtFjdnN5GP44VrhDUatQmqs=;
	b=RkXW/7uMTJ3CIkMtqoz0FBytBHojdQZjKUdIOgjn5MEGoxh/wHczrJqCqcfsdWhV0hB4
	 TH03CACgClwlXZv7/PtsvrheLc1lujxV/zZ2Lig7RGHnpcmvcnqI0OkYktV0Z3IfRWrvv
	 xkQu/4V1RTRZGxIUGd9u8AvLZdkPOlNjjUtwnqC7Rp9KBV9S912mRjPmrvKMtXPHv0w0z
	 F3ZeJ+kcrZQ4CraSOKYnv4q86U5OgkpFx2G1BER7taYTJ2MqeKCNBVIGGSYme4z6uRtgg
	 QFNtLnbAVAsWZbyvuyhstZvBzzfwaNua2lB+Jf/hqpOh7xrRz6ij7B6o+ubNxP9n2Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hq/CIiDe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F14606A31A;
	Mon, 23 Nov 2026 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq/CIiDe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A601F000D2;
	Mon, 23 Nov 2026 17:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453682;
	bh=DlOdsAbl+7GPy5K40QdjPtFjdnN5GP44VrhDUatQmqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hq/CIiDe0OP6u66SeqJ1/t9AN0UcCaHCcTZVdClRVs2zltCok+PqRzRnE5NIfrIIg
	 eQAxPUpHAZH8QSWaIcMynaXEifLFafHi3I0rs3zl17rDX6eg92G6s4KjWfJFJOHg9s
	 I+aHC3wv/9w7LHfTZUPnsjDa/4Ukwzx/bFev7CWFS2BNgN9+lHye9eOLIK/uKO+CuS
	 IgIJiUP2Yq59wK/lVDX6R1nEwvvEioqEKWOGi3sMK/GrB/l3sMxJm4TZxTOD4FS2lk
	 Yc/NIeKTDV9tn8AydAwIT6EaHDmYeNKiusTF8s58Z45vGqdXOMbeeiTvFcoWmwzRSW
	 n24s8yrzdtb2A==
Date: Mon, 23 Nov 2026 17:07:57 +0000
From: Conor Dooley <conor@kernel.org>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] dt-bindings: iio: light: stk33xx: add stk3331
Message-ID: <20261123-emblaze-dismount-b03962c99a21@spud>
References: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
 <20261122-6768-stk3337-v3-6-b0d0a924e843@protonmail.com>
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
	protocol="application/pgp-signature"; boundary="OkWGF633C/Dze2zf"
Content-Disposition: inline
In-Reply-To: <20261122-6768-stk3337-v3-6-b0d0a924e843@protonmail.com>

--OkWGF633C/Dze2zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--OkWGF633C/Dze2zf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawRy7QAKCRB4tDGHoIJi
0jViAQCaXQ2kHbIfFQRLocQFqn5kifQGAjCZ8YeuakKAEYTjmgEA0hngKuGnvhC/
4u286bBbTHC6FVKqIhWjR/JKSxnkJwE=
=wg8a
-----END PGP SIGNATURE-----

--OkWGF633C/Dze2zf--
