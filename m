Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D848F4CB8B5;
	Mon, 12 Oct 2026 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839238; cv=none; b=uewpq4PDWi4kNv/7kvAKlCl3nCkBedvzzY2vy4YE0Ag4+96uE2XZ6eWV3p3FPiv3Wc3vydZ5WKjX82KEleJpeULNO0OAQ3rjLUGcq4lo3WXF1f6OrkMHVliPMsuwJBjKih70V+YXfl5VmuXcS68N3+k6kcoTEMwmwyeenLvcAVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839238; c=relaxed/simple;
	bh=3WDrJOiLyYyG9nsoeh4ZSbfkp/5PWRrwLY2CJ+IZaJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1Wi0JCCfLt88UrQjT/9UkKPEnj2LOuiJB7QrxRENUJCPwXO1bqdqNwCvIVYkks36gG1uC0HZQ/t09Pd1B6TwUPZFSNiXErvA1tfRW6ev+EG4BHlR+0a6IObTDpVtKg/tGPyidQg05Y0UGtTred6p7MIsr8pt5CqfGZ7MJEXYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0LbWTOC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0LbWTOC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80D81F0089B;
	Mon, 12 Oct 2026 21:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791839237;
	bh=3WDrJOiLyYyG9nsoeh4ZSbfkp/5PWRrwLY2CJ+IZaJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X0LbWTOC3IS6VEuXJjwpmsLuct2YWNNgLbHDIuVQYVojFNnEE966uaU7dl/2mVv/7
	 tdB6TYh8kmXHsS8YjSO04EUQ8f+3RFtAySHV2krpzZBO6ScLSXWTJ1jAq3VcHs8e2T
	 s8Ec74MHpIDS9ffpauuHeeTX0t647zKrcx9GdAJcAljh6j6dSRwVg4iMrY5lv4YIp+
	 ttbQIi7p20ua1I41Ynm7VyK5VBWCLqDCO/ItFKr1XDd6+EWNx4J5NRu8tsVFu//X0B
	 IgTtG7kcSn/9smZlMg1gQa5qvJFnfj0NIB5GxYMyXb3C4AOjQEVTdtMVzgbY1Ovq57
	 pplMKMdXnMR1g==
Date: Mon, 12 Oct 2026 22:07:11 +0100
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: iio: adc: renesas,r9a09g077-adc: Add
 RZ/V2H(P) and RZ/V2N support
Message-ID: <20261012-presoak-partner-dc23bb5b24af@spud>
References: <20261009184122.1378797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261009184122.1378797-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tCseK2djqWMSaGaO"
Content-Disposition: inline
In-Reply-To: <20261009184122.1378797-2-prabhakar.mahadev-lad.rj@bp.renesas.com>

--tCseK2djqWMSaGaO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--tCseK2djqWMSaGaO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas1L/wAKCRB4tDGHoIJi
0syxAQDNa2IGrEFwPI3bu3jjdnDjLqkYb0h4vqH8kROn5OKMAAD+OcUnK2dfUnZL
gVSFjdmE7kw3kwgV3kg+OWONHDHPoAU=
=dNp1
-----END PGP SIGNATURE-----

--tCseK2djqWMSaGaO--
