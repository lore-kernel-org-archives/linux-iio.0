Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C642E738B;
	Wed, 15 Jul 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122641; cv=none; b=Cg7N1ZTV3CQ/uRpLDiTNvijtMBg1HR14cFt2oMIsuwMu9lLHNZsVaaj5v9AGnYJW9wGugdxGEDXZKIjWDDwEwrEsUUTU4d4pvf7yHt4pSLpPfHVlAU8D17v9fcp/l8UtwCpdtmRf1gyTgttfv9KqibU0QW65wgwA1Oq7hKjKM9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122641; c=relaxed/simple;
	bh=mQ1Ppv43Nzvd2le0EqHNXpfZ2H1Jp1liw05iUUeGFFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvvmJU6VTL4t5xcYCJlOJwxjTu5RcefA7RaEoX1GRLkeuLpbCHVGd/1NW8otys4xwzP1m7DMqJaMlOTyM+6U7ywqNibq0G7/EJ9CHk8dvCA2rMxyBUK+jQHehqyLoH3GUtSxmtVRGCXAHUbxsM60CwboXm6NHGn21E7Lm8+w0e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCNA61NH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCNA61NH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD31F00A3A;
	Wed, 15 Jul 2026 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784122640;
	bh=1571AMYBa+aqh2HI10aYEFZYKtWO6cbTBh89pLpcSrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PCNA61NHD0tHFvoCIykV9CDzLHPkx4ObtaPsEWeSAdXhMjyx7weEXB3OQvk5tr157
	 blIc09rNUNmKUHbgwKwUUGATVMkbfaLmyzAN2tvJjQNeikYhKv+YQNNpWI5FaoUckX
	 ZOiCveZSqVhdEM+PW2PkqwFSWHYtcGiP6PlNAUPyR4brdV9Kk0H2qYXHfAIENhDjt1
	 IoO5gy5Fbkg6s5wrEIQg9QzzBMW2AtNjOOBjHmSRotWLB+Sl/aEnlHk1+gAW9rDvmL
	 5j0MCyvtMapnAZpeVEDr9tir6xMgEayp9HMW1wez9uldhcJtp7DBJkQ8klYFzZAsic
	 24rkeGa7H3NfA==
Date: Wed, 15 Jul 2026 14:37:12 +0100
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
Message-ID: <157154d1-3995-454b-9e08-1527f1c5d409@sirena.org.uk>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
 <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
 <1c4af9b1-9937-4cbb-b57f-52ac575b8b89@sirena.org.uk>
 <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EWFsD0OyCJy7C58E"
Content-Disposition: inline
In-Reply-To: <lpbqk3wv6emhdtxhnczrgufzzxprcfpfgenfepnmzhzfj3b3ci@rdphuko7ikti>
X-Cookie: "Speed is subsittute fo accurancy."


--EWFsD0OyCJy7C58E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 03:29:32PM +0200, Nuno S=E1 wrote:
> On Wed, Jul 15, 2026 at 02:09:19PM +0100, Mark Brown wrote:

> > This really isn't a generic SPI thing, if nothing else you need *far*
> > more information in there about how exactly this would be put onto the
> > bus.  If it belongs anywhere outside of the specific device's binding it
> > feels like it might be regmap.

> Just for some context,

> For the analog chip, it can share the same CS line with another 3
> identical chips. It has two pins that depending on how they are set act
> as the device address (so only one replies to a given transfer -
> naturally the peripheral driver needs to setup the correct transfer
> and that depends on these pins setup and hence dt property).=20

> This property reflects that. Apparently some microchip chips are doing so=
mething
> very similar so Conor proposed a generic property given that we would hav=
e at
> least 3 users of it.

You still need to work out how the ID appears in the byte stream that
gets sent to/from the device, that's way more information than just a
number and not something the byte stream SPI offers is going to cope
well with.

--EWFsD0OyCJy7C58E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpXjQgACgkQJNaLcl1U
h9C1IAf/TpU+6+pdtt/gB6xbCDRW71qXK0+xCE1MWXM3qXIxP0etZhigDidgTGx5
kfYD/W0RzhdheLuSn6InN1fliX5N8fYFYoVhlbdD+IJF+WcyBiFtUT+nvTuvX58C
YAMgdyfhrV3hWIj4RNfKq5z6jL/x+7DkP+T08wBpxOnSJi8XC6cil7N9RV6Llwpa
maXLGgeYUOzoVgfSxO5c6RQQ2C0o6RPJVuCDg0WudkrZva4McGmu1/qTRw7dHd3g
NDL15BU5AACAMy4MxzlgaIMIbssMhnCVHoD2ZzinZjuivQME/7t4ecyZIwhrvOno
ZVYN+IBSwfdyssj8rwLdoeG5bI4w9Q==
=0xYZ
-----END PGP SIGNATURE-----

--EWFsD0OyCJy7C58E--
