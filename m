Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B602237701C;
	Mon, 22 Jun 2026 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782130484; cv=none; b=ELB6Z+KFUmDmFCEfACV2dcZaJhrleL79KYL9D/TiTevdjDhaewTmHGBvGkWaZOCwkHiuBWyeTBUXRRGUedBuPCLhhLKAA+oLjCsOtA28TO227n0QdWTGVAf6IeFAoGDpaqkVbtRliC8qZioXr6sqTgA4VX8yGv4miYxfZokmR9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782130484; c=relaxed/simple;
	bh=TMGyjSuWg9NEotd+ahz9PPBUPALrJMSkHgos5n7VfdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyve+Otpcd+tKoZ9gQYrvXqYM5E3zBwtY/T/vtEBtAEkro9j70jFUbK7SuL28EyXkOecsJxi19RiGVR564yUrKkyilw9XJbYoISb77aYtObBGQ3OAntI5hD+5EMJ2KqmnGEQ9DiCJsqAkn8oVsfdxFZhqnWhkjN/hf7eaSbfkXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf6bH7JR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf6bH7JR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959421F000E9;
	Mon, 22 Jun 2026 12:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782130483;
	bh=PLzfOePcr71pjgrrJIYMsZNq9tAcTr1Q5rZ9mAkZxo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nf6bH7JRmYestHJ6L5m7duxYhRmWPOlDCJkaF+6uIb07B0HpySfeSvBy9Vsld9KsR
	 6QkZZOcWVxOWY2mdnucSs02EufXWFmvs+R/kSoI+pFSJ2u24c2y0y5LEeIoTq7ns5a
	 ud9n2/EKWbmnlpx4pHEZZpHpPJJW5f/hJc8hicy1Q2oB7UXM0QnbOzdUjktW+0MveK
	 6Ncj7Te+k7gzeaCGFHP9dSmTw2PywEq6AfFvPS5x055SfzV8hegsFUBBbjQn0ZC9ty
	 w+6Mr0WFWuQC6A/HaVPIP0QhP+Jf+swK+1BEmiIH2BUcXWKVfg3/Z+zTs0a7Od1qd+
	 8WIqU4JGCb3cA==
Date: Mon, 22 Jun 2026 13:14:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <jan.sun97@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260622-overbid-yonder-3fdfee9eda7a@spud>
References: <20260619-bunch-diocese-dd7805cc17ff@spud>
 <ajU73_TkKrSbqD4f@nsa>
 <20260619-concierge-doozy-9c161533c369@spud>
 <ajVlD-j0nIGrRVow@nsa>
 <20260621153330.79b6600c@jic23-huawei>
 <20260621-nutmeg-coauthor-715189372230@spud>
 <ajj6nEb4tATM3C7b@nsa>
 <20260622102722.5900592f@jic23-huawei>
 <ajkILRPq_g24g4dH@nsa>
 <caa54d52-72db-4c58-ae3f-1d1343bd7845@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8y2QeyvUNb6GDuqi"
Content-Disposition: inline
In-Reply-To: <caa54d52-72db-4c58-ae3f-1d1343bd7845@gmail.com>


--8y2QeyvUNb6GDuqi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 01:54:25PM +0200, Janani Sunil wrote:
> > > > > Why do you think the microchip devices won't work? Does the spi c=
ore
> > > > > reject multiple devices with the same chip select being registere=
d or
> > > > > something like that?
> > > > Not sure how things work atm. But I'm fairly sure it used to be like
> > > > that. SPI would reject devices on the same controller and CS. Now t=
hat
> > > > we support more than one CS per controller, not sure how things wor=
k.
> > > We always supported more than one per CS per controller. I guess you =
mean
> > > per device.
> > Obviously :)
> > > > Janani, maybe you can give it a try?
> > > I think we'd need to get it to work with shared gpio proxy which maybe
> > > will just get set up under the hood.  This used to be opt in, but see=
ms
> > > that changed fairly recently so maybe some of us are working with out
> > > of date knowledge!  I haven't played with it yet, so might not be
> > > that simple.
> > >=20
> > What I meant for Janani was basically testing two devices on the same CS
> > as in my pseudo DT. For the GPIO, you mean having a way to select
> > between devices on the same CS?
> >=20
> > For these devices the pin id numbers get's setted up as part of the spi=
 message
> > so my assumption is that all of them will receive the message but only =
one acks it.
> >=20
> > - Nuno S=E1
>=20
> Hi Everyone,
>=20
> I tested the case where there are two devices on the same CS. The SPI cor=
e does reject it at spi_dev_check_cs():
> https://github.com/torvalds/linux/blob/master/drivers/spi/spi.c#L631


Can you try again, but delete that check and allow the code to continue?
Worth knowing if the problem is policy (which makes sense for 99.99% of
devices that cannot share a chip select) or actually not supported by
the spi core code.

--8y2QeyvUNb6GDuqi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajknLQAKCRB4tDGHoIJi
0vvHAQCAmeichsIP4bHRKwfnmk99xZ27BMSq9pUtwpPzW/19QAD7Bf5jclNg0xtX
usoMbgm6dKZ+hjsZOwVQ/1WyKLl2egI=
=MAat
-----END PGP SIGNATURE-----

--8y2QeyvUNb6GDuqi--
