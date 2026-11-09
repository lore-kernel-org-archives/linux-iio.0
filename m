Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254568;
	b=Vssy2k4bqDy1QB/ca1RsXuZJ2VgRjZznsveBxuHfCueNyFRyYfejg8W9LqQyHNd1iBo7
	 v0eU7XKwcbH2I1AcBYcQdK6x4OoLRQ/i6QE3WEYsE+jfiY03TaTaqOcUT/MbTosiAMnWl
	 LRIxO3OAF/dc54w3f/j/hUNwQPeOphb57+lA8zKiykBtvsCXZUCdBN01WMzPI+0txmAEy
	 Y9n0QCUmV8W/OmaE7zm6es0IVpu78mrfkmdt+Y91U3ix3w0BzY1t5Br8Ya3a0gL1KO4/2
	 j+mHaduqjCgc3UudznVfDoIGbxepVxqkoRtAtXP/a7q5qBNw++RjEzMI1h1oJodm0BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254568;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vNR0ykVAHEtqTIkdYCm9V6E0Gs8h5risRxDrcudv7l4=;
	b=JvvTqhUIpVr9YektNn5ayZ/0m+MJsEN1ZyOiCakldohD0Ej3a/2/V1a1pv+3VH5TEVhC
	 wqTjV+hQWdwbd87u+2lpfAFxghkfo2rDLVxVA1WHke18LGO+JsrUoxessPBGLUp0t9HIS
	 hzGun4gPziEfPRsgCG6anOqFcjF39m+9qtZOMtASaxSuWlNPZWZowHKzOgKZmQ8KpeEe3
	 ntLhD4ow1iSN8W7BzgBF0mjs1iiCZRQaZCCWrfnmfYxT5ReOYiGN8nEAKBgFHztTQWEmP
	 X/245T4glLlt8TOCsSj7Ft7YtA/Wc0LMBmFxH0tPHikYsEj47mx20Z2qNDgpXTtCqjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wc10VUTz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EA2606A321;
	Mon,  9 Nov 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wc10VUTz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4867D1F0089F;
	Mon,  9 Nov 2026 20:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254568;
	bh=vNR0ykVAHEtqTIkdYCm9V6E0Gs8h5risRxDrcudv7l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wc10VUTzHqmn7VHFrA2EeDbMEi790+7b6BBK/XYspp1338MBDZJNKaoPwcC5FNdWq
	 v4XW3Jfm9koRq6Ok+1zR2T4FsF/xKHbmp8GxFiP9r+n8rUy5me2zg/JYKAHpTlU5vj
	 7sAZj6Bb136TA4u8LshcIYV1czDoU4uwwIZ4CgfjdNNHDkxgxYhAy/DasHCV3vN3hT
	 07v82vj7rDkJZH7vQbswjdu26LiXhfjIB5tBl7Uwo0VW4Bb80FTarWp/G0m8detQl3
	 AK/d8tZhgW2TFk48U5cjqmeJZqlhYUmzz640sL/KbiqthCQv8gxexiLoPgbG2TgEM9
	 Ibjc3lbUW2uZw==
Date: Mon, 9 Nov 2026 20:02:43 +0000
From: Conor Dooley <conor@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v1 1/4] regulator: dt-bindings: maxim,max8907: Document
 io-channel-cells property
Message-ID: <20261109-chop-antiques-207024c192de@spud>
References: <20261108095634.100517-1-clamor95@gmail.com>
 <20261108095634.100517-2-clamor95@gmail.com>
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
	protocol="application/pgp-signature"; boundary="LDUk9pA1Tl28Sgma"
Content-Disposition: inline
In-Reply-To: <20261108095634.100517-2-clamor95@gmail.com>

--LDUk9pA1Tl28Sgma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

With JOnathan's requested change,
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: changes-requested

--LDUk9pA1Tl28Sgma
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavIm4wAKCRB4tDGHoIJi
0k22AQD2RiPcErtLmCDgjFTS6DBOlpTiIqr87AKu8fpmvXl2TAEA5QV1Ps/+wa3v
rSz3rotu4XV94o3kkTmtXwPJhpFBtgQ=
=twVy
-----END PGP SIGNATURE-----

--LDUk9pA1Tl28Sgma--
