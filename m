Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB52441A6;
	Tue, 17 Feb 2026 17:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771351060; cv=none; b=NBjRJQwmj2ISYNjHt0mScaTjqLdvpTl8Ve8oCjSIJ+azA24ud80jg9LD6jxhwnMaG8Dhj8XBXkm24wZej0h6PVg/OFm2f5bIUuVeGX893AAOQ8kbo3B3EQwqPLJhc5OTiHs8U7PxEWXJJMHcSbeac9JFlnWjOGGU99pRpTqiqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771351060; c=relaxed/simple;
	bh=WH8DUdmbwA0/F1kyOxW7LNDjoHUxqe5R7s9u/+hvldM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9ebJDZ25elivVaDLPw2nsvpgVv/dbkGjdu5R5wKwHfZlnSkKpiBTHYKbR3jX+oi9mClLd9EVnwTv3RSykdI+5dzUFZMSjxW/cfS35Gb2sPGFpy0izDovOWvck7ZhupjV6PYyofGjpyFrdm178OL36TtjMiiaC1UXVyVdNHjgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+eTRsh2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+eTRsh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711E8C4CEF7;
	Tue, 17 Feb 2026 17:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771351060;
	bh=WH8DUdmbwA0/F1kyOxW7LNDjoHUxqe5R7s9u/+hvldM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E+eTRsh2XBdzuOMhVELoZgX+NJVRlmZjucKEyTOj5/rcj0tlAnvcaG2gs/qwkzVHC
	 WRYlQwd0TF648A6vaoXa2DurKiYIhB9nJioelpu41i37+IfHDEU4imZ+SRrsnjk8pa
	 j/mB509yPax3z+R27XA8c+Kq+1RUuvuASrSUFjm88f/bgjpoooO2thpAWCUIGsoXnu
	 G0zxxcTjLA5Nk3FptNq0W/HEwSlRjXQdnyuOHQQ1bN1aGXBc+NMtqCmdgD6vk4pZ6k
	 vMQUY2YWATsLXtfD6c+NAbZ5GMRbgnO2Y/1OFZS5fEVSVwG/yGkQUlRk1wnX5e0wRa
	 aVFUCg9i4t3Pg==
Date: Tue, 17 Feb 2026 17:57:35 +0000
From: Conor Dooley <conor@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Message-ID: <20260217-dried-treachery-1020adbcdc9c@spud>
References: <20260217-cm36686-v5-0-63c2de9709d8@gmail.com>
 <20260217-cm36686-v5-1-63c2de9709d8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sAZKnIC/ZhAiPy7Y"
Content-Disposition: inline
In-Reply-To: <20260217-cm36686-v5-1-63c2de9709d8@gmail.com>


--sAZKnIC/ZhAiPy7Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 02:13:15PM +0200, Erikas Bitovtas wrote:
> Capella CM36686 is an ambient light and proximity sensor developed by
> Capella Microsystems, now a subsidiary of Vishay Intertechnology Inc. It
> has an I2C address of 0x60 and is fully compatible with an existing
> driver for VCNL4040. Capella CM36672P is a proximity-only sensor that
> is partially compatible with CM36686 - they share the same register
> fields for proximity sensing, but ambient light sensor register fields
> in CM36672P are reserved. Add compatibles for cm36672p and cm36686,
> with a fallback for cm36686 of vcnl4040.
>=20
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--sAZKnIC/ZhAiPy7Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZSsDgAKCRB4tDGHoIJi
0iv4AQCgluoFNhBlOb8gS1yU5d5fQ7whFZj5Rh+VKmE1G0sxoAEA1yXf7jZxOEbQ
Sc1CWLrVfNyVL6VqyyX3ngy0BTNvQgk=
=MFIm
-----END PGP SIGNATURE-----

--sAZKnIC/ZhAiPy7Y--
