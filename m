Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984662;
	b=enWUGqenUrwLK6RmNSzYpcV1zzaq5Ojk4Yuk4ZHK4RnCMHxjPUX3N9LrWOoYw3r+miBu
	 pFhqHOi09d1k4RZ9tZJ4AUDAitFsWFX+5eesUFWM01GREK1YNeZYcczuz4+lsaMhJOtwG
	 ZsDmdq9+TJcLJeRPt4ABREwd4FaZFsTNg2eDN62e+uJsUiq+atP/OzgxoRqI+BKtwQRlh
	 BcgmtgMaDR8DSpL3juLWUnlY/onai9dPESmPhoYIvoDrHLbeXwRawHUAKoAeaGhv8br4v
	 YrkiUde7HXsaK3eKeuEWLXmvh7hV+9OGRMRi9TqqyOPDKejHTUwHnv7/t7Hxru3kLUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/qwHj82ZGjV8oGUVTL0UP+HSV++lEMiXBJ4f5EpTCcs=;
	b=Fn6rQyOr61qJVQ37Wvbv5WniE4yAUtMmkR6Cwg5gH6dtjyn4B4zr3PEH7xH1+On1SPkE
	 c4mRj/TwQaSfiZ5bD3DJnAnIAxhXhzGw1nk90twUceVmGPOGu9EmS7TEMMC3qg9V580Hx
	 W6I3H7Xydy4bzrMdtPjEkiPg0Temfowk0uHEKGMHAd19nQDkyoe/GkxCkHLNbCtg90Eyf
	 8pNaXzsEwyCifvk7q++wW6GDGrYsFUJIpQ5a16me0vgVJ1vcmQJcfmLj7N4tWz4rvtb3z
	 gjBX0HhBgeEHy02E6OF3JGbmeu+4oJCd/qcperP6Dp0vg2Wm4bleji8xUvd70U8VhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FV5RO/mf";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92913606A326;
	Fri,  6 Nov 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FV5RO/mf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01D31F008A4;
	Fri,  6 Nov 2026 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984662;
	bh=/qwHj82ZGjV8oGUVTL0UP+HSV++lEMiXBJ4f5EpTCcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FV5RO/mfnOhj/UXvGJ03d3YWAJx2H74CbqBHlVVxOJPrwBETRSSC37hgKtBSRXGsu
	 0DQkoNaMhknpoCPGNv7g8Mz0JaCByZaApKpPgAsDTkePKkw7a1sxJ7Wq4CFVrIPPXM
	 EEG6O3KzLNy4Xr4OHinQeRfouPSb4rZu9jMMz8fVfA7K4k+cAtts/KVbwKB1vbJ6jP
	 B03nTF9deu+BdyIRyB/4aHf7DQcWvt6BSUiUXptKNup3D8dTZNE/JA7TZNDKWxraXO
	 PauP2vYDcaIj4/mSopDwrObQqgA1Yagf3bM9smeZ8OQ0X67aTyGcPBl8LU5ukrZmkG
	 ejHJemFOnpXag==
Date: Fri, 6 Nov 2026 17:04:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Joshua Crofts <crofts@kernel.org>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] dt-bindings: iio: adc: add adi,ltc2387
Message-ID: <20261106-usage-sarcastic-ef377a65e293@spud>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
 <20261106160529.876251-7-Nicolae-daniel.Deaconescu@analog.com>
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
	protocol="application/pgp-signature"; boundary="6Zm2+GCoGcbtJ0mH"
Content-Disposition: inline
In-Reply-To: <20261106160529.876251-7-Nicolae-daniel.Deaconescu@analog.com>

--6Zm2+GCoGcbtJ0mH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--6Zm2+GCoGcbtJ0mH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCau4IkAAKCRB4tDGHoIJi
0iueAP9jmAfn1jcU1E0CQxnvOVAmJfHXQT7RW7NOL4BYmj04uQEA9fCtpJwivUlD
/lvw4diYBrzR55OtM06oGpeAmRguMQo=
=A6CV
-----END PGP SIGNATURE-----

--6Zm2+GCoGcbtJ0mH--
