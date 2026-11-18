Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795025272;
	b=Bdk2limDzppsDpzjTYHn49dbYuYchlHwGNsc5cMYcY8UwEe6mWgMVo/Ch6Xl1BMe20Uw
	 xINdlyUNEDyC1bJMNuYnM4FAy0AtBVe/MT/WwZh8uYkItXlv1RNAVoYRnSDq2CE7xPKw8
	 /uftdF3AD+rKOIk2v+da+gH51Tg6tFSIt5oI1PwV0pvAMUPLTyaacOAmgRRqJWJLDdfsx
	 62Vj+Pcjmaeu/CHXYaHQno6z7kMOmvMQH1Lef9iXlUPiJkiOqoIpofGR8lNnAj6Gzzbk/
	 SF8rPsLCCsYEqtU7Q7wOs8imdTmkW/wL8L5y/o3VPZEJPdWPwE+otNKxz5aoMawGYdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795025272;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wpt7RtK74w94P/5ItBiwuRQ8rzwDJ7aLYXeH7HucXKw=;
	b=M8ddK164ULWKEqqcFKm7sHU4Xjks88mY7MWSV8EyiP5r8w3m8kaOsJ09uzfRh+dHRAx6
	 mJ0es2zOGlvUMm1zQmfpXtjT2eB7XEXvenSstGcq/mza8O5oea8BLOkN9FcRiwqS5KXtc
	 0RFJuBBFSXs2X4WTXAJ9I4UHx3kgMdWzx0BDSutSDrCubOcexIV+mSWIzxHyCqTKr5xYY
	 +CVVyz/QkRMMNROXlDCA/j9oEuqkBzvqLg5eGInS6dogg+cj5rz9XZckbklVFVrmWVVza
	 VYvJiaC5YFPVlsBzv7JRCwvN9Gy6hGX9t3yLchNS7L5WA4robPD/h77+PjKVbIBWbWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kz/C95zI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC4F606A335;
	Wed, 18 Nov 2026 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kz/C95zI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A2F1F000C4;
	Wed, 18 Nov 2026 18:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795025272;
	bh=Wpt7RtK74w94P/5ItBiwuRQ8rzwDJ7aLYXeH7HucXKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kz/C95zIAwPWknSt2Ijoheo1JwnQduaKUWcQwSa8awebRAGYP9fvvGRBEoWePSTvW
	 lc9UBN/fpYRs7qxw8AAoCjyL2qKM/PRoN0hXkV8DCGl/BIO6wLfY9piU+jRBbBBkpa
	 5Vjlh2777nSyKNb1nZ0KP9e2Ga1KwYBZrF+yZ7galPSwrsS3E4XUhqvP/pDhhN0Uaf
	 brbW9T3St4KNQjTiQgiMWdk/GxQyIyqokNz3u4oZYXTkN1VgEyNNhNcsoLPYsAsDKv
	 nkaW1UCet+CYSmhnBxMverm5UGEkgr+Q5NQMAIMXnotWSJckTqjGLmL+BoCZxuZOVE
	 XX5QIgRY/JZ2Q==
Date: Wed, 18 Nov 2026 18:07:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: iio: potentiometer: Add Analog Devices
 AD5246
Message-ID: <20261118-professor-gauze-665bd7384668@spud>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-3-ef6b7c06d4b0@telaak.dev>
 <20261117-object-glutton-d948f8e36ae4@spud>
 <CAPY4CJ6dAt1YGcd_u6SJW6A_tBUZrZUZyie6W9Pc0Q3NHwXGYg@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="mEll4gXv3Mt4VfNP"
Content-Disposition: inline
In-Reply-To: <CAPY4CJ6dAt1YGcd_u6SJW6A_tBUZrZUZyie6W9Pc0Q3NHwXGYg@mail.gmail.com>

--mEll4gXv3Mt4VfNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 03:04:25PM -0500, Joseph Telaak wrote:
> On Tue, Nov 17, 2026, Conor Dooley wrote:
> > Why is there no fallback between devices? Do the different resistance
> > values affect the logic? Please note that.
>=20
> Yes. The versions differ only in end-to-end resistance, which the
> driver reports as the channel's scale (R_AB / 128 per step), and the
> part can't report it, so none of them can stand in for another. I'll
> note that in the v2 commit message.
>=20
> > Filename matching a compatible please.
>=20
> Will do, as adi,ad5246-005.yaml.

With that,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--mEll4gXv3Mt4VfNP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav3pcwAKCRB4tDGHoIJi
0u6cAP4nxgrrvBwu1qroui/peWw1uK51tTZaIkAX0XJw04ntLAEAo6fYmwsULbBQ
Bj0fJC6NWwKV1Tuy4RnWY4G6dW0PUwY=
=TRNY
-----END PGP SIGNATURE-----

--mEll4gXv3Mt4VfNP--
