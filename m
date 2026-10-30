Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793385305;
	b=JynBQIxxMISApaPVoXyOAcKYXNxh7sXVoJvhtxID+qRMpb/XeGEZ0v4BFK+vTFU1j80v
	 XWIVmV3jsVkFfoDBevc6Xd3J9uqTdZZF4C34+1YXH2vGZgIXeYnQrL/PmzKsBLNpdciGE
	 oTcSyw+/891oaj6EUNbvdeAiT07leBHUas69tZPnxBz8suA35YJsdIsUeQuYOHcAr3/HI
	 DywiwWt80DHItznmunjwWICsj0Ec7MzIRpA638LwihLq22Nu73bVnAEONMlWiRJEXGOdd
	 gyUq0A0RdoatjPbGfcz2/PujY855pVA92YvgQSKfOCwV89DoO6BH3EDmmEZjaVRLazA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793385305;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WsATcwliNKu8sEfYqxxsUH41yWcXoOT5yVDkyAK5yrw=;
	b=LUb8i0Rx/JRerHsAtUz3aKQUPbG4hpLQxKuV3nYvyk2W3neTfvvk5hV8thkjvud7AkeH
	 1MlNT2+NxSkl0e7ognwmm8WLUipo9KbPYzKlYT3UvtpJrYEEnJIytS2v0Icm6g9CWSBxM
	 Xn6zJfbS5THlaBd7yMrsE9f/dJwJfN3z854pU6Pz2ryHB3JOyc+zMzn+/8t9p44Wgx1Tz
	 SabQh6TUsCR6oQveOEqCK/wD46c5nqSwV0T2aCR1zkFe1CMz6slfg9arSwSRpubKB+LxO
	 fjMWvJQr1Q7qQfnqrOQxzcY+PFUuzcrgyDnS5+c+ziMAd7ntYKYZ86sCfwVqvegSE0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6c82ztc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA57C606A31D;
	Fri, 30 Oct 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V6c82ztc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184741F000C1;
	Fri, 30 Oct 2026 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793385303;
	bh=WsATcwliNKu8sEfYqxxsUH41yWcXoOT5yVDkyAK5yrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V6c82ztcma7IUAgw75dJDqEmKnfD9tpqCfNRg9eNIRWkbC48DGKJ+EWqmvB5QfYhr
	 HTUhd/IvVzU5pq5poo6t1pxF+eaUDeKkH617t6naSu3QXhHyRBJpyTwUiGEO536Wog
	 W/+HwIDg2033cC7iCNgdjDwKWncdqCKYVzbkwyyYP/1zjDcjwY5iURWHYwRf6rLy09
	 3YwNy1Ww2ITh7WbD0C+zOHuPcW1UagHGvKRLf2t1gFzGF/aTaUh5GMkk+Kq2DmHm/+
	 1PU+uv4Co6gllgcxKAFyjPPc8xSD17tDy7CZNKDZ/484Wocdx2qEL4O5H8t3xbZ1hn
	 acbrbrwQD2L8g==
Date: Fri, 30 Oct 2026 18:34:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Angelo Dureghello <adureghello@baylibre.com>,
	Tobias Sperling <tobias.sperling@softing.com>,
	Eason Yang <j2anfernee@gmail.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	duje@dujemihanovic.xyz, herve.codina@bootlin.com,
	thomas.petazzoni@bootlin.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add Texas Instruments
 TLA2528
Message-ID: <20261030-parka-undrafted-b2f3d8f96d11@spud>
References: <20261030164705.297354-1-maxime.chevallier@bootlin.com>
 <20261030164705.297354-2-maxime.chevallier@bootlin.com>
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
	protocol="application/pgp-signature"; boundary="u5pR1ZRuklYsPkVg"
Content-Disposition: inline
In-Reply-To: <20261030164705.297354-2-maxime.chevallier@bootlin.com>

--u5pR1ZRuklYsPkVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--u5pR1ZRuklYsPkVg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauTjUAAKCRB4tDGHoIJi
0sFjAP9wipade2rjk5+f6l5tRhmFDmS60xEv+olGf4pYd5Ff5AD8DrzFsR9t90Dz
5ECkZ56r7c7xJ3UTCI+S/8bp4CtI8QM=
=Z1mQ
-----END PGP SIGNATURE-----

--u5pR1ZRuklYsPkVg--
