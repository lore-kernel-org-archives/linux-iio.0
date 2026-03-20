Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE7D3B19C8;
	Fri, 20 Mar 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028364; cv=none; b=h42ZqqvjEhFqxO5RKvtbgAinNmYoKPhTIZdMYFvf0saAs+GFIXzZPGaJwOS1OSy1twpBdcOCqcs6ancuJvfucbJiwDZbnHi5hZQUgPBgjlox3SdABV/E9t/ROw9bvPJqyoZ8pBVvvNXiF2aol+Sjc5Y1H4blLAN9ZlgwqQLN4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028364; c=relaxed/simple;
	bh=EmC83LvhVJvYi3xuGFTcrFTglNSFltf0KMf7Ig8lPtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1UYBmqwvGSosXPfaAfG/rKBOGvOqhr2mWxtSu620YcUDM5H4yx5IAoiE9vWtgU6+cNQ5NRJ49T0C4wBfpGxSP3BcPC9svkvb9Vu2iendkwghH78uGqz87B19FHk+7bfgOlNOMuwO7J341U48qLEnUSE12xOhI8IICNXzWP3EAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuNz7bzh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuNz7bzh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35E9C4CEF7;
	Fri, 20 Mar 2026 17:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774028364;
	bh=EmC83LvhVJvYi3xuGFTcrFTglNSFltf0KMf7Ig8lPtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JuNz7bzhidytfCq09kZKJwyJBYvyYes9xox3rnttDS0EG7HYV+aZWVNhJ2MMHjugV
	 UgxKzyFi4ZnvNG8+sEUDFGqBNwTDW3msGJxrIw9u42xAPc9C0kyufBdGv0zO5vowdT
	 1Lij6usCBGSv5b7Ay1RLCztXcmmmf7JzFf16rUjfrvM9Qj/qzuhQqRIzKHKn8ef9Mg
	 ceWH+RopObuNAJ4bimSbSCDWC1PPPCBgvK7LHR1bbtQxXfp64ZPow79gmBBzwXMp8O
	 4LIZOIMEBnzM4BTbC/X/Kf8ypKcCxFB50EHggzEB8+E9rV+lIUfVP42G8iL+GG8TZJ
	 AuX1X47T5xX/w==
Date: Fri, 20 Mar 2026 17:39:19 +0000
From: Conor Dooley <conor@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 1/5] dt-bindings: iio: imu: add icm42607
Message-ID: <20260320-carless-puppet-995866998b8a@spud>
References: <20260319182956.146976-1-macroalpha82@gmail.com>
 <20260319182956.146976-2-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aTCYQb8hepuZFpMC"
Content-Disposition: inline
In-Reply-To: <20260319182956.146976-2-macroalpha82@gmail.com>


--aTCYQb8hepuZFpMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--aTCYQb8hepuZFpMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCab2GRwAKCRB4tDGHoIJi
0n+2AQDOoSl2g8nQdYhadOyLnaeDez9zFjMDbF9Zq3NrhrkC6wEAlg3H0iNaDpQY
qvxM143+V4mX/Pk/IhhYY/lb/2LBOQ4=
=RDUK
-----END PGP SIGNATURE-----

--aTCYQb8hepuZFpMC--
