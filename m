Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2261C3612ED;
	Tue,  7 Jul 2026 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783440070; cv=none; b=AX2HSfIOIV9NIoXq1MhITn1xszdelqF2t0Wg9+0sB72S2j4kCBDisoqQhOoPANCBccrHIVIiSUmY3aH4UOt/pppuTb4TzZfjL1mZCbweJcmXqfpRdnlHrCCZk5prgqKmFY+STDInlZGHoSQ/+dI6QBCpITHYu7KN9pLIfS6b+1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783440070; c=relaxed/simple;
	bh=rBqUN2GsN4T+lTNlQmnWGyQPUaOTwm11RhXl4UCYzlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMGGb3k4f+vq4sKp/gIzkBa0rvqcZ4kPXpTKUqLdFQXCfyRHzwW54VJB0ldT3JbjlwxEvr9bO2roOsLE9lmAS/YHRu2rGwckxJuTO0A4cHiYXZF2GN2tkMGUlovAB5qRzrk68dqlX1LBPJFNN6e3yocjTOTU/h8QQQ7xbPsCagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDTC4YAc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDTC4YAc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027291F00A3A;
	Tue,  7 Jul 2026 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783440068;
	bh=rBqUN2GsN4T+lTNlQmnWGyQPUaOTwm11RhXl4UCYzlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cDTC4YAchkNgdyjPHCid5CEtbobE3gEelGhK4Y2yxDrmLLrp2zzkz4sImnszR+V97
	 ELXjdQUedW18naf2ZDQkDyUxRUjGKJM6w1Vhz5sDkSrN76IXTNTwB125w6NQlF6EEo
	 Nu0BL7JI1sZuX0g064NGxToeQoSAraq4lMprRuIPcRjpaqZSaIYu8m2JJnd0VLTKWW
	 BTddrbKzxFwfzuETcUPVPmtp3og6V2wj/uqbhGd8LeWdJDrjIBo8JhkoUzWIuzDQ6S
	 sKYr6ax2haJ7R64n29nVMdnjKpJNu29uqptYfL3xquZmNdhZZ7KGIOlCUUI9AkqicN
	 BuhL7Th5DpAXw==
Date: Tue, 7 Jul 2026 17:01:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/5] dt-bindings: iio: add Open Sensor Fusion device
Message-ID: <20260707-obstinate-tartness-651b753c9158@spud>
References: <20260707014525.1015-1-kimjinseob88@gmail.com>
 <20260707014525.1015-2-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WhgoA4ddN7WKdFR1"
Content-Disposition: inline
In-Reply-To: <20260707014525.1015-2-kimjinseob88@gmail.com>

--WhgoA4ddN7WKdFR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 07, 2026 at 10:45:21AM +0900, Jinseob Kim wrote:
> Add a binding for the generic Open Sensor Fusion host interface.
>=20
> Open Sensor Fusion devices report capabilities and samples over an OSF
> protocol stream. Sensor channels are discovered at runtime from
> capability reports instead of being described individually in Device
> Tree.
>=20
> The protocol version is discovered at runtime from the OSF frame header.
> OSF GREEN is a product identity, and OSF0 is a wire-format magic value,
> so neither is used as the Linux compatible string.
>=20
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--WhgoA4ddN7WKdFR1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak0ivAAKCRB4tDGHoIJi
0iNYAP9BA3kDbysZOVm96HECdku+sXgUVqUhAPBk38obcymbCAEAwBxh8iboiW0f
CN7nchKp1DoFjnbCnK1Vw2HRAgaXowA=
=5guU
-----END PGP SIGNATURE-----

--WhgoA4ddN7WKdFR1--
