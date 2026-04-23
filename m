Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BC51D6DB5;
	Thu, 23 Apr 2026 17:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965665; cv=none; b=hS+TGtwo50TMxwQYYOhofWHGRjcJPh/+FvKQSR1UQTi79rHTMjV3IkEqDpk95F8J0Go+nskvMAIbnCucDCl5v5WJqpgKoKmFTxsrB7Lq2NJXmODlGXK8Mnkzrn5yuJef63csghUdLKQk5yPTJfx8arPJgk18PrVwViIlJ4TZFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965665; c=relaxed/simple;
	bh=XRkotRM1nrtvqCw949rXTGVdaXdpigdHID7iQz+3OGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lc/2CsiD8FdELt8rpJzjtVOylCMLF9uW4UYRlp+D4I7bITtUgxSHWcYtPDiVhEzVWixcpWi3buFzHXJrQTNf+9WJ4JylboqRtY6wKq4heYiMQM4l1/E3W/LS2lSZ9vqd31LWtGNuK6U2oktZ6ox4UhfF2j/M2aeFHYPEEgbH39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiTDhIMg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiTDhIMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772ECC2BCAF;
	Thu, 23 Apr 2026 17:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965664;
	bh=XRkotRM1nrtvqCw949rXTGVdaXdpigdHID7iQz+3OGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiTDhIMgNdhjf5lG76zEhBAC71pXJChGwsgcF8IQIenuW4Eb4MRjOKsUfedk1XdBu
	 mVTJyWEyVIVFD9WTIwd0nqbpnRcJCsr4HMvrpK+IoRRxLrM+nKk4z4D3Zu8U1BdBSH
	 C5fMsAQmNe6p3CXlFeIQ5SAASbA4Qa49nu48C+vjQXrygJiALeSSFQg2LdSpPU5c+b
	 pTQp5sZP0TyI2ahfLDQNXW6gMtz6wKE+urKZMet/QUuRj7uvuZwBscsL6uYgFYz7PV
	 +Nvs9u//3StbiF6lADzXNjfZnRofkkIdpPC5Vr45Sade3brDaUts9EpJam/ktlgWe+
	 /06VpJeZ23vLg==
Date: Thu, 23 Apr 2026 18:34:19 +0100
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
Subject: Re: [PATCH 05/22] dt-bindings: iio: dac: ad5686: add reset/ldac/gain
 gpio support
Message-ID: <20260423-spousal-deacon-26c51d60da92@spud>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-5-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DUNMBqXHPWKvTe/g"
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-5-ed7dca001d1b@analog.com>


--DUNMBqXHPWKvTe/g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--DUNMBqXHPWKvTe/g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaepYGwAKCRB4tDGHoIJi
0nWCAQCBFpRzLjMf+rEEsMiXnaPfK2WcCT2L172Z9PuOiv1oKwEAr0uiSeaE2Tb8
TBS+D7a0HTa5YxDkrpPrfwXEIBcA8AU=
=6NcM
-----END PGP SIGNATURE-----

--DUNMBqXHPWKvTe/g--
