Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777064;
	b=tqPx5sZNyIXqh2P/i2MpBe2qGC4wimSh+gWaPfIBpOq/xL4AB5ME3SBSVbswfezk7oyN
	 O/JY6jTK8GKGEDjVmpF5DLoz/mMPM9hwzkfkqZn5cySuocMcUFe+GqcsgOJes9II7SjdV
	 iP2CrPCMAsQZDSXupQuI4suP/3UjnY2WdbAvh4xZmtKte6y6JxLxUIhA2jUlcwBzon9O+
	 coUpJi4Y/rQdugxJfnYfmjzr3PBYzU2EiruTqJ51bYutWg4tesNFqa4tH7jNuD9b2Ro2p
	 n5QZfrrc2DN4TqHX74bqYGknc79eGd5Mm6OCdFQ1i9JBcaI2D3Fc2bKD85B+z9A+MSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4SM4YBD6lUzD+hk3iOr9i7/VjypaevvBMuwZxI4VpqI=;
	b=dny7J2vM+1znvgtApVsLHObxcpA+8t8lchgp0N88kOjJlRvR6744ZCN+zr+1T+MwJPSh
	 B1ghVCRrmP2bIVwnVxPFbc6/Tv45xRMWN4spbsHP8aA/xNIeehzAa5/H4jGCdYzsVcFTh
	 kIIgqPFKEr/gDZrhk76ZM17V2S6Ufwe9nORSYzGSXDRujqr+gRTMULWTzb68AGnS85NT4
	 VH09z3yC7fx6dhIe9WBLT2p+jW/tTfuTOYMK9J48YR6eJmDyaYt4mmRW88EAJ20rWcM/2
	 qmCZHaP7FHXNIEoCShqDWz6yqFENNr4b8rcPuyGUfUcDxw2EAUjYrMzueYCTvtDgz3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqp2iPHp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EE606A31E;
	Fri, 23 Oct 2026 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cqp2iPHp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B909F1F01825;
	Fri, 23 Oct 2026 17:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777063;
	bh=4SM4YBD6lUzD+hk3iOr9i7/VjypaevvBMuwZxI4VpqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cqp2iPHp7fKQdPAUTUj0lCRddK1Rjl/QKlJRjO6BZDffmRrNeZ8Os/CsgMKSoaNrv
	 TX6gKewWoxBdq06VLcn0rD1N8WZtTemRTvkLfpqKpcFR4dq7FvTrC67xaa7a8+/Nnh
	 NLFA9YnmSftXRvpq9Q5t/wx93VjF2KBB0iQb9tlWVMnM1vhfRnE3jbUthhN9XzPq5v
	 lAnNWS7qKQvc2hOFPSzikyLjLcUIv0lvpMXuS2JCgFGNE+6Lomult0dO4o7l9VJ4ac
	 +U30kN1YzcihcHWM5iBd9KRNEPNXF4gT+U39MwDbqcEAMiego49p/7y+Uf5dYH8t9I
	 dDqkgNPiSEatw==
Date: Fri, 23 Oct 2026 18:37:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: opt4001: add opt4041
Message-ID: <20261023-purist-privacy-e079ae39f0cd@spud>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
 <20261023-opt4041-v2-1-ee320812804c@axis.com>
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
	protocol="application/pgp-signature"; boundary="DxVnmI0yXMZnzjoC"
Content-Disposition: inline
In-Reply-To: <20261023-opt4041-v2-1-ee320812804c@axis.com>

--DxVnmI0yXMZnzjoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--DxVnmI0yXMZnzjoC
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatubYgAKCRB4tDGHoIJi
0qaZAQDhFiO7gQ6R3QCOlDbr7+Rog8IhB5PJ5JmCdrOFfmDKtgEA5OyuShdHS04A
tl7Day3pzGxasIp5oYwEKvqq5jGz/gQ=
=/tQE
-----END PGP SIGNATURE-----

--DxVnmI0yXMZnzjoC--
