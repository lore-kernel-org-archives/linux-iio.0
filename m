Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA9D32F748;
	Thu, 16 Jul 2026 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204903; cv=none; b=OCfaM4ernSd+bzr5oPXQOT8AZv+mLhG7qRn6qA1QZTRj23DRZM2bm5mET2QUmYd3kuXklWxs5Wr1A1BZQKzEcwBmjQDmYapx5GSjTGBTiFcb8EvGbY3OnCD7MQYuYaRKH6Wf9pRJHdg8jeiyJyuw8G04S+2JrroMLkNIV+mQbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204903; c=relaxed/simple;
	bh=wJ7p5Hr3Ml/fLDeBV/Zu4Sbsm60AoLyZMW028tpDjm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2HbvWQC4T1E3sdIdSRLiUnX5T8/uv05VofbxX7miuTnE5o03W/VrHT2mvLonAj33W8S/bKneAOzCJGEdd5S6BTtk5yF4gfgV29Ume+bJPLqRdV/aHMkuOF9yrWsb+x0g3wZJ7J2YN6UB6Vre3JsxjUSR+18NanH1wFbJ19RVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIjvw7KN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIjvw7KN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4BF91F00A3A;
	Thu, 16 Jul 2026 12:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784204902;
	bh=XUIXHAwtnYb54eJLERQoBDQ0TalVjOeh99dYSm21u84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LIjvw7KNiotlHlYOeYCOrbA5z3nJezpNhPtw87oMaAgako67efja9MAJTHpwM02MK
	 Ibxkip+8FA6F4k6daxISORKx6K32aWeyZbujMphb7LlEeF85QQIEL/rTZd9D3OZdM7
	 Q3/4y3ov94QWm+xnRZlcnIpfHsn9x1uvKeiFElnKLYfE+zbmUG+WTg8qtzqMDI+rJA
	 TAb7zmXF2P2nPI7I2rxSP1dtGBIBs8x5dhlH5UkBKT8HYQzft1U/UH2x+0leD9hmUA
	 P39YQsLez90Nhqj8BACRQzjiPuSfUJ5nzz5Ww3K+m+gHty3TnGuTCvKmoOPrg05pTX
	 oTo3k/SjhBzKw==
Date: Thu, 16 Jul 2026 13:28:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v6 1/5] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <0e3e45fe-4c34-45d0-b985-0938f60b5914@sirena.org.uk>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
 <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>
 <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
 <157154d1-3995-454b-9e08-1527f1c5d409@sirena.org.uk>
 <jsximyohkijphqrtgat6cjtcvtirjsdtbgn3lb6npw6yhgmcth@tq64dotfowss>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZikkrN1PM8gmKHgy"
Content-Disposition: inline
In-Reply-To: <jsximyohkijphqrtgat6cjtcvtirjsdtbgn3lb6npw6yhgmcth@tq64dotfowss>
X-Cookie: The more the merrier.


--ZikkrN1PM8gmKHgy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:22:19AM +0200, Nuno S=E1 wrote:
> On Wed, Jul 15, 2026 at 02:37:12PM +0100, Mark Brown wrote:

> > You still need to work out how the ID appears in the byte stream that
> > gets sent to/from the device, that's way more information than just a
> > number and not something the byte stream SPI offers is going to cope
> > well with.

> Not sure if I'm following you. Those ID pins just become something you
> need to set on the spi_xfer. Or in Janani case, she's using regmap
> reg_base in order to set the right thing depending on the address. I
> would image this is always something that peripherals need to address in
> terms of how the message/stream needs to be set. So my understanding is
> that this should be pretty much transparent for the spi core.

Oh, isn't that just multi-pin chip selects then:

   https://patch.msgid.link/cover.1783729282.git.Jonathan.Santos@analog.com

--ZikkrN1PM8gmKHgy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpYzl4ACgkQJNaLcl1U
h9D8uwf/exdzBvd6yn5UOVsD3+eaC/9G057ZONDF38P6m/7xH6Op5HHszAyQ7FMU
nl8OpLnOpeI2aMd/h9AyhIEGi+411pwP0nrlS2+gt8FJL3WMIBeMTUrPF98WBUZF
5SiwiZV3QjPdSzc4pvNyvoBiupU9hdCi+IU+DcigvAKpTuHUPeGiYCszSYYWJrIx
rNU1J6vaKM3djX8KLx5jBUfQaG9JhPfkdsh66Up4JXZUnnJ5cEtWhX4C4xLj2QAj
ln2pWsJmKmvmxp4Mv7xO3GT0QpFf+O06SUoK5sMGrCFQiQvjaf/ZVAwBI8Xo1/F8
TDTiVu0iQHtarysr3vp+C3EOt3TtxA==
=Pfy7
-----END PGP SIGNATURE-----

--ZikkrN1PM8gmKHgy--
