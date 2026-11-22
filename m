Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795354461;
	b=AYzkZDVG4DBnFd5WmjOdf9VoPN0fIVVBO+s6rAAlQ9OjWr8WdQ6Q6dB7wk63ADtnTxuK
	 HYKbJQ635SdQp72JsCIqQlhpqcTr6yXXBo3oWNqgJQq1ZjIQ6eZNeGGPOO+kuLUsGldao
	 j2nePHRecTZZsEwwLT9+qL6rO+gwxLh8fnlbZ8Z/0+VNTEkO8XW2usQJn47fky/HSXMAx
	 bgK3AqUu9OrWw0M3zpneouNmG/So290MGw/5xuV80lvGLWeyoOzuHX5IT0wxZmXpA/Zqs
	 KHf7+Fzfh+RV24LhHH7RfCBX9ee1CplPZZyGdM3QmqIrdHfHTxck2OvmVu5JA2ihivw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795354461;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=B2YpqatDPSUl5On3Scqr15nRXXPYDlBJfIeTj6Aa2VI=;
	b=gNWMX6GIeDHfKNHXCCCU9odRIxS7IPbUbP5+z63l+6amrlBD/hz9MZnOBm9XkJM+M5Zl
	 JIQ/xAz9w1b2F56KhDFj13QRaf6aSu0nW1vdMeoUIIMrxOStuzaRmCvgDmzcS7iEfeCOb
	 STS3WILQUkjGXe8Wz1raX6r0LECyhwd5XShSea4xKoHG6xx2NwbnxKS8MBzGrruGIi38h
	 xJ+khGxB9sqMdJ1D78jPW17IpCkzBehSnFCTpEUhZ1EI1CIKz90X+mJKuxBcYx/7zGepg
	 t4qNc1tsNvIVGSVziFRteIEtinAiZ+NmQJv24w0Crr7qy3yFWs8ROj2ADaEQbY8R4GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=IY6ejkA5;
	arc=none smtp.remote-ip=185.67.36.65
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC13606A68F
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 13:34:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC13606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=IY6ejkA5
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id DB746240033
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 14:34:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1795354452;
	bh=B2YpqatDPSUl5On3Scqr15nRXXPYDlBJfIeTj6Aa2VI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=IY6ejkA5/suChshwsOezv6OLtBzqsbA4luOXxAO2vmgPZGdauXSSQwBbnx/yDYg5N
	 hcrfKUP35jZntLnF/v3SHN6Fn4zDss8E0SrSyrFFnZEiny9NZqd8al2DgfXuhgtk1T
	 D3a8cHq48JlTfE5+IWep3JlRy5uD6m1AQ4m5wzFJv9m76cmYFzTKUrxzehbSD0gwlv
	 mj3YPZHbIcsc5kaTKv+frHzEjjFTIkOpKYQO3PdKgxR2mkASQvfxu6XunRQEfkyWIm
	 6C/OrOC64go6r73eqcVnTCexZKyG8+OCC2+AxMkysS8d2zssXOA5XdAfWvNf/wpUUz
	 RDurpIJPGoe9w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jXVR60WKDz6v0W;
	Sun, 22 Nov 2026 14:34:10 +0100 (CET)
Message-ID: <947615fd284c416891ac6de5d16cdd00ec5267ab.camel@posteo.de>
Subject: Re: [RFC PATCH v7 2/4] i2c: rust: implement SMBus access via
 IoBackend
From: Markus Probst <markus.probst@posteo.de>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
	 <igor.korotin@linux.dev>, Danilo Krummrich <dakr@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Alice Ryhl
 <aliceryhl@google.com>,  Daniel Almeida <daniel.almeida@collabora.com>,
 Mark Brown <broonie@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,  Shuai
 Liu <847807867@qq.com>, linux-iio@vger.kernel.org,
 linux-i2c@vger.kernel.org, 	rust-for-linux@vger.kernel.org,
 driver-core@lists.linux.dev, 	linux-kernel@vger.kernel.org
Date: Sun, 22 Nov 2026 13:34:12 +0000
In-Reply-To: <20261109155743.83740-3-muchamadcoirulanwar@gmail.com>
References: <20261109155743.83740-1-muchamadcoirulanwar@gmail.com>
	 <20261109155743.83740-3-muchamadcoirulanwar@gmail.com>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-LlgQf4RobFMqc/n5pj36"
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-LlgQf4RobFMqc/n5pj36
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-11-09 at 22:57 +0700, Muchamad Coirul Anwar wrote:
> Implement fallible SMBus byte and word access for bound I2C clients
> using the generic I/O backend infrastructure.
>=20
> I2C transactions may fail due to NACK, arbitration loss, or timeout, so
> use FallibleIoCapable rather than the infallible IoCapable interface.
> Propagate errors returned by the I2C core to callers.
>=20
> Provide smbus_io() for byte-addressed register access and standalone
> word helpers for layouts not represented by the Region-based view.
> Also provide smbus_read_word_swapped() for devices that transmit the
> high byte of a multi-byte value first.
>=20
> Restrict these operations to I2cClient<Bound> so bus I/O is only availabl=
e
> while the client remains bound.
>=20
> Keep the raw SMBus FFI calls and errno conversion in safe bound-client
> methods. Include a generic no_run example for the word-read helper.
>=20
> Suggested-by: Shuai Liu <847807867@qq.com>
> Link: https://lore.kernel.org/all/tencent_173B7731E90B9624F9F82613DC3031B=
70907@qq.com/
> Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Hi,

please add me to CC.

Could you make `I2cClient<device::Bound>` Sync in this patch?

`I2cClient<device::Normal>` already implements Sync. Functions exposed
only for `I2cClient<device::Bound>` should be thread safe.

I will need this patch (including the change mentioned above) for a
future driver.

Thanks
- Markus Probst


--=-LlgQf4RobFMqc/n5pj36
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmsC70wbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS2xMQAKDLB02pKK6mopiQyUo4
Rw9Re4Hxwma6eGa1pfpDoTjkft+qnAjAoaZHb6hnGHojepz2FdRyVNxTARZnByFA
VHnddeyhZxrK19kmKRSD/RF79bW9V6QEqouu90CXUE9glh9KlfnjsyLrk+heqxN4
5p0n2lDo3DFczV1lhZPgkJnp+Wb8Xrys9SWX4aCC9vE5MMeQjRzJVxzlnpiQxY3z
5SOCMbxu1mXnOnWGI1yWmBxbK1HRNhydPhwo/PkAz2KIeXFdaB1brMME+eck9fKl
NxK40cAzmKgO6JWK2yG4qFMhWp+ZYcZiv/n4BR3aEeRuG+Akp8A+eUKWXV8aSqm6
HPbBkU7yaugyyYqcq6wJw55dbde7Klbd7XKBWWK+7ol7ut7nAkTsi5HSh/zeX5b7
I2OB5H+YKPCMy5vB6DCPhIN2gYO+V2N8qwfbbPcFkbLUNumfdk44ABk+Wds1Thu5
vwagzVEu/aXOt0XT+aUmH5zzutzvwDXZKyHEuGt4wstKXHAlPyIjydM9St32l6QF
L0H1XRxUAWHpr6GnlhxWAUAzu/UebGviaVAtAl1WDgrZQIWAwG1tevLVXkkju/J5
euYBaeJ3yvKDBY+sm7TkbWH9iOCikShqAeA2ZNuAs/fE5H9TVMhyZd4pQSU0ifuw
UZStFoSLiv1XrJYCjL/baqXI
=u56D
-----END PGP SIGNATURE-----

--=-LlgQf4RobFMqc/n5pj36--
