Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D581D6DB5;
	Thu, 23 Apr 2026 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965619; cv=none; b=SjxZ4PEz7xkEkMPsxvIV8nS9z4Brmd8fIA71zZZvWdDppTgnv6pcDvkh3+ClNdvhHs8Z/cuVjEYUID15/moH8npAv8dwnCsW2O1gkLNtlH7tQK060sTsXhwj8BUhNDfTBDCa5s8yi4I6hyKnLs5JrBpg0/UsyVlVbrMN+jtk88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965619; c=relaxed/simple;
	bh=XVD27Pdp4fyZ4FSMw6YF46EU63fDSbh7GiQFlrGdufo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eglp63o2xb52nqmd9tOBBzGA0ECSvVPSdFeiXJY0jhOzsRh4zqPEKehjRKkf3X1riT/HDfc6KaD/+CP/X4gjBd1oK2SnFyx8PoMiLK2haRWHw0rT7oektnv6vV8ISJ8UVF5ZzUqqrqLe7I8fTbynj7Or5xoyteHUsMhbXZkVYP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX8eCFl+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX8eCFl+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418EAC2BCAF;
	Thu, 23 Apr 2026 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965619;
	bh=XVD27Pdp4fyZ4FSMw6YF46EU63fDSbh7GiQFlrGdufo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JX8eCFl+ft8vQCl3GQizfb0u0ASEEx7cY0zzgRZ17sgzBF2K+STlW78JcXvbd7gtR
	 tF4dViVNEe9PBoYAVFTJe/s7B9o1eF5cYfp/yTNOgePJjvs0QpAU6PyHOdycHiXFeT
	 PGs+X0a3Nvj/Z3slBVGllUu0IBAJebNpMIZOrYlCBZMQnfA4Hfy3on6LTcoUSidKOx
	 Szbya8SAt9/Wdt4cph7/kpfW+w3YPblqxK62a2Uz7tYEogdJdzaeIOe8TgDZ8i3Mmd
	 to+yfsj04WsLPL/HSVKMktGLoHoSZsgRuhoidEddqfw1UmNaTvt/SPj5rvHPUTvLHs
	 7DETOe0aXn3+A==
Date: Thu, 23 Apr 2026 18:33:34 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 01/22] dt-bindings: iio: dac: ad5696: extend device
 support
Message-ID: <20260423-hardcore-thigh-15fc1690e0c2@spud>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-1-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qC20BmqYKBs77JpH"
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-1-ed7dca001d1b@analog.com>


--qC20BmqYKBs77JpH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 03:45:35PM +0100, Rodrigo Alencar via B4 Relay wrot=
e:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Support for AD5316R, AD5673R, AD5675, AD5677R and AD5697R missing from the
> device-tree bindings documentation. These devices have different bit
> resolutions or different number of channels so no fallback compatibles
> are used.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--qC20BmqYKBs77JpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaepX7QAKCRB4tDGHoIJi
0ujiAPsGMgjDuvrYBOb93bLNF5O48GYSMnmdaqmBzwFmkYsO2QEAztcHwlXrhJyV
QF+U+QcHnIZy1BG2z7N38cmPsjChagw=
=eQQJ
-----END PGP SIGNATURE-----

--qC20BmqYKBs77JpH--
