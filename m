Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EEA345CD0;
	Fri, 24 Jul 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911998; cv=none; b=flqzLFR4XQLHxXC9s8NsjezPeWeEf4JPqASbATmnwI72MkTMORWlK5jB7MR3S5D0XrP+GM1RbO/ktubI+3daqNTU63C5O/C0VwkoaT62y2Y9+vcm9kY+YG9IdAcPHq7flfNjI2+6VQR/PzTmZZoJ+GKxc61Vn54UQFbi9hasPFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911998; c=relaxed/simple;
	bh=84v0SMS6RJPzx152nTnsDEIvgaRbpc6yYplG74srE5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acZk5OK+Z3VNJatvqBHs7DUyxlqBcPkyV6knsbue3P8Ybdw123u1umaYYl2fq16cA5Wm6u/whvXmthe+yv1+QwQZFEQPv89mlkkuymH1MqJQ9ZX+fBfVyWmKeUpI0mP29yCOC0RtDTQa6oQJr469V574nATIE/nVgJJHgBS9L34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwfrhpY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwfrhpY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869271F000E9;
	Fri, 24 Jul 2026 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911996;
	bh=84v0SMS6RJPzx152nTnsDEIvgaRbpc6yYplG74srE5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FwfrhpY40mkKYH6548UEabDoqcEmOKRWzhp9VzJH5bUpRv9wepFYLwmzhOoFzgmia
	 GaOPVJYotxOTd0bzYRzYgUdr1Gd6+OlVCzw+bi5T2Gk9DQE5kBHGwtOITAYfqVEj9h
	 hniAmDA8GCNzd8E6EQVP3uzV9wDLc0eBRp+URl7To1hsIo008LPROvTbAEHw9CsrU8
	 O+D3lxKxMpwoPssS0GipaVtctT1E1c1A4qKeDpcLDpAX/phgOncJTlCao8VxOxajSy
	 t0ezcIwAazlPHncNiREQJpMm4cVNiWvz6frvjp/OsJS/Olfj+gftleK/Ea+UDRkfUP
	 L/ScnCovLuP1Q==
Date: Fri, 24 Jul 2026 17:53:12 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] dt-bindings: iio: dac: ad5696: extend device
 support
Message-ID: <20260724-envelope-fasting-9cb05be99ae5@spud>
References: <20260724-ad5686-extend-dev-support-v2-0-cfc2b30ce988@analog.com>
 <20260724-ad5686-extend-dev-support-v2-4-cfc2b30ce988@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y5mnsq/5p+m6aNC1"
Content-Disposition: inline
In-Reply-To: <20260724-ad5686-extend-dev-support-v2-4-cfc2b30ce988@analog.com>

--Y5mnsq/5p+m6aNC1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--Y5mnsq/5p+m6aNC1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamOYeAAKCRB4tDGHoIJi
0lzdAQDLio5v5/sqwjYGEJHDOAhKRKmWek2lIYdA2crSS0SSwwEAlMUf+3Sgmw8M
VifTiE391MqGBM/7hOh5Kt8xcnVu4QY=
=4Ra0
-----END PGP SIGNATURE-----

--Y5mnsq/5p+m6aNC1--
