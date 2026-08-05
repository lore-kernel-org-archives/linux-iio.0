Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8A3EEAD0;
	Wed,  5 Aug 2026 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947404; cv=none; b=MRYSbGYa22DYKh5DYAEs/H55OG1rFON8R5bNKL7k9rO9EXVvADFLZAfcKkmifcStIoHS26LIUdHp/aRO8zBdhTHX3BBwCgPGwsT1MvzxjMWQ/x+y4o/xZ7kcI5NLPXRasvHQLV2F0eCmPQI9q/IZd7Ke/DithF+wn5jl0NftFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947404; c=relaxed/simple;
	bh=2SG2FZhElwQiDCbm8UKj/zw7brGqIk7YhSgEajStjIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZAFUecJAJjcetZJGqn9LZ/6qqBEE2VCMiO+TIjNo0U3ykZk+L67SvW9eBuc1AkZfEMIvH+IWXq6zkbL4DZjOWbBBRGT4iukz8bh2eUVLYJU67eKJ0nceMOEEMsjCwOocefnnZNKekJbQq1RRDORjkM9LbwunrhZpr0b3jbw7KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=la2ITovw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="la2ITovw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F246A1F00A3A;
	Wed,  5 Aug 2026 16:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785947398;
	bh=2SG2FZhElwQiDCbm8UKj/zw7brGqIk7YhSgEajStjIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=la2ITovwDNoQQ+lebVDhplFW1Suj90Ng1jwbBZ//p8+6pzNjsQ2D1w7dxZ6C8BK0i
	 Q8GKbR8aUVc/H1aRMp/5UULRVTJavsVQPTXh1E/2WfmXQjz2LSPiYuXROZKy55BIP9
	 8dHPmc6iqw18bzvvrM0aes4eaYDeAPBvrMBCd3jDNtulbCKgWFnkaq7kwqhDJZ9JUT
	 c/MMkeYVOPaoHEsprtbLEE6RynatFn3TF/jkd7X6BEjEw4IYYZLWtqC8rT0b2nq2N0
	 FYstJu3VFcTRWGPgGWiH//P+E76LP9spYZcKR8eVda1ji0qptPfRK/b4CgjO17dSyL
	 EGk9konvrxUog==
Date: Wed, 5 Aug 2026 17:29:50 +0100
From: Conor Dooley <conor@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
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
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/3] dt-bindings: iio: dac: Add AD5529R
Message-ID: <20260805-unrefined-knelt-ef167d1ee8fe@spud>
References: <20260805-ad5529r-driver-v8-0-b41781f5632a@analog.com>
 <20260805-ad5529r-driver-v8-2-b41781f5632a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AfwjZNltJEtqQdzn"
Content-Disposition: inline
In-Reply-To: <20260805-ad5529r-driver-v8-2-b41781f5632a@analog.com>

--AfwjZNltJEtqQdzn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 05, 2026 at 09:17:42AM +0200, Janani Sunil wrote:
> Devicetree bindings for AD5529R 16 channel 12/16 bit high voltage,
> buffered voltage output digital-to-analog converter (DAC) with an
> integrated precision reference.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--AfwjZNltJEtqQdzn
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCanNk/gAKCRB4tDGHoIJi
0n8CAP9UQoKgTQNzIthZtfOEAQcvA4iVbixd3DeiT1fmLwxHJgEAvjGN4gtWStZp
TLBwYCZ6rsPwFBFzKksT74SEX9jQNwI=
=eu2m
-----END PGP SIGNATURE-----

--AfwjZNltJEtqQdzn--
