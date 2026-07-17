Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631633AA50A;
	Fri, 17 Jul 2026 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784289126; cv=none; b=iJEl5KcXbghHPvOqKaweCCCktZLAiJlMZGn6+HAgbyUqOdZiHubRoaRNTa4p/dvPEM8bT+3k37k5F/xsMa2yeC4466E+2VyEualxIa+eH1MnKBi5AWiQTuQ4CTFXA6Rang7Y/0Gl24mv2YkAxl2tncAGbb3Z6jDbIOsbwL+nv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784289126; c=relaxed/simple;
	bh=4rox8fKsK3ug9CYCB71xMQCKGbXgFJ4EdnyHaWA4paA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEcsOOZ8tmJ+MUTHpNmwp8IrdJKz3bCFtZi5R8pEgkQ+nvmxnH818s+MEXlmFM7QZh6/Wh47O0KVcqIuvyFtCFXf6M2TLb1hJBb+YTZXYJJlWRnNhfzk9L15+gGSkTgAoVsd9MXV1N2ziZtyKAblih5xt/pUtPe+K2N3S3CA1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oksaA90L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oksaA90L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E781F000E9;
	Fri, 17 Jul 2026 11:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784289120;
	bh=B/8QjaSxCtdFJy5fJge/Wc4GsEvqju4J+rbJLB5GXZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oksaA90L58UXfpLiPgL9xt4iu29AcW1cV/5tSK2unrgVZqZEldEFRyOd+gTD8Vchc
	 0YZGzhOS263nU9RUQ71euC1vjktI3YQehAeohKz2H9+YeR+Ksviz5E/FHJg0yF3C5f
	 sCIBkqNJPeQsFtB7OR+6NU/Q2MdwbQ3YG/u2WmfPHos8qsABB1CiMOp8Fy0NuXCp6q
	 2QTA0uz33dTuo6VV8PLEzxVuEA0kfonFQJwhhq47kqWB8A3gm2393Ghi2kxPFccvbo
	 cwzIrfBvg1Dh7Pj+Ja2sSYXIrHfPtp2doym4Zg7lp8FbxRCgWbpW7IfjAEpGcdmwLo
	 4EkO2rh9ML4Ew==
Date: Fri, 17 Jul 2026 12:51:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Janani Sunil <janani.sunil@analog.com>,
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
Message-ID: <27746e91-ab2b-40a0-822b-6d3a8997cefc@sirena.org.uk>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
 <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>
 <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
 <157154d1-3995-454b-9e08-1527f1c5d409@sirena.org.uk>
 <jsximyohkijphqrtgat6cjtcvtirjsdtbgn3lb6npw6yhgmcth@tq64dotfowss>
 <0e3e45fe-4c34-45d0-b985-0938f60b5914@sirena.org.uk>
 <20260716-stole-copious-7cdaacb6cef6@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XrMlIKWWYubYfzhk"
Content-Disposition: inline
In-Reply-To: <20260716-stole-copious-7cdaacb6cef6@spud>
X-Cookie: Enjoy yourself while you're still old.


--XrMlIKWWYubYfzhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2026 at 06:06:13PM +0100, Conor Dooley wrote:
> On Thu, Jul 16, 2026 at 01:28:15PM +0100, Mark Brown wrote:

> > Oh, isn't that just multi-pin chip selects then:

> >    https://patch.msgid.link/cover.1783729282.git.Jonathan.Santos@analog.com

> No, I think that's something different.

> In this case, there is one chip select that all instances of the device
> share. Both the ADI and Microchip devices then use the upper bits of the
> first/address byte during reads and write to access individual devices.
> In the microchip case that I'm familiar with, what upper bits the device
> responds to are set by fuses in the factory. They also share the same MOSI
> and MISO.

I'm struggling to identify a way in which this is functionally different
to a multi-pin chip select.

> The SPI core already supports two of these devices from Microchip, since
> it just modifies the contents of tx_buf in a spi_transfer.

When I said we'd have to modify the bitstream I was told that wasn't the
case and this was just asserting more pins along with the "chip select".

--XrMlIKWWYubYfzhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaF1gACgkQJNaLcl1U
h9DSUgf+KTh3TXt2uSnHY5q8tqNnsTkc6yf4kNoLOKui+JzC+DI3tHJzUZnIGOMQ
FYhH+cMFHjxwDhaNR+bOfalhYpzsPDSuwBBRUszhNruu3m5CWflrNi29LHLq9ISC
8ObVL8CyZBAMi9xlBqa2h1GPeIbL30+FPIm3+LIsaX5jYjmQ3mXETFnKXEmnGKYJ
Z32jpy4qzaFp0ErnoMcS5exRO81qSks/99H/00fJhdXqUVNhj3bcRrCC0ntrvmQ2
s/jJDdTZR+lo7Vlr2ohHbxAkc+Xkq6ZMhO+s2Xvjm2BCydAPA/tUXdodCQkumXx/
bToVZzYqCHi2wvOd3KKelEU0Lyolqg==
=hJ+E
-----END PGP SIGNATURE-----

--XrMlIKWWYubYfzhk--
