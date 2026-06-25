Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE12F8E9F;
	Thu, 25 Jun 2026 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404680; cv=none; b=Lpdhp5qqd0qFSqkacmdKOoH83U3+cGaPmZ6U9GWEkj8wN87xQ0JQO9v+WWUPWLUN9wYmIHB65e83UWGR2eTzQEm072jk8boDlqFm0Kx5G2pQ/PxmTZ9CsuLtyFC+v6BwOA2AWX8xwOFfEAM2iorCMKscHkMSJYYHdchcxJQDYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404680; c=relaxed/simple;
	bh=Thgki5zYQNPufQB/hqjVbfgpOjLAZ0LYxJg6D63BT2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0bUK9cV6rpEIQUkHA1EN0RGymVQdVoYkYpMMzb+6caVF5X+gcDQY3hgZYaq96HFuIMOhCfILguZLfZXvAd80tmlbR59LUG3/ue5a71VKSfD8tthdmbx67c9/d+bFSY3T6mjR2gjWPx5hMlKCn5u/JWulPY4pLyj2DwvTsOIkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0sPHYhS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0sPHYhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC61F000E9;
	Thu, 25 Jun 2026 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404679;
	bh=Thgki5zYQNPufQB/hqjVbfgpOjLAZ0LYxJg6D63BT2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e0sPHYhS15iIt6v6svyOSB6VfqT2c+Nbmp6t4lEzP02sAJOrt/DlDumjKNrBI0QiB
	 w+xXAJWNiNgOZe2zJLLwZ4cCUcKvtHkIg7uoidvdNzZS/RRLDmIItHRQPG/90tQn29
	 F0NYkygXW50pxT0X1QFGqv42wuHARillQnmOjgnmEuZ7dhX10w1ZF1JGRmZasBPFVb
	 7/Q2uL03x6ssc1Q9vz9e2N9mQbl2j3fuiv7g6R/tV2mI/zsUDqzIaAmZryCb7xOIA4
	 FcTY2XLRn8VrTOndUvKBUDH3YgkiEVKQkv2MDYTJd8UBbtnYkO+99GQgICGPYKTqVU
	 ygx49lbKpiv3g==
Date: Thu, 25 Jun 2026 17:24:34 +0100
From: Conor Dooley <conor@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add Nuvoton MA35D1 EADC
Message-ID: <20260625-gab-tartly-46ae1d07bb22@spud>
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-2-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KgOo0vAcTHRZVL56"
Content-Disposition: inline
In-Reply-To: <20260625110638.38438-2-cwweng.linux@gmail.com>


--KgOo0vAcTHRZVL56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 07:06:37PM +0800, Chi-Wen Weng wrote:
> From: Chi-Wen Weng <cwweng@nuvoton.com>
>=20
> Add devicetree binding for the Enhanced ADC controller found on
> Nuvoton MA35D1 SoCs.
>=20
> The controller has one register region, one interrupt and one functional
> clock. ADC inputs are described using standard channel child nodes,
> including optional differential channel pairs.
>=20
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--KgOo0vAcTHRZVL56
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaj1WQgAKCRB4tDGHoIJi
0rzsAQC4BpLKlBd36IGdD4/quH53bLAWjEVwrOFiN5Oh3JYKfwD/a+oArr5PGsuQ
N2sp8zcfi/PLAn244zTapkzBFxNtkgY=
=oDJ9
-----END PGP SIGNATURE-----

--KgOo0vAcTHRZVL56--
