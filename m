Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795110276;
	b=3DvwTDMNPkpOQ0eEiM9f0rcDSJ8UwKQfuLelx/sXM+fcffWHBXvTwauDRCVxb7uCynkx
	 fSVW/rjBzieqpO9q9gJn1wqGiR2Ob/85PK0nNfT5I7YzUcHPhbS6XhXVBL0DFjg2ir2A/
	 q8NiP9ofgFDjigOK+M7YZqzZsiz8yjIoamP91caks86qPaXKzO7cdCo4FloynaeKVrxAP
	 YGc+3yID8aYe5O3+nt6O31OM/nNDT9QX/dtlbjHDYxNEQjvb9b5eVkz4CFF22/Fl7BvyF
	 BKcIkHYwFacJ8QZNHO8/1JoegKqglqCUaALnPtMi6A9ujTlcsyUDNvxIIYyOPB+bIFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795110276;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vaCr7lHWmBY5KuXQYQ66g3cSsqyU04We973WTaTAJlo=;
	b=1A4QWSA0nVhzsnKdAAZZ2KCWshHiXRGwA9y+h8hR+GBnGxOIWaxJ/eaDkg0BpdwYu/Ag
	 fL+1FG004QR9olUgaXbhioalo+iZcjW89PEjVqTT3hN7mPqObvgmsvJpfBvjBP0riZSTK
	 yInJVIYZyFV4raxMbc5tsXUOvrWfailLzIM0O8Big6njheG931X2HNvlMvCk2EBT3VQ95
	 zhGHNeWskeV1qqn6VtgsiKhD+I8HZq/r05B3CdbBlZH16h5z4jrksBO/UEl5fjk22mUqW
	 9mQ3sPcgEWlXUrRhqwbDIn+g3q43cYO/yGMFd4xzsvnvDkWjrZxfr0DiuVcNk415qTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzSkSivR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D52606A324;
	Thu, 19 Nov 2026 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzSkSivR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF1C1F000C6;
	Thu, 19 Nov 2026 17:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795110275;
	bh=vaCr7lHWmBY5KuXQYQ66g3cSsqyU04We973WTaTAJlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kzSkSivRBMt7tccTvhk73wJCZU9yzaWe906e2i0RHNwjldhP1kPsHU0YAi53kkCqg
	 UVMRru1qXMG30wuL5l0j/75b/E/ZMB/6pkmE3I0rYIFOK57O3fHXzYbtVM/vo18F8w
	 cMfhKpeBMpbdE67gNmXapSf6ALV19Jh8AbsY1BM5NzVADQoED73ngJq4aT0L8HfW9D
	 1yTw4ac3b5WqT+gOdoJkEWapjltdmV+5sNapkHscCUGdzKoc7eSvgCplviOBOLmjvi
	 o978+CzFFDEIfpNXhVpnMuDYgyuIDyWlbh79O8KmIO8/Iy1+Csp8EtoW7HiUslqWPF
	 dSy4cCfGcTCzA==
Date: Thu, 19 Nov 2026 17:44:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: iio: light: stk33xx: add power
 supply support
Message-ID: <20261119-plethora-gravy-356c3c4e95e4@spud>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
 <20261117-6768-stk3337-v2-1-92f4c7be3bc6@protonmail.com>
 <20261118-coyness-luminance-6d0c07e843b7@spud>
 <20261119032903.4a0d3bf6@jic23-hlaptop>
 <20261119-giblet-epilogue-45f554c009ce@spud>
 <rCA4M9_Cq5I454sOmHgrTZ4vHFIBNgY-cfUz4wkZVVWJDhACNFHf6CPFRSJgGMwP-ntUxJ_osLG4heh6byvcqRtGwBuu1sOPnptsFXBWD8o=@protonmail.com>
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
	protocol="application/pgp-signature"; boundary="Y636xT7v0vaDx0Rw"
Content-Disposition: inline
In-Reply-To: <rCA4M9_Cq5I454sOmHgrTZ4vHFIBNgY-cfUz4wkZVVWJDhACNFHf6CPFRSJgGMwP-ntUxJ_osLG4heh6byvcqRtGwBuu1sOPnptsFXBWD8o=@protonmail.com>

--Y636xT7v0vaDx0Rw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Y636xT7v0vaDx0Rw
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav81fwAKCRB4tDGHoIJi
0t/hAQCc+dWb2Dc3trLBnl2ZNslj+H1EA/UEflz6sRgM1B7vCgD+Jx2yGoPEIpPG
hBSurEtJUOB4LmhonFeymhAAvjVrJw4=
=j2Hb
-----END PGP SIGNATURE-----

--Y636xT7v0vaDx0Rw--
