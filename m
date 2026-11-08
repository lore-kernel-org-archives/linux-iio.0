Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134412;
	b=IaJ1l7yCohR8vTAuQWb46DqmrXxFOPWQIOEMgwf+R/Za5ZswBQGGNqyOt1khHhgqhaYJ
	 OuWlcLsz23PKyp+F+pNdnqKDpWzPuRUUgqCwyMfF3YRPsCG+RxVafurNKJk43MXsheMtj
	 FUJ/xvyvLNOGuE0wM+wRdmUrXAXZuLjwH1yqyJudBRD/cReSHq5oRNHljdD/Z6QYaAVMC
	 4sZMm5Vlb8WqmKh5SqDBIOTY0kuN0BHPlKKCzo4LOACApn93Mfe+5HBksFcXY4zsfvwQ4
	 12VMPsyNJ+mLxFDV6mkhSqhmj+bxGrXodFbF/7H4/VC0tc/1PFzOfTKv2uOOu1gbP9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134412;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=/oqQc0dJoFlJLMVIlgCYb1M6N8vaTLrVMjw9+CYuwJk=;
	b=OSCjfgOZc7dRpum7CZIYUF4/7acnn9y79Q+oe7tT3juKzgAetZ6sM7K3d/KC3RrHWNFB
	 noDcyZolKPwAxJtg6uIBAKGqzRdvBL1HaJ5NO61muGwm7ZgNaSzLArFv+OvjbPj1Mv7lH
	 vQGtm+BfGXT3Bk3a7SpFM7UQ4z4VUY+U7F+lsbvoA0p0rAesAHKqRHPNOk2Hjb6s9tj70
	 u4CSceL6OAj3MekK+6XFhBhhEM3NPzkubdhFaBqf/0Q8Pp3LWIokcGV89pTmA8LK+IeE2
	 2I+kucquMS6v4j5E0u8O26pS3Nc5Gsze2fAiHqtorauWajtTAt5kZUC5EqwZ6m0w3cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGCMu8Dq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F147606A31C;
	Sun,  8 Nov 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XGCMu8Dq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74B51F0089F;
	Sun,  8 Nov 2026 10:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794134411;
	bh=/oqQc0dJoFlJLMVIlgCYb1M6N8vaTLrVMjw9+CYuwJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XGCMu8DqufpBi3PStdQBCNIgVQ2xyFTlhyBmB0ti9p27HRzsOSK5Zv8k9HX/INt7j
	 uA+pvrSRdsbBZxTYhmcFuj7lowRA95QqIPMm66kom6FinBiPqZ68n8wTMDdoAt9G4V
	 nuOzxgvjQFFnVl3n5HrRpmFL56EePO0nOe5YyHtWUiB6bC3wmhr3nLbPIHbSHYVGdf
	 qplHvNIZUSk/A9Clp3BDov/eEOgzbWTtsh4wkYmzGM69HeXBwYvz3HKukD+Fnpw3Nn
	 /O/B9oT9YxNOLGfwD3KnhYOD/wBAzqCyjeJij/btn9haPYDq4FGtf9b/+mhU6NyzN8
	 36bHbBeY/XMKw==
Received: by traversing.sirena.org.uk (Postfix, from userid 1000)
	id B6AD82BDF3F3; Sun, 08 Nov 2026 10:40:09 +0000 (GMT)
Date: Sun, 8 Nov 2026 10:40:09 +0000
From: Mark Brown <broonie@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v1 1/4] regulator: dt-bindings: maxim,max8907: Document
 io-channel-cells property
Message-ID: <8a10a4f6-55ac-43d6-84c4-7c362c2d8373@sirena.org.uk>
References: <20261108095634.100517-1-clamor95@gmail.com>
 <20261108095634.100517-2-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9YJuTka5+MAlnv5C"
Content-Disposition: inline
In-Reply-To: <20261108095634.100517-2-clamor95@gmail.com>
X-Cookie: Whoever dies with the most toys wins.


--9YJuTka5+MAlnv5C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 08, 2026 at 11:56:31AM +0200, Svyatoslav Ryhel wrote:
> The Maxim MAX8907 has a built-in 8-channel ADC. It does not require any
> Device Tree (DT) based configuration and is folded into the main PMIC
> node. Document this behavior.

Acked-by: Mark Brown <broonie@kernel.org>

--9YJuTka5+MAlnv5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQReagvpf3TrrA7BoYYv73Ows9A4iQUCavBRiQAKCRAv73Ows9A4
iU1yAQCZ8UjvKNX0t+kI0niKdZhnkKDz0wQaMx0a/UXnkq/1lAEA6BgdpS5JuJ+F
MfhVlHX2nVHLcEY0wVgohG9KDejOJws=
=sYYo
-----END PGP SIGNATURE-----

--9YJuTka5+MAlnv5C--
