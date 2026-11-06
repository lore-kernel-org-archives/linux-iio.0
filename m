Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986597;
	b=auqXshx8/h47dlDEjX+Icdelj2tqBOxlv64scq+IQTPD/e+reQt0vTY3LeyPkZC/jpjd
	 E93xxAh1K8/VLM1aVacTU+3etJjXV3UEiRzwdsMpzXYhclWcNpkMaMqiDo/vtberrSBkR
	 f8CkWaEldU2r5EUW7HQ4cawQdxaaAszO45eyOmgEe2iZtoj+Mkq6lw4EVoygL/EQbzUta
	 Uli6Rf7jraF8ML9fjq7+PGgw6L2p+jNlOaYm6ARBH7CC8fvLbBtvfkV/j5TYnMoPoISFH
	 8PUu5YREFTYE9XrAT3YGLRnnqVdH8cyzPzQ7i22wH91cOTvd2gDAkIicokIJUQxCmUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986597;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0e9LuZMNoMztwmg9oOaGy1Gc1Pq8fMC+tUmfvWTIVcE=;
	b=cZrVBBES+HJMCnViHVeq2nMO2kNi1zOSQAnzs5Ylk/x+Ll834L5ui2itKtELP7Iad6Q/
	 YBR3vx1H+cpXoISVuhNuPxf2rlcdric4/FpJq4280g6KQIiwDyTUTRqJBtn5Ws1SXP/Vp
	 eSiJeGbhWuW2+MuzcgTeVtKnsGPEKTyvjq9ympR9mEdMEIIjPZaiLfWhE0Z5Gy2dCm6Tz
	 0/cI8JGxZ/KBGm5aYWUEfte+JY/t79Z9bE9KTMfEQAMEOkqbctARhSWMPWbZYeGhEq9Mq
	 CGyzMN0JCWw5vycTtDdcemOiwPYcYxRD2lITeXPMSoXbBdkGHsiGDmqpyynzA9ZZVzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpRDjbx8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867CC606A32D;
	Fri,  6 Nov 2026 17:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpRDjbx8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9B51F008A1;
	Fri,  6 Nov 2026 17:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986597;
	bh=0e9LuZMNoMztwmg9oOaGy1Gc1Pq8fMC+tUmfvWTIVcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lpRDjbx8J2ZMqUk0Ml02X9d+XPnk0NqHXEM1W2bJl9G1dGj/bxRXnGaF4MWryi3qP
	 e8XzeDLjOzIB3LXYEbdYMaNGzjvu8/ED4jsNsn/cHrAM87W5uruyqEwyTVYiXlDQtR
	 SUhsYymrsV9pIsT2R7T2AXSDcMSqByAI7e1tVFIoHNDg5t6/R+vbXOH4dPw3apazaw
	 VzgW31faZe6K0UyU/Jv1BJjux1gxgqDTkkusEeTO23g91myq4gsNE83tE0w5TROza3
	 jQdP5NRkf82D8W6fkGA85aSuZweDtR7O1ah943/9LN+XEFHzFca5ShLB1BsU2zxovN
	 0jE4UblaoQnDA==
Date: Fri, 6 Nov 2026 17:36:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
Cc: jic23@kernel.org, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dragos Bogdan <dragos.bogdan@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: ad7405: Add
 ADuM7801/7802/7811/7812 support
Message-ID: <20261106-guacamole-atrophy-c09d4b0d9518@spud>
References: <20261106073937.13927-1-pop.ioan-daniel@analog.com>
 <20261106073937.13927-2-pop.ioan-daniel@analog.com>
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
	protocol="application/pgp-signature"; boundary="e23oUwJ6PluqAHqp"
Content-Disposition: inline
In-Reply-To: <20261106073937.13927-2-pop.ioan-daniel@analog.com>

--e23oUwJ6PluqAHqp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--e23oUwJ6PluqAHqp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4QIAAKCRB4tDGHoIJi
0u52APsHyVIVIV9X7CqFa1hE0vdjHaccjf59ZTTXdqb/e4zEWwEAkowvUFbESa5k
AFf4v4liOT1Aaom4+6rVvqC2aVJ3qQE=
=5HEh
-----END PGP SIGNATURE-----

--e23oUwJ6PluqAHqp--
