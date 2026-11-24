Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795545257;
	b=xqW1yH8PTtrPr2qbYGvKpvJuKKm5sEUhzYOz3pimzGKRiS1eujTcHNM9ZILR6w0KTqIl
	 7ScUAb79rl5rJKry4F50OFb7PTw3elCFPMcklDIbuNjO+GslFT/b40b7yfQel9QBICszd
	 5qcngS6i8/beAC4k7+DF6ZsBey4DoLauRXPfXu4M1mex052CIKsAW/erndsIKNMz0Ntfy
	 ik7WgLaw9+DcYaqdqxsTXXV9AZTmelIDA1RwUSGgkksX7+E9GoxTmLSg2Kh4sx6v+M8xP
	 5sPiVNFCuKDyhKSa1pfwtPW/PsU8+awbnd0WJh6E5pIwMorQb2VLYGJ+jpuAIeUMbsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795545257;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=acZycD1lQv56qwrusDLB08XyZ4Og2aZ5TDtWj5mWP+c=;
	b=421K5Bu3CWor9ZUQMZ19T2BsMllQVDMjsch+ygojwby6gny2gTXyFfrE+OnaEhXG5x9K
	 NAUGs/BGIu0oBOuBPEVk8MeYBnFhMZIyam49vmAa7u3r3bIigcnCn9BwBuf5heZ944IYh
	 Gvsz6b2XlGN21QvqTpPq7bg6r1SGncGEHjdAkqE0aZ5qMTGqgbQF+B4lQzegFt08ukh/7
	 WuAYcOBogS0+ZEadj1F1h3W7dbY0v1KjuyZeYqzOIyeTXZUvvxYMxwCi2Kdsfb6QjLLKH
	 NHz2Km14YDWRII/V1cxw5FziK4HNZ1WWB+ULwYqwlwGhHVucZwO8+mFfIO0mR0BFStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHC7JFsx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D089606A31E;
	Tue, 24 Nov 2026 18:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHC7JFsx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539DD1F000C4;
	Tue, 24 Nov 2026 18:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795545257;
	bh=acZycD1lQv56qwrusDLB08XyZ4Og2aZ5TDtWj5mWP+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nHC7JFsxX39tcr2Q1+y5Fda1d1WTW8BOf44q37v8vE7f+HCnUQtNd4gxwu8YaC0q8
	 tO4fapH5cAFwU5Rzs+bpi2DNuhZuM+MhaFfKE9wjXv948TuRYuh2lwYuPxReqE1561
	 ugMpXahAcMtaUuzBbPkVimq4sydICIsSLj9cLN7EozGW+RXtaeCDzaKVUIG8gx7Cup
	 qA/L4io7E6ii4Twy1aoNrlmi9zcwv9PnUUzG/Fh91xUEe4aDYJfSazLI1a5cyOox38
	 NPFHnMaV5w9BE3ZuUK5iyBlQLtZCds0mFqz1vxn1qVQC8stIavDSx4zzp4gJCOekTJ
	 EI/dDvLKPNwqQ==
Date: Tue, 24 Nov 2026 18:34:13 +0000
From: Conor Dooley <conor@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>, linux-pwm@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/6] pwm: core: add pwm_get_waveform_step_might_sleep()
Message-ID: <20261124-bath-runaround-dccb788f14e3@spud>
References: <awVki6lC3SxGfqSl@monoceros>
 <20261124114714.611570-1-Nicolae-daniel.Deaconescu@analog.com>
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
	protocol="application/pgp-signature"; boundary="c6BBEsVoccdwpXSY"
Content-Disposition: inline
In-Reply-To: <20261124114714.611570-1-Nicolae-daniel.Deaconescu@analog.com>

--c6BBEsVoccdwpXSY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 01:47:13PM +0200, Nicolae-Daniel Deaconescu wrote:
> Hi Uwe,
>=20
> Yes, that works. It is how the gate duty was set before, in ad7625.c, with
> DIV_ROUND_UP(NSEC_PER_SEC * pulses, rate), which gives 34 ns for 4 pulses
> at 120 MHz. I'd drop the step API (patches 1 and 2) and do the same for t=
he
> new parts, but i don't have the clock rate, and without a clocks property
> I don't know how I should get it. The PWM core has no way to report it.
>=20
> Conor, Uwe: is a clocks property on adi,ltc2387 acceptable,?
> If not, how should the driver get the rate?

My opinion here has not changed. The clock is an input to the pwm
generator, not the iio device.

Using the pwm generator input clock in this way is also inherently tied
to one implementation, since assumes a particular relationship between
input clock and output waveforms. Were a different pwm generator to be
used that had a /2 divider between input and output to be used, the
logic here would break?

--c6BBEsVoccdwpXSY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawXYpQAKCRB4tDGHoIJi
0lRRAQCIoKJv2Wmk0cmmDwKqfXrHgKUa5XKzWALicDBX8KoUKQD/UkM7ygos5j1K
Ot/QmgjKEsFwU2NJFvwcSxcUJtZ5xA0=
=wr0Q
-----END PGP SIGNATURE-----

--c6BBEsVoccdwpXSY--
