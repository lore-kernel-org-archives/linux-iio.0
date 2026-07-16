Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DD933B6CC;
	Thu, 16 Jul 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784221581; cv=none; b=cvzYUlQYwen3ltwBfXuZ8IDTB3a+NNY46bDd3sfN6VGGmv+qqbhyOXr6cRfXvUlZteWlubCwtQ50Ze9zQDTD7KvRPf0bg3vzTN9khc4YHQuVvsGEyENaflQ+fRtyVbUUIYcjuWW9Z2r+vLtaPVbGMD2rBjHweRcStc+RcFfg0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784221581; c=relaxed/simple;
	bh=ZiaXKH6KIv2mthdbKUHPydWyz6b+urR23vEvGyuEE7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeLl5WYIiM3Sx6iC3y1lVA4+tXWu0vO1AQkGFsQGzi9E1BIEC45krmKoxmxTq+oGmnNHCD01CaFhuuZz6s95WfAyQyG97f/1iuidkMFevV1qQJscMIOJi2zrVGn1kn+pzuurrfzrY98UqARHW78ElwEQEFMe8xXrhG3Y+EBJf54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd9SDzdl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd9SDzdl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D6C1F000E9;
	Thu, 16 Jul 2026 17:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784221579;
	bh=vJ/iingNaWhl/fNmEqqQNxJ9xHGV9HBu1LVDtl0lzDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vd9SDzdlRYLy+ecStpBG8rSMhRXcYfscRrcuIhk1B43lRHLPjDQ1bhdTxxgfWUh5a
	 vV8copUpTYRTtvVFuPmxqFVMqWYE32uVUHGyplazR7We08PsAIhPNCCJaVaSrpqpbT
	 8qaa+Ju4g9cpwBKHMwjkRUKazrBggsEhRtXmFvgl8GFT0/YNSfipuMEyACGM0cU+Tz
	 gDBf/FLs6ALqZ2UlIxYsvsP+pmRMF9+Ieg6Z0PsQ42bECD9k6hb9dftPXd51TNXmsl
	 SsysBM4OELSHNmnLA4VLpvVqlKuJrdz2Gqlqg8ogEUt0/IFGbE9nsuBuqWl17GLHd0
	 +e93xQ9ezsqdA==
Date: Thu, 16 Jul 2026 18:06:13 +0100
From: Conor Dooley <conor@kernel.org>
To: Mark Brown <broonie@kernel.org>
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
Message-ID: <20260716-stole-copious-7cdaacb6cef6@spud>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
 <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>
 <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
 <157154d1-3995-454b-9e08-1527f1c5d409@sirena.org.uk>
 <jsximyohkijphqrtgat6cjtcvtirjsdtbgn3lb6npw6yhgmcth@tq64dotfowss>
 <0e3e45fe-4c34-45d0-b985-0938f60b5914@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D9mj2wtSmfOJ2N2F"
Content-Disposition: inline
In-Reply-To: <0e3e45fe-4c34-45d0-b985-0938f60b5914@sirena.org.uk>

--D9mj2wtSmfOJ2N2F
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 01:28:15PM +0100, Mark Brown wrote:
> On Thu, Jul 16, 2026 at 11:22:19AM +0200, Nuno S=E1 wrote:
> > On Wed, Jul 15, 2026 at 02:37:12PM +0100, Mark Brown wrote:
>=20
> > > You still need to work out how the ID appears in the byte stream that
> > > gets sent to/from the device, that's way more information than just a
> > > number and not something the byte stream SPI offers is going to cope
> > > well with.
>=20
> > Not sure if I'm following you. Those ID pins just become something you
> > need to set on the spi_xfer. Or in Janani case, she's using regmap
> > reg_base in order to set the right thing depending on the address. I
> > would image this is always something that peripherals need to address in
> > terms of how the message/stream needs to be set. So my understanding is
> > that this should be pretty much transparent for the spi core.
>=20
> Oh, isn't that just multi-pin chip selects then:
>=20
>    https://patch.msgid.link/cover.1783729282.git.Jonathan.Santos@analog.c=
om

No, I think that's something different.

In this case, there is one chip select that all instances of the device
share. Both the ADI and Microchip devices then use the upper bits of the
first/address byte during reads and write to access individual devices.
In the microchip case that I'm familiar with, what upper bits the device
responds to are set by fuses in the factory. They also share the same MOSI
and MISO.

https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocu=
ments/DataSheets/MCP3911-3.3V-Two-Channel-Analog-Front-End-DS20002286D.pdf
(See Figure 6-1 and section 6.2 on page 43)

The SPI core already supports two of these devices from Microchip, since
it just modifies the contents of tx_buf in a spi_transfer.

What Jonathan is working on seems to be a setup where they have multiple
instances of a device with their own chip selects and their own MISO, but
a shared SCLK and MOSI.

--D9mj2wtSmfOJ2N2F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalkPgQAKCRB4tDGHoIJi
0vmNAP9AkFNaxjEZSyTfEKFzZq2olZuk05YicHSqI3nmOxgqQwEA3iKLTEWhphUP
dek7aiJwi3r5q+ztZoJbo1JS1yjU2AA=
=s62h
-----END PGP SIGNATURE-----

--D9mj2wtSmfOJ2N2F--
